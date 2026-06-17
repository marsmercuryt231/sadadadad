    local Players = game.Players
    local player = Players.LocalPlayer
    local name = Players.LocalPlayer.Name
    local Found = false
    local VIM = game:GetService("VirtualInputManager")
    local canSpare = true
    
    webhook = "https://discord.com/api/webhooks/1516555190461796515/tvKNIanTmJaSjXE659Pr0HafDNeqhzOncJ4Oa22P5ThuwgZVLrMLRdtXEwqBfrSc8jAl"
    local http = game:GetService("HttpService")
    local curr = nil
    function click(button)
        for i = 1, 2 do
            VIM:SendMouseButtonEvent(button.AbsolutePosition.X+button.AbsoluteSize.X/2, button.AbsolutePosition.Y+button.AbsoluteSize.Y/0.7, false and 1 or 0, i == 1, nil, 0)
        end
    end
    local UserInputService = game:GetService("UserInputService")
    
    local spareCount = 0 

    local Alphas = {
        "Dakuda", "Cosmeleon", "Ikazune", "Dractus-anniv24", "Sharpod-anniv24", "Mirrami-anniv24", "Duskit", "Protogon", "Duskit-plush", "Scorb-sapphire", "Scorb-ruby", "Scorb-emerald"
    }
    
    local Gammas = {
        "Dakuda", "Cosmeleon", "Duskit", "Ikazune", "Protogon", "Glacadia", "Arceros", "Pyramind", "Vari", "Dractus-anniv24", "Sharpod-anniv24", "Mirrami-anniv24", "Duskit-plush", "Sharpod", "Skilava"
    }
    
    function gleam()
        local prefix = nil
        for i, v in ipairs(game.Workspace:WaitForChild("chunk11"):GetDescendants()) do
            if v.Name == "Aura" then
                prefix = "Alpha"
            end

            if string.find(v.Name, "Wisp") then
                prefix = "Gamma"
            end
        end

        
        return prefix
    end


    function clickPos(x, y)
        for i = 1, 2 do
            VIM:SendMouseButtonEvent(x, y, false and 1 or 0, i == 1, nil, 0)
        end
    end

    local function SendWebhook(msg)
        task.spawn(function()
            data = {
                ["content"] = "@everyone",
                ["embeds"] = {
                    {
                        ["title"] = "Wilk Bot",
                        ["description"] = player.Name.." has found a "..gleam().." "..msg,
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
    
    local function check()
        if game.Workspace:FindFirstChild("trickretreat").BuiltInBattleScenes.Model then
        local Scene = game.Workspace:FindFirstChild("trickretreat").BuiltInBattleScenes.Model:GetChildren()
        local imstupid = nil
        for i, v in pairs(Scene) do
            if (table.find(Alphas, v.Name) and gleam() == "Alpha") or (table.find(Gammas, v.Name) and gleam() == "Gamma") or (v.Name == "Ikazune") then
                Found = true
                curr = v.Name
                local foe = player.PlayerGui.BackGui:WaitForChild("Frame"):WaitForChild("FoeHealthGui")
                for i, v in ipairs(foe:GetDescendants()) do
                    if v.Name == "Frame" then
                        if math.round(v.AbsolutePosition.X) == 603 and math.round(v.AbsolutePosition.Y) == 92 then
                            if v.AbsoluteSize.X > 5 then
                                canSpare = true
                            else
                                canSpare = false
                            end
                        end
                    end
                end
                return
            end
        end
        local Frame = Players.LocalPlayer.PlayerGui.MainGui


        if Frame and Frame:FindFirstChild("BattleGui") then
            local run = Frame:FindFirstChild("BattleGui").Run
            click(run)
        end
        Found = false
    end
    end
    function idum()
    while true do
    check()
    wait(0.5)
    end
    end
    
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
                            click(answer[2])
                            SendWebhook(curr)
                            wait(1)
                            canSpare = true

                        end
                    end
                    wait(0.05)
                end
            end
            wait()
        end
    end

    --771860314 particle id
    function spare()
        if player.PlayerGui.MainGui and player.PlayerGui.MainGui:FindFirstChild("BattleGui") then
            clickPos(328 + 144, 249 + 59)
            wait(0.2)
            clickPos(328 + 144, 249 + 50)
            wait(1)
            clickPos(85+144, 218+59)
            wait(0.2)
            clickPos(85+144, 218+59)
        end
        spareCount += 1    
        if spareCount < 2 then
            spare()
        end
    end

    function cursor()
        while true do
            if not game.Workspace:FindFirstChild("trickretreat").BuiltInBattleScenes.Model then
                clickPos(400, 200)
                local main = game:GetService("Players").HelloMotherIdo.PlayerGui.MainGui
                if main:FindFirstChild("Frame") then
                    for i, v in ipairs(main.Frame:GetChildren()) do
                        if v:IsA("ImageLabel") and v.Visible == true and Color3.fromRGB(49, 202, 113) then
                            VIM:SendMouseMoveEvent(v.AbsolutePosition.X+v.AbsoluteSize.X/2, v.AbsolutePosition.Y+v.AbsoluteSize.Y/1.2, nil)
                            wait()
                        end
                    end
                end
                wait()
            end
            wait()
        end
    end

    --local cursorTask = coroutine.create(cursor)
    --coroutine.resume(cursorTask)
    local checkTask = coroutine.create(idum)
    coroutine.resume(checkTask)
    local noTask = coroutine.create(no)
    coroutine.resume(noTask)


    while true do
    if Found == true then
        local items = nil
        local fight = nil
        
        local Elements = Players.LocalPlayer.PlayerGui.MainGui:WaitForChild("BattleGui")
        for i, v in pairs(Elements:GetChildren()) do
            if v.Name == "ImageLabel" then
                if v.ImageColor3 == Color3.fromRGB(255, 204, 102) then
                items = v.Button
                end
            end
        end
        for i, v in pairs(Elements:GetChildren()) do
            if v.Name == "ImageLabel" then
                if v.ImageColor3 == Color3.fromRGB(255, 102, 102) then
                    fight = v.Button
                end
            end
        end


        if spareCount < 2 then
            spare()
        else 
            spareCount = 0
        end

        

        wait(0.1)
        click(items)
        wait(0.2)

        if Players.LocalPlayer.PlayerGui.MainGui:WaitForChild("WatchContainer"):FindFirstChild("BagMenu") then
            local Bag = Players.LocalPlayer.PlayerGui.MainGui:WaitForChild("WatchContainer"):WaitForChild("BagMenu"):WaitForChild("Frame"):WaitForChild("BattleContainer"):WaitForChild("DiscContainer"):WaitForChild("ContentContainer")
            wait(1)
            if curr == "Duskit-plush" and gleam() == "Gamma" then
                click(Bag:GetChildren()[2])
            else
                click(Bag:GetChildren()[1])
            end
            wait(0.5)
            local BattleDetails = Players.LocalPlayer.PlayerGui.MainGui:WaitForChild("WatchContainer"):WaitForChild("BagMenu"):WaitForChild("Frame"):WaitForChild("BattleDetailsContainer")
            local real = {}
            for i, v in pairs(BattleDetails:GetChildren()) do
                if v:IsA("ImageButton") then
                    table.insert(real, v)
                end
            end

            for i = 1, 2 do
                VIM:SendMouseButtonEvent(real[1].AbsolutePosition.X+real[1].AbsoluteSize.X/2, real[1].AbsolutePosition.Y+real[1].AbsoluteSize.Y/0.5, false and 1 or 0, i == 1, nil, 0)
            end

            wait(0.5)
        end
  
    end

    wait()
    end

    

