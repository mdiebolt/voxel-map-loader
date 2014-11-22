TacticsCore = require "tactics-core"

setInterval ->
  TacticsCore.Loader.refresh().then (data) ->
    scene = engine.scene()
    clear scene
  
    mapData = data.map.map (cube, z) ->
      ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].map (letter, x) ->
        {
          x: x
          y: parseInt cube[letter]
          z: z
        }
  
    mapData.forEach (row) ->
      row.forEach ({x, y, z}) ->
        [y..0].forEach (y) ->
          cube = engine.Cube(x, y, z)
        
          scene.add cube 
    
    directionalLight = new THREE.DirectionalLight 0xffeedd
    directionalLight.position.set 0, 0, 10
    directionalLight.castShadow = true
      
    scene.add directionalLight
, 5000

engine = TacticsCore.init
  data: {}
  update: ->
    ;

clear = (scene) ->
  removableChildren = scene.children.copy().reverse()

  removableChildren.forEach (child) ->
    scene.remove(child) unless child.tag is "axis"
