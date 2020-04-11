<style>
  .container {
    width: 500px;
    height: 500px;
  }
</style>

<script>
  import * as THREE from 'three';

  import { onMount } from 'svelte';

  import { initScene } from './three.js';

  export let players;
  let scene;

  $: {
    players.forEach((p, i) => {
      const player = scene.getObjectByName(p.name);
      if (player) {
      } else {
        const boxSize = 50;
        const geometry = new THREE.BoxGeometry(boxSize, boxSize, boxSize);
        const material = new THREE.MeshPhongMaterial({ color: 0x44aa88 });

        const cube = new THREE.Mesh(geometry, material);
        cube.position.set(i * 50, 0, 0);
        cube.name = p.name;
        scene.add(cube);
      }
    });
  }

  let container;

  onMount(() => {
    scene = initScene(container);
  });
</script>

<div bind:this="{container}" class="container"></div>
