-- main.lua
-- return a function you can call with the key
return function(key)
    local VALID_KEY = "test"
    if key == VALID_KEY then
        print("Key is valid")
        -- ... do the rest of your logic here
    else
        warn("Key is invalid")
    end
end
