local model = {}

model.field = {}

for i = 0, 14, 1 do
    model.field[i] = {}
    for x = 1, 19, 1 do
        model.field[i][x]=false 
    end
end

function model.CreateField(difficulty)
    for i = 0, 14, 1 do
        model.field[i] = {}
        for x = 1, 19, 1 do
            model.field[i][x]=false 
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
   for i = 0, 14, 1 do
    local randomNumbers = model.getRandomNumbers(numbersOfFailures)
    for _, num in ipairs(randomNumbers) do
        model.field[i][num]=true
    end
   end
end

function model.getRandomNumbers(count)
    math.randomseed(os.time()) -- Zufallszahlen initialisieren
    
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