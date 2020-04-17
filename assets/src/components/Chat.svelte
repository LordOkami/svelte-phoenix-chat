<style>
  .chat-container {
    position: absolute;
    height: 50vh;

  }

  .messages-panel {
    height: 250px;
    overflow-y: scroll;
    background-color: white;
  }

  .input-message-panel {
    padding-top: 25px;
    background-color: white;

  }

  .input-message-panel input {
    height: 25px;
  }
</style>

<script>
  import { afterUpdate } from 'svelte';

  export let messages;
  export let onSend;
  export let name;

  let message = '';
  let messagePanelRef;

  const submit = () => {
    onSend(message);
    message = '';
  };

  afterUpdate(() => {
    messagePanelRef.scrollTop = messagePanelRef.scrollHeight;
  })
</script>

<div class="chat-container">
  <h1>Gat Chat</h1>
  <div class="chat">
    <div bind:this={messagePanelRef} class="messages-panel">
      <ul>
        {#each messages as { name, message }}
          <li>{name}: {message}</li>
        {/each}
      </ul>

    </div>
    <div class="input-message-panel">
      <form class="message-form" on:submit|preventDefault="{submit}">
        <span>{name}</span>

        <input bind:value="{message}" placeholder="enter your message" />
        <button type="submit">Enviar</button>
      </form>
    </div>
  </div>

</div>
