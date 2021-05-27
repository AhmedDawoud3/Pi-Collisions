Class = require "class"
require "block"
count = 0
digits = 8
timeSteps = 7 ^ (digits - 1)
dT = 0
function love.load()
    clack = love.audio.newSource('clack.wav', 'static')
    love.window.setMode(800, 600)
    block1 = Block(100, 20, 1, 0)
    m2 = 100 ^ (digits - 1);
    block2 = Block(200, 100, m2, -1 / timeSteps)

end

function love.update(dt)
    dT = dt
end

function love.draw()
    love.graphics.clear(200 / 255, 200 / 255, 200 / 255)
    clackSound = false
    for i = 1, timeSteps do
        if block1:Collides(block2) then
            v1 = block1:Bounce(block2)
            v2 = block2:Bounce(block1)
            block1.v = v1
            block2.v = v2
            clackSound = true
            count = count + 1
        end
        if block1:HitWall() then
            block1:Reverse()
            clackSound = true
            count = count + 1
        end
        block1:Update();
        block2:Update();
    end

    if clackSound then
        clack:play()
    end
    clackSound = false
    love.graphics.setColor(0.4, 0.4, 0.4, 1)
    block1:Render()
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    block2:Render()
    love.graphics.print("Pi = " .. tostring(count) .. "\n" .. "FPS :" .. tostring(1 / dT) .. "\n" .. "V1 :" ..
                            tostring(block1.v * timeSteps) .. "\n" .. "V2 :" .. tostring(block2.v * timeSteps) .. "\n" ..
                            "M2/M1 :" .. tostring(block2.m / block1.m) .. "\n" .. "m2V1 = " ..
                            tostring(block1.m * block2.v) .. "\n" .. "m1v2 = " .. tostring(block1.m * block2.v))
end
