
local View = {}
local controller = require("Controller")

function View.createButton(x, y, width, height, text, onClick)
    return {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        onClick = onClick,
        isHovered = false,

        draw = function(self)
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
            self.isHovered = mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
        end,

        click = function(self)
            if self.isHovered and self.onClick then
                self.onClick()
            end
        end
    }
end
View.buttons = {}

function View:CreateField()
    local buttonWidth, buttonHeight = 40, 40
    for i = 0, 14 do
        for j = 0, 19 do
            table.insert(self.buttons, self.createButton(j * buttonWidth, i * buttonHeight, buttonWidth, buttonHeight, "", function()
                print("Button at (" .. j .. ", " .. i .. ") clicked!")
                controller
            end))
        end
    end

end

function View:draw()
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

function View:update()
    local mouseX, mouseY = love.mouse.getPosition()
    for _, button in ipairs(self.buttons) do
        button:update(mouseX, mouseY)
    end 
end

return View