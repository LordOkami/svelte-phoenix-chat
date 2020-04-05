<script>
  export let onLogin;
  let name = "";
</script>

<style>

</style>

<div class="login">
  <h1>Login</h1>
  <input bind:value={name} placeholder="enter your name" />
  <button on:click={onLogin({ user_id: name })}>Enviar</button>
</div>
