    local Players = game.Players
    local player = Players.LocalPlayer
    local name = Players.LocalPlayer.Name
    local VIM = game:GetService("VirtualInputManager")
    local curr = nil
    local currGleam = nil
    local char = player.Character or player.CharacterAdded:Wait()
    local http = game:GetService("HttpService")
    local GuiService = game:GetService("GuiService")

    webhook = "https://discord.com/api/webhooks/1516555190461796515/tvKNIanTmJaSjXE659Pr0HafDNeqhzOncJ4Oa22P5ThuwgZVLrMLRdtXEwqBfrSc8jAl"
   function click(button, xOffset, yOffset)
        if button and button.Visible then
            local absPos = button.AbsolutePosition
            local absSize = button.AbsoluteSize

            local x = math.floor(absPos.X + absSize.X * xOffset + 0.5)
            local y = math.floor(absPos.Y + absSize.Y * yOffset + 0.5)

            print("Clicking at:", x, y)

            -- Mouse down
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.05)
            -- Mouse up
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end
    end
    
    local function SendWebhook(msg)
        task.spawn(function()
            data = {
                ["content"] = "@everyone",
                ["embeds"] = {
                    {
                        ["title"] = "Wilk Bot",
                        ["description"] = player.Name.." has found a "..currGleam.." "..msg,
                        ["type"] = "rich",
                        ["color"] = tonumber(string.format("0x%X", math.random(0x000000, 0xFFFFFF))),
                    }
                }
            }
            repeat task.wait() until data
            local newdata = game:GetService("HttpService"):JSONEncode(data)
            local headers = {
                ["Content-Type"] = "application/json"
            }
            local request = http_request or request or HttpPost or syn.request or http.request
            local abcdef = {Url = webhook, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
        end)
    end
    
    local function pressKey(keyCode)
        VIM:SendKeyEvent(true, keyCode, false, game)
        task.wait(0.1)
        VIM:SendKeyEvent(false, keyCode, false, game)
        task.wait(0.2)
    end
    function mouseMove(button, xOffset, yOffset)
        if button and button.Visible then
            local absPos = button.AbsolutePosition
            local absSize = button.AbsoluteSize

            local x = math.floor(absPos.X + absSize.X * xOffset + 0.5)
            local y = math.floor(absPos.Y + absSize.Y * yOffset + 0.5)

        
            VIM:SendMouseMoveEvent(x, y, nil)

        end
    end 
    local UserInputService = game:GetService("UserInputService")
    
    

    local Alphas = {
        "kyeggo-r", "pattern4", "fab"
    }
    
    local Gammas = {
        "kyeggo-r", "pattern", "fab", "kyeggo"
    }
    
    local temp = {

    }


    function findButton(container, options)
    for _, obj in ipairs(container:GetDescendants()) do
        if not options.className or obj.ClassName == options.className or obj.Name == options.className then
            local isMatch = true

            if options.text then
                local textMatch = false
                for _, child in ipairs(obj:GetChildren()) do
                    if (child:IsA("TextLabel") or child:IsA("TextButton")) and string.find(child.Text, options.text) then
                        textMatch = true
                        break
                    end
                end
                isMatch = isMatch and textMatch
            end

            if options.color then
                if obj:IsA("ImageLabel") then
                    isMatch = isMatch and (obj.ImageColor3 == options.color)
                elseif obj:IsA("GuiObject") then
                    isMatch = isMatch and (obj.BackgroundColor3 == options.color)
                else
                    isMatch = false
                end
            end

            if options.childName then
                isMatch = isMatch and obj:FindFirstChild(options.childName) ~= nil
            end

            if isMatch then
                return obj
            end
        end
    end

    return nil
end

    
function gleam(entity)
    local prefix = nil
    for _, v in ipairs(entity:GetDescendants()) do
        if v.Name == "Aura" then
            if v.Texture == "rbxassetid://771860314" then
                prefix = "Alpha"
            end
        end
        if string.find(v.Name, "Wisp") then
            prefix = "Gamma"
            return prefix 
        end
    end
    if prefix == nil then prefix = "Normal" end
    return prefix
end


    function clickPos(x, y)
        for i = 1, 2 do
            VIM:SendMouseButtonEvent(x, y, false and 1 or 0, i == 1, nil, 0)
        end
    end

   -- helper: does `str` contain ANY entry from `tbl` as a substring? (case-insensitive, plain text)
    local function containsSubstringFromTable(str, tbl)
        str = string.lower(str)
        for _, word in ipairs(tbl) do
            if string.find(str, string.lower(word), 1, true) then
                return true
            end
        end
        return false
    end


local function runEncounterActions()
    print("FOUND")
    local items = nil
    local mainFrame = Players.LocalPlayer.PlayerGui.MainGui
    local battleGui = mainFrame and mainFrame:FindFirstChild("BattleGui")
    if not battleGui then
        print("no battle")
        return false
    end
    local okButton = findButton(battleGui, {color = Color3.fromRGB(255, 204, 102)})
    if not okButton then
        print("no ok ")
        return false
    end
    click(okButton, 0.5, 1.2)
    wait(0.1)
    click(okButton, 0.5, 1.2)
    print(okButton.Name)
    wait(0.2)

    local watchContainer = Players.LocalPlayer.PlayerGui.MainGui:FindFirstChild("WatchContainer")
    local bagMenu = watchContainer and watchContainer:FindFirstChild("BagMenu")

    if not (bagMenu and bagMenu.Visible) then
        return false
    end

    local Bag = bagMenu:WaitForChild("Frame"):WaitForChild("BattleContainer"):WaitForChild("DiscContainer"):WaitForChild("ContentContainer")
    wait(1)
    click(Bag:GetChildren()[1], 0.75, 1.6)
    click(Bag:GetChildren()[1], 0.75, 2)
    click(Bag:GetChildren()[1], 0.75, 3.2)

    wait(0.5)
    local BattleDetails = bagMenu:WaitForChild("Frame"):WaitForChild("BattleDetailsContainer")
    local real = {}
    for i, v in pairs(BattleDetails:GetChildren()) do
        if v:IsA("ImageButton") then
            table.insert(real, v)
        end
    end
    click(real[1], 0.75, 1)
    click(real[1], 0.75, 2)
    click(real[1], 0.75, 2.5)
    click(real[1], 0.75, 4)
    wait(0.5)

    print("true")
    return true
end


local function onEncounterStart(plat)
    print("entered")
    task.wait(0.2)
    print("after wait")
    while true do
        local Scene = plat.Parent:GetDescendants()
        print("scene size:", #Scene)
        for _, v in ipairs(Scene) do
            if v.Name ~= "Plat21" and v.Parent.Name ~= "Double" and not string.find(string.lower(v.Name), "plat") then
                local kind = gleam(v)
                print(v.Name, kind)
                if (containsSubstringFromTable(v.Name, Alphas) and kind == "Alpha")
                    or (containsSubstringFromTable(v.Name, Gammas) and kind == "Gamma")
                    or (containsSubstringFromTable(v.Name, temp)) then
                    print("MATCHED:", v.Name, kind)
                    curr = v
                    currGleam = kind
                    while true do
                        runEncounterActions()
                        local mainFrame = Players.LocalPlayer.PlayerGui.MainGui
                        local battleGui = mainFrame and mainFrame:FindFirstChild("BattleGui")
                        if not battleGui then
                            return
                        end
                        task.wait(0.3)
                    end
                end
            end
        end
        -- nothing matched, try clicking Run
        local Frame = Players.LocalPlayer.PlayerGui.MainGui
        local battleGui = Frame and Frame:FindFirstChild("BattleGui")
        print("battleGui:", battleGui)
        if not battleGui then
            return
        end
        local run = battleGui.Run
        click(run, 0.5, 2)
        print("made it here")
        task.wait(0.3)
        Frame = Players.LocalPlayer.PlayerGui.MainGui
        if not (Frame and Frame:FindFirstChild("BattleGui")) then
            return
        end
    end
end

local function onEncounterEnd()
    if curr then
        SendWebhook(curr.Name)
    end
    curr = nil
    currGleam = nil
end

local mainGui = player.PlayerGui:WaitForChild("MainGui")

local lastEncounterTime = os.time()

mainGui.DescendantAdded:Connect(function(child)
    if child.Name == "BattleGui" then
        lastEncounterTime = os.time()
        task.wait(2)
        local plat = game.Workspace:FindFirstChild("Plat21", true)
        if plat then
            onEncounterStart(plat)
        end
    end
end)

task.spawn(function()
    while task.wait(10) do
        if os.time() - lastEncounterTime > 120 then
            print("No encounter in 2 minutes, reconnecting...")
            game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        end
    end
end)

mainGui.DescendantRemoving:Connect(function(child)
    if child.Name == "BattleGui" then
        onEncounterEnd()
    end
end)




local PlayerGui = player:WaitForChild("PlayerGui")

function no()
        while true do

            if Players.LocalPlayer.PlayerGui.FrontGui and Players.LocalPlayer.PlayerGui.FrontGui:FindFirstChild("YesOrNoPrompt") then

                local YesNo  = Players.LocalPlayer.PlayerGui.FrontGui.YesOrNoPrompt:GetChildren()
                local answer = {}

                for i, v in pairs(YesNo) do
                    if Players.LocalPlayer.PlayerGui.FrontGui and Players.LocalPlayer.PlayerGui.FrontGui:FindFirstChild("YesOrNoPrompt") then
                            
                        local YesNo  = Players.LocalPlayer.PlayerGui.FrontGui.YesOrNoPrompt
                        local answer = {}
                        
                        for i, v in pairs(YesNo:GetChildren()) do
                            if v:IsA("ImageButton") then
                                table.insert(answer, v)
                            end
                        end

                        if YesNo.Visible == true then
                            click(answer[2], 0.5, 2.2)
                            wait(0.2)
                        end
                    end
                    wait(0.05)
                end
            end
            wait()
        end
    end

local noTask = coroutine.create(no)
coroutine.resume(noTask)




task.spawn(function()
    while true do
        for _, v in ipairs(game.Workspace:GetDescendants()) do
            if v:IsA("Model") and string.find(string.lower(v.Name), "trainer", 1, true) then
                v:Destroy()
            end
            if (v.Name == "Door" and v.Parent.Name ~= "Gate") or v.Name == "Grass" then
                v:Destroy()
            end
            if string.find(string.lower(v.Name), "cavedoor", 1, true) then
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)

-- menu clicker runs freely after

   
--771860314 particle id




