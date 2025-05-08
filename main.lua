local key = game:GetService("ScriptContext").RequestUrl:match("key=([^&]+)")

if key and key == "test" then
    print("Key is valid")
else
    print("Key is invalid")
end

