local model = {}

model.field = {}

function model.ran()
    math.randomseed(os.time()) -- Zufall nur einmal initialisieren
end


function model.CreateField(difficulty)
    for i = 1, 15, 1 do
        model.field[i] = {}
        for x = 1, 20, 1 do
            model.field[i][x]=0 -- kein dings in der umgebung
        end
    end
   local numbersOfFailures
   if difficulty == 1 then
    numbersOfFailures = 4
   elseif difficulty == 2 then
    numbersOfFailures = 6
   else
    numbersOfFailures = 9
   end
   for i = 1, 15, 1 do
    local randomNumbers = model.getRandomNumbers(numbersOfFailures)
    for _, num in ipairs(randomNumbers) do
        model.field[i][num]=9 -- verloren
    end
   end
end
function model.setNumbers()
    for i = 1, 15, 1 do
        for x = 1, 20, 1 do
            if model.field[i][x]~=9 then
                local numberField
                if model.field[i-1][x-1]==9 then
                    numberField= numberField+1  
                end
                if model.field[i-1][x]==9 then
                    numberField= numberField+1  
                end
                if model.field[i-1][x+1]==9 then
                    numberField= numberField+1  
                end
                if model.field[i][x+1]==9 then
                    numberField= numberField+1  
                end
                if model.field[i+1][x+1]==9 then
                    numberField= numberField+1  
                end
                if model.field[i+1][x]==9 then
                    numberField= numberField+1  
                end
                if model.field[i+1][x-1]==9 then
                    numberField= numberField+1  
                end
                if model.field[i][x-1]==9 then
                    numberField= numberField+1  
                end
            model.field[i][x]= numberField
           end 
        end
    end
end
function model.getRandomNumbers(count)
    
    local numbers = {}   -- Hier speichern wir die Zufallszahlen
    local used = {}      -- Set, um doppelte Zahlen zu vermeiden
    
    while #numbers < count do
        local num = math.random(0, 19)
        if not used[num] then  -- Prüfen, ob die Zahl schon existiert
            table.insert(numbers, num)
            used[num] = true
        end
    end
    
    return numbers
end

function model:isFail(x,y)
   return self.field[x][y] 
end

return model