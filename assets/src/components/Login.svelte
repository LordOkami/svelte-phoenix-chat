<script>
  import * as THREE from 'three';
  import WAVES from 'vanta/dist/vanta.waves.min';
  import { onMount, onDestroy } from 'svelte';

  export let onLogin;
  let name = '';

  // Vanta
  let containerRef;
  let vantaEffect;

  const submit = () => {
    onLogin({ user_id: name });
  };

  onMount(() => {
    vantaEffect = WAVES({
      el: containerRef,
      THREE: THREE, // use a custom THREE when initializing
    });
  });

  onDestroy(() => {
    vantaEffect.destroy();
  });
</script>

<style>
  .login {
    position: absolute;
    width: 100vw;
    height: 100vh;
  }
</style>

<div bind:this={containerRef} class="login">
  <h1>Login:</h1>
  <form class="login-form" on:submit|preventDefault={submit}>
    <input bind:value={name} placeholder="enter your name" />
    <button type="submit">Enviar</button>
  </form>
</div>
