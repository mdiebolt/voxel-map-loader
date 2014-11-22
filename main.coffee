TacticsCore = require "tactics-core"

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
          cube.castShadow = true
          cube.receiveShadow = true
          
          scene.add cube 
    
    ambientLight = new THREE.AmbientLight 0x101030
    scene.add ambientLight

    light = new THREE.DirectionalLight 0xffffff, 1
    light.castShadow = true
    light.shadowCameraVisible = true
    #light.shadowCameraNear = 100
	  #light.shadowCameraFar = 200
    #light.shadowCameraLeft = -20
	  #light.shadowCameraRight = 20
	  #light.shadowCameraTop = 20
	  #light.shadowCameraBottom = -20
    light.position.set 5, 5, 5
      
    scene.add light
    scene.add new THREE.DirectionalLightHelper(light, 0.2)
, 5000

engine = TacticsCore.init
  data: {}
  update: ->
    
camera = engine.camera()
camera.position.set(5, 10, 20)

renderer = engine.renderer()
renderer.shadowMapEnabled = true

controls = new THREE.OrbitControls camera, renderer.domElement
controls.target = new THREE.Vector3(5, 0, 5)

clear = (scene) ->
  removableChildren = scene.children.copy().reverse()

  removableChildren.forEach (child) ->
    scene.remove(child) unless child.tag is "axis"
