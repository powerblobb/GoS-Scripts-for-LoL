require("Inspired")
require('IWalk')

--Super Simple Sivir
--Version 1.0.0.1
--Inspired V11
--by MarCiii

Config = scriptConfig("Sivir", "Super Simple Sivir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)


OnLoop(function(myHero)
	if not IWalkConfig.Combo then return end
	DrawMenu()
	DrawText("SSSivir ON",24,0,0,0xffff0000);
	local target = GetCurrentTarget()
		if ValidTarget(target, 1200) then
			local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1650,250,1200,70,true,true)
                 	if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and Config.Q then
                 	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end

		if  CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) and Config.W then
                        CastTargetSpell(myHero,_W)
		end	

		end 
end)