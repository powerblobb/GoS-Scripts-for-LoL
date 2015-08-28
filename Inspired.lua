require('DLib') 
menuTable = {}
currentPos = {x = 150, y = 250}
MINION_ALLY, MINION_ENEMY, MINION_JUNGLE = GetTeam(GetMyHero()), GetTeam(GetMyHero()) == 100 and 200 or 100, 300
Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
Smite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonersmite") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonersmite") and SUMMONER_2 or nil))
Exhaust = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerexhaust") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerexhaust") and SUMMONER_2 or nil))
objectLoopEvents = {}
afterObjectLoopEvents = {}
onProcessSpells = {}
delayedActions = {}
delayedActionsExecuter = nil
DAMAGE_MAGIC, DAMAGE_MAGICAL, DAMAGE_PHYSICAL = 1, 1, 2

local root = menu.addItem(SubMenu.new("Inspired"))
local InspiredMenu = root.addItem(MenuBool.new("Inspired Menu",true))

gapcloserTable = {
  ["Aatrox"] = _Q, ["Akali"] = _R, ["Alistar"] = _W, ["Ahri"] = _R, ["Amumu"] = _Q, ["Corki"] = _W,
  ["Diana"] = _R, ["Elise"] = _Q, ["Elise"] = _E, ["Fiddlesticks"] = _R, ["Fiora"] = _Q,
  ["Fizz"] = _Q, ["Gnar"] = _E, ["Grags"] = _E, ["Graves"] = _E, ["Hecarim"] = _R,
  ["Irelia"] = _Q, ["JarvanIV"] = _Q, ["Jax"] = _Q, ["Jayce"] = "JayceToTheSkies", ["Katarina"] = _E, 
  ["Kassadin"] = _R, ["Kennen"] = _E, ["KhaZix"] = _E, ["Lissandra"] = _E, ["LeBlanc"] = _W, 
  ["LeeSin"] = "blindmonkqtwo", ["Leona"] = _E, ["Lucian"] = _E, ["Malphite"] = _R, ["MasterYi"] = _Q, 
  ["MonkeyKing"] = _E, ["Nautilus"] = _Q, ["Nocturne"] = _R, ["Olaf"] = _R, ["Pantheon"] = _W, 
  ["Poppy"] = _E, ["RekSai"] = _E, ["Renekton"] = _E, ["Riven"] = _E, ["Sejuani"] = _Q, 
  ["Sion"] = _R, ["Shen"] = _E, ["Shyvana"] = _R, ["Talon"] = _E, ["Thresh"] = _Q, 
  ["Tristana"] = _W, ["Tryndamere"] = "Slash", ["Udyr"] = _E, ["Volibear"] = _Q, ["Vi"] = _Q, 
  ["XinZhao"] = _E, ["Yasuo"] = _E, ["Zac"] = _E, ["Ziggs"] = _W
}
GapcloseSpell, GapcloseTime, GapcloseUnit, GapcloseTargeted, GapcloseRange = 2, 0, nil, true, 450

function DelayAction(func, delay, args)
    if not delayedActionsExecuter then
        function delayedActionsExecuter()
            for t, funcs in pairs(delayedActions) do
                if t <= GetTickCount() then
                    for _, f in ipairs(funcs) do f.func(unpack(f.args or {})) end
                    delayedActions[t] = nil
                end
            end
        end
        OnLoop(delayedActionsExecuter)
    end
    local t = GetTickCount() + (delay or 0)
    if delayedActions[t] then table.insert(delayedActions[t], { func = func, args = args })
    else delayedActions[t] = { { func = func, args = args } }
    end
end

OnLoop(function(myHero)
    if InspiredMenu.getValue() then
    DrawMenu()
    end
    if Ignite and InspiredAutoIgnite.getValue() or InspiredConfig.Ignite then AutoIgnite() end 
    --if Ignite and InspiredConfig.Ignite then AutoIgnite() end
    local DlibIgnite = InspiredAutoIgnite.getValue() 
    local InspiredIgnite = InspiredConfig.Ignite  
--if InspiredAutoIgnite.getValue() == true and InspiredConfig.Ignite == false then 
--  return InspiredConfig.addParam("Ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
--elseif InspiredAutoIgnite.getValue() == false and InspiredConfig.Ignite == true then
--  return InspiredAutoIgnite = root.addItem(MenuBool.new("AutoIgnite",true))
--elseif InspiredAutoIgnite.getValue() == true and InspiredConfig.Ignite == true then
--  return InspiredAutoIgnite = root.addItem(MenuBool.new("AutoIgnite",true)) 
--  return InspiredConfig.addParam("Ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)  
--elseif InspiredAutoIgnite.getValue() == false and InspiredConfig.Ignite == false then
--  return InspiredAutoIgnite = root.addItem(MenuBool.new("AutoIgnite",false)) 
--  return InspiredConfig.addParam("Ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, false)    
--end     
    --    if Ignite and InspiredConfig.Ignite then AutoIgnite() end   
    --local root = menu.addItem(SubMenu.new("Inspired"))
    --InspiredAutoIgnite = menu.addItem(MenuBool.new("AutoIgnite",true))
end)

do
  _G.objectManager = {}
  objectManager.maxObjects = 0
  objectManager.objects = {}
  objectManager.spawnpoints = {}
  objectManager.camps = {}
  objectManager.barracks = {}
  objectManager.heroes = {}
  objectManager.minions = {}
  objectManager.turrets = {}
  objectManager.missiles = {}
  objectManager.shops = {}
  objectManager.wards = {}
  objectManager.unknown = {}
  OnObjectLoop(function(object, myHero)
    objectManager.objects[GetNetworkID(object)] = object
  end)
  OnLoop(function(myHero)
    objectManager.maxObjects = 0
    for _, obj in pairs(objectManager.objects) do
      objectManager.maxObjects = objectManager.maxObjects + 1
      local type = GetObjectType(obj)
      if type == Obj_AI_SpawnPoint then
        objectManager.spawnpoints[_] = obj
      elseif type == Obj_AI_Camp then
        objectManager.camps[_] = obj
      elseif type == Obj_AI_Barracks then
        objectManager.barracks[_] = obj
      elseif type == Obj_AI_Hero then
        objectManager.heroes[_] = obj
      elseif type == Obj_AI_Minion then
        objectManager.minions[_] = obj
      elseif type == Obj_AI_Turret then
        objectManager.turrets[_] = obj
      elseif type == Obj_AI_LineMissle then
        objectManager.missiles[_] = obj
      elseif type == Obj_AI_Shop then
        objectManager.shops[_] = obj
      else
        local objName = GetObjectBaseName(obj)
        if objName:lower():find("ward") or objName:lower():find("totem") then
          objectManager.wards[_] = obj
        else
          objectManager.unknown[_] = obj
        end
      end
    end
  end)
  DelayAction(function() EmptyObjManager() end, 60000)
end

function EmptyObjManager()
  _G.objectManager = {}
  objectManager.maxObjects = 0
  objectManager.objects = {}
  objectManager.spawnpoints = {}
  objectManager.camps = {}
  objectManager.barracks = {}
  objectManager.heroes = {}
  objectManager.minions = {}
  objectManager.turrets = {}
  objectManager.missiles = {}
  objectManager.shops = {}
  objectManager.wards = {}
  objectManager.unknown = {}
  collectgarbage()
  DelayAction(function() EmptyObjManager() end, 60000)
end

function AddGapcloseEvent(spell, range, targeted)
    GapcloseSpell = spell
    GapcloseTime = 0
    GapcloseUnit = nil
    GapcloseTargeted = targeted
    GapcloseRange = range
    str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
    --  local menu = root.addItem(SubMenu.new("GapClose"))
    GapcloseConfig = scriptConfig("gapclose", "Anti-Gapclose ("..str[spell]..")")
    GapcloseConfigDLIB = root.addItem(SubMenu.new("Anti-Gapclose ("..str[spell]..")"))
    --local root = menu.addItem(SubMenu.new("Inspired"))
    --InspiredAutoIgnite = menu.addItem(MenuBool.new("AutoIgnite",true))
    DelayAction(function()
        for _,k in pairs(GetEnemyHeroes()) do
          if gapcloserTable[GetObjectName(k)] then
            GapcloseConfig2 = GapcloseConfigDLIB.addItem(MenuBool.new(GetObjectName(k).."agap", "On "..GetObjectName(k).." "..(type(gapcloserTable[GetObjectName(k)]) == 'number' and str[gapcloserTable[GetObjectName(k)]] or (GetObjectName(k) == "LeeSin" and "Q" or "E")), true))
          end
        end
    end, 1)
     DelayAction(function()
        for _,k in pairs(GetEnemyHeroes()) do
          if gapcloserTable[GetObjectName(k)] then
            GapcloseConfig.addParam(GetObjectName(k).."agap", "On "..GetObjectName(k).." "..(type(gapcloserTable[GetObjectName(k)]) == 'number' and str[gapcloserTable[GetObjectName(k)]] or (GetObjectName(k) == "LeeSin" and "Q" or "E")), SCRIPT_PARAM_ONOFF, false)
          end
        end
    end, 1)
    OnProcessSpell(function(unit, spell)
      if not unit or not gapcloserTable[GetObjectName(unit)] or not GapcloseConfig[GetObjectName(unit).."agap"] or not GapcloseConfig2[GetObjectName(unit).."agap"].getValue() then return end
      if spell.name == (type(gapcloserTable[GetObjectName(unit)]) == 'number' and GetCastName(unit, gapcloserTable[GetObjectName(unit)]) or gapcloserTable[GetObjectName(unit)]) and (spell.target == GetMyHero() or GetDistanceSqr(spell.endPos) < GapcloseRange*GapcloseRange*4) then
        GapcloseTime = GetTickCount() + 2000
        GapcloseUnit = unit
      end
    end)
    OnLoop(function(myHero)
      if CanUseSpell(myHero, GapcloseSpell) == READY and GapcloseTime and GapcloseUnit and GapcloseTime > GetTickCount() then
        local pos = GetOrigin(GapcloseUnit)
        if GapcloseTargeted then
          if GetDistanceSqr(pos,GetMyHeroPos()) < GapcloseRange*GapcloseRange then
            CastTargetSpell(GapcloseUnit, GapcloseSpell)
          end
        else 
          if GetDistanceSqr(pos,GetMyHeroPos()) < GapcloseRange*GapcloseRange*4 then
            CastSkillShot(GapcloseSpell, pos.x, pos.y, pos.z)
          end
        end
      else
        GapcloseTime = 0
        GapcloseUnit = nil
      end
    end)
end

function AutoIgnite()
    if Ignite then
        for _, k in pairs(GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
    end
end

function CountMinions()
    local m = 0
    for _,k in pairs(GetAllMinions()) do 
        m = m + 1 
    end
    return m
end

function GetAllMinions(team)
    local result = {}
    for _,k in pairs(objectManager.minions) do
        if k and not IsDead(k) and GetCurrentHP(k) < 100000 and GetObjectName(k):find("_") then
            if not team or GetTeam(k) == team then
                result[_] = k
            end
        else
            objectManager.minions[_] = nil
        end
    end
    return result
end

function ClosestMinion(pos, team)
    local minion = nil
    for k,v in pairs(GetAllMinions(team)) do 
      if v then
        if not minion then minion = v end
        if minion and GetDistanceSqr(GetOrigin(minion),pos) > GetDistanceSqr(GetOrigin(v),pos) then
          minion = v
        end
      end
    end
    return minion
end

function GetLowestMinion(pos, range, team)
    local minion = nil
    for k,v in pairs(GetAllMinions(team)) do 
      if v then
        if not minion and GetDistanceSqr(GetOrigin(v),pos) < range*range then minion = v end
        if minion and GetDistanceSqr(GetOrigin(v),pos) < range*range and GetCurrentHP(v) < GetCurrentHP(minion) then
            minion = v
        end
      end
    end
    return minion
end

function GetHighestMinion(pos, range, team)
    local minion = nil
    for k,v in pairs(GetAllMinions(team)) do 
      if v then
        if not minion and GetDistanceSqr(GetOrigin(v),pos) < range*range then minion = v end
        if minion and GetDistanceSqr(GetOrigin(v),pos) < range*range and GetCurrentHP(v) > GetCurrentHP(minion) then
          minion = v
        end
      end
    end
    return minion
end

function GenerateMovePos()
    local mPos = GetMousePos()
    local tV = {x = (mPos.x-GetMyHeroPos().x), z = (mPos.z-GetMyHeroPos().z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = GetMyHeroPos().x + 250 * tV.x / len, y = GetMyHeroPos().y, z = GetMyHeroPos().z + 250 * tV.z / len}
end

function ValidTarget(unit, range)
    range = range or 25000
    if unit == nil or GetOrigin(unit) == nil or not IsTargetable(unit) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(GetMyHero()) or not IsInDistance(unit, range) then return false end
    return true
end

function IsInDistance(p1,r)
    return GetDistanceSqr(GetOrigin(p1)) < r*r
end

function GetDistance(p1,p2)
    p1 = GetOrigin(p1) or p1
    p2 = GetOrigin(p2) or p2
    return math.sqrt(GetDistanceSqr(p1,p2))
end

function EnemiesAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GetEnemyHeroes()) do 
        if v and ValidTarget(v) and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
            c = c + 1
        end
    end
    return c
end

function ClosestEnemy(pos)
    local enemy = nil
    for k,v in pairs(GetEnemyHeroes()) do 
        if not enemy and v then enemy = v end
        if enemy and v and GetDistanceSqr(GetOrigin(enemy),pos) > GetDistanceSqr(GetOrigin(v),pos) then
            enemy = v
        end
    end
    return enemy
end

function GetMyHeroPos()
    return GetOrigin(GetMyHero()) 
end

function GetEnemyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) ~= GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetAllyHeroes()
  local result = {}
  for _, obj in pairs(objectManager.heroes) do
    if GetTeam(obj) == GetTeam(GetMyHero()) then
      table.insert(result, obj)
    end
  end
  return result
end

function GetDistanceSqr(p1,p2)
    p2 = p2 or GetMyHeroPos()
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    return dx*dx + dz*dz
end

function CalcDamage(source, target, addmg, apdmg)
    local ADDmg = addmg or 0
    local APDmg = apdmg or 0
    local ArmorPen = math.floor(GetArmorPenFlat(source))
    local ArmorPenPercent = math.floor(GetArmorPenPercent(source)*100)/100
    local Armor = GetArmor(target)*ArmorPenPercent-ArmorPen
    local ArmorPercent = Armor > 0 and math.floor(Armor*100/(100+Armor))/100 or math.ceil(Armor*100/(100-Armor))/100
    local MagicPen = math.floor(GetMagicPenFlat(source))
    local MagicPenPercent = math.floor(GetMagicPenPercent(source)*100)/100
    local MagicArmor = GetMagicResist(target)*MagicPenPercent-MagicPen
    local MagicArmorPercent = MagicArmor > 0 and math.floor(MagicArmor*100/(100+MagicArmor))/100 or math.ceil(MagicArmor*100/(100-MagicArmor))/100
    return (GotBuff(source,"exhausted")  > 0 and 0.4 or 1) * math.floor(ADDmg*(1-ArmorPercent))+math.floor(APDmg*(1-MagicArmorPercent))
end

function GetTarget(range, damageType)
    damageType = damageType or 2
    local target, steps = nil, 10000
    for _, k in pairs(GetEnemyHeroes()) do
        local step = GetCurrentHP(k) / CalcDamage(GetMyHero(), k, DAMAGE_PHYSICAL == damageType and 100 or 0, DAMAGE_MAGIC == damageType and 100 or 0)
        if k and ValidTarget(k, range) and step < steps then
            target = k
            steps = step
        end
    end
    return target
end

function CastOffensiveItems(unit)
  i = {3748, 3074, 3077, 3142, 3184}
  u = {3153, 3146, 3144}
  for _,k in pairs(i) do
    slot = GetItemSlot(GetMyHero(),k)
    if slot ~= nil and slot ~= 0 and CanUseSpell(GetMyHero(), slot) == READY then
      CastTargetSpell(GetMyHero(), slot)
      return true
    end
  end
  for _,k in pairs(u) do
    slot = GetItemSlot(GetMyHero(),k)
    if slot ~= nil and slot ~= 0 and CanUseSpell(GetMyHero(), slot) == READY then
      CastTargetSpell(unit, slot)
      return true
    end
  end
  return false
end

SCRIPT_PARAM_ONOFF = 1
SCRIPT_PARAM_KEYDOWN = 2
SCRIPT_PARAM_SLICE = 3
SCRIPT_PARAM_INFO = 4
SCRIPT_PARAM_LIST = 5
selectedMenuState = ""

function DrawMenu()
      --    if Ignite and InspiredConfig.Ignite then AutoIgnite() end   
--if Ignite then
--  InspiredConfig = scriptConfig("Inspired", "Inspired.lua")
--  InspiredConfig.addParam("Ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
--  --Combo = root.addItem(SubMenu.new("Combo"))
--  InspiredAutoIgnite = root.addItem(MenuBool.new("AutoIgnite",true))
  
--end
    --InspiredAutoIgnite = menu.addItem(MenuBool.new("AutoIgnite",true))
  if KeyIsDown(0x10) and InspiredMenu.getValue() then
    local c = 0
    local d = 0
    local e = 0
    local f = 0
    for a,b in pairs(menuTable) do
      d = d + 1
    end
    local mPos  = GetMousePos()
    local mmPos = WorldToScreen(1,mPos.x,mPos.y,mPos.z)
    FillRect(currentPos.x-5,currentPos.y+30,210,d*35+40,0x50ffffff)
    c = c + 1
    FillRect(currentPos.x,c*35+currentPos.y,200,30,0x90ffffff)
    DrawText("- - - - ScriptConfig - - - -",20,currentPos.x+10,c*35+currentPos.y+5,0xffffffff)
    for _, menu in pairs(menuTable) do
      c = c + 1
      FillRect(currentPos.x,c*35+currentPos.y,200,30,0x90ffffff)
      DrawText(menu.name,20,currentPos.x+10,c*35+currentPos.y+5,0xffffffff)
      if selectedMenuState == _ then
        FillRect(currentPos.x,c*35+currentPos.y,200,30,0x90ffffff)
        for k, thing in pairs(menu) do
          if type(thing) == "table" then
            f = f + 1
          end
        end
        FillRect(currentPos.x+205,currentPos.y+65,210,f*35+5,0x50ffffff)
        e = e + 1
        for k, thing in pairs(menu) do
          if thing.type == SCRIPT_PARAM_INFO then
            e = e + 1
            FillRect(currentPos.x+210,e*35+currentPos.y,200,30,0x90ffffff)
            DrawText(thing.t,20,currentPos.x+10+210,e*35+currentPos.y+5,0xffffffff)
          elseif thing.type == SCRIPT_PARAM_ONOFF then
            e = e + 1
            if thing.value then
              FillRect(currentPos.x+150+210,e*35+currentPos.y,50,30,0x9000ff00)
            else
              FillRect(currentPos.x+150+210,e*35+currentPos.y,50,30,0x90ff0000)
            end
            FillRect(currentPos.x+210,e*35+currentPos.y,150,30,0x90ffffff)
            DrawText(thing.t,20,currentPos.x+10+210,e*35+currentPos.y+5,0xffffffff)
            DrawText(({[true] = "On", [false] = "Off"})[thing.value],20,currentPos.x+160+210,e*35+currentPos.y+5,0xffffffff)
          end
        end
        for k, thing in pairs(menu) do
          if thing.type == SCRIPT_PARAM_KEYDOWN then
            e = e + 1
            if thing.value then
              FillRect(currentPos.x+150+210,e*35+currentPos.y,50,30,0x9000ff00)
            else
              FillRect(currentPos.x+150+210,e*35+currentPos.y,50,30,0x90ff0000)
            end
            FillRect(currentPos.x+210,e*35+currentPos.y,150,30,0x90ffffff)
            DrawText(thing.t,20,currentPos.x+10+210,e*35+currentPos.y+5,0xffffffff)
            local t = string.char(thing.key)
            if thing.switchNow then
              DrawText("...",20,currentPos.x+165+210,e*35+currentPos.y+5,0xffffffff)
            else
              DrawText(t == " " and "Space" or t,20,currentPos.x+(t == " " and 155 or 170)+210,e*35+currentPos.y+5,0xffffffff)
            end
          end
        end
      elseif selectedMenuState == "" then
        selectedMenuState = _
      end
    end
    if KeyIsDown(1) and InspiredMenu.getValue() then
      local c = 1
      local f = 1
      for a,b in pairs(menuTable) do
        d = d + 1
      end
      if moveNow then currentPos = {x = mmPos.x-25, y = mmPos.y-45} end
      if mmPos.x >= currentPos.x and mmPos.x <= currentPos.x+200 and mmPos.y >= (1*35+currentPos.y) and mmPos.y <= (1*35+currentPos.y+30) then
        moveNow = true
      end
      for _, menu in pairs(menuTable) do
        c = c + 1
        if mmPos.x >= currentPos.x and mmPos.x <= currentPos.x+200 and mmPos.y >= (c*35+currentPos.y) and mmPos.y <= (c*35+currentPos.y+30) then
          selectedMenuState = _
        end
        if selectedMenuState == _ then
          for k, thing in pairs(menu) do
            if thing.type ~= SCRIPT_PARAM_KEYDOWN then
              if type(thing) == "table" then
                f = f + 1
              end
              if thing.type == SCRIPT_PARAM_ONOFF and thing.lastSwitch + 250 < GetTickCount() and mmPos.x >= currentPos.x+150+210 and mmPos.x <= currentPos.x+200+210 and mmPos.y >= (f*35+currentPos.y) and mmPos.y <= (f*35+currentPos.y+30) then
                thing.lastSwitch = GetTickCount()
                thing.value = not thing.value
              end
            end
          end
          for k, thing in pairs(menu) do
            if thing.type == SCRIPT_PARAM_KEYDOWN then
              if type(thing) == "table" then
                f = f + 1
              end
              if thing.type == SCRIPT_PARAM_KEYDOWN and mmPos.x >= currentPos.x+150+210 and mmPos.x <= currentPos.x+200+210 and mmPos.y >= (f*35+currentPos.y) and mmPos.y <= (f*35+currentPos.y+30) then
                thing.switchNow = true
              end
            end
          end
        end
      end
    else
      moveNow = false
    end
    for _,menu in pairs(menuTable) do
      for _,k in pairs(menu) do
        if k.type and k.type == SCRIPT_PARAM_KEYDOWN and k.switchNow then
          for i=17, 128 do
            if KeyIsDown(i) then
              k.key = i
              k.switchNow = false
            end
          end
        end
      end
    end
  else
    moveNow = false
  end
end

function scriptConfig(id, text, master)
  local Config = {}
  menuTable[id] = {name = text, m = master}
  Config.addSubMenu = function(idSub, textSub) Config[idSub] = scriptConfig(idSub, ">>"..text..": "..textSub, id) end
  Config.addParam   = function(idBut, textBut, type, val1, val2, val3, val4) 
                        if type == SCRIPT_PARAM_ONOFF then
                          Config[idBut] = val1
                          menuTable[id][idBut] = {t = textBut, type = type, value = val1, lastSwitch = 0}
                          OnLoop(function(myHero) Config[idBut] = menuTable[id][idBut].value end)
                        elseif type == SCRIPT_PARAM_KEYDOWN then 
                          Config[idBut] = false
                          menuTable[id][idBut] = {t = textBut, type = type, key = val1, value = false, switchNow = false}
                          OnLoop(function(myHero) Config[idBut] = KeyIsDown(menuTable[id][idBut].key)
                                                  menuTable[id][idBut].value = KeyIsDown(menuTable[id][idBut].key) end)
                        elseif type == SCRIPT_PARAM_SLICE then
                        elseif type == SCRIPT_PARAM_INFO then
                          menuTable[id][idBut] = {t = textBut, type = type}
                        elseif type == SCRIPT_PARAM_LIST then
                        end
                      end
  return Config
end

if Ignite then
  InspiredConfig = scriptConfig("Inspired", "Inspired.lua")
  InspiredConfig.addParam("Ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, false)
  InspiredAutoIgnite = root.addItem(MenuBool.new("AutoIgnite",true))
end

local toPrint, toPrintCol = {}, {}
function print(str, time, col)
  local b = 0
  for _, k in pairs(toPrint) do
    b = _
  end
  local index = b + 1
  toPrint[index] = str
  toPrintCol[index] = col or 0xffffffff
  DelayAction(function() toPrint[index] = nil toPrintCol[index] = nil end, time or 2000)
end

OnLoop(function(myHero)
  local c = 0
  for _, k in pairs(toPrint) do
    c = c + 1
    DrawText(k,50,750,200+50*c,toPrintCol[_])
  end
end)

function VectorType(v)
    v = GetOrigin(v) or v
    return v and v.x and type(v.x) == "number" and ((v.y and type(v.y) == "number") or (v.z and type(v.z) == "number"))
end

local function IsClockWise(A,B,C)
    return VectorDirection(A,B,C)<=0
end

local function IsCounterClockWise(A,B,C)
    return not IsClockWise(A,B,C)
end

function IsLineSegmentIntersection(A,B,C,D)
    return IsClockWise(A, C, D) ~= IsClockWise(B, C, D) and IsClockWise(A, B, C) ~= IsClockWise(A, B, D)
end

function VectorIntersection(a1, b1, a2, b2) --returns a 2D point where to lines intersect (assuming they have an infinite length)
    assert(VectorType(a1) and VectorType(b1) and VectorType(a2) and VectorType(b2), "VectorIntersection: wrong argument types (4 <Vector> expected)")
    --http://thirdpartyninjas.com/blog/2008/10/07/line-segment-intersection/
    local x1, y1, x2, y2, x3, y3, x4, y4 = a1.x, a1.z or a1.y, b1.x, b1.z or b1.y, a2.x, a2.z or a2.y, b2.x, b2.z or b2.y
    local r, s, u, v, k, l = x1 * y2 - y1 * x2, x3 * y4 - y3 * x4, x3 - x4, x1 - x2, y3 - y4, y1 - y2
    local px, py, divisor = r * u - v * s, r * k - l * s, v * k - l * u
    return divisor ~= 0 and Vector(px / divisor, py / divisor)
end

function LineSegmentIntersection(A,B,C,D)
    return IsLineSegmentIntersection(A,B,C,D) and VectorIntersection(A,B,C,D)
end

function VectorDirection(v1, v2, v)
    --assert(VectorType(v1) and VectorType(v2) and VectorType(v), "VectorDirection: wrong argument types (3 <Vector> expected)")
    return ((v.z or v.y) - (v1.z or v1.y)) * (v2.x - v1.x) - ((v2.z or v2.y) - (v1.z or v1.y)) * (v.x - v1.x) 
end

function VectorPointProjectionOnLine(v1, v2, v)
    assert(VectorType(v1) and VectorType(v2) and VectorType(v), "VectorPointProjectionOnLine: wrong argument types (3 <Vector> expected)")
    local line = Vector(v2) - v1
    local t = ((-(v1.x * line.x - line.x * v.x + (v1.z - v.z) * line.z)) / line:len2())
    return (line * t) + v1
end

--[[
    VectorPointProjectionOnLineSegment: Extended VectorPointProjectionOnLine in 2D Space
    v1 and v2 are the start and end point of the linesegment
    v is the point next to the line
    return:
        pointSegment = the point closest to the line segment (table with x and y member)
        pointLine = the point closest to the line (assuming infinite extent in both directions) (table with x and y member), same as VectorPointProjectionOnLine
        isOnSegment = if the point closest to the line is on the segment
]]
function VectorPointProjectionOnLineSegment(v1, v2, v)
    assert(v1 and v2 and v, "VectorPointProjectionOnLineSegment: wrong argument types (3 <Vector> expected)")
    local cx, cy, ax, ay, bx, by = v.x, (v.z or v.y), v1.x, (v1.z or v1.y), v2.x, (v2.z or v2.y)
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
    local pointLine = { x = ax + rL * (bx - ax), y = ay + rL * (by - ay) }
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or { x = ax + rS * (bx - ax), y = ay + rS * (by - ay) }
    return pointSegment, pointLine, isOnSegment
end

class 'Vector'

function Vector:__init(a, b, c)
    if a == nil then
        self.x, self.y, self.z = 0.0, 0.0, 0.0
    elseif b == nil then
        a = GetOrigin(a) or a
        assert(VectorType(a), "Vector: wrong argument types (expected nil or <Vector> or 2 <number> or 3 <number>)")
        self.x, self.y, self.z = a.x, a.y, a.z
    else
        assert(type(a) == "number" and (type(b) == "number" or type(c) == "number"), "Vector: wrong argument types (<Vector> or 2 <number> or 3 <number>)")
        self.x = a
        if b and type(b) == "number" then self.y = b end
        if c and type(c) == "number" then self.z = c end
    end
end

function Vector:__type()
    return "Vector"
end

function Vector:__add(v)
    assert(VectorType(v) and VectorType(self), "add: wrong argument types (<Vector> expected)")
    return Vector(self.x + v.x, (v.y and self.y) and self.y + v.y, (v.z and self.z) and self.z + v.z)
end

function Vector:__sub(v)
    assert(VectorType(v) and VectorType(self), "Sub: wrong argument types (<Vector> expected)")
    return Vector(self.x - v.x, (v.y and self.y) and self.y - v.y, (v.z and self.z) and self.z - v.z)
end

function Vector.__mul(a, b)
    if type(a) == "number" and VectorType(b) then
        return Vector({ x = b.x * a, y = b.y and b.y * a, z = b.z and b.z * a })
    elseif type(b) == "number" and VectorType(a) then
        return Vector({ x = a.x * b, y = a.y and a.y * b, z = a.z and a.z * b })
    else
        assert(VectorType(a) and VectorType(b), "Mul: wrong argument types (<Vector> or <number> expected)")
        return a:dotP(b)
    end
end

function Vector.__div(a, b)
    if type(a) == "number" and VectorType(b) then
        return Vector({ x = a / b.x, y = b.y and a / b.y, z = b.z and a / b.z })
    else
        assert(VectorType(a) and type(b) == "number", "Div: wrong argument types (<number> expected)")
        return Vector({ x = a.x / b, y = a.y and a.y / b, z = a.z and a.z / b })
    end
end

function Vector.__lt(a, b)
    assert(VectorType(a) and VectorType(b), "__lt: wrong argument types (<Vector> expected)")
    return a:len() < b:len()
end

function Vector.__le(a, b)
    assert(VectorType(a) and VectorType(b), "__le: wrong argument types (<Vector> expected)")
    return a:len() <= b:len()
end

function Vector:__eq(v)
    assert(VectorType(v), "__eq: wrong argument types (<Vector> expected)")
    return self.x == v.x and self.y == v.y and self.z == v.z
end

function Vector:__unm()
    return Vector(-self.x, self.y and -self.y, self.z and -self.z)
end

function Vector:__vector(v)
    assert(VectorType(v), "__vector: wrong argument types (<Vector> expected)")
    return self:crossP(v)
end

function Vector:__tostring()
    if self.y and self.z then
        return "(" .. tostring(self.x) .. "," .. tostring(self.y) .. "," .. tostring(self.z) .. ")"
    else
        return "(" .. tostring(self.x) .. "," .. self.y and tostring(self.y) or tostring(self.z) .. ")"
    end
end

function Vector:clone()
    return Vector(self)
end

function Vector:unpack()
    return self.x, self.y, self.z
end

function Vector:len2(v)
    assert(v == nil or VectorType(v), "dist: wrong argument types (<Vector> expected)")
    local v = v and Vector(v) or self
    return self.x * v.x + (self.y and self.y * v.y or 0) + (self.z and self.z * v.z or 0)
end

function Vector:len()
    return math.sqrt(self:len2())
end

function Vector:dist(v)
    assert(VectorType(v), "dist: wrong argument types (<Vector> expected)")
    local a = self - v
    return a:len()
end

function Vector:normalize()
    local a = self:len()
    self.x = self.x / a
    if self.y then self.y = self.y / a end
    if self.z then self.z = self.z / a end
end

function Vector:normalized()
    local a = self:clone()
    a:normalize()
    return a
end

function Vector:center(v)
    assert(VectorType(v), "center: wrong argument types (<Vector> expected)")
    return Vector((self + v) / 2)
end

function Vector:crossP(other)
    assert(self.y and self.z and other.y and other.z, "crossP: wrong argument types (3 Dimensional <Vector> expected)")
    return Vector({
        x = other.z * self.y - other.y * self.z,
        y = other.x * self.z - other.z * self.x,
        z = other.y * self.x - other.x * self.y
    })
end

function Vector:dotP(other)
    assert(VectorType(other), "dotP: wrong argument types (<Vector> expected)")
    return self.x * other.x + (self.y and (self.y * other.y) or 0) + (self.z and (self.z * other.z) or 0)
end

function Vector:projectOn(v)
    assert(VectorType(v), "projectOn: invalid argument: cannot project Vector on " .. type(v))
    if type(v) ~= "Vector" then v = Vector(v) end
    local s = self:len2(v) / v:len2()
    return Vector(v * s)
end

function Vector:mirrorOn(v)
    assert(VectorType(v), "mirrorOn: invalid argument: cannot mirror Vector on " .. type(v))
    return self:projectOn(v) * 2
end

function Vector:sin(v)
    assert(VectorType(v), "sin: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    local a = self:__vector(v)
    return math.sqrt(a:len2() / (self:len2() * v:len2()))
end

function Vector:cos(v)
    assert(VectorType(v), "cos: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    return self:len2(v) / math.sqrt(self:len2() * v:len2())
end

function Vector:angle(v)
    assert(VectorType(v), "angle: wrong argument types (<Vector> expected)")
    return math.acos(self:cos(v))
end

function Vector:affineArea(v)
    assert(VectorType(v), "affineArea: wrong argument types (<Vector> expected)")
    if type(v) ~= "Vector" then v = Vector(v) end
    local a = self:__vector(v)
    return math.sqrt(a:len2())
end

function Vector:triangleArea(v)
    assert(VectorType(v), "triangleArea: wrong argument types (<Vector> expected)")
    return self:affineArea(v) / 2
end

function Vector:rotateXaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.y, self.z = self.y * c - self.z * s, self.z * c + self.y * s
end

function Vector:rotateYaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.x, self.z = self.x * c + self.z * s, self.z * c - self.x * s
end

function Vector:rotateZaxis(phi)
    assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    local c, s = math.cos(phi), math.sin(phi)
    self.x, self.y = self.x * c - self.z * s, self.y * c + self.x * s
end

function Vector:rotate(phiX, phiY, phiZ)
    assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotate: wrong argument types (expected <number> for phi)")
    if phiX ~= 0 then self:rotateXaxis(phiX) end
    if phiY ~= 0 then self:rotateYaxis(phiY) end
    if phiZ ~= 0 then self:rotateZaxis(phiZ) end
end

function Vector:rotated(phiX, phiY, phiZ)
    assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotated: wrong argument types (expected <number> for phi)")
    local a = self:clone()
    a:rotate(phiX, phiY, phiZ)
    return a
end

-- not yet full 3D functions
function Vector:polar()
    if math.close(self.x, 0) then
        if (self.z or self.y) > 0 then return 90
        elseif (self.z or self.y) < 0 then return 270
        else return 0
        end
    else
        local theta = math.deg(math.atan((self.z or self.y) / self.x))
        if self.x < 0 then theta = theta + 180 end
        if theta < 0 then theta = theta + 360 end
        return theta
    end
end

function Vector:angleBetween(v1, v2)
    assert(VectorType(v1) and VectorType(v2), "angleBetween: wrong argument types (2 <Vector> expected)")
    local p1, p2 = (-self + v1), (-self + v2)
    local theta = p1:polar() - p2:polar()
    if theta < 0 then theta = theta + 360 end
    if theta > 180 then theta = 360 - theta end
    return theta
end

function Vector:compare(v)
    assert(VectorType(v), "compare: wrong argument types (<Vector> expected)")
    local ret = self.x - v.x
    if ret == 0 then ret = self.z - v.z end
    return ret
end

function Vector:perpendicular()
    return Vector(-self.z, self.y, self.x)
end

function Vector:perpendicular2()
    return Vector(self.z, self.y, -self.x)
end

class "Circle" -- {
  function Circle:__init(x, y, z, r)
    local pos = GetOrigin(x) or type(x) ~= "number" and x or nil
    self.x = pos and pos.x or x
    self.y = pos and pos.y or y
    self.z = pos and pos.z or z
    self.r = pos and y or r
  end

  function Circle:contains(pos)
    return GetDistanceSqr(Vector(self.x, self.y, self.z), pos) < self.r * self.r
  end

  function Circle:draw(color)
    DrawCircle(self.x, self.y, self.z, self.r, 1, 10, color or 0xffffffff)
  end
-- }

wallTable = { -- Summoners Rift only..
  Circle(1550,93,1700,400), Circle(1720,95,2320,150), 
  Circle(2166,95,1830,150), Circle(3460,93,1280,200), 
  Circle(4270,95,1290,150), Circle(4000,95,2450,150), 
  Circle(3200,93,3220,200), Circle(1170,93,3590,200),
  Circle(2440,95,4040,150), Circle(1165,95,4270,150),
  Circle(3650,95,3690,150), Circle(1820,90,4890,170),
  Circle(2000,50,4890,170), Circle(2200,50,4890,170),
  Circle(2350,50,4890,170), Circle(3000,50,4800,170),
  Circle(3200,50,4700,170), Circle(3400,50,4600,170),
  Circle(3600,50,4500,170), Circle(3400,50,4600,170),
  Circle(4450,50,3700,170), Circle(4550,50,3500,170),
  Circle(4650,50,3300,170), Circle(4750,50,3100,170),
  Circle(4850,50,2600,170), Circle(4870,50,2400,170),
  Circle(4880,50,2200,170), Circle(4890,50,2000,170),
  Circle(5636,51,2125,250), Circle(5656,51.94,1957,261),
  Circle(5644,51.63,2400,240), Circle(4190,50,2000,170),
  Circle(5716,51,2700,260), Circle(6047,52,2860,210),
  Circle(5765,53,3169,370), Circle(5365.73,50.31,4327,480),
  Circle(5408,51,3994,300), Circle(5544,47.09,4733,210),
  Circle(5831.42,48.49,4727.8,300), Circle(6601,48.52,4999,190),
  Circle(6567.42,56.67,5694,265), Circle(6602,49.38,5315,220),
  Circle(6280,51.76,5571,185), Circle(6050,50.07,5403,180),
  Circle(6805,52.80,6038,185), Circle(6949,63.34,5792,180),
  Circle(7458,51.04,5452,265), Circle(7341,55.34,5692,180),
  Circle(7085,57.13,5861,235), Circle(6676,52.16,2129,400),
  Circle(7461,51.14,2009,235), Circle(7066,51.58,2111,400),
  Circle(6884,52.05,2369,195), Circle(7721,50.96,1929,200),
  Circle(6745,51.70,2366,195), Circle(6781,51.56,3487,340),
  Circle(6350,49.90,3983,245), Circle(6462,48.46,3752,220),
  Circle(6466,48.67,4277,215), Circle(6520,48.52,4471,120),
  Circle(7300,56.65,4267,265), Circle(7398,49.26,4434,250),
  Circle(7722,56.25,4552,225), Circle(8045,52.51,4544,250),
  Circle(8282,53.36,4382,305), Circle(8287,53.96,3936,250),
  Circle(8027,52.94,3718,190), Circle(7756,52.56,2998,210),
  Circle(7927,52.11,2691,260), Circle(8076,51.55,3005,185),
  Circle(8344,51.46,3079,165), Circle(8572,53.12,3065,195),
}

function IsWall(spot)
  for _=1, #wallTable do
    if wallTable[_]:contains(spot) then
      return true
    end
  end
  return false
end
