
local View = {}
require("const")
local controller = require("Controller")
View.StartButtons = {}
View.StartScreen = {}
View.bStart = true
function View:CreateStartScreen()
    
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1) -- Dunkler Hintergrund
    love.graphics.setColor(1, 1, 1) -- Weißer Text
    local quickanddirty = {Map1=love.graphics.newImage("Map1.png"),Map2=love.graphics.newImage("Map2.png"),Map3=love.graphics.newImage("Map3.png"),}
    local quickanddirtea = quickanddirty.Map1 
    
    self.StartScreen["Map"]= quickanddirtea
    
    self.StartButtons["PlayerRight"]= View.createButton(200,250,100,40,">",function(button)
        
    end)
    self.StartButtons["PlayerLeft"]= View.createButton(100,250,100,40,"<",function(button)
        
    end)
    self.StartButtons["Sound"]= View.createButton(600,0,100,40,"TON",function(button)
        
    end)
    self.StartButtons["difficulty"]= View.createButton(200,0,100,40,"Leicht",function(button)
        self.StartButtons.difficulty.text= "Schwer"
    end)
    self.StartButtons["StartButton"]= View.createButton(350,500,100,40,"START",function(button)
        self:CreateField()
        self.StartButtons.StartButton.enabled =false
        self.StartButtons.PlayerLeft.enabled =false
        self.StartButtons.PlayerRight.enabled =false
        self.StartButtons.difficulty.enabled =false
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
    
    for _, StartButtons in pairs(self.StartButtons) do
        StartButtons:draw()
    end
    if self.bStart then
        for _, StartScreen in pairs(self.StartScreen) do
            love.graphics.setColor(1,1,1)
            love.graphics.draw(StartScreen,150,150)
        end  
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