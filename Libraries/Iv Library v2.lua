-- // Iv Library v2
local Library = {};

loadstring(game:HttpGet('https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Imports.lua'))(); -- // Import
Library['Load'] = function(self, Remove)
    if isIndexType(Core:GetChildren(), 'Iv Hubv2') then
        Core['Iv Hubv2']:Destroy();
    end

    local Windows, Tabs = {}, {};
    local UI = GetObjs(11709541508);
    loadstring(game:HttpGet('https://pastebin.com/raw/TBqptCxV'))()(UI.Frame);

    UI.Parent = Core;
    UI.Frame.Side.Hightlight:Destroy();
    UI.Frame.Side.Label.Text = format('Iv Hub  |  %s', MarketplaceService:GetProductInfo(game.PlaceId).Name);
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
                    if v.Text:lower():match(UI.Frame.Top.Search.Text:lower()) then v.Parent.Visible = true else
                        v.Parent.Visible = false;
                    end
                end
            end
        end
    end)

    -- // Window
    local Wv = {};
    Wv['CreateWindow'] = function(self, Window_Name)
        local Objects = UI:FindFirstChildWhichIsA('ObjectValue');
        local Window = Objects.Window:Clone();
        local Tab = Objects.Tab:Clone();
        local Events = {};

        insert(Tabs, Tab);
        insert(Windows, Window);
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

        Events['CreateLabel'] = function(self, Text)
            local Label = Objects.Label:Clone();
            Label.Label.Text = Text;
            Label.Parent = Window;
        end

       Events['CreateButton'] = function(self, Text, Code)
            local Button = Objects.Button:Clone();
            Button.Label.Text = Text;
            Button.Parent = Window;
            Button.Button.MouseButton1Click:Connect(function()
                Button.Effect:TweenSizeAndPosition(UDim2.new(1, 0, 0.98, 0), UDim2.new(0, 0, 0, 0), 'InOut', 'Quint', 0.1, true); wait(0.1);
                Button.Effect.Size = UDim2.new(0, 0, 0.98, 0);
                Button.Effect.Position = UDim2.new(0.5, 0, 0, 0)

                spawn(Code or function() end);
            end)
        end

        Events['CreateInput'] = function(self, Text, Code)
            local Input = Objects.Input:Clone();
            Input.Label.Text = Text;
            Input.Parent = Window;
            Input.Box.FocusLost:Connect(function()
                Code = Code or function() end;
                Code(Input.Box.Text);
            end)
        end

        Events['CreateToggle'] = function(self, Text, Code)
            local Toggle = Objects.Toggle:Clone();
            local Toggled = false;

            Toggle.Label.Text = Text;
            Toggle.Parent = Window;
            Toggle.Button.MouseButton1Click:Connect(function()
                Code = Code or function() end;
                Toggled = not Toggled;
	
                Toggle.Icon.Image = Toggled and 'rbxassetid://6031068426' or 'rbxassetid://6031068433';
                Toggle.Icon:TweenSizeAndPosition(UDim2.new(0, 25, 0, 25), UDim2.new(0.012, 0, 0.164, 0), 'Out', 'Bounce', 0.1, true); wait(0.1);
                Toggle.Icon:TweenSizeAndPosition(UDim2.new(0, 22, 0, 22), UDim2.new(0.016, 0, 0.217, 0), 'Out', 'Bounce', 0.1, true);

                Code(Toggled);
            end)
        end

        Events['CreateSlider'] = function(self, Text, Values, Code)
            local SliderC = Objects.Slider:Clone();
            local Dragger, Slider = SliderC.bg.Hitbox, SliderC.bg;
            local Output = SliderC.Value;
            local Dragging = false;
            local Values = isType(Values, 'table') and Values or {0, 200};

            SliderC.Parent = Window;
            SliderC.Label.Text = Text;

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
                    local RelPos = InputService:GetMouseLocation() - Slider.AbsolutePosition;
                    local Precent = clamp(RelPos.X/Slider.AbsoluteSize.X, 0, 1);

                    Output.Text = format('%d/%d', floor(Precent * Values[2]), Values[2]);
                    Dragger.Parent.bg.Position = UDim2.new(Precent, -2, 0, 0);
                    return Code(Precent * Values[2]);
                end
            end)
        end

        return Events;
    end

    return Wv;
end

return Library;
