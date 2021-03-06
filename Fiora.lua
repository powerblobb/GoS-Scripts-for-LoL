if GetObjectName(GetMyHero()) ~= "Fiora" then return end
--MonTour Fiora:V1.0.0.3 - updated GoS:myHeroPos() to GetOrigin(myHero)
PrintChat(string.format("<font color='#80F5F5'>MonTour Fiora:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.2</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> leoferrerinha for Auto W</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))
local MonTourMenu = Menu("Fiora", "Fiora")
MonTourMenu:SubMenu("Combo", "Combo")
MonTourMenu.Combo:Boolean("Q","Use Q",true)
MonTourMenu.Combo:Boolean("W","Use W",false)
MonTourMenu.Combo:Boolean("E","Use E",true)
MonTourMenu.Combo:Boolean("R","Use R",true)
MonTourMenu.Combo:Slider("HP", "Use R if HP < x%", 20, 1, 80, 1)
MonTourMenu:SubMenu("Harass", "Harass")
MonTourMenu.Harass:Boolean("Q","Use Q",true)
MonTourMenu.Harass:Boolean("W","Use W",false)
MonTourMenu.Harass:Boolean("E","Use E",false)
MonTourMenu.Harass:Boolean("R","Use R",false)
MonTourMenu.Harass:Slider("HP", "Use R if HP < x%", 20, 1, 80, 1)
MonTourMenu:SubMenu("LaneClear", "LaneClear/JungleClear")
MonTourMenu.LaneClear:Boolean("Q","Use Q",true)
MonTourMenu.LaneClear:Boolean("W","Use W",false)
MonTourMenu.LaneClear:Boolean("E","Use E",true)
MonTourMenu.LaneClear:Info("Fiora", " ")
MonTourMenu.LaneClear:Boolean("useTiamat", "Tiamat", true)
MonTourMenu.LaneClear:Boolean("useHydra", "Hydra", true)
MonTourMenu.LaneClear:Slider("TiHy", "if MinionAround >= X (Def. 5)", 5, 1, 20, 1)
MonTourMenu:SubMenu("Items", "Items&Ignite")
MonTourMenu.Items:Boolean("Ignite","AutoIgnite if OOR",true)
MonTourMenu.Items:Info("Fiora", " ")
MonTourMenu.Items:Info("Fiora", "In Combo/Harass")
MonTourMenu.Items:Boolean("useTiamat", "Tiamat", true)
MonTourMenu.Items:Boolean("useHydra", "Hydra", true)
MonTourMenu.Items:Info("Fiora", " ")
MonTourMenu.Items:Info("Fiora", "In Combo only")
MonTourMenu.Items:Boolean("useCut", "Bilgewater Cutlass", true)
MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Info("Fiora", " ")
MonTourMenu.Items:Boolean("useBork", "Blade of the Ruined King", true)
MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Info("Fiora", " ")
MonTourMenu.Items:Boolean("useGhost", "Youmuu's Ghostblade", true)
MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
MonTourMenu:SubMenu("Drawings", "Drawings")
MonTourMenu.Drawings:Boolean("Q","Draw Q",true)
MonTourMenu.Drawings:Boolean("W","Draw W",true)
MonTourMenu:SubMenu("OP", "Auto Dodging")
MonTourMenu.OP:Boolean("W","Use W",true)

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/
Defender = {["Aatrox"] = {_E},["Ahri"] = {_Q,_W,_E,_R},["Anivia"] = {_Q,_E},["Annie"] = {_Q},["Amumu"] = {_Q},["Blitzcrank"] = {_Q},["Brand"] = {_Q,_R},["Caitlyn"] = {_Q,_E},["Cassiopeia"] = {_W,_E},["Corki"] = {_R},["DrMundo"] = {_Q},["Elise"] = {_Q,_E},["Ezreal"] = {_Q,_W},["Galio"] = {_Q,_E},["Gangplank"] = {_Q},["Gnar"] = {_Q},["Graves"] = {_Q,_R},["Heimerdinger"] = {_W},["Irelia"] = {_R},["Jinx"] = {_W},["Kalista"] = {_Q},["Karma"] = {_Q},["Kassadin"] = {_Q},["Leblanc"] = {_Q,_E},["Leesin"] = {_Q},["Leona"] = {_E},["Lux"] = {_Q,_E},["Morgana"] = {_Q},["Pantheon"] = {_Q},["Quinn"] = {_Q},["Rengar"] = {_E},["Ryze"] = {_Q},["Sejuani"] = {_R},["Sivir"] = {_Q},["Skarner"] = {_E},["Teemo"] = {_Q},["Thresh"] = {_Q},["Varus"] = {_Q},["Vayne"] = {_E},["Veigar"] = {_R},["Twistedfate"] = {_Q},["Velkoz"] = {_Q},["Zed"] = {_Q}}
--Inicia
		myHero = GetMyHero()
		function GerarPosicaoAtaque(unitPos, spellPos, range)
		local PosXZ = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
		local len = math.sqrt(PosXZ.x * PosXZ.x + PosXZ.z * PosXZ.z)
		return {x = unitPos.x + range * PosXZ.x / len, y = 0, z = unitPos.z + range * PosXZ.z / len}
		end
		unit = GetCurrentTarget()
    target = GetCurrentTarget()
--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/
		OnProcessSpell(function(unit, spell)
		myHero = GetMyHero()

			if MonTourMenu.OP.W:Value() then

				if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GoS:GetDistance(unit) < 700 then
				local Ataques = Defender[GetObjectName(unit)]

					if myHero == spell.target and Ataques and GetRange(unit) >= 450 and not spell.name:lower():find("attack") then
					local wPos = GetOrigin(unit)
						CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
						elseif spell.endPos and not spell.name:lower():find("attack") then
						local ComporPos = GerarPosicaoAtaque(GetOrigin(unit), spell.endPos, GoS:GetDistance(unit, myHero))

							if GoS:GetDistanceSqr(ComporPos) < (GetHitBox(myHero)*3)^2 or GoS:GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
							local wPos = GetOrigin(unit)
							CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
							end
					end
				end
			end
		end)

OnLoop(function(myHero)
    
-- buffdatas = GetBuffData(target,"fiorapassivemanager");
--DrawText(string.format("[dravenpassivestacks INFO]", buffdatas.Type),12,200,130,0xff00ff00);
--DrawText(string.format("Type = %d", buffdatas.Type),12,200,140,0xff00ff00);
--DrawText(string.format("Name = %s", buffdatas.Name),12,200,150,0xff00ff00);
--DrawText(string.format("Count = %d", buffdatas.Count),12,200,160,0xff00ff00);
--DrawText(string.format("Stacks = %f", buffdatas.Stacks),12,200,170,0xff00ff00);
--DrawText(string.format("StartTime = %f", buffdatas.StartTime),12,200,180,0xff00ff00);
--DrawText(string.format("ExpireTime = %f", buffdatas.ExpireTime),12,200,190,0xff00ff00);
--DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,200,200,0xff00ff00);
--DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas.Type)),12,200,220,0xffffff00);    
        
Ignite()
Combo()
Harass()
LaneClear()
Items()
Draws()
end)

function Draws()
if MonTourMenu.Drawings.Q:Value() and GetCastLevel(myHero,_Q) >=1 then DrawCircle(GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z,GetCastRange(myHero,_Q),0.6,50,0xff0000ff) end
if MonTourMenu.Drawings.W:Value() and GetCastLevel(myHero,_W) >=1 then DrawCircle(GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z,GetCastRange(myHero,_W),0.6,50,0xff0000ff) end
end

function Combo()
  local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Combo" then
if GoS:ValidTarget(unit, 1550) then--and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
      if MonTourMenu.Combo.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) < 1 or GetItemSlot(myHero, 3074) < 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
      if MonTourMenu.Combo.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) >= 1 or GetItemSlot(myHero, 3074) >= 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,450,400,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 450) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
       if GetCastName(myHero, _W) == "FioraW" then
            if MonTourMenu.Combo.W:Value() then           
                local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(unit, 750) then --and IsObjectAlive(unit)
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
      if GetCastName(myHero, _E) == "FioraE" then
            if MonTourMenu.Combo.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(unit, 260) then
                CastSpell(_E)
            end
        end
    end
   if GetCastName(myHero, _R) == "FioraR" then
            if MonTourMenu.Combo.R:Value() then
                if (100*GetCurrentHP(unit)/GetMaxHP(unit)) < MonTourMenu.Combo.HP:Value() and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and GoS:IsInDistance(unit, 500) then
            CastTargetSpell(unit, _R)
            end
        end
    end
end
end
end  

function LaneClear()
if IOW:Mode() == "LaneClear" then
for i,jminion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
jminionpos = GetOrigin(jminion)
if GoS:ValidTarget(jminion, 600) then
      if MonTourMenu.LaneClear.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) < 1 or GetItemSlot(myHero, 3074) < 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),jminion,GetMoveSpeed(jminion),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(jminion, 400) then
            CastSkillShot(_Q,jminionpos.x,jminionpos.y,jminionpos.z)
            end
        end
      end  
      if MonTourMenu.LaneClear.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) >= 1 or GetItemSlot(myHero, 3074) >= 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),jminion,GetMoveSpeed(jminion),1700,250,450,400,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(jminion, 450) then
            CastSkillShot(_Q,jminionpos.x,jminionpos.y,jminionpos.z)
            end
        end
      end  
      if MonTourMenu.LaneClear.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(jminion, 550) then --tiamat
        if GoS:GetDistance(jminion) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end
      end  
      if MonTourMenu.LaneClear.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(jminion, 550) then --hydra
        if GoS:GetDistance(jminion) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
        end
      end
            if MonTourMenu.LaneClear.W:Value() then           
                local WPred = GetPredictionForPlayer(GetOrigin(myHero),jminion,GetMoveSpeed(jminion),1700,250,750,50,false,true)
                if CanUseSpell(myHero, _W) == READY and IsObjectAlive(jminion) and GoS:IsInDistance(jminion, 750) then
                  CastSkillShot(_W,jminionpos.x,jminionpos.y,jminionpos.z)
                end
            end
            if MonTourMenu.LaneClear.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(jminion, 500) and GoS:GetDistance(myHero, jminion) < 450 and GoS:GetDistance(myHero, jminion) > 10 then
                CastSpell(_E)
              end
            end
            if MonTourMenu.LaneClear.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(jminion, 500) and GoS:GetDistance(myHero, jminion) < 450 and GoS:GetDistance(myHero, jminion) > 10 and (GetObjectName(jminion) == "SRU_Baron" or GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "Sru_Crab" or GetObjectName(mob) == "SRU_Gromp" or GetObjectName(mob) == "SRU_Razorbeak" or GetObjectName(mob) == "SRU_Murkwolf" or GetObjectName(mob) == "SRU_Krug" or GetObjectName(mob) == "SRU_Red" or GetObjectName(mob) == "SRU_Blue") then
                CastSpell(_E)
              end
            end            
end
end
end
if IOW:Mode() == "LaneClear" then
for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
  if GoS:ValidTarget(minion, 600) then
      if MonTourMenu.LaneClear.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(minion, 550) and MinionAround(GetOrigin(myHero), 400) >= MonTourMenu.LaneClear.TiHy:Value()  then --tiamat
        if GoS:GetDistance(minion) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end
      end  
      if MonTourMenu.LaneClear.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(minion, 550) and MinionAround(GetOrigin(myHero), 400) >= MonTourMenu.LaneClear.TiHy:Value() then --hydra
        if GoS:GetDistance(minion) < 400 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
        end
      end
  end   
end
end
end 

function Harass()
  local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Harass" then
if GoS:ValidTarget(unit, 1550) then--and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
--        if MonTourMenu.Harass.Q:Value() then
--        if GetCastName(myHero, _Q) == "FioraQ" then
--        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
--            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 400) then
--            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
--            end
--        end
--      end 
      if MonTourMenu.Harass.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) < 1 or GetItemSlot(myHero, 3074) < 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
      if MonTourMenu.Harass.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) >= 1 or GetItemSlot(myHero, 3074) >= 1) then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,450,400,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 450) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end 
       if GetCastName(myHero, _W) == "FioraW" then
            if MonTourMenu.Harass.W:Value() then           
                local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(unit, 750) then --and IsObjectAlive(unit)
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
      if GetCastName(myHero, _E) == "FioraE" then
            if MonTourMenu.Harass.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(unit, 260) then
                CastSpell(_E)
            end
        end
    end
   if GetCastName(myHero, _R) == "FioraR" then
            if MonTourMenu.Harass.R:Value() then
                if (100*GetCurrentHP(unit)/GetMaxHP(unit)) < MonTourMenu.Harass.HP:Value() and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and GoS:IsInDistance(unit, 500) then
            CastTargetSpell(unit, _R)
            end
        end
    end
end
end
end  

function Ignite()
      local Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
    if GoS:ValidTarget(unit, 700) and Ignite and MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and GoS:GetDistance(unit) > 450 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function Items()
  if IOW:Mode() == "Combo" or IOW:Mode() == "Harass" then
   if MonTourMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(unit, 550) then --tiamat
        if GoS:GetDistance(unit) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end       
    elseif MonTourMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(unit, 550) then --hydra
      if GoS:GetDistance(unit) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
      end
    end
  end 
  if IOW:Mode() == "Combo" then
      if MonTourMenu.Items.useCut:Value() and GetItemSlot(myHero,3144) >= 1 and GoS:ValidTarget(unit,550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.CutBlademyhp:Value() and (100*GetCurrentHP(target)/GetMaxHP(target)) > MonTourMenu.Items.CutBladeehp:Value() then --CutBlade
        if CanUseSpell(myHero,GetItemSlot(myHero,3144)) == READY then
          CastTargetSpell(unit, GetItemSlot(myHero,3144))
        end	
    elseif MonTourMenu.Items.useBork:Value() and GetItemSlot(myHero,3153) >= 1 and GoS:ValidTarget(unit,550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.borkmyhp:Value() and (100*GetCurrentHP(target)/GetMaxHP(target)) > MonTourMenu.Items.borkehp:Value() then 
        if CanUseSpell(myHero,GetItemSlot(myHero,3153)) == READY then --bork
          CastTargetSpell(unit,GetItemSlot(myHero,3153))
        end
      elseif MonTourMenu.Items.useGhost:Value() and GetItemSlot(myHero,3142) >= 1 and GoS:ValidTarget(unit,500) then --ghost
        if CanUseSpell(myHero,GetItemSlot(myHero,3142)) == READY then
          CastSpell(GetItemSlot(myHero,3142))
        end
     elseif MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(unit,500) then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end 
  end
end

function MinionAround(pos, range)
  local c = 0
  if pos == nil then return 0 end
  for k,v in pairs(GoS:GetAllMinions(MINION_ENEMY)) do 
    if v and GoS:ValidTarget(v) and GoS:GetDistanceSqr(pos,GetOrigin(v)) < range*range then
      c = c + 1
    end
  end
  return c
end
