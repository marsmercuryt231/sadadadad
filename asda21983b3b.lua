local VIM = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer

local equivalency = {
    ["Route 6"] = { location = "Rally Ranch" },
    ["Route 3"] = { location = "Silvent City", gate = "Route 3" },
    ["Route 4"] = { location = "Silvent City", gate = "Route 4" },
    ["Sepharite Junkyard"] = { location = "Sepharite City", gate = "Route 7" },
    ["Cheshma Town"] = { location = "Cheshma Town" },
    ["Sepharite City"] = { location = "Sepharite City" },
    ["Silvent City"] = { location = "Silvent City" },
    ["Heiwa Village"] = { location = "Heiwa Village" },
    ["Route 8"] = {location = "POLUT Underwater Mining Lab"},
    ["Atlanthian City"] = {location = "Atlanthian City - Living District"}
}

local isGeohopping = false

local char, hrp
local function bindCharacter(c)
    char = c
    hrp = char:WaitForChild("HumanoidRootPart")
end
if player.Character then
    bindCharacter(player.Character)
end
player.CharacterAdded:Connect(bindCharacter)


local function isTooCloseToDoor(position)
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Main" and v:IsA("BasePart") then
            local parent = v.Parent
            if parent and parent.Name == "Door" then
                if (v.Position - position).Magnitude < 20 then
                    return true
                end
            end
        end
    end
    return false
end


local function click(button, xOffset, yOffset)
    if button and button.Visible then
        local absPos = button.AbsolutePosition
        local absSize = button.AbsoluteSize

        local x = math.floor(absPos.X + absSize.X * xOffset + 0.5)
        local y = math.floor(absPos.Y + absSize.Y * yOffset + 0.5)

        print("Clicking at:", x, y)

        VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
    end
end

local function invisibleTeleportTo(cf)
    if not char or not hrp or not hrp.Parent then
        local c = player.Character or player.CharacterAdded:Wait()
        bindCharacter(c)
    end
    hrp.Parent = nil
    hrp.CFrame = cf
    hrp.Parent = char -- no task.wait() here
end

local function pressKey(keyCode)
    VIM:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.1)
    VIM:SendKeyEvent(false, keyCode, false, game)
    task.wait(0.3)
end

local function getTabButtons(mapMenu)
    local buttons = {}
    for _, child in ipairs(mapMenu:GetChildren()) do
        if child:IsA("ImageButton") then
            table.insert(buttons, child)
        end
    end
    table.sort(buttons, function(a, b)
        return a.AbsolutePosition.X < b.AbsolutePosition.X
    end)
    return buttons
end

local function getWeatherFromFrame(frame)
    for _, child in ipairs(frame:GetChildren()) do
        if child.Name == "Frame" and #child:GetChildren() == 2 then
            local textLabel = child:FindFirstChildOfClass("TextLabel")
            if textLabel then
                return textLabel.Text
            end
        end
    end
    return nil
end

local function scrollToAndClick(button, locationsScrollingFrame)
    if not button then return end

    local buttonY = button.AbsolutePosition.Y
    local frameY = locationsScrollingFrame.AbsolutePosition.Y
    local frameHeight = locationsScrollingFrame.AbsoluteSize.Y

    if buttonY < frameY or buttonY > frameY + frameHeight then
        local currentCanvas = locationsScrollingFrame.CanvasPosition.Y
        local relativeY = buttonY - frameY + currentCanvas - (frameHeight / 2)
        locationsScrollingFrame.CanvasPosition = Vector2.new(0, relativeY)
        task.wait(0.2)
    end

    click(button, 0.5, 4)
end

local function clickGeoHop(locationName, locationsScrollingFrame)
    if not locationName then return end

    for _, desc in ipairs(locationsScrollingFrame:GetDescendants()) do
        if desc:IsA("TextLabel") and desc.Text == locationName then
            local cityFrame = desc.Parent
            if not cityFrame then continue end
            local outerFrame = cityFrame.Parent
            if not outerFrame then continue end

            for _, sibling in ipairs(outerFrame:GetChildren()) do
                if sibling:IsA("Frame") and sibling ~= cityFrame then
                    local button = sibling:FindFirstChildOfClass("ImageButton")
                    if button then
                        scrollToAndClick(button, locationsScrollingFrame)
                        return
                    end
                end
            end
        end
    end
end

local function waitForTeleport(timeout)
    local startPos = player.Character.HumanoidRootPart.Position
    local elapsed = 0
    while elapsed < timeout do
        task.wait(0.5)
        elapsed += 0.5
        local character = player.Character
        if character then
            local newPos = character.HumanoidRootPart.Position
            if (newPos - startPos).Magnitude > 100 then
                task.wait(1)
                return true
            end
        end
    end
    return false
end

local function waitForGate(destination, timeout)
    local elapsed = 0
    while elapsed < timeout do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Gate" then
                local marquee = obj:FindFirstChild("Marquee")
                if marquee then
                    local mtext = marquee:FindFirstChild("MText")
                    if mtext and mtext.Value == destination then
                        return marquee
                    end
                end
            end
        end
        task.wait(0.5)
        elapsed += 0.5
    end
    return nil
end
local isTeleportingToGate = false

local function teleportToGate(destination)
    isTeleportingToGate = true
    local marquee = waitForGate(destination, 10)
    if not marquee then print("Gate not found after timeout:", destination) return end

    local targetCFrame = CFrame.new(marquee.Position - Vector3.new(0, 10, 0))

    local elapsed = 0
    while elapsed < 3 do
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = targetCFrame
            end
        end
        task.wait(1)
        elapsed += 1
    end
    isTeleportingToGate = false
end

local function raidCaveExists()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "RaidCaveModel" then
            return true
        end
    end
    return false
end

local function waitForRaidCave(timeout)
    local elapsed = 0
    while elapsed < timeout do
        if raidCaveExists() then
            return true
        end
        task.wait(1)
        elapsed += 1
    end
    return false
end

local function isBattleActive()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "BuiltInBattleScenes" and v:FindFirstChild("Model") then
            return true
        end
    end
    return false
end

local function run()
    local watchContainer = player.PlayerGui.MainGui:FindFirstChild("WatchContainer")
    if not watchContainer then return end

    pressKey(Enum.KeyCode.Three)
    task.wait(0.5)

    local mapMenu = watchContainer:FindFirstChild("MapMenu")
    if not mapMenu then return end

    local tabs = getTabButtons(mapMenu)
    if #tabs < 3 then return end

    click(tabs[3], 0.5, 2.5)
    click(tabs[3], 0.5, 3)
    click(tabs[3], 0.5, 3.5)
    click(tabs[3], 0.5, 4)
    task.wait(0.5)

    local forecastContainer = mapMenu:FindFirstChild("ForecastContainer")
    if not forecastContainer then return end

    local timelineVertical = forecastContainer:FindFirstChild("TimelineVertical")
    if not timelineVertical then return end

    local frames = {}
    for _, child in ipairs(timelineVertical.Parent:GetChildren()) do
        if child.Name == "Frame" then
            table.insert(frames, child)
        end
    end
    table.sort(frames, function(a, b)
        return a.AbsolutePosition.Y < b.AbsolutePosition.Y
    end)

    if #frames == 0 then return end

    local weather = getWeatherFromFrame(frames[1])
    print("Current weather:", weather)
    if not weather then return end

    local locationData = equivalency[weather]
    if not locationData then return end

    click(tabs[1], 0.5, 2.5)
    click(tabs[1], 0.5, 3)
    click(tabs[1], 0.5, 3.5)
    click(tabs[1], 0.5, 4)
    task.wait(0.5)

    local locationsScrollingFrame = mapMenu:FindFirstChild("ScrollingFrame")
    if not locationsScrollingFrame then return end

    clickGeoHop(locationData.location, locationsScrollingFrame)

    if locationData.gate then
        waitForTeleport(10)
        teleportToGate(locationData.gate)
    end
end


local encounterFiring = false

local originalInvoke
originalInvoke = hookfunction(Instance.new("RemoteFunction").InvokeServer, newcclosure(function(self, ...)
    local args = {...}
    if args[2] == "BattleFunction" and args[3] == "new" then
        print("BATTLE CREATED - FLEEING")
        encounterFiring = true
        if hrp then
            if not hrp.Parent then
                hrp.Parent = char -- reparent first if mid-teleport
            end
            hrp.CFrame = CFrame.new(0, 10000, 0)
        end
    end
    return originalInvoke(self, ...)
end))

task.spawn(function()
    while true do
        if encounterFiring and not player.PlayerGui.MainGui:FindFirstChild("BattleGui") then
            encounterFiring = false
        end
        task.wait(1)
    end
end)

local function isEncounterStarting()
    return encounterFiring
end

local HopInterval = 100 -- 35 minutes in seconds

local isHoppingTime = false 

local function executeServerHop()
    local watchContainer = player.PlayerGui.MainGui:FindFirstChild("WatchContainer")

    pressKey(Enum.KeyCode.Three)
    task.wait(0.5)

    local mapMenu = watchContainer:FindFirstChild("MapMenu")
    if not mapMenu then return end

    local tabs = getTabButtons(mapMenu)
    if #tabs < 3 then return end

    click(tabs[2], 0.5, 2.5)
    click(tabs[2], 0.5, 3)
    click(tabs[2], 0.5, 3.5)
    click(tabs[2], 0.5, 4)
    task.wait(0.5)
    
    local targetButton = PlayerGui:FindFirstChild("TeleportButton1", true) 
        or PlayerGui:FindFirstChild("teleportbutton1", true)
    
    if targetButton and (targetButton:IsA("TextButton") or targetButton:IsA("ImageButton")) then
        click(targetButton, 0.5, 1)
        print("[BOT SUCCESS] Found and clicked TeleportButton1 inline!")
    end

end



-- TIMER THREAD
task.spawn(function()
    local serverStartTime = os.time() 
    
    while task.wait(10) do 
        local timeElapsed = os.time() - serverStartTime
        
        if timeElapsed >= HopInterval then
            -- 1. FORCE EGG VACUUM LOOPS TO FREEZE INSTANTLY
            isHoppingTime = true 
            
            -- 2. Execute your menu click sequence
            executeServerHop()
        end
    end
end)

-- MAIN LOOP
while true do
    if not raidCaveExists() then
        isGeohopping = true
        run()
        waitForRaidCave(5)  -- this already waits for the new chunk
        task.wait(2)        -- little extra buffer after chunk loads
        isGeohopping = false
        continue
    end 

        while raidCaveExists() do
        if not isEncounterStarting() and not isGeohopping and not isTeleportingToGate and not isHoppingTime then  -- add isGeohopping check
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "Egg" and v:IsA("BasePart")
                    and not v:IsDescendantOf(workspace.CurrentCamera)
                    and not isTooCloseToDoor(v.Position) then
                    if isEncounterStarting() then break end
                    invisibleTeleportTo(v.CFrame)
                    task.wait()
                    if isEncounterStarting() then break end
                end
            end
        end
        task.wait()
    end
end

