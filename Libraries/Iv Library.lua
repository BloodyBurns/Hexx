local Library = {}
local FirstWindow = nil
local Core = game:GetService('CoreGui')
local Drag = loadstring(game:HttpGet('https://pastebin.com/raw/TBqptCxV'))()
function Library:Load(Name)
	if Core:FindFirstChild('IvAdminLib') then
		Core.IvAdminLib:Destroy()
	end

	UI = game:GetObjects('rbxassetid://11072306536')[1]
	UI.Frame.Top.Close.MouseButton1Click:Connect(function()
		UI:Destroy()
	end)

	UI.Parent = Core
	UI.Frame.Top.Label.Text = Name
	Drag(UI.Frame, 25, true)
end

function Library:Notify(Text, Length)
	spawn(function()
		local Notification = UI.Notifications[' '].Frame:Clone()
		Notification.Display.Text = tostring(Text)
		Notification.Parent = UI.Notifications
		Notification.Display.bg.Timer:TweenSize(UDim2.new(0, 0, 1, 0), 'In', 'Linear', tonumber(Length) or 3)
		wait(tonumber(Length) or 3)
		Notification:Destroy()
	end)
end

function Library:Window(Name)
	local Path = UI.Elements
	local Objs = {
		['Display'] = UI.Frame.Displays,
		['TextInput'] = Path.TextInput,
		['Button'] = Path.Button,
		['Tabs'] = UI.Frame.Tabs,
		['Slider'] = Path.Slider,
		['Toggle'] = Path.Toggle,
		['Window'] = Path.Frame,
		['TButton'] = Path.Tab,
	}
	
	local Window = Objs.Window:Clone()
	local TButton = Objs.TButton:Clone()
	
	if not FirstWindow then
		FirstWindow = {}
		table.insert(FirstWindow, Window)
		table.insert(FirstWindow, TButton)
	end
	
	Window.Parent = Objs.Display
	TButton.Parent = Objs.Tabs
	TButton.Text = tostring(Name)
	TButton.MouseButton1Click:Connect(function()
		Window.Visible = true
		TButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		for _, v in next, Objs['Tabs']:GetChildren() do
			if v:IsA('TextButton') and v ~= TButton then
				v.TextColor3 = Color3.fromRGB(150, 150, 150)
			end
		end

		for _, v in next, Objs.Display:GetChildren() do
			if v:IsA('ScrollingFrame') and v ~= Window then
				v.Visible = false
			end
		end
	end)
	
	for _, v in next, Objs['Tabs']:GetChildren() do
		if v:IsA('TextButton') and not table.find(FirstWindow, v) then
			v.TextColor3 = Color3.fromRGB(150, 150, 150)
		end
	end

	for _, v in next, Objs.Display:GetChildren() do
		if v:IsA('ScrollingFrame') and not table.find(FirstWindow, v) then
			v.Visible = false
		end
	end
	
	local Events = {}; do
		function Events:Slider(Text, Max, Code)
			local InputService = game:GetService('UserInputService')
			local Slider = Objs.Slider:Clone()
			local Button = Slider.bg.Hitbox
			local Active = false
			
			Slider.Parent = Window
			Slider.Label.Text = tostring(Text)
			Button.MouseButton1Down:Connect(function()
				Active = true
			end)
			
			InputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Active = false
				end
			end)
			
			InputService.InputChanged:Connect(function()
				if Active then
					local Pos = InputService:GetMouseLocation() - Slider.bg.AbsolutePosition
					local Multi = math.clamp(Pos.X/Slider.bg.AbsoluteSize.X, 0, 1)
					Slider.bg.bg.Position = UDim2.new(Multi, -2, 0, 0)
					Slider.Value.Text = math.floor(Multi * Max)
					return Code(tonumber(Slider.Value.Text));
				end
			end)
		end
		
		function Events:Button(Text, Code)
			local Button = Objs.Button:Clone()
			
			Button.Parent = Window
			Button.Text = tostring(Text)
			Button.MouseButton1Click:Connect(Code)
		end
		
		function Events:Toggle(Text, Code)
			local Toggler = Objs.Toggle:Clone()
			local Clicked = false
			
			Toggler.Parent = Window
			Toggler.Label.Text = tostring(Text)
			Toggler.Hitbox.MouseButton1Click:Connect(function()
				Clicked = not Clicked
				Code(Clicked)
			end)
		end
		
		function Events:TextInput(Text, Code)
			local TextInput = Objs.TextInput:Clone()
			
			TextInput.Parent = Window
			TextInput.Label.Text = tostring(Text)
			TextInput.Box.FocusLost:Connect(function()
				Code(TextInput.Box.Text)
			end)
		end
		
		return Events;
	end
end

return Library;
