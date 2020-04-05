<script>
  import { tick } from "svelte";

  import { connect } from "./socket";
  import Login from "./Login.svelte";
  import Chat from "./Chat.svelte";

  // Player name, TODO: set one time on init app
  let name = "";

  let message = "";
  let messages = [];

  let players = [];

  // Phoenix variables
  let socket;
  let chatChannel;
  let presence;

  let connected = false;

  // Functions
  const sendMessage = (channel, payload) => {
    channel.push("shout", {
      name: payload.name,
      message: payload.message
    });
    message = "";
  };

  const onMessageReceived = async ({ name, message }) => {
    console.log("Name: ", name);
    console.log("Message: ", message);
    messages = [...messages, { name, message }];
    await tick();
  };

  const onPresenceSync = () => {
    players = presence.list((id, { metas: [first, ...rest] }) => {
      const count = rest.length + 1;
      return { name: id };
    });
  };

  const onLogin = ({ user_id }) => {
    const connection = connect({
      user_id,
      channel_topic: "room:lobby"
    });
    name = user_id;
    connected = true;

    socket = connection.socket;
    chatChannel = connection.channel;
    presence = connection.presence;

    chatChannel.on("shout", onMessageReceived);
    presence.onSync(onPresenceSync);
  };
</script>

<style>

</style>

{#if !connected}
  <Login {onLogin} />
{:else}
  <Chat
    onSend={message => sendMessage(chatChannel, { name, message })}
    {messages}
    {name}
    {players}/>
{/if}
