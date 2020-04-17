<script>
  import * as THREE from 'three';

  import { onMount, onDestroy, afterUpdate } from 'svelte';

  import { initScene } from './three.js';

  let container;

  export let players, movePlayer;
  let scene, camera;

  // Svelte life cycle
  afterUpdate(() => {
    Object.values(players).forEach(({ player: p }, i) => {
      const player = scene.getObjectByName(p.id);

      if (player) {
        player.position.set(p.position.x, 5, p.position.y);
      } else {
        const boxSize = 10;
        const geometry = new THREE.BoxGeometry(boxSize, boxSize, boxSize);
        const material = new THREE.MeshPhongMaterial({ color: 0x44aa88 });

        const cube = new THREE.Mesh(geometry, material);
        cube.position.set(i * 10, 5, 0);
        cube.name = p.id;
        scene.add(cube);
      }
    });
  });

  onDestroy(() => {
    if (scene) {
      scene.dispose();
    }
  });

  onMount(() => {
    const three = initScene(container);
    scene = three.scene;
    camera = three.camera;
  });

  // ThreeJs Functions and callbacks
  const onSceneClick = (event) => {
    let raycaster = new THREE.Raycaster();
    let mouse = new THREE.Vector2();

    const { clientHeight, clientWidth } = container;

    mouse.x = (event.clientX / clientWidth) * 2 - 1;
    mouse.y = -(event.clientY / clientHeight) * 2 + 1;

    raycaster.setFromCamera(mouse, camera);

    var intersects = raycaster.intersectObjects(scene.children);

    for (var i = 0; i < intersects.length; i++) {
      const intersectObject = intersects[i].object;

      if (intersectObject.name === 'floor') {
        const { x, z: y } = intersects[i].point;
        movePlayer({ x, y });
      }
    }
  };
</script>

<style>
  .container {
    width: 100vw;
    height: 100vh;
    position: absolute;
  }
</style>

<div bind:this={container} on:click={onSceneClick} class="container" />
