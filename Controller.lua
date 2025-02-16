local controller = {}
local model = require("Model")
 model.CreateField(1)
 function controller.isFail(x,y)
    model:isFail(x,y)        
 end
return controller