if GetObjectName(myHero) ~= "Poppy" then return end
--MonTour Poppy:V0.0.1.0 Beta
PrintChat(string.format("<font color='#80F5F5'>MonTour Poppy:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>0.0.1.0 Beta</font>"))
mapID = GetMapID()
if mapID ~= SUMMONERS_RIFT then 
  PrintChat(string.format("<font color='#BC0707'>This Map is not Supported for:</font> <font color='#EFF0F0'>STUN E!</font>"))
  PrintChat(string.format("<font color='#BC0707'>Please Turn Off:</font> <font color='#EFF0F0'>STUN E in Menus</font>"))
  PrintChat(string.format("<font color='#BC0707'>Or use it at your own</font> <font color='#BC0707'>Risk!!!</font>"))
end  
require('MapPositionGOS')
local PoppyMenu = Menu("PoppyMenu", "Poppy")
PoppyMenu:SubMenu("Combo", "Combo")
PoppyMenu.Combo:List("prio", "Start Combo only if Stunnable?", 1, {"Yes", "No"})
PoppyMenu.Combo:Boolean("Q","Use Q",true)
PoppyMenu.Combo:Boolean("W","Use W",true)
PoppyMenu.Combo:Boolean("E","Use E ",true)
PoppyMenu.Combo:List("Eprio", "Use E only with Stun", 1, {"Yes", "No"})
PoppyMenu.Combo:Boolean("AutoE","Use Auto E+Q+W (Stun)",false)
PoppyMenu.Combo:Slider("AutoEE", "if EnemyAround Me <= X (Def. 2)", 2, 1, 5, 1)
PoppyMenu.Combo:Slider("AutoER", "EnemyAround Range (Def: 1000)", 1000, 200, 5000, 1)
PoppyMenu:SubMenu("Harass", "Harass")
PoppyMenu.Harass:List("prio", "Start Harass only if Stunnable?", 2, {"Yes", "No"})
PoppyMenu.Harass:Boolean("Q","Use Q",true)
PoppyMenu.Harass:Boolean("W","Use W",true)
PoppyMenu.Harass:Boolean("E","Use E",true)
PoppyMenu.Harass:List("Eprio", "Use E only with Stun", 1, {"Yes", "No"})
PoppyMenu:SubMenu("LastHit", "LastHit")
PoppyMenu.LastHit:Boolean("LHQ","Use Q",true)
PoppyMenu:SubMenu("LaneClear", "LaneClear")
PoppyMenu.LaneClear:Boolean("LHQ","Use Q",true)
PoppyMenu.LaneClear:Boolean("useTiamat", "Tiamat", true)
PoppyMenu.LaneClear:Boolean("useHydra", "Hydra", true)
PoppyMenu.LaneClear:Slider("TiHy", "if MinionAround >= X (Def. 5)", 5, 1, 20, 1)
PoppyMenu:SubMenu("KS", "KillSteal&DMGoHP")
PoppyMenu.KS:Boolean("ALL","ALL ON/OFF",true)
PoppyMenu.KS:Boolean("DOH","Draw DMGoHP",true)
PoppyMenu.KS:Boolean("Q","Use Q KS",true)
PoppyMenu.KS:Boolean("EQstun","Use EQ Stun KS",true)
PoppyMenu.KS:Boolean("EQnostun","Use EQ No Stun KS",true)
PoppyMenu.KS:Boolean("Estun","Use E Stun KS",true)
PoppyMenu.KS:Boolean("Enostun","Use E No Stun KS",true)
PoppyMenu:SubMenu("Items", "Items & Ignite")
PoppyMenu.Items:Boolean("Ignite","AutoIgnite if OOR and E NotReady",true)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("useTiamat", "Tiamat", true)
PoppyMenu.Items:Boolean("useHydra", "Hydra", true)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
PoppyMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
PoppyMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
PoppyMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
PoppyMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
PoppyMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
PoppyMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
PoppyMenu.Items:Info("PoppyMenu", " ")
PoppyMenu.Items:Boolean("QSS", "Always Use QSS", true)
PoppyMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
PoppyMenu:SubMenu("Misc", "Drawings")
PoppyMenu.Misc:Boolean("D","Draw Vectors for E",true)

target = GetCurrentTarget()	
unit = GetCurrentTarget()
OnLoop(function(myHero)
ItemUse()
if PoppyMenu.Items.Ignite:Value() then
Ignite()
end
if PoppyMenu.KS.ALL:Value() then
KillSteal()
end
AllforOne() 

if IOW:Mode() == "Combo" and PoppyMenu.Combo.prio:Value() == 1 and (GetCastLevel(myHero,_Q) == 0 or GetCastLevel(myHero,_W) == 0 or GetCastLevel(myHero,_E) == 0) then
Combo()
end

if IOW:Mode() == "Combo" and PoppyMenu.Combo.prio:Value() == 2 then
Combo()
end 

if IOW:Mode() == "Harass" and PoppyMenu.Harass.prio:Value() == 1 and (GetCastLevel(myHero,_Q) == 0 or GetCastLevel(myHero,_W) == 0 or GetCastLevel(myHero,_E) == 0) then
Harass()
end

if IOW:Mode() == "Harass" and PoppyMenu.Harass.prio:Value() == 2 then
Harass()
end 
if IOW:Mode() == "LastHit" and PoppyMenu.LastHit.LHQ:Value() then
LastHit()
end 
if IOW:Mode() == "LaneClear" and PoppyMenu.LaneClear.LHQ:Value() then
LastHit()
CastItemsForMinion()
end
end)

function Combo()
--if GoS:ValidTarget(unit,600) then
  if CanUseSpell(myHero,_W) == READY and PoppyMenu.Combo.W:Value() then
    Wskill()
  end
  if CanUseSpell(myHero,_E) == READY and PoppyMenu.Combo.E:Value() and PoppyMenu.Combo.Eprio:Value() == 1 then
    Estun()
  end  
  if CanUseSpell(myHero,_E) == READY and PoppyMenu.Combo.E:Value() and PoppyMenu.Combo.Eprio:Value() == 2 then
    Eskill()
  end 
  if CanUseSpell(myHero,_Q) == READY and PoppyMenu.Combo.Q:Value()then
    Qskill()
  end
--end
end

function Harass()
--if GoS:ValidTarget(unit,600) then
  if CanUseSpell(myHero,_W) == READY and PoppyMenu.Harass.W:Value() then
    Wskill()
  end
  if CanUseSpell(myHero,_E) == READY and PoppyMenu.Harass.E:Value() and PoppyMenu.Harass.Eprio:Value() == 1 then
    Estun()
  end  
  if CanUseSpell(myHero,_E) == READY and PoppyMenu.Harass.E:Value() and PoppyMenu.Harass.Eprio:Value() == 2 then
    Eskill()
  end  
  if CanUseSpell(myHero,_Q) == READY and PoppyMenu.Harass.Q:Value()then
    Qskill()
  end
--end
end

function AttackUnitM(minion)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
  if GoS:GetDistanceSqr(GetOrigin(minion)) <= 125*125 then --GoS:IsInDistance(minion, 125) and GoS:GetDistance(myHero, minion) <= 125 then 
    AttackUnit(minion)
  end
  end
end

function AttackUnitKS(unit)
	for i,unit in pairs(GoS:GetEnemyHeroes()) do  
  if GoS:GetDistanceSqr(GetOrigin(unit)) <= 125*125 then --GoS:IsInDistance(minion, 125) and GoS:GetDistance(myHero, minion) <= 125 then 
    AttackUnit(unit)
  end
  end
end

function Qskill()
  local unit = GetCurrentTarget()
  if GoS:ValidTarget(unit,300) and GoS:GetDistance(myHero, unit) <= 300 and CanUseSpell(myHero,_Q) == READY then
    CastSpell(_Q)
  end
end

function Wskill()
  local unit = GetCurrentTarget()
  if GoS:ValidTarget(unit,600) and GoS:GetDistance(myHero, unit) <= 600 and CanUseSpell(myHero,_W) == READY and GotBuff(myHero, "poppyparagonstats") < 10 then
    CastSpell(_W)
  end
  if GoS:ValidTarget(unit,600) and GoS:GetDistance(myHero, unit) <= 600 and CanUseSpell(myHero,_W) == READY and GotBuff(myHero, "poppyparagonstats") == 10 then
    --for i,unit in pairs(GoS:GetEnemyHeroes()) do 
    if GetMoveSpeed(myHero) <= GetMoveSpeed(unit) then
      CastSpell(_W)
    end
    --end
  end
end

function Eskill()
  local unit = GetCurrentTarget()
  if GoS:ValidTarget(unit,525) and GoS:GetDistance(myHero, unit) <= 525 and CanUseSpell(myHero,_E) == READY then
    CastTargetSpell(unit, _E)
  end
end

function Estun()
 for _,unit in pairs(GoS:GetEnemyHeroes()) do
    if GoS:ValidTarget(unit,1000) then
			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz
			local distance1=24
			local distance2=118
			local distance3=212
			local distance4=296--306
			local distance5=380--400
			--setting enemyPos--
			local enemyposition = GetOrigin(unit)
			enemyposx=enemyposition.x
			enemyposy=enemyposition.y
			enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
			--setting coordinates myHero--
			local self=GetOrigin(myHero)
			selfx = self.x
			selfy = self.y
    	selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
    	------------------------------
			local Pos1 = TargetPos-(TargetPos-HeroPos)*(-distance1/GoS:GetDistance(unit))
			local Pos2 = TargetPos-(TargetPos-HeroPos)*(-distance2/GoS:GetDistance(unit))
			local Pos3 = TargetPos-(TargetPos-HeroPos)*(-distance3/GoS:GetDistance(unit))
			local Pos4 = TargetPos-(TargetPos-HeroPos)*(-distance4/GoS:GetDistance(unit))
			local Pos5 = TargetPos-(TargetPos-HeroPos)*(-distance5/GoS:GetDistance(unit))
			--Check if in Wall--
				if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 then
						 CastTargetSpell(unit, _E) 
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 then
						 CastTargetSpell(unit, _E) 
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 then
						 CastTargetSpell(unit, _E) 
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 then
						 CastTargetSpell(unit, _E) 
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 then
						 CastTargetSpell(unit, _E) 
					end
				end
    end
	end
end  

function AllforOne()
 for _,unit in pairs(GoS:GetEnemyHeroes()) do
			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz
			local distance1=24
			local distance2=118
			local distance3=212
			local distance4=296--306
			local distance5=380--400
			--setting enemyPos--
			local enemyposition = GetOrigin(unit)
			enemyposx=enemyposition.x
			enemyposy=enemyposition.y
			enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
			--setting coordinates myHero--
			local self=GetOrigin(myHero)
			selfx = self.x
			selfy = self.y
    	selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
    	------------------------------
			local Pos1 = TargetPos-(TargetPos-HeroPos)*(-distance1/GoS:GetDistance(unit))
			local Pos2 = TargetPos-(TargetPos-HeroPos)*(-distance2/GoS:GetDistance(unit))
			local Pos3 = TargetPos-(TargetPos-HeroPos)*(-distance3/GoS:GetDistance(unit))
			local Pos4 = TargetPos-(TargetPos-HeroPos)*(-distance4/GoS:GetDistance(unit))
			local Pos5 = TargetPos-(TargetPos-HeroPos)*(-distance5/GoS:GetDistance(unit))
			--Check if in Wall--
    if GoS:ValidTarget(unit,1000) then      
      if PoppyMenu.Combo.AutoE:Value() and CanUseSpell(myHero,_W) == READY and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 and GoS:EnemiesAround(GoS:myHeroPos(), PoppyMenu.Combo.AutoER:Value()) <= PoppyMenu.Combo.AutoEE:Value() then
				if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300)  
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300)  
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300)  
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300)  
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300)  
					end
				end
      end  
      if IOW:Mode() == "Combo" and PoppyMenu.Combo.prio:Value() == 1 and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 then     
        if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
        if GoS:GetDistance(unit)<=525 and (CanUseSpell(myHero,_E) ~= READY or not PoppyMenu.Combo.E:Value()) then
            Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50)  
				end
       end
      if IOW:Mode() == "Harass" and PoppyMenu.Harass.prio:Value() == 1 and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 then     
        if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 and PoppyMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
        if GoS:GetDistance(unit)<=525 and (CanUseSpell(myHero,_E) ~= READY or not PoppyMenu.Harass.E:Value()) then
            Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50)  
				end
--        else
--        Harass()
      end
   end
if PoppyMenu.Misc.D:Value() then      
       if GoS:ValidTarget(unit,20000) then
				if MapPosition:inWall(Pos1)==false then DrawCircle(Pos1.x,Pos1.y,Pos1.z,5,2,0,0xffff0000) 
				elseif MapPosition:inWall(Pos1)==true then DrawCircle(Pos1.x,Pos1.y,Pos1.z,5,2,0,0xff00ff00) end
				if MapPosition:inWall(Pos2)==false then DrawCircle(Pos2.x,Pos2.y,Pos2.z,5,2,0,0xffff0000) 
				elseif MapPosition:inWall(Pos2)==true then DrawCircle(Pos2.x,Pos2.y,Pos2.z,5,2,0,0xff00ff00) end
				if MapPosition:inWall(Pos3)==false then DrawCircle(Pos3.x,Pos3.y,Pos3.z,5,2,0,0xffff0000) 
				elseif MapPosition:inWall(Pos3)==true then DrawCircle(Pos3.x,Pos3.y,Pos3.z,5,2,0,0xff00ff00) end
				if MapPosition:inWall(Pos4)==false then DrawCircle(Pos4.x,Pos4.y,Pos4.z,5,2,0,0xffff0000) 
				elseif MapPosition:inWall(Pos4)==true then DrawCircle(Pos4.x,Pos4.y,Pos4.z,5,2,0,0xff00ff00) end
				if MapPosition:inWall(Pos5)==false then DrawCircle(Pos5.x,Pos5.y,Pos5.z,5,2,0,0xffff0000) 
        elseif MapPosition:inWall(Pos5)==true then DrawCircle(Pos5.x,Pos5.y,Pos5.z,5,2,0,0xff00ff00) end
       end
    end
    end
end    


function Ignite()
      local Igniteit = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
    if GoS:ValidTarget(unit, 700) and Igniteit and CanUseSpell(myHero,_E) ~= READY and GoS:GetDistance(unit) > 500 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Igniteit) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Igniteit)
            end
        end
     end
end

function ItemUse()
    for _,target in pairs(Gos:GetEnemyHeroes()) do
      if (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then
        if GetItemSlot(myHero,3153) > 0 and PoppyMenu.Items.bork:Value() and GoS:ValidTarget(target, 550)  and GetCurrentHP(myHero)/GetMaxHP(myHero) < (PoppyMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (PoppyMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and PoppyMenu.Items.CutBlade:Value() and GoS:ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (PoppyMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (PoppyMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and PoppyMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GoS:ValidTarget(target, PoppyMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
        if PoppyMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(target, 550) then --tiamat
          if GoS:GetDistance(target) < 400 then
          CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
          end 
        end
        if PoppyMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(target, 550) then --hydra
          if GoS:GetDistance(target) < 385 then
          CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
          end
        end
        if PoppyMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(target,PoppyMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
          if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
          end
        end
      end
    end  
    if GetItemSlot(myHero,3140) > 0 and PoppyMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < PoppyMenu.Items.QSSHP:Value() then
    CastTargetSpell(myHero, GetItemSlot(myHero,3140))
    end

    if GetItemSlot(myHero,3139) > 0 and PoppyMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < PoppyMenu.Items.QSSHP:Value() then
    CastTargetSpell(myHero, GetItemSlot(myHero,3139))
    end

end

function LastHit()
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0 
    local QMAXPERCENT = 0  
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = 2
      end
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end 
  for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do      
   if GetCastLevel(myHero,_Q) > 0 and GoS:ValidTarget(minion,350) then
    if GetCastLevel(myHero,_Q) == 1 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(minion)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 75 then
        QMAXPERCENT = 75
      end
    elseif GetCastLevel(myHero,_Q) == 2 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(minion)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 150 then
        QMAXPERCENT = 150
      end 
    elseif GetCastLevel(myHero,_Q) == 3 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(minion)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 225 then
        QMAXPERCENT = 225
      end 
    elseif GetCastLevel(myHero,_Q) == 4 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(minion)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 300 then
        QMAXPERCENT = 300
      end
    elseif GetCastLevel(myHero,_Q) == 5 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(minion)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 375 then
        QMAXPERCENT = 375
      end         
    end
   end
  -- DrawText(string.format("QMAXPERCENT = %f", QMAXPERCENT),20,100,300,0xffffffff);
    if GotBuff(myHero,"PoppyDevastatingBlow") == 0 then
      IOW:EnableAutoAttacks()
    end
    if GoS:ValidTarget(minion,125) then
      local ADDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
      local QDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+0.6*GetBonusAP(myHero)+QMAXPERCENT or 0  --+QMAXPERCENT
      local DamageAD = GoS:CalcDamage(myHero, minion,ADDmg + sheendmg + frozendmg,lichbane)
      local DamageQ = GoS:CalcDamage(myHero, minion, sheendmg + frozendmg,QDmg + lichbane)
      if GetCurrentHP(minion) < DamageQ and GetCurrentHP(minion) > DamageAD then
         IOW:DisableAutoAttacks() GoS:DelayAction(function() CastSpell(_Q) end, 1)
      end  
      if GotBuff(myHero,"PoppyDevastatingBlow") == 1 and GoS:GetDistanceSqr(GetOrigin(minion)) <= 125*125 and GetCurrentHP(minion) < DamageQ and GetCurrentHP(minion) > DamageAD then
        AttackUnit(minion) GoS:DelayAction(function() IOW:EnableAutoAttacks() end, 100)
      end     
    end
  end  
end  

function CastItemsForMinion()
  for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do 
    if GoS:ValidTarget(minion, 600) and IOW:Mode() == "LaneClear" then
      if PoppyMenu.LaneClear.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(minion, 550) and MinionAround(GoS:myHeroPos(), 400) >= PoppyMenu.LaneClear.TiHy:Value()  then --tiamat
        if GoS:GetDistance(minion) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end
      end  
      if PoppyMenu.LaneClear.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(minion, 550) and MinionAround(GoS:myHeroPos(), 400) >= PoppyMenu.LaneClear.TiHy:Value() then --hydra
        if GoS:GetDistance(minion) < 400 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
        end
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

--OnLoop(function(myHero)
--buffdatas = GetBuffData(myHero,"sheen");
--DrawText(string.format("[RECALL_BUFF INFO]", buffdatas.Type),12,0,20,0xff00ff00);
--DrawText(string.format("Type = %d", buffdatas.Type),12,0,30,0xff00ff00);
--DrawText(string.format("Name = %s", buffdatas.Name),12,0,40,0xff00ff00);
--DrawText(string.format("Count = %d", buffdatas.Count),12,0,50,0xff00ff00);
--DrawText(string.format("Stacks = %f", buffdatas.Stacks),12,0,60,0xff00ff00);
--DrawText(string.format("StartTime = %f", buffdatas.StartTime),12,0,70,0xff00ff00);
--DrawText(string.format("ExpireTime = %f", buffdatas.ExpireTime),12,0,80,0xff00ff00);
--DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,0,90,0xff00ff00);
--bufftypelist = GetBuffTypeList();
--if buffdatas.Type == bufftypelist.Aura then
--	DrawText("Buff is considered as aura",12,0,100,0xffffffff);
--	end
--DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas.Type)),12,0,110,0xffffff00);
--end)

OnLoop(function(myHero)
local capspress = KeyIsDown(0x14); --Caps Lock key
if capspress then
	local itemid = GetItemID(myHero,ITEM_1);
	local itemammo = GetItemAmmo(myHero,ITEM_1);
	local itemstack = GetItemStack(myHero,ITEM_1);
	PrintChat(string.format("itemID in Slot 1 is = %d", itemid));
	PrintChat(string.format("AMMO! in Slot 1 is = %d", itemammo));
	PrintChat(string.format("STACK in Slot 1 is = %d", itemstack));
	end
end)

function KillSteal()
  local unit = GetCurrentTarget()
  local myHero = GetMyHero()
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0 
    local Poppyult = 1 
    local QMAXPERCENT = 0
      
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end 
     for i,unit in pairs(GoS:GetEnemyHeroes()) do
      if GotBuff(unit, "poppydtarget") >= 1 then
        Poppyult = Poppyult + (10 + 10*GetCastLevel(myHero,_E))/100
      end
--      if GotBuff(unit, "poppydtarget") == 0 then
--        Poppyult = Poppyult + 1
--      end 
   if GetCastLevel(myHero,_Q) > 0 and GoS:ValidTarget(unit,10000) then
    if GetCastLevel(myHero,_Q) == 1 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(unit)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 75 then
        QMAXPERCENT = 75
      end
    elseif GetCastLevel(myHero,_Q) == 2 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(unit)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 150 then
        QMAXPERCENT = 150
      end 
    elseif GetCastLevel(myHero,_Q) == 3 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(unit)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 225 then
        QMAXPERCENT = 225
      end 
    elseif GetCastLevel(myHero,_Q) == 4 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(unit)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 300 then
        QMAXPERCENT = 300
      end
    elseif GetCastLevel(myHero,_Q) == 5 then
      QMAXPERCENT = QMAXPERCENT + GetMaxHP(unit)*0.08 + 20*GetCastLevel(myHero,_Q)
      if QMAXPERCENT > 375 then
        QMAXPERCENT = 375
      end         
    end
   end

			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz
			local distance1=24
			local distance2=118
			local distance3=212
			local distance4=296--306
			local distance5=380--400
			--setting enemyPos--
			local enemyposition = GetOrigin(unit)
			enemyposx=enemyposition.x
			enemyposy=enemyposition.y
			enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
			--setting coordinates myHero--
			local self=GetOrigin(myHero)
			selfx = self.x
			selfy = self.y
    	selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
    	------------------------------
			local Pos1 = TargetPos-(TargetPos-HeroPos)*(-distance1/GoS:GetDistance(unit))
			local Pos2 = TargetPos-(TargetPos-HeroPos)*(-distance2/GoS:GetDistance(unit))
			local Pos3 = TargetPos-(TargetPos-HeroPos)*(-distance3/GoS:GetDistance(unit))
			local Pos4 = TargetPos-(TargetPos-HeroPos)*(-distance4/GoS:GetDistance(unit))
			local Pos5 = TargetPos-(TargetPos-HeroPos)*(-distance5/GoS:GetDistance(unit))   
      local enemyhp = GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
      local ADDmg = GetBaseDamage(myHero) or 0 --GetBonusDmg(myHero)+
      local QDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+ 0.6*GetBonusAP(myHero) + QMAXPERCENT or 0 --QMAXPERCENT or 0 20*GetCastLevel(myHero,_Q)
      local EDmgStun = 50+75*GetCastLevel(myHero,_E) + 0.8*GetBonusAP(myHero) or 0
      local EDmgNoStun = 25+25*GetCastLevel(myHero,_E) + 0.4*GetBonusAP(myHero) or 0
      local DamageQ = GoS:CalcDamage(myHero, unit, (sheendmg + frozendmg)*Poppyult,(QDmg + lichbane)*Poppyult)
      local DamageEStun = GoS:CalcDamage(myHero, unit, (sheendmg + frozendmg)*Poppyult, (lichbane + EDmgStun)*Poppyult)  
      local DamageENoStun = GoS:CalcDamage(myHero, unit,(sheendmg + frozendmg)*Poppyult, (lichbane + EDmgNoStun)*Poppyult)       
      local DamageEQStun = GoS:CalcDamage(myHero, unit, (sheendmg + frozendmg)*Poppyult, (QDmg + lichbane + EDmgStun)*Poppyult)  
      local DamageEQNoStun = GoS:CalcDamage(myHero, unit, (sheendmg + frozendmg)*Poppyult,(QDmg + lichbane + EDmgNoStun)*Poppyult) 
        DrawText(string.format("QMAXPERCENT = %f", QMAXPERCENT),20,100,300,0xffffffff);
        DrawText(string.format("sheendmg = %f", sheendmg),20,100,330,0xffffffff);
      if GoS:ValidTarget(unit,125) and GoS:GetDistanceSqr(GetOrigin(unit)) <= 125*125 then
        if PoppyMenu.KS.Q:Value() and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) ~= READY and enemyhp < DamageQ then
          Wskill() GoS:DelayAction(function() CastSpell(_Q) end, 100)
        end  
        if PoppyMenu.KS.Q:Value() and GotBuff(myHero,"PoppyDevastatingBlow") == 1 and enemyhp < DamageQ then
          AttackUnitKS(unit) 
        end     
      end
      if GoS:ValidTarget(unit,525) and GoS:GetDistanceSqr(GetOrigin(unit)) <= 525*525 then
        if PoppyMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)         
        
        elseif PoppyMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)          

------------------
        elseif PoppyMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos1)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos1)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos2)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos2)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)         
        
        elseif PoppyMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos3)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos3)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos4)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos4)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif PoppyMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos5)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif PoppyMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos5)==true and enemyhp < DamageEStun then
           GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)          
        end 
      end 
      
      -----------------------------------DMGOVER
      
      if GoS:ValidTarget(unit,20000) and PoppyMenu.KS.DOH:Value() then
        if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) ~= READY then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageQ,0xffffffff) 
        
        elseif GotBuff(myHero,"PoppyDevastatingBlow") == 1 and CanUseSpell(myHero,_E) ~= READY then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageQ,0xffffffff) 
   
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQNoStun,0xffffffff) 
  
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQNoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQStun,0xffffffff)         
        
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQNoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQNoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQNoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1)  then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEQStun,0xffffffff)          

------------------
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos1)==false then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageENoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos1)==true then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos2)==false then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageENoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos2)==true then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEStun,0xffffffff)         
        
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos3)==false then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageENoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos3)==true then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos4)==false then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageENoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos4)==true then
          DrawDmgOverHpBar(unit,enemyhp,0,DamageEStun,0xffffffff)
          
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos5)==false then
         DrawDmgOverHpBar(unit,enemyhp,0,DamageENoStun,0xffffffff)
  
        elseif CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and GotBuff(myHero,"PoppyDevastatingBlow") == 0 and MapPosition:inWall(Pos5)==true then
           DrawDmgOverHpBar(unit,enemyhp,0,DamageEStun,0xffffffff)         
        end 
      end               
  end  
end  