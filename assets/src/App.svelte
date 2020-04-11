<style>

</style>

<script>
  import { tick } from 'svelte';

  import { connect } from './socket';
  import Login from './components/Login.svelte';
  import Chat from './components/Chat.svelte';
  import ThreeViewer from './components/ThreeViewer/ThreeViewer.svelte';

  // Player name
  let name = '';

  let messages = [];

  let players = [];

  // Phoenix variables
  let chatChannel;
  let presence;

  let connected = false;

  // Functions
  const sendMessage = (channel, payload) => {
    channel.push('shout', {
      name: payload.name,
      message: payload.message,
    });
  };

  const onMessageReceived = async ({ name, message }) => {
    messages = [...messages, { name, message }];
    await tick();
  };

  const onPresenceSync = presence => {
    players = presence.list((id) => {
      return { name: id };
    });
  };

  const onLogin = ({ user_id }) => {
    const connection = connect({
      user_id,
      channel_topic: 'room:lobby',
    });

    name = user_id;
    connected = true;

    chatChannel = connection.channel;
    presence = connection.presence;

    chatChannel.on('shout', onMessageReceived);
    presence.onSync(() => onPresenceSync(presence));
  };
</script>

{#if !connected}
  <Login {onLogin} />
{:else}
  <Chat
    onSend="{message => sendMessage(chatChannel, { name, message })}"
    {messages}
    {name}
    {players}
  />
{/if}
<ThreeViewer {players} />
