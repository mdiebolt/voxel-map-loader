TacticsCore = require "tactics-core"

clear = (scene) ->
  removableChildren = scene.children.copy().reverse()

  removableChildren.forEach (child) ->
    scene.remove(child) unless child.tag is "axis"

addLights = (scene, opts={}) ->
  ambientLight = new THREE.AmbientLight 0x212223
  scene.add ambientLight

  light = new THREE.DirectionalLight 0xffffff, 1
  
  light.castShadow = true
  
  # This is all very important for gettings shadows working properly
  # Tweak these or calculate them based on objects in your scene
  light.shadowCameraNear = 1
  light.shadowCameraFar = 20
  light.shadowCameraLeft = -7
  light.shadowCameraRight = 7
  light.shadowCameraTop = 7
  light.shadowCameraBottom = -7

  light.position.set 10, 5, 10
    
  scene.add light
  
  if opts.debug
    light.shadowCameraVisible = true
    scene.add new THREE.DirectionalLightHelper(light, 0.2)  

setInterval ->
  TacticsCore.Loader.refresh().then (data) ->
    scene = engine.scene()
    clear scene
  
    mapData = data.map.map (cube, z) ->
      "abcdefghij".split("").map (letter, x) ->
        {
          x: x
          y: parseInt cube[letter]
          z: z
        }
  
    mapData.forEach (row) ->
      row.forEach ({x, y, z}) ->
        [y..0].forEach (y) ->
          cube = engine.Cube(x, y, z)
          
          floorCubes = y < 1 
          
          cube.receiveShadow = floorCubes
          cube.castShadow = !floorCubes
          
          scene.add cube 
    
    addLights scene
, 5000

engine = TacticsCore.init
  data: {}
  update: ->
    
camera = engine.camera()
camera.position.set(5, 10, 20)

renderer = engine.renderer()
renderer.shadowMapEnabled = true
renderer.shadowMapSoft = false

controls = new THREE.OrbitControls camera, renderer.domElement
controls.target = new THREE.Vector3(5, 0, 5)
