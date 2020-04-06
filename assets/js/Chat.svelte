<script>
  import PlayersLists from "./PlayersLists.svelte";
  export let messages;
  export let players;
  export let onSend;
  export let name;

  let message = "";

  const submit = () => {
    onSend(message);
    message = "";
  };
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
      <form class="message-form" on:submit|preventDefault={submit}>
        <input bind:value={message} placeholder="enter your message" />
        <button type="submit">Enviar</button>
      </form>
    </div>
    <PlayersLists {players} />
  </div>

</div>
