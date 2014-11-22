TacticsCore = require "tactics-core"

TacticsCore.Loader.get().then (data) ->
  console.log data
  
  mapData = data.map.map (cube, x) ->
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].map (letter, z) ->
      {
        x: x
        y: parseInt cube[letter]
        z: z     
      }
        
engine = TacticsCore.init
  data: {}
  update: ->
    ;
      
clear = (scene) ->
  removableChildren = scene.children.copy().reverse()
  
  removableChildren.forEach (child) ->
    scene.remove(child) unless child.tag in ["camera", "axis"]

scene = engine.scene()
clear scene 

console.log mapData

mapData.forEach (row) ->
  row.forEach (col) ->
    cube = engine.Cube