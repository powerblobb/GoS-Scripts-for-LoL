require('Inspired')
require('IWalk')

--GoS LUA API v0.0.5
--Version v0.2.0.1 Beta
--Inspired.lua v13
--Created by MarCiii

Config = scriptConfig("Draven", "League of Draven")
Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E if killable", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R if killable", SCRIPT_PARAM_ONOFF, true)
Config.addParam("combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))

PrintChat("<font color='#00aaff'>League of Draven By MarCiii loaded!!</font>")
PrintChat("<font color='#00aaff'>This Script is optimized for Inspired.lua v13 and GoS LUA API v0.0.5</font>")

local myHero = GetMyHero()
local MyheroRange = 550
--local RCAST = (
--GetCastRange(myHero, _R)
--local CastRangeE = GetCastRange(myHero, _E)
--local CastRangeR = GetCastRange(myHero, _R)
--local aCheckCastRangeR = IsInDistance(target, 700)
--local bCheckCastRangeR = aCheckCastRangeR => 700

local myHero = GetMyHero()

OnLoop(function(myHero)
	myHeroPos = GetOrigin(myHero)
	local target = GetCurrentTarget()
	if Config.combo then 
--	if not IWalkConfig.Combo then return end
	    			if  CanUseSpell(myHero, _Q) == READY and IsInDistance(target, MyheroRange) and Config.Q then
                        CastTargetSpell(myHero,_Q)
                    end   
	    	if CanUseSpell(myHero, _E) == READY and Config.E then
			if ValidTarget(target, GetCastRange(myHero, _E)) then
				local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target), 1600, 250, GetCastRange(myHero, _E), 80, false, true)			
				if EPred.HitChance == 1 and emdg() > GetCurrentHP(target) then
					CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
				end
			end
		end
		
		if CanUseSpell(myHero, _R) == READY and Config.R then
			if ValidTarget(target, 20000) then
--			if target ~= nil then 
				local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target), 2000, 1000, 20000, 160, false, true)			
				if RPred.HitChance == 1 and  rmdg() > GetCurrentHP(target) then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
			end
		end
	end	
end)
--and GetOrigin(myHero) > IsInDistance(target, 640)
--function qmdg()--Q DMG
--	if GetCastLevel(myHero, _Q) == 0 then
--		return 0
--	end
--	if GetCastLevel(myHero, _Q) == 1 then
--		return 0 + (GetBonusDmg(myHero)/100*45) + GetBonusDmg(myHero)
--	end
--	if GetCastLevel(myHero, _Q) == 2 then
--		return 0 + (GetBonusDmg(myHero)/100*55) + GetBonusDmg(myHero)
--	end
--	if GetCastLevel(myHero, _Q) == 3 then
--		return 0 + (GetBonusDmg(myHero)/100*65) + GetBonusDmg(myHero)
--	end
--	if GetCastLevel(myHero, _Q) == 4 then
--		return 0 + (GetBonusDmg(myHero)/100*75) + GetBonusDmg(myHero)
--	end
--	if GetCastLevel(myHero, _Q) == 5 then
--		return 0 + (GetBonusDmg(myHero)/100*85) + GetBonusDmg(myHero)
--	end
--end

function emdg()--E DMG
	if GetCastLevel(myHero, _E) == 0 then
		return 0
	end
	if GetCastLevel(myHero, _E) == 1 then
		return 70 + (GetBonusDmg(myHero)/100*50)
	end
	if GetCastLevel(myHero, _E) == 2 then
		return 105 + (GetBonusDmg(myHero)/100*50)
	end
	if GetCastLevel(myHero, _E) == 3 then
		return 140 + (GetBonusDmg(myHero)/100*50)
	end
	if GetCastLevel(myHero, _E) == 4 then
		return 175 + (GetBonusDmg(myHero)/100*50)
	end
	if GetCastLevel(myHero, _E) == 5 then
		return 210 + (GetBonusDmg(myHero)/100*50)
	end
end

function rmdg()--R DMG
	if GetCastLevel(myHero, _R) == 0 then
		return 0
	end
	if GetCastLevel(myHero, _R) == 1 then
		return 175 + (GetBonusDmg(myHero)/100*110)
	end
	if GetCastLevel(myHero, _R) == 2 then
		return 275 + (GetBonusDmg(myHero)/100*110)
	end
	if GetCastLevel(myHero, _R) == 3 then
		return 375 + (GetBonusDmg(myHero)/100*110)
	end
end
