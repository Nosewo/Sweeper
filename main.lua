local View = require("View")



function love.load()
    require("View"):CreateField()  
end

function love.update(dt)
    View:update()
    
end

function love.draw()
   View:draw()
end

function love.mousepressed(x, y, buttonType, istouch, presses)
    if buttonType == 1 then
        for _, button in ipairs(View.buttons) do
            button:click()
        end
    end
end
