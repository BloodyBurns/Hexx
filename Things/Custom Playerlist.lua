loadstring(game:HttpGet('https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Imports.lua'))();

-- // Configs
local Configs = {
	NotifyOnJoin = true,
	NotifyOnFriendJoin = true,
	NotificationColor = Color3.fromRGB(255, 0, 0),
}

-- // Custom Playerlist
local Open, Show = true, true;
local UI = GetObjs(11837971003);
local Darken = function(v)
	local R, G, B = v.R * 255, v.G * 255, v.B * 255;
	return Color3.fromRGB(R * 0.5, G * 0.5, B * 0.5);
end

local Notify = function(Text, Duration, Icon)
	spawn(function()
        -- // Settings
        local Text = toStr(Text);
        local Duration = toNum(Duration) or 4;
        local Color = Configs.NotificationColor or Color3.new(0.8, 0, 0);

        -- // Notification
		local Notification = UI[' '].Notification:Clone();
		local Info = Notification.Info;
		local Bar = Info.Bar;

		Info.Frame.Label.Text = Text;
		Bar.Timer.ImageColor3 = Color;
		Info.Frame.Icon.Visible = Icon;
		Bar.ImageColor3 = Darken(Color);
		Info.Frame.Icon.Image = Icon or '';
		Notification.Parent = UI.Notifications;
		Info.Frame.Label.Size = Icon and UDim2.new(0.783, 0, 1, 0) or UDim2.new(1, 0, 1, 0);
		
        -- // Animation
		Info:TweenPosition(UDim2.new(0, 0, 0, 0), 'InOut', 'Sine', 0.5);
		Bar.Timer:TweenSize(UDim2.new(0, 0, 1, 0), 'InOut', 'Sine', Duration + 1);
		
		wait(Duration + 0.5);
		
		Info:TweenPosition(UDim2.new(1, 0, 0, 0), 'InOut', 'Sine', 0.5); wait(0.6);
		Notification:Destroy();
	end)
end

local CreatePlayer = function(User, isFriend)
    local Player = UI[' '].Player:Clone();

	Player.Name = toStr(User);
    Player.Icon.Image = pfp(User.UserId);
    Player.Parent = UI.Playerlist.Frame.Players;
    Player.User.Text = format('%s | %s', toStr(User), User.DisplayName);
    Player.User.TextColor3 = isFriend and Color3.fromRGB(128, 255, 121) or Color3.new(1, 1, 1);
end

UI.Parent = Core;
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
UI.Playerlist.Label.Text = format('Players: %d', maxn(GetPlayers()));
UI.Playerlist.Expand.MouseButton1Click:Connect(function()
    Open = not Open;
	UI.Playerlist.Frame.Players.Visible = Open;
    UI.Playerlist.Expand.Rotation = not Open and 180 or 0;
    UI.Playerlist.Frame:TweenSize(not Open and UDim2.new(1, 0, 0.085, 0) or UDim2.new(1, 0, 1, 0), 'InOut', 'Sine', 0.4, true);
end)

InputService.InputBegan:Connect(function(Input, IsTyping)
	if Input.KeyCode == Enum.KeyCode.Tab and not IsTyping then
        Show = not Show;
        UI.Playerlist:TweenPosition(Show and UDim2.new(0.84, 0, 0, 15) or UDim2.new(1, 0, 0, 15), 'InOut', 'Sine', 0.5, true);
	end
end)

plrs.PlayerAdded:Connect(function(v)
	if Configs.NotifyOnJoin then
		Notify(format(Configs.NotifyOnFriendJoin and 'Your friend %s has joined!' or '%s has joined', v.DisplayName), 4, pfp(v.UserId));
	end

	if not Configs.NotifyOnJoin and Configs.NotifyOnFriendJoin and v:IsFriendsWith(plr.UserId) then
		Notify(format('Your friend %s has joined!', v.DisplayName), 4, pfp(v.UserId));
	end

	CreatePlayer(v, v:isFriendsWith(plr.UserId));
	UI.Playerlist.Label.Text = format('Players: %d', maxn(GetPlayers()));
end)

plrs.PlayerRemoving:Connect(function(v)
	UI.Playerlist.Label.Text = format('Players: %d', maxn(GetPlayers()));
	if UI.Playerlist.Frame.Players:FindFirstChild(v.Name) then
		UI.Playerlist.Frame.Players[v.Name]:Destroy();
	end
end)

CreatePlayer(plr, false);
Notify('Custom Playerlist!', 4, pfp(plr.UserId));

for _, v in next, filter(GetPlayers(), plr) do
    CreatePlayer(v, v:isFriendsWith(plr.UserId));
end
