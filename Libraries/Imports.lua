-- // URL: https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Imports.lua
-- // Loadstring: loadstring(game:HttpGet('https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Imports.lua'))();

-- // Local Player
plr = game:GetService('Players').LocalPlayer;

-- // Request
request = (((syn or http) and (syn and syn.request) or http.request) or http_request or request);

-- // Services
Chat = game:GetService('Chat');
plrs = game:GetService('Players');
Core = game:GetService('CoreGui');
Lighting = game:GetService('Lighting');
RunService = game:GetService('RunService');
StarterGui = game:GetService('StarterGui');
StarterPack = game:GetService('StarterPack');
HttpService = game:GetService('HttpService');
SoundService = game:GetService('SoundService');
StarterPlayer = game:GetService('StarterPlayer');
ReplicatedStorage = game:GetService('ReplicatedStorage');
MarketplaceService = game:GetService('MarketplaceService');

-- // Game Variables
ChatEvents = ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents');
ChatRemote = ChatEvents and ChatEvents.SayMessageRequest;
MuteRemote = ChatEvents and ChatEvents.MutePlayerRequest;
UnMuteRemote = ChatEvents and ChatEvents.UnMutePlayerRequest;

-- // RS Events
Stepped = RunService.Stepped;
Heartbeat = RunService.Heartbeat;
RenderStepped = RunService.RenderStepped;

-- // Table Library
find = table.find;
maxn = table.maxn;
pack = table.pack;
sort = table.sort;
clear = table.clear;
concat = table.concat;
insert = table.insert;
foreach = table.foreach;

-- // String Library
rep = string.rep;
toStr = tostring;
toNum = tonumber;
len = string.len;
sub = string.sub;
gsub = string.gsub;
byte = string.byte;
char = string.char;
lower = string.lower;
upper = string.upper;
split = string.split;
match = string.match;
gmatch = string.gmatch;
format = string.format;
reverse = string.reverse;

-- // Math Library
pi = math.pi;
huge = math.huge;
rad = math.rad;
max = math.max;
pow = math.pow;
tan = math.tan;
cos = math.cos;
sin = math.sin;
abs = math.abs;
min = math.min;
sqrt = math.sqrt;
clamp = math.clamp;
floor = math.floor;
random = math.random;

-- // Custom Functions
isType = function(a, b)
    return type(a) == toStr(b);
end

JSON = function(Type, Data)
    if isType(Data, 'table') and (Type == 'Encode' or Type == 'Decode') then
        return Type == 'Encode' and HttpService:JSONEncode(Data) or HttpService:JSONDecode(Data);
    end
end

isIndexOf = function(Data, Value)
    if isType(Data, 'table') then
        for _, v in next, Data do
            if v == Value then
                return _;
            end
        end
        return nil;
    end
end

isIndexType = function(Data, Value)
    if isType(Data, 'table') then
        for _, v in next, Data do
            if toStr(v) == toStr(Value) then
                return _;
            end
        end
        return nil;
    end
end

GetObjs = function(Asset)
    return game:GetObjects(format('rbxassetid://%d', toNum(Asset)));
end

filter = function(Data, Excluded)
    if isType(Data, 'table') then
        local filtered = {}; do
            for _, v in next, Data do
                if isType(Excluded, 'table') and not find(Excluded, v) or v ~= Excluded then
                    insert(filtered, v);
                end
            end
        end
        return filtered;
    end
end

Disconnect = function(Signal, Data)
    if Signal and isType(Signal, 'userdata') then
        Signal:Disconnect();
        Signal = nil;

        if Data and isType(Data, 'table') and isIndexOf(Data, Signal) then
            local Index = isIndexOf(Data, Signal);

            Data[Index]:Disconnect();
            Data[Index] = nil;
            return
        end
    end
end

Randomize = function(Data, Excluded)
    if isType(Data, 'table') then
        local newOutput = {}; do
            for _, v in next, Data do
                if Excluded and filter(Data, Excluded) or true then
                    insert(newOuput, v);
                end
            end
        end
        return newOuput[random(1, maxn(newOuput))];
    end
end

GetPlayers = function()
    return plrs:GetPlayers();
end

GetPlayer = function(str)
    if not str then
        return nil;
    end

    str = lower(toStr(str));
    Check = {
        ['others'] = filter(GetPlayers(), plr),
        ['random'] = Randomize(GetPlayers()),
        ['me'] = plr
    }

    if Check[str] then
        return Check[str];
    end

    for _, v in next, GetPlayers() do
        if match(sub(lower(v.Name), 1, len(str)), str) or match(sub(lower(v.DisplayName), 1, len(str)), str) then
            return v;
        end
    end

    return nil;
end

GetCharacter = function(Player, Limb)
    local Player = Player and GetPlayer(Player) and GetPlayer(Player).Character or nil
    if Player and Limb then
        if Player:FindFirstChild(Limb) then
            Player = Player[Limb];
        end
    end

    return Limb and toStr(Player) == Limb and Player or Player;
end

Save = function(Path, Data)
    if writefile then
        writefile(Path, isType(Data, 'table') and JSON('Encode', Data) or Data);
    end
end

Save = function(Type, Table)
    if writefile then
		if Type == 'Settings' or Type == 'Configs' then
			writefile(Folder..'/Settings.json', JSON('Encode', Settings))
		elseif Type == 'PlayersData' or Type == 'Players' then
			writefile(Folder..'/PlayersData.json', JSON('Encode', PlayersData))
		end
	end
end
