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
    
    renderer = engine.renderer()
    renderer.shadowMapEnabled = true

    ambientLight = new THREE.AmbientLight 0x101030
    scene.add ambientLight

    light = new THREE.PointLight 0xffeedd
    light.position.set 5, 5, 5
      
    scene.add light
, 5000

engine = TacticsCore.init
  data: {}
  update: ->
    ;
    
camera = engine.camera()
camera.position.set(5, 10, 20)

clear = (scene) ->
  removableChildren = scene.children.copy().reverse()

  removableChildren.forEach (child) ->
    scene.remove(child) unless child.tag is "axis"
