require('Inspired')
require('IAC')
myIAC = IAC()

local version = 2.1
require ("DLib")

up=Updater.new("powerblobb/GoS-Scripts-for-LoL/master/MonTour.lua", "MonTour", version)
if up.newVersion() then 
	up.update() end

--e.g If you want to use only Leona from my Script then MonTourStartChampion = {"Leona", "DravenOFF"}
--e.g If you want to use only Draven from my Script then MonTourStartChampion = {"LeonaOFF", "Draven"}
MonTourStartChampion = {"Leona", "Draven"}

local HOTKEY = string.byte('N') --You can change the Key here "string.byte('????')"

----MarCiiionTour Lib V2
----Voteup for Scripts please thanks :)
----GoS LUA API v0.0.7
----Leona Version 1.0.0.3
----Draven Version 1.0.0.2
----Inspired.lua v14
----IAC.lua v14
----created by MarCiii
----credits to Inspired and Deftsu for some code that i used for learning

--you can find my scripts here:
--http://gamingonsteroids.com/topic/1380-league-of-draven-v14-beta-v0204-adc/
--http://gamingonsteroids.com/topic/1408-leona-on-tour-v14-updated-to-1001-combo-harass-perfect-r/

--Leona--
--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for E+Q+W Combo
--Press N for SpecialAttack - Perfect R by Leona

--Draven--
--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for Q Combo
--Press N for SpecialAttack - Knocking Back inRange Enemy by Draven

myHero = GetMyHero()
MonTourMyHeroName = GetObjectName(myHero)

for _,m in pairs(MonTourStartChampion) do
	if m == MonTourMyHeroName then
	PrintChat("<font color=\"#FFFFFF\"><b>League of "..MonTourMyHeroName.." - </b></font> <font color=\"#FFFFFF\"><b>Loaded. by MarCiii</font><b>")
	PrintChat("<font color='#FFFFFF\'>This Script is optimized for Inspired.lua V14 - IAC.lua V14 and GoS LUA API v0.0.7</font>")
	
myHeroName = GetObjectName(myHero)
myHero = GetMyHero()
MonTourTable = {"Leona", "Draven"}
--minionTable = {}
--orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }

local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local MyHeroMana = GetCurrentMana(myHero)
local MyheroRange = 550 --DRAVEN RANGE
local MyheroRangeL = 125 --LEONA RANGE

function HeroNameLoadLib() --Libs
	if MonTourMyHeroName == "Leona" then
		require('Inspired')
		require('IAC')
		myIAC = IAC()	
		elseif MonTourMyHeroName == "Draven" then
		require('Inspired')
		require('IAC')
		require('Baseult') 
		myIAC = IAC()
	end --end of myHeroName
end

HeroNameLoadLib()

function DoMyHeroConfigMenu() --Config Menu
	if MonTourMyHeroName == "Leona" then
		Config = scriptConfig("Leona", "Leona")
		Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("R", "Use R in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("RR", "EQW/MANA READY", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("U", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("n"))
	elseif MonTourMyHeroName == "Draven" then
		Config = scriptConfig("Draven", "League of Draven")
		Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("LHQ", "Use Q Last Hit", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("LCQ", "Use Q Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("E", "Use E if killable", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("R", "Use R if killable", SCRIPT_PARAM_ONOFF, true)
		Config.addParam("U", "KnockBack Enemy in Range", SCRIPT_PARAM_KEYDOWN, string.byte("n")) 
	end --end of myHeroName
end

DoMyHeroConfigMenu()

function DoMyHeroCombo() --Combo Cast
DrawText(string.format("Combo ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local MyHeroMana = GetCurrentMana(myHero)
local ManaCheck = MyHeroMana >= qcost() + wcost() + ecost() + rcost()
local MyheroRange = 550 --DRAVEN RANGE	
	--Leona
	
	if MonTourMyHeroName == "Leona" then
		for _,unit in pairs(GetEnemyHeroes()) do
			if ValidTarget(unit, 1250) then 	
			local EPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,875,70,true,true)
        		if Config.E then           
					if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then		
					CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)     
					end --end of CanUseSpell(myHero, _E)         
 	   			end	
 	  			if Config.Q then             
        			if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) then
        			CastTargetSpell(myHero,_Q)
					end --end of CanUseSpell(myHero, _Q)
        		end
        		if Config.W then      
        			if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) then
        			CastTargetSpell(myHero,_W)
					end --end off CanUseSpell(myHero, _W)
				end	
				if Config.R and Config.RR and ManaCheck and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _R) ~= ONCOOLDOWN then	
				local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
					if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
        			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
					end --end of CanUseSpell(myHero, _R)
				end
				if Config.R and not Config.RR then	
				local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
					if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
        			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
					end --end of CanUseSpell(myHero, _R)
				end
	  		end --end of ValidTarget(target, 1250)   	
    	end --for _,unit in pairs(GetEnemyHeroes()) do
  		
	--Draven
	elseif MonTourMyHeroName == "Draven" then
	for _,unit in pairs(GetEnemyHeroes()) do	
	if ValidTarget(unit, MyheroRange) then 
		if Config.Q then
			if  CanUseSpell(myHero, _Q) == READY and IsInDistance(target, MyheroRange) then
            CastTargetSpell(myHero,_Q)
            end 
        end
    end 
    if MyHeroMana >= qcost() + wcost() then
   		if ValidTarget(unit, 600) then   
        	if Config.W then
--        	local targetmove = GetMoveSpeed(target)
--        	local myheromove = GetMoveSpeed(myHero)
--        		if targetmove > myheromove and IsInDistance(target, 620) then 
					if IsInDistance(target, 600) then
						if  CanUseSpell(myHero, _W) == READY then
            			CastTargetSpell(myHero,_W)
            			end 
       				end
--        		end
        	end
    	end
    end     
    if ValidTarget(unit, 1150) then     
        if Config.E then      
	   		if GetDistance(myHero, unit) >= 600 then
	    		if CanUseSpell(myHero, _E) == READY then
	    		
					local EPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 1600, 250, 1150, 80, false, true) --GetCastRange(myHero, _E) = 1150							
					if EPred.HitChance == 1 and  CalcDamage(myHero, target, Edmg()) > GetCurrentHP(target) + GetHPRegen(target) then
					CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
					end
				end
		 	end	
		end
	end
	if ValidTarget(unit, 4500) then
		if Config.R then
			if GetDistance(myHero, unit) > 780 then 	--			if GetDistance(myHero,unit)
				if CanUseSpell(myHero, _R) == READY then
			
					local RPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 2000, 1000, 20000, 160, false, true)						
					if RPred.HitChance == 1 and  CalcDamage(myHero, target, Rdmg()) > GetCurrentHP(target) + GetHPRegen(target) then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
					end		
				end
			end
		end
	end
end
	else
	DrawText(string.format("%s not supported", GetObjectName(myHero)),24,750,50,0xffffff00)
	end -- end of myHeroName
end

function DoMyHeroHarass() --Harass Cast
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local MyheroRange = 550 --DRAVEN RANGE
DrawText(string.format("Harass ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
	--Leona
	if MonTourMyHeroName == "Leona" then
		for _,unit in pairs(GetEnemyHeroes()) do	
			if ValidTarget(unit, 1250) then 	
			local EPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,875,70,true,true)
        		if Config.E then           
					if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then		
					CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)     
					end --end of CanUseSpell(myHero, _E)         
        		end	
        		if Config.Q then                 
        			if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) then
        			CastTargetSpell(myHero,_Q)
					end --end of CanUseSpell(myHero, _Q)
        		end 
        		if Config.W then       
        			if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) then
        			CastTargetSpell(myHero,_W)
					end --end off CanUseSpell(myHero, _W)
				end	
			end --end of ValidTarget(target, 1250)
		end
	--Draven
	elseif MonTourMyHeroName == "Draven" then
		for _,unit in pairs(GetEnemyHeroes()) do	
			if ValidTarget(unit, MyheroRange) then 		
				if Config.Q then
					if  CanUseSpell(myHero, _Q) == READY and IsInDistance(target, MyheroRange) then
            		CastTargetSpell(myHero,_Q)
            		end 
        		end
    		end 
    	end   
	end	-- end of myHeroName
end

function DoMyHeroLaneClear() --LaneClear Cast config.LCQ
DrawText(string.format("LastClearMode ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
   
        --Leona  	
		if MonTourMyHeroName == "Leona" then
			for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
				if ValidTarget(k, MyheroRangeL) and IsInDistance(k, MyheroRangeL) then
				end
			end	
		--Draven
		elseif MonTourMyHeroName == "Draven" then
			for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
				if Config.LCQ then	
				    if ValidTarget(k, MyheroRange) and IsInDistance(k, MyheroRange) then
						if  CanUseSpell(myHero, _Q) == READY then
          				CastTargetSpell(myHero,_Q)
       					end 
      				end
      			end
      		end
        end    
    return
end


function DoMyHeroLastHit() --LastHit Cast config.LHQ
DrawText(string.format("LastHitMode ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);		
local MyheroRangeL = 125 --LEONA RANGE
local MyheroRangeL = 550 --DRAVEN RANGE   
        --Leona  	
		if MonTourMyHeroName == "Leona" then
			for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
				if ValidTarget(k, MyheroRangeL) and IsInDistance(k, MyheroRangeL) then
				end
			end	
			
		--Draven
		elseif MonTourMyHeroName == "Draven" then
			for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
				if Config.LHQ then	
				    if ValidTarget(k, MyheroRange) and IsInDistance(k, MyheroRange) then
						if  CanUseSpell(myHero, _Q) == READY then
          				CastTargetSpell(myHero,_Q)
       					end 
      				end
      			end
      		end
        end    
    return
end

function SpecialAttack() --Leona Ultimate R... AT THE MOMENT
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local MyheroRange = 550 --DRAVEN RANGE
		IAC:Move()
		if MonTourMyHeroName == "Leona" then
		  for _,unit in pairs(GetEnemyHeroes()) do 
			DrawText(string.format("Ultimate Perfect R - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);
        	if ValidTarget(unit, 1250) then
			local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
			
                if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
                CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
				end --end of CanUseSpell(myHero, _R)
			end --end of ValidTarget(target, 1250)
		 end	
		elseif MonTourMyHeroName == "Draven" then
		  for _,unit in pairs(GetEnemyHeroes()) do
			DrawText(string.format("Knocking Back inRange Enemy - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
			if ValidTarget(target, GetCastRange(myHero, _E)) then
			local EPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 1600, 250, GetCastRange(myHero, _E), 80, false, true)	
										
				if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then	
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
				end
			end	
		  end	
		end -- end of MonTourMyHeroName
end	

function Edmg()--E DMG
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()	
	local useE = GetCastLevel(myHero, _E)
	local Bperc50 = (GetBonusDmg(myHero)/100*50)
	if MonTourMyHeroName == "Leona" then
	
	elseif MonTourMyHeroName == "Draven" then	
		if useE == 0 then
		return 0
		end
		if useE == 1 then
		return 70 + Bperc50
		end
		if useE == 2 then
		return 105 + Bperc50
		end
		if useE == 3 then
		return 140 + Bperc50
		end
		if useE == 4 then
		return 175 + Bperc50
		end
		if useE == 5 then
		return 210 + Bperc50
		end
	end
end


function Rdmg()--R DMG
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()	
	local useR = GetCastLevel(myHero, _R)
	local Bperc110 = (GetBonusDmg(myHero)/100*110)
	if MonTourMyHeroName == "Leona" then
	
	elseif MonTourMyHeroName == "Draven" then	
		if useR == 0 then
		return 0
		end
		if useR == 1 then
		return 175 + Bperc110
		end
		if useR == 2 then
		return 275 + Bperc110
		end
		if useR == 3 then
		return 375 + Bperc110
		end
	end
end

function qcost()--Q COST
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()

	if MonTourMyHeroName == "Leona" then
		if GetCastLevel(myHero, _Q) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _Q) == 1 then
		return 45
		end
		if GetCastLevel(myHero, _Q) == 2 then
		return 50
		end
		if GetCastLevel(myHero, _Q) == 3 then
		return 55
		end
		if GetCastLevel(myHero, _Q) == 4 then
		return 60
		end
		if GetCastLevel(myHero, _Q) == 5 then
		return 65
		end	
		
	elseif MonTourMyHeroName == "Draven" then
		if GetCastLevel(myHero, _Q) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _Q) == 1 then
		return 45
		end
		if GetCastLevel(myHero, _Q) == 2 then
		return 45
		end
		if GetCastLevel(myHero, _Q) == 3 then
		return 45
		end
		if GetCastLevel(myHero, _Q) == 4 then
		return 45
		end
		if GetCastLevel(myHero, _Q) == 5 then
		return 45
		end
	end
end

function wcost()--W COST
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()

	if MonTourMyHeroName == "Leona" then
		if GetCastLevel(myHero, _W) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _W) == 1 then
		return 40
		end
		if GetCastLevel(myHero, _W) == 2 then
		return 40
		end
		if GetCastLevel(myHero, _W) == 3 then
		return 40
		end
		if GetCastLevel(myHero, _W) == 4 then
		return 40
		end
		if GetCastLevel(myHero, _W) == 5 then
		return 40
		end
			
	elseif MonTourMyHeroName == "Draven" then
		if GetCastLevel(myHero, _W) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _W) == 1 then
		return 60
		end
		if GetCastLevel(myHero, _W) == 2 then
		return 60
		end
		if GetCastLevel(myHero, _W) == 3 then
		return 60
		end
		if GetCastLevel(myHero, _W) == 4 then
		return 60
		end
		if GetCastLevel(myHero, _W) == 5 then
		return 60
		end
	end
end

function ecost()--E COST
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()

	if MonTourMyHeroName == "Leona" then
	if GetCastLevel(myHero, _E) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _E) == 1 then
		return 70
		end
		if GetCastLevel(myHero, _E) == 2 then
		return 70
		end
		if GetCastLevel(myHero, _E) == 3 then
		return 70
		end
		if GetCastLevel(myHero, _E) == 4 then
		return 70
		end
		if GetCastLevel(myHero, _E) == 5 then
		return 70
		end	
				
	elseif MonTourMyHeroName == "Draven" then
		if GetCastLevel(myHero, _E) == 0 then
		return 0
		end
		if GetCastLevel(myHero, _E) == 1 then
		return 60
		end
		if GetCastLevel(myHero, _E) == 2 then
		return 60
		end
		if GetCastLevel(myHero, _E) == 3 then
		return 60
		end
		if GetCastLevel(myHero, _E) == 4 then
		return 60
		end
		if GetCastLevel(myHero, _E) == 5 then
		return 60
		end
	end
end

function rcost()--R COST
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()

	if MonTourMyHeroName == "Leona" then
		if GetCastLevel(myHero, _R) == 0 then
		return 0
		end			
		if GetCastLevel(myHero, _R) == 1 then
		return 100
		end
		if GetCastLevel(myHero, _R) == 2 then
		return 100
		end
		if GetCastLevel(myHero, _R) == 3 then
		return 100
		end
			
	elseif MonTourMyHeroName == "Draven" then
		if GetCastLevel(myHero, _R) == 0 then
		return 0
		end			
		if GetCastLevel(myHero, _R) == 1 then
		return 120
		end
		if GetCastLevel(myHero, _R) == 2 then
		return 120
		end
		if GetCastLevel(myHero, _R) == 3 then
		return 120
		end
	end
end


OnLoop(function(myHero)
local MonTourMyHeroName = GetObjectName(myHero)	
local myHero = GetMyHero()
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
  for _,k in pairs(MonTourTable) do
	if k == MonTourMyHeroName then
		if IWalkConfig.Combo then
		DoMyHeroCombo()
	
		elseif IWalkConfig.Harass then
		DoMyHeroHarass()
	 
		elseif IWalkConfig.LaneClear then
    	DoMyHeroLaneClear()
    
    	elseif IWalkConfig.LastHit then 
    	DoMyHeroLastHit()
    
    	elseif KeyIsDown(HOTKEY) then 
    	SpecialAttack()
    	
--    	elseif IWalkConfig.Combo and KeyIsDown(HOTKEY) then 
--    	SpecialAttack()
    	end
    end
  end	 	
end)
	
	end
end




--    elseif KeyIsDown(0x02)then
--    CastTargetSpell(myHero,ping-mia.troy)