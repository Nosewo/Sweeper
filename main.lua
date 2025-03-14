local View = require("View")



function love.load()
    love.setCursor(love.image.newImageData("Player1.png"))
    require("View"):CreateStartScreen()  
    require("View").Backgroundsound= love.audio.newSource("Background.wav","static")
    require("View").Backgroundsound:setLooping(true)
    require("View").Backgroundsound:setVolume(0.01)
    love.audio.play(require("View").Backgroundsound)
    love.window.setTitle("Sweeper")
end

function love.setCursor(Cursor)
    local cursorImage = Cursor -- Lade dein Cursor-Bild
    customCursor = love.mouse.newCursor(cursorImage, 0, 0) -- Erstelle einen benutzerdefinierten Cursor
    love.mouse.setCursor(customCursor) 
end
function love.update(dt)
    View:update()
    
end

function love.draw()
   View:draw()
end

function love.mousepressed(x, y, buttonType, istouch, presses)
    for _, button in pairs(View.buttons) do
        if button.isHovered then
            button:click(buttonType)  -- Linksklick (1) oder Rechtsklick (2) weitergeben
        end
    end
    for _, button in pairs(View.StartButtons) do
        if button.isHovered then
            button:click(buttonType)
        end
    end
end
