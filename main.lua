-- verify
if getgenv().key ~= "123" then
    error("no")
else
    print("KEY HAS BEEN VERIFIED")
end

-- rest of script