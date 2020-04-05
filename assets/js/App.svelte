<script>
  import { tick } from "svelte";

  export let socket;

  let name = "";
  let message = "";
  let messages = [];

  let connected = false;

  // Functions
  const sendMessage = (payload) => {
    channel.push("shout", {
      name: payload.name,
      message: payload.message
    });
    message = "";
  };

  const onMessageReceived = async ({ name, message }) => {
    console.log("Name: ", name);
    console.log("Message: ", message);
    messages = [...messages, { name, message }]
    await tick();
  };

  // // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel("room:lobby", {});
  channel
    .join()
    .receive("ok", resp => {
      console.log("Joined successfully", resp);
      connected = true;
    })
    .receive("error", resp => {
      console.log("Unable to join", resp);
    });
  channel.on("shout", onMessageReceived);
</script>

<style>
  h1 {
    color: red;
  }
</style>

<div class="background">

  <h1>Gat Chat</h1>
  <ul>
    {#each messages as { name, message }}
      <li>{name}: {message}</li>
    {/each}
  </ul>

  <input bind:value={name} placeholder="enter your name" />
  <input bind:value={message} placeholder="enter your message" />

  <button on:click={() => sendMessage({ name, message })}>Enviar</button>
</div>