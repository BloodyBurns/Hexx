local Library = {}
Library.Notify = function(Message, Type, Length)
    local Course = game:GetObjects('rbxassetid://10580996692')[1]
    if not game:GetService('CoreGui'):FindFirstChild('Hexx') then
        Course.Parent = game:GetService('CoreGui')
        for _, v in next, Course:GetChildren() do
            if v.Name ~= 'Notifications' then
                v:Destroy()
            end
        end
    end

    spawn(function()
        local Length = tonumber(Type) or tonumber(Length) or 3
        local Notification = Course.Notifications[' '].Notification:Clone()
        local Types = {
            error = Color3.fromRGB(220, 0, 0),
            warn = Color3.fromRGB(255, 255, 50),
            default = Color3.fromRGB(255, 255, 255),
        }

        Notification.Parent = game:GetService('CoreGui').Hexx.Notifications
        Notification.Display.Label.Text = tostring(Message) or 'nil'
        Notification.T1.T1.BackgroundColor3 = Types[tostring(Type):lower()] or Types.default
        Notification.T1.T1:TweenSize(UDim2.new(0, 0, 1, 0), 'Out', 'Linear', Length)
        wait(Length)
        Notification:Destroy()
    end)
end

Library.Vel = function(Part, Vel)
    if Part:IsA('BasePart') and type(Vel) == 'vector' or Library.Notify('Invalid Arguments (Vel)', 'error', 4) then
        Part.Velocity = Vel
    end
end

Library.Create = function(Class, Part, info)
    if Part:IsA('BasePart') and type(info) == 'table' or Library.Notify('Invalid Arguments (Create)', 'error', 4) then
        if Class:lower() == 'gyro' or Class:lower() == 'bodygyro' then
            if Part:FindFirstChildOfClass('BodyGyro') then
                Part:FindFirstChildOfClass('BodyGyro'):Destroy()
            end
    
            Part:BreakJoints()
            Part.Massless = true
    
            local BodyGyro = Instance.new('BodyGyro', Part)
            for _, v in next, info do
                BodyGyro[_] = v
            end
        elseif Class:lower() == 'position' or Class:lower() == 'bodyposition' then
            if Part:FindFirstChildOfClass('BodyPosition') then
                Part:FindFirstChildOfClass('BodyPosition'):Destroy()
            end
    
            Part:BreakJoints()
            Part.Massless = true
    
            local BodyPosition = Instance.new('BodyPosition', Part)
            for _, v in next, info do
                BodyPosition[_] = v
            end
        end
    end
end

Library.SetPosition = function(Part, Vec)
    if Part and Part:IsA('BasePart') and Part:FindFirstChildWhichIsA('BodyPosition') and type(Vec) == 'vector' or Library.Notify('Invalid Arguments (SetPosition)', 'error', 4) then
        Part:FindFirstChildWhichIsA('BodyPosition').Position = Vec
    end
end

Library.SetGyro = function(Part, CF)
    if Part and Part:IsA('BasePart') and Part:FindFirstChildOfClass('BodyGyro') and type(CF) == 'userdata' or Library.Notify('Invalid Arguments (SetGyro)', 'error', 4) then
        Part:FindFirstChildOfClass('BodyGyro').CFrame = CF
    end
end

Library.Clean = function()
    local rbx;rbx = game:GetService('Players').LocalPlayer.Backpack.ChildAdded:Connect(function(Obj)
        game:GetService('RunService').RenderStepped:Wait()
        for _, v in next, Obj:GetDescendants() do
            if v:IsA('BodyPosition') or v:IsA('BodyGyro') then
                v:Destroy()
            end
        end
        rbx:Disconnect()
    end)
end

return Library
