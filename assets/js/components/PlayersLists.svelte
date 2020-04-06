<script>
  export let players;
</script>

<style>

</style>

<div class="players-panel">
  <h4>Players Online</h4>
  <ul>
    {#each players as { name }}
      <li>{name}</li>
    {/each}
  </ul>
</div>
