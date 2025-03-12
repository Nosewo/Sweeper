
local View = {}
require("const")
local controller = require("Controller")
View.StartButtons = {}
View.StartScreen = {}
View.bStart = true
function View:CreateStartScreen()
    
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1) -- Dunkler Hintergrund
    love.graphics.setColor(1, 1, 1) -- Weißer Text
    local diffrentMaps = {love.graphics.newImage("Map1.png"),love.graphics.newImage("Map2.png"), love.graphics.newImage("Map3.png"),}
    local diffrentPlayers = {love.graphics.newImage("Player1.png"),love.graphics.newImage("Player2.png"),}
    local diffrentPlayersData = {love.image.newImageData("Player1.png"),love.image.newImageData("Player2.png"),}
    local iMap = 1
    local iPlayer = 1
    self.StartScreen["Map"]= diffrentMaps[iMap]
    self.StartScreen["Player"]= diffrentPlayers[iPlayer]
    
    self.StartButtons["MapRight"]= View.createButton(200,250,100,40,">",function(button)
        iMap=iMap+1 -- variable machen
        if iMap == 4 then
          iMap = 1  
        end
        self.StartScreen["Map"]=diffrentMaps[iMap]
    end)
    self.StartButtons["MapLeft"]= View.createButton(100,250,100,40,"<",function(button)
        iMap=iMap-1
        if iMap == 0 then
          iMap = 3  
        end
        self.StartScreen["Map"]=diffrentMaps[iMap]
    end)
    self.StartButtons["PlayerRight"]= View.createButton(600,250,100,40,">",function(button)
        iPlayer=iPlayer+1
        if iPlayer == 3 then
            iPlayer = 1  
        end
        self.StartScreen["Player"]=diffrentPlayers[iPlayer]
        love.setCursor(diffrentPlayersData[iPlayer])
    end)
    self.StartButtons["PlayerLeft"]= View.createButton(500,250,100,40,"<",function(button)
        iPlayer=iPlayer-1
        if iPlayer == 0 then
            iPlayer = 2  
        end
        self.StartScreen["Player"]=diffrentPlayers[iPlayer]
       love.setCursor(diffrentPlayersData[iPlayer]) 
    end)
    self.StartButtons["Sound"]= View.createButton(600,0,100,40,"TON",function(button)
        
    end)
    self.StartButtons["difficulty"]= View.createButton(200,0,100,40,"Leicht",function(button)
        if self.StartButtons.difficulty.text == "Schwer" then
           self.StartButtons.difficulty.text= "Leicht" 
        else
        self.StartButtons.difficulty.text= "Schwer"
        end
    end)
    self.StartButtons["StartButton"]= View.createButton(350,500,100,40,"START",function(button)
        self:CreateField()
        for _, button in pairs(self.StartButtons) do
            button.enabled = false
         end
        self.bStart = false
    end)
end

function View.createButton(x, y, width, height, text, onClick)
    return {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        onClick = onClick,
        isHovered = false,
        enabled = true,

        draw = function(self)
            if self.enabled == false then
                return
            end    
            if self.isHovered then
                love.graphics.setColor(0.8, 0.8, 0.8)
            else
                love.graphics.setColor(1, 1, 1)
            end
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
            
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
            
            local textWidth = love.graphics.getFont():getWidth(self.text)
            local textHeight = love.graphics.getFont():getHeight()
            love.graphics.print(self.text, self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
        end,

        update = function(self, mouseX, mouseY)
            if self.enabled == false then
                return
            end
            self.isHovered = mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
        end,

        click = function(self)
            if self.enabled == false then
                return
            end
            if self.isHovered and self.onClick then
                self.onClick(self) 
            end
        end
    }
end

View.buttons = {}

function View:CreateField()
    self.buttons["BackToStart"]= View.createButton(700,0,100,40,"BackToStart",function(button)
        self.bStart = true
        
    end)
    local buttonWidth, buttonHeight = 40, 40
    for i = 1, 14 do
        for j = 0, 19 do
            self.buttons[i.."Feld"..j]= self.createButton(j * buttonWidth, i * buttonHeight, buttonWidth, buttonHeight, "", function(button)
                local stext = "O"
                if controller.isFail(i+1, j+1)== const.VERLOREN then
                    stext ="X"
                else
                    controller.checkField(i+1, j+1)
                end
                button.text = tostring(stext)
            end)
        end
    end
end


function View:draw()
    if self.bStart == false then
        for _, button in pairs(self.buttons) do
            button:draw()
        end  
    end 
    
    if self.bStart then
        for _, button in pairs(self.StartButtons) do
            button.enabled = true
         end
        for _, StartButtons in pairs(self.StartButtons) do
            StartButtons:draw()
        end
        love.graphics.setColor(1,1,1)
        love.graphics.draw(self.StartScreen["Map"], 150, 150)   
        love.graphics.draw(self.StartScreen["Player"], 580, 180)
    end
end

function View:update()
    local mouseX, mouseY = love.mouse.getPosition()
    for _, button in pairs(self.buttons) do
        button:update(mouseX, mouseY)
    end 
    for _, button in pairs(self.StartButtons) do
        button:update(mouseX, mouseY)
    end 
end

return View