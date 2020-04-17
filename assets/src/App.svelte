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

  let players = {};

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

  const movePlayer = (channel, position) => {
    channel.push('move', {position})
  }

  const onMessageReceived = async ({ name, message }) => {
    messages = [...messages, { name, message }];
    await tick();
  };

  const onMovePlayer = async ({player_id, position}) => {
    players[player_id].player.position = position;
    await tick();

  }

  const onPresenceSync = presence => {
    players = presence.state;
  };

  const onLogin = ({ username }) => {
    const connection = connect({
      username,
      channel_topic: 'room:lobby',
    });

    name = username;
    connected = true;

    chatChannel = connection.channel;
    presence = connection.presence;

    chatChannel.on('shout', onMessageReceived);
    chatChannel.on('move', onMovePlayer);
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
  <ThreeViewer {players} movePlayer={(position) => movePlayer(chatChannel, position)}/>
{/if}
