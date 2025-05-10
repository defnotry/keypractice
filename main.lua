repeat
    task.wait()
until game:IsLoaded()
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local FileName = "devrykey.txt"
local ServiceID = "devryhub98"

if Character then
    Library:Notify("DevryHub: Character loaded. Initializing script...")
end

local savedKey = nil
local KeyValid = false

local function ReadKey()
    Library:Notify("DevryHub: Reading key...")
    if isfile and isfile(FileName) then
        return readfile(FileName)
    elseif pcall(function()
        return syn and syn.request
    end) then
        return pcall(function()
            return syn.request({
                Url = "synuserdata://" .. FileName,
                Method = "GET"
            }).Body
        end)
    end
    return nil
end

local function ValidateKey(key)
    Library:Notify("DevryHub: Validating key...")
    -- return Pelinda.Init({
    --     Service = ServiceID,
    --     SilentMode = true,
    --     Key = key,
    --     SecurityLevel = 1
    -- })
    if key == "devryhub98" then
        return "validated!!"
    else
        return "invalid!!"
    end
end

local function SaveKey(key)
    Library:Notify("DevryHub: Saving key...")
    if writefile then
        writefile(FileName, key)
    elseif pcall(function()
        return syn and syn.request
    end) then
        pcall(function()
            syn.request({
                Url = "synuserdata://" .. FileName,
                Method = "PUT",
                Body = key
            })
        end)
    end
end

local function getRevenueMode(service)
    local url = "https://pandadevelopment.net/api/revenue-mode?service=" .. ServiceID

    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
    end)
    if success and response.Success then
        local responseJson = HttpService:JSONDecode(response.Body)
        return responseJson.revenueMode or ""
    else
        warn("Error getting revenue mode:", response and response.StatusCode or "Request failed")
        return ""
    end
end

local function GetHwid()
    if gethwid then
        return gethwid()
    end
    local success, Payload = pcall(function()
        return request({
            Url = "http://httpbin.org/get",
            Method = "GET"
        })
    end)
    if success and Payload and Payload.Body then
        local JsonData = HttpService:JSONDecode(Payload.Body)
        if JsonData and JsonData.headers then
            for Index, Value in pairs(JsonData.headers) do
                if Index:lower():find("fingerprint") then
                    return Value
                end
            end
        end
    end
end

local function getKeyUrl(service)
    local hwid = GetHwid()
    local revenueMode = getRevenueMode(service)

    if revenueMode == "SECUREDLINKVERTISE" or revenueMode == "SECUREDLOOTLABS" or revenueMode ==
        "SECUREDLINKVERTISEANDLOOTLABS" then
        return "https://pandadevelopment.net/getkey/proceed_hwid?service=" .. service .. "&hwid=" .. hwid
    else
        return "https://pandadevelopment.net/getkey?service=" .. service .. "&hwid=" .. hwid
    end
end

if getgenv().devryhub_key and getgenv().devryhub_key ~= "insert_key_here" then
    if ValidateKey(getgenv().devryhub_key) == "validated!!" then
        Library:Notify("DevryHub: Key validated. Initializing script...")
        SaveKey(getgenv().devryhub_key)
        KeyValid = true
    else
        savedKey = ReadKey()
        Library:Notify("DevryHub: Provided Key was invalid. Initiating key verification...")
        KeyValid = false
    end
else
    savedKey = ReadKey()
    Library:Notify("DevryHub: Key was not found. Initiating key verification...")
    KeyValid = false
end

if savedKey then
    if ValidateKey(savedKey) == "validated!!" then
        Library:Notify("DevryHub: Key validated. Initializing script...")
        KeyValid = true
    else
        Library:Notify("DevryHub: Key is invalid. Initiating key verification...")
        KeyValid = false
    end
end

if not KeyValid then
    local KeyLibrary = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local user_key = ""

    local KeyWindow = KeyLibrary:CreateWindow({
        Title = 'DevryHub',
        Center = true,
        AutoShow = true,
        Resizable = true,
        Size = UDim2.fromOffset(480, 360),
        ShowCustomCursor = true,
        NotifySide = "Left",
        TabPadding = 8,
        MenuFadeTime = 0.2
    })

    local KeyTab = KeyWindow:AddTab("Key Verification")

    local MainGroupbox = KeyTab:AddLeftGroupbox("Process Key")
    MainGroupbox:AddInput("KeyInput", {
        Default = 'Insert Key Here',
        Numeric = false,
        Finished = false,
        ClearTextOnFocus = true,

        Text = 'KeyInput',
        Tooltip = 'This is a tooltip',

        Placeholder = 'Insert Key Here',
        Callback = function(Value)
            user_key = Value
        end
    })

    MainGroupbox:AddButton({
        Text = "Check Key",
        Func = function()
            if user_key ~= "" then
                if ValidateKey(user_key) == "validated!!" then
                    Library:Notify("DevryHub: Key validated. Initializing script...")
                    SaveKey(user_key)
                    KeyValid = true
                    KeyLibrary:Unload()
                else
                    Library:Notify("DevryHub: Key is invalid. Please try again.")
                    KeyValid = false
                end
            end
        end
    })
    MainGroupbox:AddDivider()
    MainGroupbox:AddButton({
        Text = "Get Key",
        Func = function()
            Library:Notify("DevryHub: Key retrieved. Please paste it into the browser.")
            setclipboard("test")
        end
    })
end

repeat
    task.wait()
until KeyValid

task.spawn(function()
    while true do
        Library:Notify("Welcome to DevryHub!")
        task.wait(5)
    end
end)

local Window = Library:CreateWindow({
    Title = 'DevryHub',
    Center = true,
    AutoShow = true,
    Resizable = true,
    Size = UDim2.fromOffset(480, 360)
})

local Tab = Window:AddTab("Main")

local Groupbox = Tab:AddLeftGroupbox("Main")
