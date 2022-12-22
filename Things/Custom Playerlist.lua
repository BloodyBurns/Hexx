-- // Custom Playerlist
local Open, Show = true, true;
V4mp = GetObjs(11837971003);
Darken = function(v)
	local R, G, B = v.R * 255, v.G * 255, v.B * 255;
	return Color3.fromRGB(R * 0.5, G * 0.5, B * 0.5);
end

local CreatePlayer = function(User, isFriend)
	local Player = V4mp.Objs.Player:Clone();
	local Api = 'https://inventory.roblox.com/v1/users/%s/items/GamePass/%d';
	local Admin = match(game:HttpGet(format(Api, User.UserId, 35748)), 35748) or match(game:HttpGet(format(Api, User.UserId, 66254)), 66254);

	Player.Name = toStr(User);
	Player.User.RichText = true;
	Player.Icon.Image = pfp(User.UserId);
	Player.Parent = V4mp.Playerlist.Players;
	V4mp.Playerlist.Frame.Size = UDim2.new(1, 0, 0.106 + (maxn(GetPlayers()) * 0.12), 0);
	Player.User.TextColor3 = isFriend and Color3.fromRGB(128, 255, 121) and Color3.new(0, 0.8, 0) or Color3.new(1, 1, 1);
	Player.User.Text = format('<font color = \'rgb(200, 0, 0)\'>%s</font>%s', Admin and '[ Perm ] ' or '', User.DisplayName);

	Player.MouseEnter:Connect(function()
		Player.User.Text = concat({'@', User.Name}, '')
	end)

	Player.MouseLeave:Connect(function()
		Player.User.Text = format('<font color = \'rgb(200, 0, 0)\'>%s</font>%s', Admin and '[ Perm ] ' or '', User.DisplayName);
	end)
end

V4mp.Parent = Core;
V4mp.Playerlist.Players.Zindex = 3;
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
V4mp.Playerlist.Label.Text = format('Players: %d', maxn(GetPlayers()));
V4mp.Playerlist.Expand.MouseButton1Click:Connect(function()
	Open = not Open;
	V4mp.Playerlist.Players.Visible = Open;
	V4mp.Playerlist.Expand.Rotation = not Open and 180 or 0;
	V4mp.Playerlist.Frame:TweenSize(not Open and UDim2.new(1, 0, 0.1, 0) or UDim2.new(1, 0, 0.106 + (maxn(GetPlayers()) * 0.12), 0), 'InOut', 'Sine', 0.4, true);
end)

local s1; s1 = InputService.InputBegan:Connect(function(Input, IsTyping)
	if Input.KeyCode == Enum.KeyCode.Tab and not IsTyping then
		Show = not Show;
		V4mp.Playerlist:TweenPosition(Show and UDim2.new(0.84, 0, 0, 15) or UDim2.new(1, 0, 0, 15), 'InOut', 'Sine', 0.5, true);
	end
end)

local s2; s2 = plrs.PlayerAdded:Connect(function(v)
	CreatePlayer(v, v:isFriendsWith(plr.UserId))
end)

local s3; s3 = plrs.PlayerRemoving:Connect(function(v)
	V4mp.Playerlist.Frame.Size = UDim2.new(1, 0, 0.106 + (maxn(GetPlayers()) * 0.12), 0);
	V4mp.Playerlist.Label.Text = format('Players: %d', maxn(GetPlayers()));
	if V4mp.Playerlist.Players:FindFirstChild(v.Name) then
		V4mp.Playerlist.Players[v.Name]:Destroy();
	end
end)

CreatePlayer(plr, false);

for _, v in next, filter(GetPlayers(), plr) do
	spawn(function() CreatePlayer(v, v:isFriendsWith(plr.UserId)) end);
end

spawn(function()
	V4mp.Destroying:Wait();
	Disconnect(s1);
	Disconnect(s2);
	Disconnect(s3);
end)
