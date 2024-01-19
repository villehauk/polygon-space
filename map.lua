local map = {}

map.scale = 64

map.world = love.physics.newWorld(0, 0, true)

map.width, map.height, map.flags = love.window.getMode()

return map
