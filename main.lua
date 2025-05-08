local key = rawget(_G, "script_key")
if key == "test" then
    print("Access granted")
else
    error("Invalid key")
end
