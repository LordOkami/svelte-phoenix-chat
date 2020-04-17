<style>
  h4 {
    color: red;
  }

  .players-panel {
    position: absolute;
    overflow-y: scroll;
    overflow-x: hidden;
    width: 200px;
    height: 300px;
    background-color:white;
    right:0;
  }
</style>

<script>
  export let players;
</script>

<div class="players-panel">
  <h4>Players Online</h4>
  <ul>
    {#each Object.values(players) as {player}}
      <li>{player.username}: position {player.position.x}, {player.position.y}</li>
    {/each}
  </ul>
</div>
