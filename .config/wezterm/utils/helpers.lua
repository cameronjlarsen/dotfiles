local M = {}

return setmetatable(M, {
    __call = function(_, config)
        return config
    end
})

