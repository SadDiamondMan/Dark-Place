function Mod:registerShaders()
    self.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        self.shaders[path] = shader
    end
end

--- Returns the current party leader's PartyMember, Actor, ActorSprite, Character or PartyBattler object
---@param kind? "partymember"|"party"|"character"|"chara"|"actor"|"sprite"|"actorsprite"|"battler"|"partybattler" The kind of object that will be gathered, "partymember" by default
---@return PartyMember|Actor|ActorSprite|Character|PartyBattler|nil obj A object related to the leader.
function Mod:getLeader(kind)
    kind = (kind or "partymember"):lower()

    local leader = Game.party[1]
    if not leader then return nil end

    if kind == "character" or kind == "chara" then
        if not Game.world then return nil end
        return Game.world:getCharacter(leader.id)
    elseif kind == "actor" then
        return leader.actor
    elseif kind == "sprite" or kind == "actorsprite" then
        local chara = self:getLeader("character")
        if not chara then return nil end
        return chara.sprite
    elseif kind == "battler" or kind == "partybattler" then
        if not Game.battle then return nil end
        return Game.battle:getPartyBattler(leader.id)
    end
    return leader --[[ if kind == "partymember" or kind == "party" ]]
end

-- Get the average LOVE for the whole party \
-- Note that the result absolutely can be a double. Round if necessary.
--- @return number love # The LOVE of the party
function Mod:getPartyLove()
    local sum_love = 0
    for _,char in ipairs(Game.party) do
        sum_love = sum_love + char:getLOVE()
    end
    return sum_love/#Game.party
end

-- Check if a file exists in the AppData/Home folder.
-- Can/Will be used to check if the player has played certain games like Undertale or Deltarune.
---@param try_wine_route? boolean # If true, an attempt to check wineprefixs for the file will be made on Linux. In this case name should be a path for Windows.
---@param wine_steam_appid? number # The Steam AppID of the game to check for; if specified, wine route will also check the wineprefix corresponding to that AppID.
--- @return boolean exists
function Mod:fileExists(name, try_wine_route, wine_steam_appid)
    local path = ""
    local function fileExists(path)
        local f = io.open(path, "r")
        return f ~= nil and io.close(f)
    end
    local function directoryExists(file)
        local ok, err, code = os.rename(file, file)
        if not ok then
            if code == 13 then
                -- Permission denied, but it exists
                return true
            end
        end
        return ok, err
    end
    if love.system.getOS() == "Windows" then
        local function unixizePathSep(path)
            return string.gsub(path, "\\", "/")
        end
        local appdata = (
            os.getenv("APPDATA") and (unixizePathSep(os.getenv("APPDATA")).."/../")
            or (unixizePathSep(os.getenv("USERPROFILE")).."/AppData/")
        )
        path = appdata..name
    elseif love.system.getOS() == "OS X" then
        if try_wine_route then return false end -- UNIMPLEMENTED

        path = os.getenv("HOME").."/Library/Application Support/"..name
    elseif love.system.getOS() == "Linux" then
        if not try_wine_route then
            -- don't ask why %
            name = string.gsub(name, "%XDG_CONFIG_HOME%", os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME").."/.config")
            local starts_at_root, _ = Utils.startsWith(name, "/")
            if not starts_at_root then
                path = os.getenv("HOME").."/"..name
            else
                path = name
            end
        else -- assuming that a Windows path is passed
            local wineprefix = os.getenv("WINEPREFIX") or os.getenv("HOME").."/.wine"
            local user_wineprefix = wineprefix.."/drive_c/users/"..os.getenv("USER")
            local appdata_wineprefix = user_wineprefix.."/Local Settings/Application Data/" -- 2k3
            if not directoryExists(appdata_wineprefix) then
                appdata_wineprefix = user_wineprefix.."/AppData/" -- vista
            end
            local path_wineprefix = appdata_wineprefix..name
            if fileExists(path_wineprefix) then return true end

            if wine_steam_appid then
                local steamroot = os.getenv("STEAMROOT") or os.getenv("HOME").."/.steam"
                local steampfx = steamroot.."/steam/steamapps/compatdata/"..tostring(wine_steam_appid).."/pfx"
                local user_steampfx = steampfx.."/drive_c/users/steamuser"
                local appdata_steampfx = user_steampfx.."/Local Settings/Application Data/" -- 2k3
                if not directoryExists(appdata_steampfx) then
                    appdata_steampfx = user_steampfx.."/AppData/" -- vista
                end
                local path_steampfx = appdata_steampfx..name
                if fileExists(path_steampfx) then return true end
            end
            return false
        end
    end
    return fileExists(path)
end

-- Directly check if a Kristal mod has any save files using Mod:fileExists()
--- @return boolean exists
function Mod:hasSaveFiles(id, specific_file, fused_identify)
    local paths = {
        "LOVE/kristal/saves/",                      -- Source code version
        "kristal/saves/",                           -- Executable version
        "LOVE/"..(fused_identify or id).."/saves/", -- Source code version but changed Kristal's id in conf.lua
        (fused_identify or id).."/saves/",  		-- Executable version but changed Kristal's id in conf.lua
    }

    for i,v in ipairs(paths) do
        if love.system.getOS() == "Windows" then
            paths[i] = "Roaming/"..v
        elseif love.system.getOS() == "OS X" then
            paths[i] = v
        elseif love.system.getOS() == "Linux" then
            local data_home = os.getenv("XDG_DATA_HOME") or os.getenv("HOME").."/.local/share"
            paths[i] = data_home..v
        end
    end

    for _,path in ipairs(paths) do
        if specific_file then
            if Mod:fileExists(path..id.."/"..specific_file) then
                return true
            end
        else
            for i = 0 --[[ for Wii BIOS mod ]], 3 do
                if Mod:fileExists(path..id.."/file_"..i..".json") then
                    return true
                end
            end
        end
    end

    return false
end

function Mod:hasWiiBIOS()
    return not not love.filesystem.getInfo("wii_settings.json")
end

---@param ... any # Extra parameters to cond()
function Mod:evaluateCond(data, ...)
    local result = true

    if data.cond then
        result = data.cond(...)
    elseif data.flagcheck then
        local inverted, flag = Utils.startsWith(data.flagcheck, "!")

        local flag_value = Game.flags[flag]
        local expected_value = data.flagvalue
        local is_true
        if expected_value ~= nil then
            is_true = flag_value == expected_value
        elseif type(result) == "number" then
            is_true = flag_value > 0
        else
            is_true = flag_value
        end

        if is_true then
            result = not inverted
        else
            result = inverted
        end
    end

    return result
end

function Mod:setPresenceState(details)
    self.rpc_state = details

    -- talk about some half-baked support :bangbang:
    local presence = Kristal.getPresence()
    if presence then
        presence.state = Kristal.callEvent("getPresenceState")
        Kristal.setPresence(presence)
    end
end

-- Gets the index of an item in a 2D table
---@return integer|nil i
---@return integer|nil j
function Mod:getIndex2D(t, value)
    for i,r in ipairs(t) do
        local j = Utils.getIndex(r, value)
        if j then
            return i, j
        end
    end
    return nil, nil
end

function Mod:setDesiredWindowTitleAndIcon()
    if Kristal.setDesiredWindowTitleAndIcon then
        Kristal.setDesiredWindowTitleAndIcon()
    else
        love.window.setIcon(Kristal.icon)
        love.window.setTitle(Kristal.getDesiredWindowTitle())
    end
end

-- "Linear interpolation" that snaps into place when there is little distance left.
-- This is meaningful in case m (typically named t) is constant.
--
-- Derived from GML snippet by cecil (@attic-stuff) on GameMaker Discord
--
---@param a number # Left edge
---@param b number # Right edge
---@param m number # Progress or increment amount
---@param snap_delta? number # Distance at which to snap to b
---@return number
function Mod:lerpSnap(a, b, m, snap_delta)
    if snap_delta == nil then snap_delta = 0.001 end
    local result = Utils.lerp(a, b, m)
    if b - result <= snap_delta then
        return b
    end
    return result
end