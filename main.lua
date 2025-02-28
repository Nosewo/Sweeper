local View = require("View")



function love.load()
    local cursorImage = love.image.newImageData("Player1.png") -- Lade dein Cursor-Bild
    customCursor = love.mouse.newCursor(cursorImage, 0, 0) -- Erstelle einen benutzerdefinierten Cursor
    love.mouse.setCursor(customCursor)
    require("View"):CreateStartScreen()  
end

function love.update(dt)
    View:update()
    
end

function love.draw()
   View:draw()
end

function love.mousepressed(x, y, buttonType, istouch, presses)
    if buttonType == 1 then
        for _, button in pairs(View.buttons) do
            button:click()
        end
        for _, button in pairs(View.StartButtons) do
            button:click()
        end
    end
end
