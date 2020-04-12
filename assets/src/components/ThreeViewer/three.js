import * as THREE from 'three';
// import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
// import brick_texture from "../../../"
const texture = THREE.ImageUtils.loadTexture(
  '/textures/castle_brick/castle_brick_02_red_diff_1k.jpg',
);
// assuming you want the texture to repeat in both directions:
// texture.wrapS = THREE.RepeatWrapping;
// texture.wrapT = THREE.RepeatWrapping;

export const initScene = (container) => {
  var camera, scene, renderer;

  const width = 500;
  const height = 500;

  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(width, height);
  container.appendChild(renderer.domElement);

  camera = new THREE.OrthographicCamera(
    width / -2,
    width / 2,
    height / 2,
    height / -2,
    0.11,
    1000,
  );
  camera.position.z = 100;
  camera.position.y = 100;
  camera.position.x = 100;
  camera.lookAt(new THREE.Vector3(0, 0, 0));

  scene = new THREE.Scene();

  const color = 0xffffff;
  const intensity = 1;
  const light = new THREE.DirectionalLight(color, intensity);
  light.position.set(-1, 2, 4);
  scene.add(light);

  const ambientLight = new THREE.AmbientLight(color, intensity);
  scene.add(ambientLight);

  // Fog
  scene.fog = new THREE.FogExp2(0xcccccc, 0.002);

  // Add floor

  const material = new THREE.MeshLambertMaterial({ map: texture });
  const plane = new THREE.Mesh(new THREE.PlaneGeometry(400, 3500), material);
  plane.material.side = THREE.DoubleSide;

  // rotation.z is rotation around the z-axis, measured in radians (rather than degrees)
  // Math.PI = 180 degrees, Math.PI / 2 = 90 degrees, etc.
  plane.rotation.x = Math.PI / 2;

  scene.add(plane);

  // controls = new OrbitControls(camera, renderer.domElement);

  renderer.render(scene, camera);

  const animate = () => {
    requestAnimationFrame(animate);

    render();
  };

  const render = () => {
    renderer.render(scene, camera);
  };

  animate();
  return scene;
};
