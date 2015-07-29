require('Inspired')
require('IWalk')

----GoS LUA API v0.0.5
----Version 1.0.0.0
----Inspired.lua v13
----created by MarCiii

--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for E+Q+W Combo
--Press N for Perfect R
--	You can Change the Perfect R Key with editing this use the Button Code instead of KeyIsDown(????)
--	You can find the Keypatterns here:
--	https://msdn.microsoft.com/de-de/library/windows/desktop/dd375731%28v=vs.85%29.aspx
-- e.g	if KeyIsDown(????) then DoWalk()
-- e.g	if KeyIsDown(????) then

Config = scriptConfig("Leona", "Leona")
Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R in combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("ulti", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("n"))
--Config.addParam("harass", "Harass", SCRIPT_PARAM_KEYDOWN, string.byte(" "))

PrintChat("<font color='#00aaff'>League of Leona By MarCiii loaded!!</font>")
PrintChat("<font color='#00aaff'>This Script is optimized for Inspired.lua v13 and GoS LUA API v0.0.5</font>")

local myHero = GetMyHero()

OnLoop(function(myHero)
--if Config.combo then
if not IWalkConfig.Combo then return end 
	DrawMenu()
 	myPos = GetOrigin(myHero)
	local target = GetCurrentTarget() 
                   if ValidTarget(target, 1250) then
			
                local EPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,875,70,true,true)
                 if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                 CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                 end
                if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) and Config.Q then
                        CastTargetSpell(myHero,_Q)
			end
                if  CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) and Config.W then
                        CastTargetSpell(myHero,_W)
			end
			
		        local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
                 if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
                 CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
					end
				end
--			end
	
end)

OnLoop(function(myHero)
--if Config.harass then
if not IWalkConfig.Harass then return end 
	DrawMenu()
 	myPos = GetOrigin(myHero)
	local target = GetCurrentTarget() 
                   if ValidTarget(target, 1250) then
			
                local EPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,875,70,true,true)
                 if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then
                 CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                 end
                if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) and Config.Q then
                        CastTargetSpell(myHero,_Q)
			end
                if  CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) and Config.W then
                        CastTargetSpell(myHero,_W)
			end

				end
--			end
	
end)

OnLoop(function(myHero)
--if not Config.ulti then return end
if KeyIsDown(0x4E) then DoWalk()
if KeyIsDown(0x4E) then
	DrawMenu()
 	myPos = GetOrigin(myHero)
	local target = GetCurrentTarget() 
                   if ValidTarget(target, 1250) then
			
		        local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
                 if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
                 CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
					end
					end
			end
	end
end)