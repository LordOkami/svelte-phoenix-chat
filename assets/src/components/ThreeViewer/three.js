import * as THREE from 'three';

const floorTexture = new THREE.ImageUtils.loadTexture(
  '/textures/checkerboard.jpg',
);

export const initScene = (container) => {
  var camera, scene, renderer;

  ///////////
  // SCENE //
  ///////////
  scene = new THREE.Scene();

  ////////////
  // CAMERA //
  ////////////
  var SCREEN_WIDTH = window.innerWidth,
    SCREEN_HEIGHT = window.innerHeight;
  // camera attributes
  var VIEW_ANGLE = 45,
    ASPECT = SCREEN_WIDTH / SCREEN_HEIGHT,
    NEAR = 0.1,
    FAR = 20000;
  // set up camera
  camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);
  // add the camera to the scene
  scene.add(camera);
  // the camera defaults to position (0,0,0)
  // 	so pull it back (z = 400) and up (y = 100) and set the angle towards the scene origin
  camera.position.set(0, 150, 400);
  camera.lookAt(scene.position);

  //////////////
  // RENDERER //
  //////////////
  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
  container.appendChild(renderer.domElement);

  ///////////
  // LIGHT //
  ///////////
  // create a light
  const light = new THREE.PointLight(0xffffff);
  light.position.set(0, 250, 0);
  scene.add(light);
  const ambientLight = new THREE.AmbientLight(0x111111);
  scene.add(ambientLight);

  ///////////
  // FLOOR //
  ///////////

  // note: 4x4 checkboard pattern scaled so that each square is 25 by 25 pixels.

  floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping;
  floorTexture.repeat.set(10, 10);
  // DoubleSide: render texture on both sides of mesh
  var floorMaterial = new THREE.MeshBasicMaterial({
    map: floorTexture,
    side: THREE.DoubleSide,
  });
  var floorGeometry = new THREE.PlaneGeometry(1000, 1000, 1, 1);
  var floor = new THREE.Mesh(floorGeometry, floorMaterial);
  floor.position.y = -0.5;
  floor.rotation.x = Math.PI / 2;
  floor.name = 'floor';
  scene.add(floor);

  /////////
  // SKY //
  /////////

  // recommend either a skybox or fog effect (can't use both at the same time)
  // without one of these, the scene's background color is determined by webpage background

  // make sure the camera's "far" value is large enough so that it will render the skyBox!
  var skyBoxGeometry = new THREE.CubeGeometry(10000, 10000, 10000);
  // BackSide: render faces from inside of the cube, instead of from outside (default).
  var skyBoxMaterial = new THREE.MeshBasicMaterial({
    color: 0x9999ff,
    side: THREE.BackSide,
  });
  var skyBox = new THREE.Mesh(skyBoxGeometry, skyBoxMaterial);
  scene.add(skyBox);

  // fog must be added to scene before first render
  scene.fog = new THREE.FogExp2(0x9999ff, 0.00025);

  renderer.render(scene, camera);

  const animate = () => {
    requestAnimationFrame(animate);

    render();
  };

  const render = () => {
    renderer.render(scene, camera);
  };

  animate();
  return { camera, scene, renderer };
};
