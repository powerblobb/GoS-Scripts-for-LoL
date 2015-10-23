if GetObjectName(myHero) ~= "Poppy" then return end
--MonTour Poppy:V0.0.1.6 Beta - fixed Ignite ... hopefully
PrintChat(string.format("<font color='#80F5F5'>MonTour Poppy:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>0.0.1.6 Beta</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))
mapID = GetMapID()
if mapID ~= SUMMONERS_RIFT then 
  PrintChat(string.format("<font color='#BC0707'>This Map is not Supported for:</font> <font color='#EFF0F0'>STUN E!</font>"))
  PrintChat(string.format("<font color='#BC0707'>Please Turn Off:</font> <font color='#EFF0F0'>STUN E in Menus</font>"))
  PrintChat(string.format("<font color='#BC0707'>Or use it at your own</font> <font color='#BC0707'>Risk!!!</font>"))
end  
require('MapPositionGOS')
require('Inspired')
require('MenuConfig')
require('IOW')
local MonTourMenu = Menu("MoTPoppy", "MoTPoppy")
MonTourMenu:SubMenu("Combo", "Combo")
MonTourMenu.Combo:List("prio", "Start Combo only if Stunnable?", 1, {"Yes", "No"})
MonTourMenu.Combo:Boolean("Q","Use Q",true)
MonTourMenu.Combo:Boolean("W","Use W",true)
MonTourMenu.Combo:Boolean("E","Use E ",true)
MonTourMenu.Combo:List("Eprio", "Use E only with Stun", 1, {"Yes", "No"})
MonTourMenu.Combo:Boolean("AutoE","Use Auto E+Q+W (Stun)",false)
MonTourMenu.Combo:Slider("AutoEE", "if EnemyAround Me <= X (Def. 2)", 2, 1, 5, 1)
MonTourMenu.Combo:Slider("AutoER", "EnemyAround Range (Def: 1000)", 1000, 200, 5000, 1)
MonTourMenu:SubMenu("Harass", "Harass")
MonTourMenu.Harass:List("prio", "Start Harass only if Stunnable?", 2, {"Yes", "No"})
MonTourMenu.Harass:Boolean("Q","Use Q",true)
MonTourMenu.Harass:Boolean("W","Use W",true)
MonTourMenu.Harass:Boolean("E","Use E",true)
MonTourMenu.Harass:List("Eprio", "Use E only with Stun", 1, {"Yes", "No"})
MonTourMenu:SubMenu("LastHit", "LastHit")
MonTourMenu.LastHit:Boolean("LHQ","Use Q",true)
MonTourMenu:SubMenu("LaneClear", "LaneClear")
MonTourMenu.LaneClear:Boolean("LHQ","Use Q",true)
MonTourMenu.LaneClear:Boolean("useTiamat", "Tiamat", true)
MonTourMenu.LaneClear:Boolean("useHydra", "Hydra", true)
MonTourMenu.LaneClear:Slider("TiHy", "if MinionAround >= X (Def. 5)", 5, 1, 20, 1)
MonTourMenu:SubMenu("KS", "KillSteal&DMGoHP")
MonTourMenu.KS:Boolean("ALL","ALL ON/OFF",true)
MonTourMenu.KS:Boolean("DOH","Draw DMGoHP",true)
MonTourMenu.KS:Boolean("Q","Use Q KS",true)
MonTourMenu.KS:Boolean("EQstun","Use EQ Stun KS",true)
MonTourMenu.KS:Boolean("EQnostun","Use EQ No Stun KS",true)
MonTourMenu.KS:Boolean("Estun","Use E Stun KS",true)
MonTourMenu.KS:Boolean("Enostun","Use E No Stun KS",true)
MonTourMenu:SubMenu("Items", "Items & Ignite")
MonTourMenu.Items:Boolean("Ignite","AutoIgnite if OOR and E NotReady",true)
MonTourMenu.Items:Boolean("useTiamat", "Tiamat", true)
MonTourMenu.Items:Boolean("useHydra", "Hydra", true)
MonTourMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
MonTourMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
MonTourMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
MonTourMenu:SubMenu("Interrupt", "Interrupt")
MonTourMenu.Interrupt:Boolean("Interrupt", "Auto Interrupt Spells", true)
MonTourMenu:SubMenu("Misc", "Drawings")
MonTourMenu.Misc:Boolean("D","Draw Vectors for E",true)

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["MasterYi"]                    = {_W},
    ["FiddleSticks"]                = {_W, _R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_Q, _R},
    ["Varus"]                       = {_Q},
    ["TahmKench"]                   = {_R},
    ["TwistedFate"]                 = {_R},
    ["Janna"]                       = {_R}
}

local callback = nil
 
OnProcessSpell(function(unit, spell)    
    if not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == GetTeam(GetMyHero()) then return end
    local unitChanellingSpells = CHANELLING_SPELLS[GetObjectName(unit)]
 
        if unitChanellingSpells then
            for _, spellSlot in pairs(unitChanellingSpells) do
                if spell.name == GetCastName(unit, spellSlot) then callback(unit, CHANELLING_SPELLS) end
            end
	end
end)
 
function addInterrupterCallback( callback0 )
callback = callback0
end

target = IOW.target	
unit = IOW.target
OnDraw(function(myHero)
 if IOW:Mode() == "Combo" and MonTourMenu.Combo.prio:Value() == 1 and (GetCastLevel(myHero,_Q) == 0 or GetCastLevel(myHero,_W) == 0 or GetCastLevel(myHero,_E) == 0) then
Combo()
end

if IOW:Mode() == "Combo" and MonTourMenu.Combo.prio:Value() == 2 then
Combo()
end 

if IOW:Mode() == "Harass" and MonTourMenu.Harass.prio:Value() == 1 and (GetCastLevel(myHero,_Q) == 0 or GetCastLevel(myHero,_W) == 0 or GetCastLevel(myHero,_E) == 0) then
Harass()
end

if IOW:Mode() == "Harass" and MonTourMenu.Harass.prio:Value() == 2 then
Harass()
end 
if IOW:Mode() == "LastHit" and MonTourMenu.LastHit.LHQ:Value() then
LastHit()
end 
if IOW:Mode() == "LaneClear" and MonTourMenu.LaneClear.LHQ:Value() then
LastHit()
CastItemsForMinion()
end
end)



OnTick(function(myHero)
AllforOne()
ItemUse()
if MonTourMenu.KS.ALL:Value() then
KillSteal()
end
if MonTourMenu.Items.Ignite:Value() then
Igniteit()
end
end)

function Combo()
--if GoS:ValidTarget(unit,600) then
  if CanUseSpell(myHero,_W) == READY and MonTourMenu.Combo.W:Value() then
    Wskill()
  end
  if CanUseSpell(myHero,_E) == READY and MonTourMenu.Combo.E:Value() and MonTourMenu.Combo.Eprio:Value() == 1 then
    Estun()
  end  
  if CanUseSpell(myHero,_E) == READY and MonTourMenu.Combo.E:Value() and MonTourMenu.Combo.Eprio:Value() == 2 then
    Eskill()
  end 
  if CanUseSpell(myHero,_Q) == READY and MonTourMenu.Combo.Q:Value()then
    Qskill()
  end
--end
end

function Harass()
--if GoS:ValidTarget(unit,600) then
  if CanUseSpell(myHero,_W) == READY and MonTourMenu.Harass.W:Value() then
    Wskill()
  end
  if CanUseSpell(myHero,_E) == READY and MonTourMenu.Harass.E:Value() and MonTourMenu.Harass.Eprio:Value() == 1 then
    Estun()
  end  
  if CanUseSpell(myHero,_E) == READY and MonTourMenu.Harass.E:Value() and MonTourMenu.Harass.Eprio:Value() == 2 then
    Eskill()
  end  
  if CanUseSpell(myHero,_Q) == READY and MonTourMenu.Harass.Q:Value()then
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
    AttackUnit(unit) GoS:DelayAction(function() CastItemsForKS() GoS:DelayAction(function() AttackUnit(unit) end, 10) end, 50)
  end
  end
end

function Qskill()
  local unit = IOW.target
  if GoS:ValidTarget(unit,300) and GoS:GetDistance(myHero, unit) <= 300 and CanUseSpell(myHero,_Q) == READY then
    CastSpell(_Q)
  end
end

function Wskill()
  local unit = IOW.target
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
  local unit = IOW.target
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
      if MonTourMenu.Combo.AutoE:Value() and CanUseSpell(myHero,_W) == READY and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 and GoS:EnemiesAround(GetOrigin(myHero), MonTourMenu.Combo.AutoER:Value()) <= MonTourMenu.Combo.AutoEE:Value() then
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
      if IOW:Mode() == "Combo" and MonTourMenu.Combo.prio:Value() == 1 and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 then     
        if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Combo.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
        if GoS:GetDistance(unit)<=525 and (CanUseSpell(myHero,_E) ~= READY or not MonTourMenu.Combo.E:Value()) then
            Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50)  
				end
       end
      if IOW:Mode() == "Harass" and MonTourMenu.Harass.prio:Value() == 1 and GetCastLevel(myHero,_Q) > 0 and GetCastLevel(myHero,_W) > 0 and GetCastLevel(myHero,_E) > 0 then     
        if MapPosition:inWall(Pos1)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos2)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos3)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos4)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
				if MapPosition:inWall(Pos5)==true then
					if GoS:GetDistance(unit)<=525 and MonTourMenu.Harass.E:Value() then
						 Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 100) end, 200) end, 300) 
					end
				end
        if GoS:GetDistance(unit)<=525 and (CanUseSpell(myHero,_E) ~= READY or not MonTourMenu.Harass.E:Value()) then
            Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50)  
				end
--        else
--        Harass()
      end
   end
if MonTourMenu.Misc.D:Value() then      
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


function Igniteit()  
  for i,enemy in pairs(GoS:GetEnemyHeroes()) do
  	if Ignite and MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_E) ~= READY and GoS:GetDistance(unit)>=525 then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
    end
  end     
     
end

function ItemUse()
    for _,target in pairs(Gos:GetEnemyHeroes()) do
      if (IOW:Mode() == "Combo" or IOW:Mode() == "Harass" or MonTourMenu.Combo.AutoE:Value()) then
        if GetItemSlot(myHero,3153) > 0 and MonTourMenu.Items.bork:Value() and GoS:ValidTarget(target, 550)  and GetCurrentHP(myHero)/GetMaxHP(myHero) < (MonTourMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (MonTourMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and MonTourMenu.Items.CutBlade:Value() and GoS:ValidTarget(target, 550) and GetCurrentHP(myHero)/GetMaxHP(myHero) < (MonTourMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (MonTourMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and MonTourMenu.Items.ghostblade:Value() and GoS:ValidTarget(target, MonTourMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
        if MonTourMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(target, 550) then --tiamat
          if GoS:GetDistance(target) < 400 then
          CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
          end 
        end
        if MonTourMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(target, 550) then --hydra
          if GoS:GetDistance(target) < 385 then
          CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
          end
        end
        if MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(target,MonTourMenu.Items.useRedPotR:Value()) then --redpot
          if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
          end
        end
      end
    end  
    if GetItemSlot(myHero,3140) > 0 and MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.QSSHP:Value() then
    CastTargetSpell(myHero, GetItemSlot(myHero,3140))
    end

    if GetItemSlot(myHero,3139) > 0 and MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.QSSHP:Value() then
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
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
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
      IOW.attacksEnabled = true
    end
    if GoS:ValidTarget(minion,125) then
      local ADDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
      local QDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+0.6*GetBonusAP(myHero)+QMAXPERCENT or 0  --+QMAXPERCENT
      local DamageAD = GoS:CalcDamage(myHero, minion,ADDmg + sheendmg + frozendmg,lichbane)
      local DamageQ = GoS:CalcDamage(myHero, minion, sheendmg + frozendmg,QDmg + lichbane)
      if GetCurrentHP(minion) < DamageQ and GetCurrentHP(minion) > DamageAD then
         IOW.attacksEnabled = false GoS:DelayAction(function() CastSpell(_Q) end, 1)
      end  
      if GotBuff(myHero,"PoppyDevastatingBlow") == 1 and GoS:GetDistanceSqr(GetOrigin(minion)) <= 125*125 and GetCurrentHP(minion) < DamageQ and GetCurrentHP(minion) > DamageAD then
        AttackUnit(minion) GoS:DelayAction(function() IOW.attacksEnabled = true end, 100)
      end     
    end
  end  
end  

function CastItemsForMinion()
  for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do 
    if GoS:ValidTarget(minion, 600) and IOW:Mode() == "LaneClear" then
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

function CastItemsForKS()
  for i,unit in pairs(GoS:GetEnemyHeroes()) do 
    if GoS:ValidTarget(unit, 600) then
      if MonTourMenu.LaneClear.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 then --tiamat
        if GoS:GetDistance(unit) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end
      end  
      if MonTourMenu.LaneClear.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 then --hydra
        if GoS:GetDistance(unit) < 400 then
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

function KillSteal()
  local unit = IOW.target
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
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
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
--        DrawText(string.format("QMAXPERCENT = %f", QMAXPERCENT),20,100,300,0xffffffff);
--        DrawText(string.format("sheendmg = %f", sheendmg),20,100,330,0xffffffff);
      if GoS:ValidTarget(unit,125) and GoS:GetDistanceSqr(GetOrigin(unit)) <= 125*125 then
        if MonTourMenu.KS.Q:Value() and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) ~= READY and enemyhp < DamageQ then
          Wskill() GoS:DelayAction(function() CastSpell(_Q) end, 100)
        end  
        if MonTourMenu.KS.Q:Value() and GotBuff(myHero,"PoppyDevastatingBlow") == 1 and enemyhp < DamageQ then
          AttackUnitKS(unit) 
        end     
      end
      if GoS:ValidTarget(unit,525) and GoS:GetDistanceSqr(GetOrigin(unit)) <= 525*525 then
        if MonTourMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos1)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos2)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)         
        
        elseif MonTourMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos3)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos4)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.EQnostun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==false and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQNoStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.EQstun:Value() and CanUseSpell(myHero,_E) == READY and MapPosition:inWall(Pos5)==true and (CanUseSpell(myHero,_Q) == READY or GotBuff(myHero,"PoppyDevastatingBlow") == 1) and enemyhp < DamageEQStun then
          Wskill() GoS:DelayAction(function() Qskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)          

------------------
        elseif MonTourMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos1)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos1)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos2)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos2)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)         
        
        elseif MonTourMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos3)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos3)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos4)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos4)==true and enemyhp < DamageEStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
          
        elseif MonTourMenu.KS.Enostun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos5)==false and enemyhp < DamageENoStun then
          GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)
  
        elseif MonTourMenu.KS.Estun:Value() and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_Q) ~= READY and MapPosition:inWall(Pos5)==true and enemyhp < DamageEStun then
           GoS:DelayAction(function() Wskill() GoS:DelayAction(function() Eskill() GoS:DelayAction(function() AttackUnitKS(unit) end, 10) end, 50) end, 100)          
        end 
      end 
      
      -----------------------------------DMGOVER
      
      if GoS:ValidTarget(unit,20000) and MonTourMenu.KS.DOH:Value() then
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

addInterrupterCallback(function(unit, spellType)
    local unit = IOW.target
        if spellType == CHANELLING_SPELLS and MonTourMenu.Interrupt.Interrupt:Value() then
            if CanUseSpell(myHero, _E) == READY and GoS:IsInDistance(unit, 525) then
            Eskill()
            end    
        end
end)