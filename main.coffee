TacticsCore = require "tactics-core"

TacticsCore.Loader.get().then (data) ->
  console.log data
  
  mapData = data.map.map (cube) ->
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].map (letter) ->
      parseInt cube[letter]
      
  console.log mapData 