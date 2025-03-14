
local View = {}
require("const")
local controller = require("Controller")
View.StartButtons = {}
View.Backgroundsound = nil
local bTon = "Tonan"
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
    self.StartScreen["Sweeper"]= love.graphics.newImage("Sweeper.png") 
    
    self.StartButtons["MapRight"]= View.createButton(200,460,100,40,"Rechts",function(button)
        iMap=iMap+1 -- variable machen
        if iMap == 4 then
          iMap = 1  
        end
        self.StartScreen["Map"]=diffrentMaps[iMap]
    end)
    self.StartButtons["MapLeft"]= View.createButton(100,460,100,40,"Links",function(button)
        iMap=iMap-1
        if iMap == 0 then
          iMap = 3  
        end
        self.StartScreen["Map"]=diffrentMaps[iMap]
    end)
    self.StartButtons["PlayerRight"]= View.createButton(600,460,100,40,"Rechts",function(button)
        iPlayer=iPlayer+1
        if iPlayer == 3 then
            iPlayer = 1  
        end
        self.StartScreen["Player"]=diffrentPlayers[iPlayer]
        love.setCursor(diffrentPlayersData[iPlayer])
    end)
    self.StartButtons["PlayerLeft"]= View.createButton(500,460,100,40,"Links",function(button)     
        iPlayer=iPlayer-1
        if iPlayer == 0 then
            iPlayer = 2  
        end
        self.StartScreen["Player"]=diffrentPlayers[iPlayer]
       love.setCursor(diffrentPlayersData[iPlayer]) 
    end)
    self.StartButtons["Sound"]= View.createButton(0,0,100,40,bTon,function(button)
        if self.StartButtons.Sound.text == "Tonan" then
            self.StartButtons.Sound.text= "Tonaus"
            bTon = "Tonaus"
            self.Backgroundsound:pause()
         else
         self.StartButtons.Sound.text=  "Tonan"
         bTon = "Tonan"
         love.audio.play(self.Backgroundsound)
         end 
    end)
    self.StartButtons["difficulty"]= View.createButton(350,460,100,40,"Leicht",function(button)
        if self.StartButtons.difficulty.text == "Schwer" then
           self.StartButtons.difficulty.text= "Leicht" 
        else
        self.StartButtons.difficulty.text= "Schwer"
        end
    end)
    self.StartButtons["Language"]= View.createButton(700,0,100,40,"Deutsch",function(button)
        if self.StartButtons.Language.text == "Deutsch" then
            controller.setLanguage(const.English) 
           self.StartButtons.Language.text= "Englisch"
        else
            controller.setLanguage(const.German)    
        self.StartButtons.Language.text= "Deutsch"
        end
    end)
    self.StartButtons["StartButton"]= View.createButton(350,500,100,40, "Start",function(button)
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
            
            local textWidth = love.graphics.getFont():getWidth(controller.getText(self.text))
            local textHeight = love.graphics.getFont():getHeight()
            love.graphics.print(controller.getText(self.text), self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
        end,

        update = function(self, mouseX, mouseY)
            if self.enabled == false then
                return
            end
            self.isHovered = mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
        end,

        click = function(self, buttonType)
            if self.enabled == false then
                return
            end
            if self.isHovered and self.onClick then
                self.onClick(self, buttonType)  -- Rechts- oder Linksklick übergeben 
            end
        end
    }
end

View.buttons = {}

function View:CreateField()
    self.buttons["BackToStart"]= View.createButton(700,0,100,40,"Hauptmenue",function(button)
        self.bStart = true
        
    end)
    self.buttons["Sound"]= View.createButton(0,0,100,40,bTon,function(button)
        if self.buttons.Sound.text == "Tonan" then
            self.buttons.Sound.text= "Tonaus"
            bTon = "Tonaus"
            self.Backgroundsound:pause()
         else
         self.buttons.Sound.text= "Tonan"
         bTon = "Tonan"
         love.audio.play(self.Backgroundsound)
         end 
    end)
    local buttonWidth, buttonHeight = 40, 40
    for i = 1, 14 do
        for j = 0, 19 do
            self.buttons[i.."Feld"..j]= self.createButton(j * buttonWidth, i * buttonHeight, buttonWidth, buttonHeight, "Nichts", function(button, buttonType)
                local stext = "Nichts" 
                if buttonType == 2 then  -- Rechtsklick
                    if button.Fahne then
                        button.Fahne=false
                    else
                        button.Fahne=true
                    end
                elseif controller.isFail(i+1, j+1)== const.VERLOREN then
                    stext ="X"
                else
                    controller.checkField(i+1, j+1)
                    stext = "O"
                end
                button.text = tostring(stext)
            end)
        end
    end
end


function View:draw()
    if self.bStart == false then
        for _, button in pairs(self.buttons) do
            if button.Fahne then
                love.graphics.setColor(1, 0, 0)  -- Rot für Fahne
                love.graphics.rectangle("fill",button.x+button.width/2-button.width*0.2/2,
                button.y+button.height*0.1,
                button.width*0.2,
                button.height*0.8)
                love.graphics.polygon("fill",
                button.x+button.width/2-button.width*0.2/2+button.width*0.2, button.y+button.height*0.1,
                button.x + button.width,button.y+button.height*0.1+button.height*0.8/2 / 2,
                button.x+button.width/2-button.width*0.2/2+button.width*0.2,button.y+button.height*0.1+button.height*0.8/2)
            else
                button:draw()
            end
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
        love.graphics.draw(self.StartScreen["Map"], 150, 360)   
        love.graphics.draw(self.StartScreen["Player"], 580, 390)
        love.graphics.draw(self.StartScreen["Sweeper"], 135, 100)
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