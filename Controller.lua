local controller = {}
local model = require("Model")
 model.ran()
 model.CreateField(9)
 function controller.isFail(x,y)
    return model:isFail(x,y)        
 end
 function controller.checkField(x,y)
   local field = {}
   for i = 1, 15, 1 do
      field[i] = {}
      for x = 1, 20, 1 do
          field[i][x]=false 
      end
  end
   if model:isFail(x,y+1) then

   else   
      
   end
 end
return controller