-- // Iv Hubv2
local Library = {};

loadstring(game:HttpGet('https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Imports.lua'))(); -- // Import
Library['Load'] = function(self, Remove)
    if isIndexType(Core:GetChildren(), 'Iv Hubv2') then
        Core['Iv Hubv2']:Destroy();
    end

    local MainWindow = nil;
    local Windows, Tabs = {}, {};
    local UI = GetObjs(11709541508);
    local Objects = UI:FindFirstChildWhichIsA('ObjectValue');
    loadstring(game:HttpGet('https://pastebin.com/raw/TBqptCxV'))()(UI.Frame);

    UI.Parent = Core;
    UI.Frame.Top.Label.Text = format('Iv Hub  |  %s', MarketplaceService:GetProductInfo(game.PlaceId).Name);
    UI.Frame.Top.Exit.MouseButton1Click:Connect(function()
        UI.Enabled = false;
    end)

    UI.Frame.Top.Search.Focused:Connect(function()
        while UI.Frame.Top.Search:IsFocused() and wait() do
            local CurrentWindow = nil;

            for _, v in next, Windows do
                if v.Visible then
                    CurrentWindow = v;
                end
            end

            for _, v in next, CurrentWindow:GetDescendants() do
                if v:IsA('TextLabel') and v.Name == 'Label' or v:IsA('TextButton') and v.Name == 'Label' then
                    if v.Parent.Parent.Name == 'Dropdown' then
                        v.Parent.Parent.Visible = v.Text:lower():match(UI.Frame.Top.Search.Text:lower());
                    else
                        v.Parent.Visible = v.Text:lower():match(UI.Frame.Top.Search.Text:lower());
                    end
                end
            end
        end
    end)

    -- // Window
    local Wv = {};
    Wv['CreateWindow'] = function(self, Window_Name)
        local Window = Objects.Window:Clone();
        local Tab = Objects.Tab:Clone();
        local Events = {};

        insert(Tabs, Tab);
        insert(Windows, Window);

        Window.Visible = (not MainWindow);
        Tab.BackgroundTransparency = (not MainWindow and 0) or 1;

        if not MainWindow then
            MainWindow = true;
        end

        Tab.Text = Window_Name;
        Window.Parent = UI.Frame.Main;
        Tab.Parent = UI.Frame.Side.Tabs;
        Tab.MouseButton1Click:Connect(function()
            for _, v in next, Windows do
                v.Visible = (v == Window);
            end

            for _, v in next, Tabs do
                v.BackgroundTransparency = (v == Tab and 0) or 1;
            end
        end)

        Events['CreateLabel'] = function(self, Text, Icon)
            local Label = Objects.Label:Clone();
            Label.Icon.Image = Icon or Label.Icon.Image;
            Label.Label.Text = Text;
            Label.Parent = Window;
        end

        Events['CreateButton'] = function(self, Text, Icon, Code)
            local Icon_ = typeof(Icon) ~= 'function' and Icon;
            local Button = Objects.Button:Clone();
            Button.Icon.Image = Icon_ or Button.Icon.Image;
            Button.Label.Text = Text;
            Button.Parent = Window;
            Button.Button.MouseButton1Click:Connect(function()
                Button.Effect:TweenSizeAndPosition(UDim2.new(1, 0, 0.98, 0), UDim2.new(0, 0, 0, 0), 'InOut', 'Quint', 0.1, true); wait(0.1);
                Button.Effect.Size = UDim2.new(0, 0, 0.98, 0);
                Button.Effect.Position = UDim2.new(0.5, 0, 0, 0)

                spawn(Code or not Icon_ and Icon or function() end);
            end)
        end

        Events['CreateInput'] = function(self, Text, Icon, Code)
            local Icon_ = typeof(Icon) ~= 'function' and Icon;
            local Input = Objects.Input:Clone();
            Input.Icon.Image = Icon_ or Input.Icon.Image;
            Input.Label.Text = Text;
            Input.Parent = Window;
            Input.Box.FocusLost:Connect(function()
                Code = Code or not Icon_ and Icon or function() end;
                Code(Input.Box.Text);
            end)
        end

        Events['CreateToggle'] = function(self, Text, Icon, Code)
            local Icon_ = typeof(Icon) ~= 'function' and Icon;
            local Toggle = Objects.Toggle:Clone();
            local Toggled = false;

            Toggle.Icon.Image = Icon_ or Toggle.Icon.Image;
            Toggle.Label.Text = Text;
            Toggle.Parent = Window;
            Toggle.Button.MouseButton1Click:Connect(function()
                Code = Code or not Icon_ and Icon or function() end;
                Toggled = not Toggled;
	
                Toggle.Icon.Image = Toggled and 'rbxassetid://6031068426' or 'rbxassetid://6031068433';
                Toggle.Icon:TweenSizeAndPosition(UDim2.new(0, 25, 0, 25), UDim2.new(0.012, 0, 0.164, 0), 'Out', 'Bounce', 0.1, true); wait(0.1);
                Toggle.Icon:TweenSizeAndPosition(UDim2.new(0, 22, 0, 22), UDim2.new(0.016, 0, 0.217, 0), 'Out', 'Bounce', 0.1, true);

                Code(Toggled);
            end)
        end

        Events['CreateSlider'] = function(self, Text, Values, Icon, Code)
            local Icon_ = typeof(Icon) ~= 'function' and Icon;
            local SliderC = Objects.Slider:Clone();
            local Dragger, Slider = SliderC.bg.Hitbox, SliderC.bg;
            local Output = SliderC.Value;
            local Dragging = false;
            local Values = isType(Values, 'table') and Values or {0, 200};

            SliderC.Parent = Window;
            SliderC.Label.Text = Text;
            SliderC.Icon.Image = Icon_ or SliderC.Icon.Image;

            local RelPos = InputService:GetMouseLocation() - Slider.AbsolutePosition;
            local Precent = clamp(RelPos.X/Slider.AbsoluteSize.X, 0, 1);

            Output.Text = format('%d/%d', Values[1], Values[2]);
            Dragger.Parent.bg.Position = UDim2.new(0, Precent * Values[1], 0, 0);

            Dragger.MouseButton1Down:Connect(function()
                Dragging = true;
            end)

            InputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false;
                end
            end)

            InputService.InputChanged:Connect(function()
                if Dragging then
                    local Code = Code or not Icon_ and Icon or function() end;
                    local RelPos = InputService:GetMouseLocation() - Slider.AbsolutePosition;
                    local Precent = clamp(RelPos.X/Slider.AbsoluteSize.X, 0, 1);

                    Output.Text = format('%d/%d', floor(Precent * Values[2]), Values[2]);
                    Dragger.Parent.bg.Position = UDim2.new(Precent, -2, 0, 0);
                    return Code(Precent * Values[2]);
                end
            end)
        end

        Events['CreateDropdown'] = function(self, Text, Icon, Values)
            local Activated = false;
            local Icon_ = typeof(Icon) ~= 'table' and Icon;
            local Menu = Objects.Dropdown:Clone();
            local CreateSelection = function(Text, Code)
                local Selection = Menu.Menu[' '].Selection:Clone();

                Selection.Text = Text;
                Selection.Visible = Menu.Menu.Visible;
                Selection.MouseButton1Click:Connect(function() Code() end);
                Selection.Parent = Menu.Menu.Selections;
            end

            for _, v in next, (Values or Icon) do
                CreateSelection(v.Text, v.Code);
            end

            Menu.Background.Icon.Image = Icon_ or Menu.Background.Icon.Image;
            Menu.Background.Label.Text = Text;
            Menu.Parent = Window;
            Menu.Background.Button.MouseButton1Click:Connect(function()
                Activated = not Activated;
                
                for _, v in next, Menu.Menu.Selections:GetChildren() do
                    if v:IsA('TextButton') then
                        v.Visible = Activated;
                    end
                end
                
                Menu.Menu.Visible = Activated;
                Menu.Background.Icon.Rotation = Activated and 180 or 0;
                Menu.Size = Activated and UDim2.new(1, 0, 0, 130) or UDim2.new(1, 0, 0, 40);
                Menu.Menu:TweenSize(Activated and UDim2.new(1, 0, 0, 130) or UDim2.new(1, 0, 0, 0), 'InOut', 'Quint', 0.3, true);
            end)
        end

        return Events;
    end

    Wv['Notify'] = function(self, Message, Length)
        spawn(function()
            local Length = toNum(Length) or 4;
            local Notification = Objects.Notification:Clone();
    
            Notification.Main.Label.TextSize = 18
            Notification.Parent = UI.Notifications
            Notification.Main.Label.Text = toStr(Message) or 'nil'
            Notification.Length.Timer:TweenSize(UDim2.new(0, 0, 1, 0), 'Out', 'Linear', Length); wait(Length)
            Notification:Destroy()
        end)
    end
    
    return Wv;
end

return Library;
