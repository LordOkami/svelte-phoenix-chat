<style>

</style>

<script>
  export let onLogin;
  let name = '';

  const submit = () => {
    onLogin({ user_id: name });
  };
</script>

<div class="login">
  <h1>Login</h1>
  <form class="login-form" on:submit|preventDefault="{submit}">
    <input bind:value="{name}" placeholder="enter your name" />
    <button type="submit">Enviar</button>
  </form>
</div>
