AntiBot = function()
    local Delete = function(Target)
        spawn(function()
            MuteRemote:InvokeServer(Target.Name);
            game:GetService('TestService'):Message(format('Deleted: %s', Target.Name));
            Target.CharacterAdded:Connect(function(Character)
                repeat wait(0) until Character:FindFirstChildWhichIsA('Humanoid');
                for i = 1, 10 do
                    for _, v in next, Character:GetChildren() do
                        if not v:IsA('Humanoid') then
                            v:Destroy();
                        end
                    end
                end
            end)

            if Target.Character then
                for _, v in next, Target.Character:GetChildren() do
                    if not v:IsA('Humanoid') then
                        v:Destroy();
                    end
                end
            end

            wait(1)
            MuteRemote:InvokeServer(Target.Name);
        end)
    end

    local Content = {
        Name = {
            'TheAloneSystems_', 'StormWRLD_', 'D00MBotMan_', 'newgenLOLOLOL', 'skidbottingera', 'sleepinbot', 'sleepnbetter', 'MurderlnOsaka', 'iluvlostritualac',
            'LOSTRITUALOWNSYOU', 'prunebot', 'skidbottingera', 'killhouseAC7'
        },

        Display = {
            'TheAloneSystems', 'sleepinbot', 'sleepnbetter', 'ILuvOven', 'skidbottingera2', 'lostritual and oven are besties', 'LOSTRITUALOWNSYOU', 'prunebot',
            'Killhousebot', 'MestalicFlungYouLOL'
        },
    }

    for _, v in next, filter(GetPlayers(), plr) do
        for _, v2 in next, Content.Name do
            if match(v.Name, v2) then
                Delete(v);
            end
        end

        for _, v2 in next, Content.Display do
            if match(v.DisplayName, v2) then
                Delete(v);
            end
        end
    end

    plrs.PlayerAdded:Connect(function(v)
        for _, v2 in next, Content.Name do
            if match(v.Name, v2) then
                Delete(v);
            end
        end

        for _, v2 in next, Content.Display do
            if match(v.DisplayName, v2) then
                Delete(v);
            end
        end
    end)

    wait(1)
    for _, v in next, plrs.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller:GetDescendants() do
        if v:IsA('TextButton') then
            local Message = split(v.Text, ':]');
            local Player = sub(Message[1], 2, len(Message[1]));
            local isT = false;

            for _, v2 in next, Content.Name do
                if match(Player, v2) then
                    isT = true;
                    v.Parent.Parent.Visible = false;
                end
            end

            if not isT then    
                for _, v2 in next, Content.Display do
                    if match(Player, v2) then
                        isT = true;
                        v.Parent.Parent.Visible = false;
                    end
                end
            end
        end
    end

    plrs.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller.DescendantAdded:Connect(function(v)
        if v:IsA('TextButton') then
            RenderStepped:Wait();
            local Message = split(v.Text, ':]');
            local Player = sub(Message[1], 2, len(Message[1]));
            local isT = false;

            for _, v2 in next, Content.Name do
                if match(Player, v2) then
                    isT = true;
                    v.Parent.Parent.Visible = false;
                end
            end

            if not isT then    
                for _, v2 in next, Content.Display do
                    if match(Player, v2) then
                        isT = true;
                        v.Parent.Parent.Visible = false;
                    end
                end
            end
        end
    end)
end

return AntiBot;
