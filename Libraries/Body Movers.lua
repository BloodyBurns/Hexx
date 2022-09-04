local Library = {}
Library.Vel = function(Part, Vel)
    if Part:IsA('BasePart') and type(Vel) == 'vector' then
        Part.Velocity = Vel
    end
end

Library.AutoVel = function(Part, Vel)
    if Part:IsA('BasePart') and type(Vel) == 'vector' then
        local rbx;rbx = game:GetService('RunService').Heartbeat:Connect(function()
            if Part or rbx:Disconnect() then
                v.Velocity = Vel
            end
        end)
    end
end

Library.Create = function(Class, Part, info)
    if Part:IsA('BasePart') and type(info) == 'table' then
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
    if Part and Part:IsA('BasePart') and Part:FindFirstChildWhichIsA('BodyPosition') and type(Vec) == 'vector' then
        Part:FindFirstChildWhichIsA('BodyPosition').Position = Vec
    end
end

Library.SetGyro = function(Part, CF)
    if Part and Part:IsA('BasePart') and Part:FindFirstChildOfClass('BodyGyro') and type(CF) == 'userdata' then
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
