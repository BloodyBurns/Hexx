-- // Haxx!?
local Instance = function(Class, Configuration, Code)
    return ((function()
        local Code = typeof(Code) == 'function' and Code or function() end;
        local NewInstance = Instance.new(Class);
        for _, v in next, Configuration do
            NewInstance[_] = v;
        end
        return NewInstance, spawn(function() Code(NewInstance) end);
    end)())
end

Instance('TextLabel', {
    Parent = Instance('ScreenGui', {
        Parent = game:GetService('CoreGui'),
        IgnoreGuiInset = true,
        Name = 'Iv Admin V3',
    }),

    Name = 'Label',
    Text = '[ERROR]: You\'re Gay',
    Size = UDim2.new(1, 0, 1, 0),
    TextColor3 = Color3.new(1, 1, 1);
    TextSize = 10000000000000000/1e14;
}, function(x)
    local Bomb = time();

    repeat 
    task.wait(0.5);
    x.BackgroundColor3 = BrickColor.random().Color;

    until
    math.abs(time() - Bomb) > math.random(5, 10);

    x:FindFirstAncestorWhichIsA('ScreenGui'):Destroy();
end)
