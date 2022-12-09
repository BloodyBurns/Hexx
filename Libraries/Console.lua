if not rconsoleprint then
    return warn('Not Supported');
end


-- // Loadstring: loadstring(game:HttpGet('https://raw.githubusercontent.com/BloodyBurns/Hexx/main/Libraries/Console.lua'))();
-- // Console
Loading = false;
Running = true;
isSyn = syn or false;
Console = function(Type, Color, ...)
    local Type = tostring(Type):lower();
    local Colors = {
        ['light magenta'] = isSyn and '@@LIGHT_MAGENTA@@' or 'bwhite',
        ['light green'] = isSyn and '@@LIGHT_GREEN@@' or 'bwhite',
        ['light cyan'] = isSyn and '@@LIGHT_CYAN@@' or 'bwhite',
        ['light gray'] = isSyn and '@@LIGHT_GRAY@@' or 'bblack',
        ['light blue'] = isSyn and '@@LIGHT_BLUE@@' or 'bwhite',
        ['light red'] = isSyn and '@@LIGHT_RED@@' or 'bwhite',
        ['dark gray'] = isSyn and '@@DARK_GRAY@@' or 'bblack',
        ['magenta'] =isSyn and ' @@MAGENTA@@' or 'bmagneta',
        ['yellow'] = isSyn and '@@YELLOW@@' or 'byellow',
        ['brown'] = isSyn and '@@BROWN@@' or 'bwhite',
        ['white'] = isSyn and '@@WHITE@@' or 'bwhite',
        ['black'] = isSyn and '@@BLACK@@' or 'bblack',
        ['green'] = isSyn and '@@GREEN@@' or 'bgreen',
        ['cyan'] = isSyn and '@@CYAN@@' or 'bcyan',
        ['blue'] = isSyn and '@@BLUE@@' or 'bblue',
        ['red'] = isSyn and '@@RED@@' or 'bred',
    }

    local extra = function(Type, Color, Input)
        local Type, Output, Color = Type:lower(), ('[ %s ] %s\n'), Colors[Color];
        if isSyn or rconsoleprint(Output:format(Type, table.concat(Input, ' ')), Color) then
            if Type == 'warn' then
                rconsolewarn(table.concat(Input, ' '));
            elseif Type == 'error' or Type == 'err' then
                rconsoleerr(table.concat(Input, ' '));
            elseif Type == 'info' then
                rconsoleinfo(table.concat(Input, ' '));
            end
        end
    end

    if Type == 'clear' then
        rconsoleclear();
    end

    if Type == 'exit' or Type == 'close' or Type == 'destroy' then
        Running = false;
        if isSyn or rconsoleclear() and rconsoledestroy() then
            rconsoleclear();
            rconsoleclose();
        end
    end

    if Type == 'warn' then
        extra('warn', 'yellow', {tostring(Color), ...});
    end

    if Type == 'error' then
        extra('error', 'red', {tostring(Color), ...});
    end

    if Type == 'info' then
        extra('info', 'cyan', {tostring(Color), ...});
    end

    if Type == 'name' or Type == 'title' or Type == 'console name' then
        local Args = {tostring(Color), ...};
        if isSyn or rconsolesettitle(table.concat(Args, ' ')) then
            rconsolename(table.concat(Args, ' '));
        end
    end

    if Type == 'print' then
        local Args = {...};
        local Color = Colors[tostring(Color):lower()] or extra('warn', 'yellow', {('Invalid Color Code \'%s\' |Setting Color to default'):format(tostring(Color))}) and Colors['white'];

        if isSyn or rconsoleprint(table.concat(Args, ' '), Color) then
            rconsoleprint(Color);
            rconsoleprint(table.concat(Args, ' '));
        end
    end
end

--[[
Console('clear');
Console('name', 'Command Prompt');
Console('warn', 'This is a warning');
Console('error', 'This is an error');
Console('info', 'This is an hint');
Console('print', 'white', 'This is a console print');
]]

