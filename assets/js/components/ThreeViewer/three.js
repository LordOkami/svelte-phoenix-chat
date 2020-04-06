import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";


export const initScene = (container) => {
  var camera, controls, scene, renderer;

  const width = 500;
  const height = 500;

  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(width, height);
  container.appendChild(renderer.domElement);

  camera = new THREE.OrthographicCamera(width / - 2, width / 2, height / 2, height / - 2, 0.11, 1000);
  camera.position.z = 100;
  camera.position.y = 100;
  camera.position.x = 100;
  camera.lookAt(new THREE.Vector3(0, 0, 0))


  scene = new THREE.Scene();



  const color = 0xffffff;
  const intensity = 1;
  const light = new THREE.DirectionalLight(color, intensity);
  light.position.set(-1, 2, 4);
  scene.add(light);

  const ambientLight = new THREE.AmbientLight(color, intensity);
  scene.add(ambientLight);

  // Fog
  scene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );


  // controls = new OrbitControls(camera, renderer.domElement);

  renderer.render(scene, camera);

  const animate = () => {

    requestAnimationFrame(animate);

    render();

  }

  const render = () => {

    renderer.render(scene, camera);

  }
  animate();
  return scene;
}



