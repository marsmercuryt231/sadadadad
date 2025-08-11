    local VIM = game:GetService("VirtualInputManager")
    local Players = game.Players
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local portal = game.Workspace.chunk11.GardroneRaidCave.Trigger
    local Char = player.Character
    local humanoid = Char.Humanoid
    local RootPart =  Char.HumanoidRootPart
    local watch = player.PlayerGui.MainGui.WatchContainer
    --local RaidMenu = game.Players.LocalPlayer.PlayerGui.MainGui.RaidLobbyMenu
    local leaders = {"HelloMotherIdo", "RichChineseWoman", "RawblocksBaddie"} 
    local isLeader = false





    for i, v in pairs(leaders) do
        if v == player.Name then
            isLeader = true;
        end
    end
    function Click(x, y)
        for i = 1, 2 do
            VIM:SendMouseButtonEvent(x, y, false and 1 or 0, i == 1, nil, 0)
        end
    end
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


    function yes()

        while true do
            if Players.LocalPlayer.PlayerGui.FrontGui and Players.LocalPlayer.PlayerGui.FrontGui:FindFirstChild("YesOrNoPrompt") then
            
                local YesNo  = Players.LocalPlayer.PlayerGui.FrontGui.YesOrNoPrompt
                local answer = {}
                
                for i, v in pairs(YesNo:GetChildren()) do
                    if v:IsA("ImageButton") then
                        table.insert(answer, v)
                    end
                end
                if YesNo.Visible == true then
                    Click(answer[1].AbsolutePosition.X+answer[1].AbsoluteSize.X/2, answer[1].AbsolutePosition.Y+answer[1].AbsoluteSize.Y/2 + 50)
                end
            end
            wait(0.05)
        end
    end


    coroutine.wrap(yes)()
    function findButton(container, options)
    --[[
        options = {
            text = "SomeText",           -- (optional) part of the TextLabel.Text
            color = Color3.fromRGB(...),-- (optional) BackgroundColor3 to match
            childName = "ImageLabel",   -- (optional) required child of the button
            className = "TextButton"    -- (optional) only return buttons of this ClassName
        }
    ]]

    for _, obj in ipairs(container:GetDescendants()) do
        -- Optional: restrict to certain class (e.g. only actual buttons)
        if not options.className or obj.ClassName == options.className or obj.Name == options.className then
            local isMatch = true

            -- Text match (if any TextLabel child exists)
            if options.text then
                local textMatch = false
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("TextLabel") or child:IsA("TextButton") then
                        if string.find(child.Text, options.text) then
                            textMatch = true
                            break
                        end
                    end
                end
                isMatch = isMatch and textMatch
            end

            -- Color match
            if options.color then
                if obj:IsA("GuiObject") then
                    isMatch = isMatch and obj.BackgroundColor3 == options.color
                else
                    isMatch = false -- Can't match color if it's not a GuiObject
                end
            end

            -- Must have child with this name
            if options.childName then
                isMatch = isMatch and obj:FindFirstChild(options.childName) ~= nil
            end

            if isMatch then
                return obj
            end
        end
    end

    return nil -- not found
    end

    print(isLeader)
    function switch() 
        while true do
            if player.PlayerGui.MainGui:FindFirstChild("RaidLobbyMenu") then
                if isLeader then
                    local RaidMenu = player.PlayerGui.MainGui.RaidLobbyMenu
                    local host = findButton(RaidMenu, {
                        text = "+"
                    })
                    
                    click(host, 0.2, 1)

                    wait(0.3)
                    local iceRaid = findButton(RaidMenu, {
                        text = "Nightmare",
                        color = Color3.fromRGB(77, 224, 247)

                    })
                    click(iceRaid, 0.5, 2.6)
                    wait(0.4)
                    local openParty = findButton(RaidMenu,{
                        text = "Invite"
                    })
                    
                    click(openParty, 0.6, 3.5)
                    wait(0.1)
                    click(openParty, 1.4, 0.5)
                    -- click open party
                    --wait 5 seconds then press ready
                    wait(1)

                    local ready = findButton(RaidMenu,{
                        text = "Ready",
                        color = Color3.fromRGB(113, 222, 79)
                    })
                    click(ready, 0.5, 2.5)
                    wait(0.1)

                    for i, v in pairs(RaidMenu.ImageButton.InLobby:GetChildren()) do
                        if v:IsA("TextLabel") then
                            if v.Text == "Too Many Players" and v.Visible == true then
                                local kickButton = findButton(RaidMenu, {
                                    text = "Kick"
                                })
                                click(kickButton, 0.9, 2.75)
                            end
                        end
                    end
                    
                    wait(0.1)
                else
                    local RaidMenu = player.PlayerGui.MainGui.RaidLobbyMenu
                    local join = findButton(RaidMenu, {
                        text = "1/2"
                    })
                    
                    click(join, 0.5, 1)
                    wait(0.3)

                    local ready = findButton(RaidMenu,{
                        text = "Ready",
                        color = Color3.fromRGB(113, 222, 79)
                    })
                    print(ready)
                    click(ready, 0.5, 2.75)
                    wait(0.3)
                end
            else
                humanoid:MoveTo(Vector3.new(1549, 239, 4509))
                wait(1)
                humanoid:MoveTo(portal.Position)
                wait(1)
            end
            
        wait()
        end
    end




    coroutine.wrap(switch)()





    while true do
        if player.PlayerGui.MainGui:FindFirstChild("BattleGui") then
            local fightButton = findButton(player.PlayerGui.MainGui.BattleGui, {
                childName = "FighterIcon"
            })
            click(fightButton, 0.5, 2)
        end

        wait(0.2)
        if player.PlayerGui.MainGui:FindFirstChild("BattleGui") then
            local move1 = findButton(player.PlayerGui.MainGui.BattleGui, {
                className = "Move1"
            })
            click(move1, 0.5, 2)
        end


        if player.PlayerGui:FindFirstChild("MainGui") then
            local okButton = findButton(player.PlayerGui.MainGui, {color = Color3.fromRGB(107, 209, 101)})
            click(okButton, 0.5, 2.75)
        end

        if watch:FindFirstChild("PartyMenu") then
            if watch.PartyMenu.Visible == true then
                if watch.PartyMenu.PartyMain.Slot2 then
                    click(watch.PartyMenu.PartyMain.Slot2.ImageButton, 0.5, 2)

                    print("Helllloooo sacrifice")

                    wait(0.3)

                    if player.PlayerGui.FrontGui:FindFirstChild("SwitchButton") then
                        click(player.PlayerGui.FrontGui.SwitchButton, 0.5, 3.7)
                    end
                    wait(0.3)

                    click(watch.PartyMenu.PartyMain.Slot3.ImageButton, 0.5, 2)
                    wait(0.3)
                    if player.PlayerGui.FrontGui:FindFirstChild("SwitchButton") then
                        click(player.PlayerGui.FrontGui.SwitchButton, 0.5, 3.7)
                    end
                    wait(0.1)
                end
            end
        end  

        wait()

    end

    --join player function:




