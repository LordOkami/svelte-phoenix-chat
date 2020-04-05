<script>
  import { tick } from "svelte";

  import { connect } from "./socket";
  import Login from "./Login.svelte";
  import Chat from "./Chat.svelte";

  // Player name, TODO: set one time on init app
  let name = "";

  let message = "";
  let messages = [];

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
    presence.onSync(() => {
      console.log("PRESENCE", presence);
      const playersList = presence
        .list((id, { metas: [first, ...rest] }) => {
          const count = rest.length + 1;
          return `${id}:${count}`;
        })
        .join("\n");

      console.log("Players List: ", playersList);
    });
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
    {name} />
{/if}
