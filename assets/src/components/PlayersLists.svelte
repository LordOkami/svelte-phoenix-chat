<style>

</style>

<script>
  export let players;
</script>

<div class="players-panel">
  <h4>Players Online</h4>
  <ul>
    {#each players as { name }}
      <li>{name}</li>
    {/each}
  </ul>
</div>
