if GetObjectName(GetMyHero()) ~= "Fiora" then return end
--MonTour Fiora:V1.0.0.0
PrintChat(string.format("<font color='#80F5F5'>MonTour Fiora:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.0</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> leoferrerinha for Auto W</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))
local FioraMenu = Menu("Fiora", "F")
FioraMenu:SubMenu("Combo", "Combo")
FioraMenu.Combo:Boolean("Q","Use Q",true)
FioraMenu.Combo:Boolean("W","Use W",false)
FioraMenu.Combo:Boolean("E","Use E",true)
FioraMenu.Combo:Boolean("R","Use R",true)
FioraMenu.Combo:Slider("HP", "Use R if HP < x%", 20, 1, 80, 1)
FioraMenu:SubMenu("Items", "Items&Ignite")
FioraMenu.Items:Boolean("Ignite","AutoIgnite if OOR",true)
FioraMenu.Items:Boolean("useTiamat", "Tiamat", true)
FioraMenu.Items:Boolean("useHydra", "Hydra", true)
FioraMenu.Items:Info("Fiora", " ")
FioraMenu.Items:Boolean("useCut", "Bilgewater Cutlass", true)
FioraMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
FioraMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
FioraMenu.Items:Info("Fiora", " ")
FioraMenu.Items:Boolean("useBork", "Blade of the Ruined King", true)
FioraMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
FioraMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
FioraMenu.Items:Info("Fiora", " ")
FioraMenu.Items:Boolean("useGhost", "Youmuu's Ghostblade", true)
FioraMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
FioraMenu:SubMenu("Harass", "Harass")
FioraMenu.Harass:Boolean("Q","Use Q",true)
FioraMenu.Harass:Boolean("W","Use W",false)
FioraMenu.Harass:Boolean("E","Use E",false)
FioraMenu.Harass:Boolean("R","Use R",false)
FioraMenu.Harass:Slider("HP", "Use R if HP < x%", 20, 1, 80, 1)
FioraMenu:SubMenu("OP", "Auto Dodging")
FioraMenu.OP:Boolean("W","Use W",true)

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

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/
		OnProcessSpell(function(unit, spell)
		myHero = GetMyHero()

			if FioraMenu.OP.W:Value() then

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
PrintChat(string.format("<font color='#198c19'>Fiora:</font> <font color='#ffff32'>loaded by MarCiii!</font>"))

OnLoop(function(myHero)
Ignite()
Combo()
Harass()
Items()
end)

function Combo()
unit = GetCurrentTarget()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Combo" then
if GoS:ValidTarget(unit, 1550) and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
       
      if FioraMenu.Combo.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) < 1 or GetItemSlot(myHero, 3074) < 1) then
        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
      if FioraMenu.Combo.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) >= 1 or GetItemSlot(myHero, 3074) >= 1) then
        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,450,400,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 450) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
       if GetCastName(myHero, _W) == "FioraW" then
            if FioraMenu.Combo.W:Value() then           
                local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and GoS:IsInDistance(unit, 750) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
      if GetCastName(myHero, _E) == "FioraE" then
            if FioraMenu.Combo.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(unit, 260) then
                CastSpell(_E)
            end
        end
    end
   if GetCastName(myHero, _R) == "FioraR" then
            if FioraMenu.Combo.R:Value() then
                if (GetCurrentHP(unit)/GetMaxHP(unit)) < (FioraMenu.Combo.HP:Value()/100) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and GoS:IsInDistance(unit, 500) then
            CastTargetSpell(unit, _R)
            end
        end
    end
end
end
end  

function Harass()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Harass" then
if GoS:ValidTarget(unit, 1550) and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
      if FioraMenu.Harass.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) < 1 or GetItemSlot(myHero, 3074) < 1) then
        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end  
      if FioraMenu.Harass.Q:Value() then
        if GetCastName(myHero, _Q) == "FioraQ" and (GetItemSlot(myHero, 3077) >= 1 or GetItemSlot(myHero, 3074) >= 1) then
        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,450,400,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 450) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
      end 
       if GetCastName(myHero, _W) == "FioraW" then
            if FioraMenu.Harass.W:Value() then           
                local WPred = GetPredictionForPlayer(GoS:myHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and GoS:IsInDistance(unit, 750) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
      if GetCastName(myHero, _E) == "FioraE" then
            if FioraMenu.Harass.E:Value() then
              if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(unit, 260) then
                CastSpell(_E)
            end
        end
    end
   if GetCastName(myHero, _R) == "FioraR" then
            if FioraMenu.Harass.R:Value() then
                if (GetCurrentHP(unit)/GetMaxHP(unit)) < (FioraMenu.Harass.HP:Value()/100) and
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
    if GoS:ValidTarget(unit, 700) and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and Ignite and FioraMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and GoS:GetDistance(unit) > 450 then
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function Items()
  if IOW:Mode() == "Combo" or IOW:Mode() == "Harass" then
   if FioraMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(unit, 550) then --tiamat
        if GoS:GetDistance(unit) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end       
    elseif FioraMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(unit, 550) then --hydra
      if GoS:GetDistance(unit) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
      end
    end
  end 
  if IOW:Mode() == "Combo" then
      if FioraMenu.Items.useCut:Value() and GetItemSlot(myHero,3144) >= 1 and GoS:ValidTarget(unit,550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < (FioraMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (FioraMenu.Items.CutBladeehp:Value()/100) then --CutBlade
        if CanUseSpell(myHero,GetItemSlot(myHero,3144)) == READY then
          CastTargetSpell(unit, GetItemSlot(myHero,3144))
        end	
    elseif FioraMenu.Items.useBork:Value() and GetItemSlot(myHero,3153) >= 1 and GoS:ValidTarget(unit,550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < (FioraMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (FioraMenu.Items.borkehp:Value()/100) then 
        if CanUseSpell(myHero,GetItemSlot(myHero,3153)) == READY then --bork
          CastTargetSpell(unit,GetItemSlot(myHero,3153))
        end
      elseif FioraMenu.Items.useGhost:Value() and GetItemSlot(myHero,3142) >= 1 and GoS:ValidTarget(unit,500) then --ghost
        if CanUseSpell(myHero,GetItemSlot(myHero,3142)) == READY then
          CastSpell(GetItemSlot(myHero,3142))
        end
     elseif FioraMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(unit,250) then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end 
  end
end
