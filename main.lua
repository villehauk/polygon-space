function love.load() -- nil >> nil
    spaceship = require "spaceships"
    map = require "map"
    love.physics.setMeter(map.scale)

    player = spaceship:new({},{
         0,  0,
        20,-20,
        30,-20,
        20,-10,
        40,  0,
        20, 10,
        30, 20,
        20, 20
    })
end

function love.update(dt) -- dt := number >> nil
    player.com_x,player.com_y = player.body:getWorldCenter()
    map.world:update(dt)
    if love.keyboard.isDown("w") then
        player.body:applyForce(50*math.cos(player.body:getAngle()),50*math.sin(player.body:getAngle()))
    end
    if love.keyboard.isDown("s") then
        player.body:applyForce(-50*math.cos(player.body:getAngle()),-50*math.sin(player.body:getAngle()))
    end
    if love.keyboard.isDown("d") then
        player.body:applyTorque(250)
    end
    if love.keyboard.isDown("a") then
        player.body:applyTorque(-250)
    end
end

function love.draw() -- nil >> nil
    love.graphics.print("inertia:"..player.inertia, 10, 10)
    love.graphics.translate(map.width/2-player.com_x, map.height/2-player.com_y)
    player:draw("line")
    love.graphics.origin()
    --love.graphics.polygon("line",aircraft.body:getWorldPoints(aircraft.shape:getPoints()))
end
