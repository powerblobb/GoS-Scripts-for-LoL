require('Inspired')
require('IAC')

----GoS LUA API v0.0.6
----Version 1.0.0.1
----Inspired.lua v14
----IAC.lua v14
----created by MarCiii
----credits to Inspired and Deftsu for some code that i used for learning

--Press the Combo Button for E+Q+W+R Combo
--Press the Harass Button for E+Q+W Combo
--Press N for SpecialAttack - Perfect R by Leona
--	You can Change the Perfect R Key with editing this use the Button Code instead of KeyIsDown(????)
--	You can find the Keypatterns here:
--	https://msdn.microsoft.com/de-de/library/windows/desktop/dd375731%28v=vs.85%29.aspx
-- 	e.g	if KeyIsDown(0x4E)in Line 132


function PrintInChat() --Print in Chat
PrintChat("<font color=\"#FFFFFF\"><b>League of "..myHeroName.." - </b></font> <font color=\"#FFFFFF\"><b>Loaded. by MarCiii</font><b>")
PrintChat("<font color='#FFFFFF\'>This Script is optimized for Inspired.lua V14 - IAC.lua V14 and GoS LUA API v0.0.5</font>")
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
	end --end of myHeroName
end

DoMyHeroConfigMenu()

function DoMyHeroCombo() --Combo Cast
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
DrawText(string.format("Combo ON - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);	
	
	--Leona
	if myHeroName == "Leona" then
		if ValidTarget(target, 1250) then 	
		local EPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,875,70,true,true)
                   
			if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then		
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)     
			end --end of CanUseSpell(myHero, _E)         
                         
        	if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) and Config.Q then
        	CastTargetSpell(myHero,_Q)
			end --end of CanUseSpell(myHero, _Q)
                
        	if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) and Config.W then
        	CastTargetSpell(myHero,_W)
			end --end off CanUseSpell(myHero, _W)
			
			local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
		
        	if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
        	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
			end --end of CanUseSpell(myHero, _R)
			
		end --end of ValidTarget(target, 1250)
		
	--Draven
	elseif myHeroName == "Draven" then
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
                   
			if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and Config.E then		
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)     
			end --end of CanUseSpell(myHero, _E)         
                         
        	if CanUseSpell(myHero, _Q) == READY and IsInDistance(target, 400) and Config.Q then
        	CastTargetSpell(myHero,_Q)
			end --end of CanUseSpell(myHero, _Q)
                
        	if CanUseSpell(myHero, _W) == READY and IsInDistance(target, 600) and Config.W then
        	CastTargetSpell(myHero,_W)
			end --end off CanUseSpell(myHero, _W)

		end --end of ValidTarget(target, 1250)
	
	--Draven
	elseif myHeroName == "Draven" then
	end	-- end of myHeroName
end

function SpecialAttack() --Leona Ultimate R... AT THE MOMENT
local myPos = GetOrigin(myHero)
local target = GetCurrentTarget()
Move()
	if myHeroName == "Leona" then 
			DrawText(string.format("Ultimate Perfect R - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);
        	if ValidTarget(target, 1250) then
			local RPred = GetPredictionForPlayer(myPos,target,GetMoveSpeed(target),1900,500,1200,70,true,true)
			
                if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and Config.R then
                CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
				end --end of CanUseSpell(myHero, _R)
				
			end --end of ValidTarget(target, 1250)
			
			elseif myHeroName == "Draven" then
			DrawText(string.format("Knockbacking inRange Enemy - %s", GetObjectName(myHero)),24,750,50,0xff00ff00);
				
	end -- end of myHeroName
end	


OnLoop(function(myHero)

	if IWalkConfig.Combo then
	DoMyHeroCombo()
	
	elseif IWalkConfig.Harass then
	DoMyHeroHarass()

--	elseif Config.U then --NOT WORKING HMMM IF ANYBODY KNOW HOW TO FIX PLEASE WRITE IT TO ME :)
--    SpecialAttack()

    elseif KeyIsDown(0x4E) then 
    SpecialAttack()
    

end		
end)