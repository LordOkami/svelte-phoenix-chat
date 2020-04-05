<script>
  export let messages;
  export let onSend;
  export let name;
  
  let message = "";
</script>

<style>

</style>

<div class="background">
  <h1>Gat Chat</h1>
  <div class="chat">
    <div class="message-panel">
      <ul>
        {#each messages as { name, message }}
          <li>{name}: {message}</li>
        {/each}
      </ul>
      <span>{name}</span>
      <input bind:value={message} placeholder="enter your message" />
      <button on:click={() => onSend(message)}>Enviar</button>
    </div>
    <div class="players-panel" />
  </div>

</div>
