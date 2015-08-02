require('Inspired')
require('IAC')

MonTourTable = {"Leona", "Draven"}
minionTable = {}

myHero = GetMyHero()
myHeroName = GetObjectName(myHero)
IWalkTarget = nil

local HOTKEY = string.byte('N') --You can change the Key here "string.byte('????')"

----MarCiiionTour Lib V1.1
----Voteup for Scripts please thanks :)
----GoS LUA API v0.0.7
----Leona Version 1.0.0.2
----Draven Version 0.2.0.5
----Inspired.lua v14
----IAC.lua v14
----created by MarCiii
----credits to Inspired and Deftsu for some code that i used for learning

--Leona--
--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for E+Q+W Combo
--Press N for SpecialAttack - Perfect R by Leona

--Draven--
--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for Q Combo
--Press N for SpecialAttack - Knocking Back inRange Enemy by Draven


function PrintInChat() --Print in Chat
PrintChat("<font color=\"#FFFFFF\"><b>League of "..myHeroName.." - </b></font> <font color=\"#FFFFFF\"><b>Loaded. by MarCiii</font><b>")
PrintChat("<font color='#FFFFFF\'>This Script is optimized for Inspired.lua V14 - IAC.lua V14 and GoS LUA API v0.0.7</font>")
end

PrintInChat()

function DoMyHeroConfigMenu() --Config Menu
if myHeroName == "Leona" then
	Config = scriptConfig("Leona", "Leona")
	Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
	Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
	Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
	Config.addParam("R", "Use R in combo", SCRIPT_PARAM_ONOFF, true)
	Config.addParam("U", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("n"))
elseif myHeroName == "Draven" then
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
local myPos = GetOrigin(myHero)
--local myPos = nil
local target = GetCurrentTarget()
DrawText(string.format("Combo ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
	
	--Leona
	if myHeroName == "Leona" then
		if ValidTarget(target, 1250) then 	
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
		if Config.R then	
			local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
			if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
        	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
			end --end of CanUseSpell(myHero, _R)
		end	
		end --end of ValidTarget(target, 1250)
		
	--Draven
	elseif myHeroName == "Draven" then
	for _, target in pairs(GetEnemyHeroes()) do	
		local MyheroRange = 550
		GetEnemyHeroes()
	if ValidTarget(target, MyheroRange) then 
		if Config.Q then
			if  CanUseSpell(myHero, _Q) == READY and IsInDistance(target, MyheroRange) then
            CastTargetSpell(myHero,_Q)
            end 
        end
    end 
    
    if ValidTarget(target, 620) then   
        if Config.W then
        local targetmove = GetMoveSpeed(target)
        local myheromove = GetMoveSpeed(myHero)
        if targetmove > myheromove and IsInDistance(target, 620) then 
			if IsInDistance(target, 610) then
			if  CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(myHero,_W)
            end 
        end
        end
        end
    end     
    if ValidTarget(target, GetCastRange(myHero, _E)) then     
        if Config.E then      
	   	if GetDistance(myHero,target) > 700 then
	    	if CanUseSpell(myHero, _E) == READY then
				local EPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 1600, 250, GetCastRange(myHero, _E), 80, false, true)			
				
				if EPred.HitChance == 1 and  CalcDamage(myHero, target, Edmg()) > GetCurrentHP(target) + GetHPRegen(target) then
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
				end
			end
		 	end	
		end
	end
	if ValidTarget(target, 20000) then
		if Config.R then
		if GetDistance(myHero,target) > 800 then
			if CanUseSpell(myHero, _R) == READY then
--			GetEnemyHeroes()
			
				local RPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 2000, 1000, 20000, 160, false, true)			
			
--				if RPred.HitChance == 1 and  Rdmg() > GetCurrentHP(target) + GetHPRegen(target) then
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
	target = nil
--	end
--	end
	end -- end of myHeroName
end

function DoMyHeroHarass() --Harass Cast
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
DrawText(string.format("Harass ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
	--Leona
	if myHeroName == "Leona" then
		if ValidTarget(target, 1250) then 	
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
	
	--Draven
	elseif myHeroName == "Draven" then
		for _, target in pairs(GetEnemyHeroes()) do	
		local MyheroRange = 550
		GetEnemyHeroes()
	if ValidTarget(target, MyheroRange) then 		
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
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local eminion = GetAllMinions(MINION_ENEMY)
DrawText(string.format("LastClearMode ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
	
	--Leona
	if myHeroName == "Leona" then
		
	--Draven
	elseif myHeroName == "Draven" then
		local MyheroRange = 550
--	if ValidTarget(eminion, MyheroRange) then	
		if Config.LCQ then
--		if IsInDistance(eminion, MyheroRange)then		
			if  CanUseSpell(myHero, _Q) == READY then
            CastTargetSpell(myHero,_Q)
            end 
        end
--    end    
	end -- end of myHeroName
end

function DoMyHeroLastHit() --LastHit Cast config.LHQ
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
-- local eminion = nil
DrawText(string.format("LastHitMode ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
--for _, eminion in pairs(GetAllMinions(MINION_ENEMY)) do	
--if ValidTarget(minion, MyheroRange) and IsInDistance(minion, MyheroRange) then	
	--Leona
	if myHeroName == "Leona" then
	--and IsInDistance((GetAllMinions(MINION_ENEMY)), MyheroRange)	
	--Draven
	elseif myHeroName == "Draven" then
		local MyheroRange = 550
		if Config.LHQ then
--		if IsInDistance(eminion, MyheroRange)then		
			if  CanUseSpell(myHero, _Q) == READY then
            CastTargetSpell(myHero,_Q)
            end 
        end    
	end -- end of myHeroName
--else return end	
end

function SpecialAttack() --Leona Ultimate R... AT THE MOMENT
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
Move()
	if myHeroName == "Leona" then 
			DrawText(string.format("Ultimate Perfect R - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);
--        	if target ~= nil then
        	if ValidTarget(target, 1250) then
			local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
			
                if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 then
                CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
				end --end of CanUseSpell(myHero, _R)
				
			end --end of ValidTarget(target, 1250)
	elseif myHeroName == "Draven" then
			DrawText(string.format("Knocking Back inRange Enemy - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
			if ValidTarget(target, GetCastRange(myHero, _E)) then			
			if CanUseSpell(myHero, _E) == READY then
			local EPred = GetPredictionForPlayer(myPos, target, GetMoveSpeed(target), 1600, 250, GetCastRange(myHero, _E), 80, false, true)			
				
				if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
				end
				
			end
			end	
	end -- end of myHeroName
end	

function Edmg()--E DMG
	local useE = GetCastLevel(myHero, _E)
	local Bperc50 = (GetBonusDmg(myHero)/100*50)
	if myHeroName == "Leona" then
	
	elseif myHeroName == "Draven" then	
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
	local useR = GetCastLevel(myHero, _R)
	local Bperc110 = (GetBonusDmg(myHero)/100*110)
	if myHeroName == "Leona" then
	
	elseif myHeroName == "Draven" then	
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


OnLoop(function(myHero)
for _,k in pairs(MonTourTable) do
  if k == myHeroName then
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
    
--    elseif KeyIsDown(0x02)then
--    CastTargetSpell(myHero,ping-mia.troy)
end
    end
    end	 	
end)
