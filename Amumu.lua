if GetObjectName(myHero) ~= "Amumu" then return end
--MonTour Amumu:V1.0.0.4 - updated GoS:myHeroPos() to GetOrigin(myHero)
PrintChat(string.format("<font color='#80F5F5'>MonTour Amumu:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.4</font>"))
local MonTourMenu = Menu("Amumu", "Amumu")
MonTourMenu:SubMenu("Combo", "Combo")
MonTourMenu.Combo:Boolean("Q","Use Q",true)
MonTourMenu.Combo:Boolean("W","Use W",true)
MonTourMenu.Combo:Boolean("E","Use E",true)
MonTourMenu.Combo:Boolean("R","Use R",true)
MonTourMenu.Combo:Info("Amumu", "Use R if X+ Enemys")
MonTourMenu.Combo:Slider("RE", "will be stunned (Def. 3)", 3, 1, 5, 1)
MonTourMenu:SubMenu("Harass", "Harass")
MonTourMenu.Harass:Boolean("Q","Use Q",true)
MonTourMenu.Harass:Boolean("W","Use W",true)
MonTourMenu.Harass:Boolean("E","Use E",true)
MonTourMenu.Harass:Boolean("R","Use R",true)
MonTourMenu.Harass:Info("Amumu", "Use R if X+ Enemys")
MonTourMenu.Harass:Slider("RE", "will be stunned (Def. 1)", 1, 1, 5, 1)
MonTourMenu:SubMenu("LaneClear", "LaneClear")
MonTourMenu.LaneClear:Boolean("W","Use W",true)
MonTourMenu.LaneClear:Slider("WC", "Turn on if MinionAround >= X (Def. 4)", 4, 1, 20, 1)
MonTourMenu.LaneClear:Slider("WC2", "Turn off if MinionAround <= X (Def. 1)", 1, 1, 20, 1)
MonTourMenu.LaneClear:Info("Amumu", " ")
MonTourMenu.LaneClear:Boolean("E","Use E",true)
MonTourMenu.LaneClear:Slider("EC", "Use E if MinionAround >= X (Def. 4)", 4, 1, 20, 1)
MonTourMenu:SubMenu("JungleClear", "JungleClear")
MonTourMenu.JungleClear:Boolean("Q","Use Q",true)
MonTourMenu.JungleClear:Boolean("W","Use W",true)
MonTourMenu.JungleClear:Boolean("E","Use E",true)
MonTourMenu:SubMenu("KS", "KillSteal")
MonTourMenu.KS:Boolean("Q","KS with Q",true)
MonTourMenu.KS:Boolean("E","KS with E",true)
MonTourMenu.KS:Info("Amumu", " ")
MonTourMenu.KS:Boolean("R","KS with R",true)
MonTourMenu.KS:Info("Amumu", "Use R if X+ Enemys")
MonTourMenu.KS:Slider("RE", "will be stunned (Def. 3)", 3, 1, 5, 1)
MonTourMenu.KS:Info("Amumu", " ")
MonTourMenu.KS:Boolean("QE","KS with QE",false)
MonTourMenu.KS:Info("Amumu", " ")
MonTourMenu.KS:Boolean("QR","KS with QR",false)
MonTourMenu.KS:Info("Amumu", "Use R if X+ Enemys")
MonTourMenu.KS:Slider("RE2", "will be stunned (Def. 3)", 3, 1, 5, 1)
MonTourMenu.KS:Info("Amumu", " ")
MonTourMenu.KS:Boolean("QER","KS with QER",false)
MonTourMenu.KS:Info("Amumu", "Use R if X+ Enemys")
MonTourMenu.KS:Slider("RE3", "will be stunned (Def. 3)", 3, 1, 5, 1)
MonTourMenu.KS:Info("Amumu", " ")
MonTourMenu:SubMenu("Misc", "Misc")
MonTourMenu.Misc:Boolean("MGUN","Ultimate Notifier", true)
MonTourMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
MonTourMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 30, 5, 60, 1)
MonTourMenu.Misc:Slider("MGUNX", "UN X POS", 60, 0, 1600, 1)
MonTourMenu.Misc:Slider("MGUNY", "UN Y POS", 200, 0, 1055, 1)
MonTourMenu.Misc:Info("Amumu", " ")
MonTourMenu.Misc:Boolean("MGUN2","Stunable Champion Notifier", true)
MonTourMenu.Misc:Boolean("MGUNDEB2","TEXT DEBUG", false)
MonTourMenu.Misc:Slider("MGUNSIZE2", "SCN Text Size", 25, 5, 60, 1)
MonTourMenu.Misc:Slider("MGUNX2", "SCN X POS", 700, 0, 1600, 1)
MonTourMenu.Misc:Slider("MGUNY2", "SCN Y POS", 785, 0, 1055, 1)
MonTourMenu.Misc:Info("Amumu", " ")
MonTourMenu.Misc:Boolean("DMGoHP","Draw DMG over HP",true) 
MonTourMenu:SubMenu("Interrupt", "Interrupt")
MonTourMenu.Interrupt:Boolean("InterruptQ", "Auto Interrupt Spells with Q", true)
MonTourMenu.Interrupt:Info("Amumu", "Auto Interrupt Spells")
MonTourMenu.Interrupt:Boolean("InterruptR", "with R if Q not Ready", true)
MonTourMenu:SubMenu("Drawings", "Drawings")
MonTourMenu.Drawings:Boolean("Q","Draw Q",true)
MonTourMenu.Drawings:Boolean("R","Draw R",true)

target = GetCurrentTarget()
unit = GetCurrentTarget()

  spellData = 
	{
	[_Q] = {dmg = function () return 30 + 50*GetCastLevel(myHero,_Q) + 0.7*GetBonusAP(myHero) end,  
			mana = function () return 70 + 10*GetCastLevel(myHero,_Q) end,
      speed = math.huge,
			delay = 250,			 			
			range = 1100, 
			width = 65},  
	[_W] = {dmg = function () for _,unit in pairs(GoS:GetEnemyHeroes()) do return 4 + 4*GetCastLevel(myHero,_W) + GetMaxHP(unit)/100*(GetCastLevel(myHero,_W)*0.5+0.5) end end, 
			mana = 8,   --per second
			range = 300},
	[_E] = {dmg = function () return 50 + 25*GetCastLevel(myHero,_E) + 0.5*GetBonusAP(myHero) end, 
			mana = 35,						 			
			range = 350}, 
	[_R] = {dmg = function () return 50 + 100*GetCastLevel(myHero,_R) + 0.8*GetBonusAP(myHero) end, 
			mana = function () return 50 + 50*GetCastLevel(myHero,_R) end,
			delay = 250,			 			
			range = 550, 
			width = 550},					
	}


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

OnLoop(function(myHero)
	QREADY = CanUseSpell(myHero,_Q) == READY
	WREADY = CanUseSpell(myHero,_W) == READY
	EREADY = CanUseSpell(myHero,_E) == READY
	EREADYONCOOLDOWN = CanUseSpell(myHero,_E) == ONCOOLDOWN
	RREADY = CanUseSpell(myHero,_R) == READY 
	targetPos = GetOrigin(target)
	myHeroPos = GetOrigin(myHero) 
  AuraofDespairOff = GotBuff(myHero,"AuraofDespair") == 0
  AuraofDespairOn = GotBuff(myHero,"AuraofDespair") == 1    
  target = GetCurrentTarget()
  GLOBALULTNOTICEDEBUG()
	Killsteal()
  Drawings()
if IOW:Mode() == "Combo" then
  Combo()
end 
if IOW:Mode() == "Harass" then
  Harass()
end 
if IOW:Mode() == "LaneClear" then
  LaneClear(minion)
  JungleClear(jminion)
end
if MonTourMenu.Misc.DMGoHP:Value() then
  Draws()
end
if MonTourMenu.Misc.MGUN:Value() then
  GLOBALULTNOTICE()
end
if MonTourMenu.Misc.MGUN2:Value() then
  GLOBALULTNOTICE2()
end
end)

function Combo()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
  if GoS:ValidTarget(target, spellData[_Q].range+50) then
 		local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
		if MonTourMenu.Combo.Q:Value() and QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end   
    if MonTourMenu.Combo.W:Value() and WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(target, spellData[_W].range) and GoS:GetDistance(myHero, target) > 50 and GoS:GetDistance(myHero, target) <= spellData[_W].range then 
        CastTargetSpell(target,_W) 
    end    
    if MonTourMenu.Combo.W:Value() and WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range+50) <= 0 and AuraofDespairOn and not GoS:IsInDistance(target, spellData[_W].range) and GoS:GetDistance(myHero, target) > spellData[_W].range then 
        CastTargetSpell(target,_W) 
    end
  	if MonTourMenu.Combo.E:Value() and EREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(target, spellData[_E].range) and GoS:GetDistance(myHero, target) <= spellData[_E].range-30 and GoS:GetDistance(myHero, target) > 0 then 
        CastTargetSpell(target,_E)
    end
    for _,target in pairs(GoS:GetEnemyHeroes()) do
    if MonTourMenu.Combo.R:Value() and RREADY and GoS:IsInDistance(target, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= MonTourMenu.Combo.RE:Value() then
        CastTargetSpell(target,_R)
    end
    end
   end 
end  

function Harass()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
  if GoS:ValidTarget(target, spellData[_Q].range+50) then
 		local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
		if MonTourMenu.Harass.Q:Value() and QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end   
    if MonTourMenu.Harass.W:Value() and WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(target, spellData[_W].range) and GoS:GetDistance(myHero, target) > 50 and GoS:GetDistance(myHero, target) <= spellData[_W].range then 
        CastTargetSpell(target,_W) 
    end    
    if MonTourMenu.Harass.W:Value() and WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range+50) <= 0 and AuraofDespairOn and not GoS:IsInDistance(target, spellData[_W].range) and GoS:GetDistance(myHero, target) > spellData[_W].range then 
        CastTargetSpell(target,_W) 
    end
  	if MonTourMenu.Harass.E:Value() and EREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(target, spellData[_E].range) and GoS:GetDistance(myHero, target) <= spellData[_E].range-30 and GoS:GetDistance(myHero, target) > 0 then 
        CastTargetSpell(target,_E)
    end
    for _,target in pairs(GoS:GetEnemyHeroes()) do    
    if MonTourMenu.Harass.R:Value() and RREADY and GoS:IsInDistance(target, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= MonTourMenu.Harass.RE:Value() then
        CastTargetSpell(target,_R)
    end
    end
  end  
end 

function Drawings()
if MonTourMenu.Drawings.Q:Value() and GetCastLevel(myHero,_Q) >=1 then DrawCircle(GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z,GetCastRange(myHero,_Q),0.6,50,0xff0000ff) end
if MonTourMenu.Drawings.R:Value() and GetCastLevel(myHero,_R) >=1 then DrawCircle(GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z,GetCastRange(myHero,_R),0.6,50,0xff0000ff) end
end

function Draws()
local rangeofdraws = 20000
	for _,unit in pairs(GoS:GetEnemyHeroes()) do
	--Ready Q + W + E + R
	if GoS:ValidTarget(unit,rangeofdraws) and QREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_Q].dmg() + spellData[_E].dmg() + spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + E + (R)			
	elseif GoS:ValidTarget(unit,rangeofdraws) and QREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_Q].dmg() + spellData[_E].dmg()),0xffffffff)
	--Ready Q + (W) + (E) + R			
	elseif GoS:ValidTarget(unit,rangeofdraws) and QREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_Q].dmg() + spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + (E) + (R)		
	elseif GoS:ValidTarget(unit,rangeofdraws) and QREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_Q].dmg()),0xffffffff)
	--Ready (Q) + (W) + E + R
	elseif GoS:ValidTarget(unit,rangeofdraws) and not QREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_E].dmg() + spellData[_R].dmg()),0xffffffff)	
	--Ready (Q) + (W) + E + (R)			
	elseif GoS:ValidTarget(unit,rangeofdraws) and not QREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_E].dmg()),0xffffffff)		
	--Ready (Q) + (W) + (E) + R		
	elseif GoS:ValidTarget(unit,rangeofdraws) and not QREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, 0, spellData[_R].dmg()),0xffffffff)
	end
	end	
end

function LaneClear(minion)
			for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do	
  if GoS:ValidTarget(minion, spellData[_W].range+50) then     
        if MonTourMenu.LaneClear.W:Value() and WREADY and MinionAround(GetOrigin(myHero), spellData[_W].range) >= MonTourMenu.LaneClear.WC:Value() and AuraofDespairOff and GoS:IsInDistance(minion, spellData[_W].range) and GoS:GetDistance(myHero, minion) > 50 and GoS:GetDistance(myHero, minion) <= spellData[_W].range then 
        CastTargetSpell(minion,_W) 
        elseif MonTourMenu.LaneClear.W:Value() and WREADY and MinionAround(GetOrigin(myHero), spellData[_W].range) <= MonTourMenu.LaneClear.WC2:Value() and AuraofDespairOn and not GoS:IsInDistance(minion, spellData[_W].range) and GoS:GetDistance(myHero, minion) > spellData[_W].range then 
        CastTargetSpell(minion,_W) 
        elseif MonTourMenu.LaneClear.E:Value() and EREADY and MinionAround(GetOrigin(myHero), spellData[_E].range) >= MonTourMenu.LaneClear.EC:Value() and GoS:IsInDistance(minion, spellData[_E].range) and GoS:GetDistance(myHero, minion) >= 10 and GoS:GetDistance(myHero, minion) <= spellData[_E].range then 
        CastTargetSpell(minion,_E) 
				end		
			end
  end    
end

function JungleClear(jminion)
			for i,jminion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
        jminionpos = GetOrigin(jminion)
  if GoS:ValidTarget(jminion, spellData[_Q].range+50) then 
    		if MonTourMenu.JungleClear.Q:Value() and QREADY and GoS:IsInDistance(jminion, spellData[_Q].range) and GoS:GetDistance(myHero, jminion) > spellData[_Q].range-spellData[_W].range then --GetRange(myHero)
        CastSkillShot(_Q,jminionpos.x,jminionpos.y,jminionpos.z)
        end  
        if MonTourMenu.JungleClear.W:Value() and WREADY and JMinionAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(jminion, spellData[_W].range) and GoS:GetDistance(myHero, jminion) > 50 and GoS:GetDistance(myHero, jminion) <= spellData[_W].range then 
        CastTargetSpell(jminion,_W) 
        elseif MonTourMenu.JungleClear.W:Value() and WREADY and JMinionAround(GetOrigin(myHero), spellData[_W].range) <= 0 and AuraofDespairOn and not GoS:IsInDistance(jminion, spellData[_W].range) and GoS:GetDistance(myHero, jminion) > spellData[_W].range then 
        CastTargetSpell(jminion,_W) 
        elseif MonTourMenu.JungleClear.E:Value() and EREADY and JMinionAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(jminion, spellData[_E].range) and GoS:GetDistance(myHero, jminion) >= 10 and GoS:GetDistance(myHero, jminion) <= spellData[_E].range then 
        CastTargetSpell(jminion,_E) 
				end		
			end
  end    
end

function Killsteal()
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy)
  local QDmg = spellData[_Q].dmg() or 0
 -- local WDmg = WREADY and spellData[_W].dmg() or 0
  local EDmg = spellData[_E].dmg() or 0
  local RDmg = spellData[_R].dmg() or 0
		if MonTourMenu.KS.E:Value() and GoS:ValidTarget(enemy, spellData[_E].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, EDmg) then
			  	if EREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(enemy, spellData[_E].range) and GoS:GetDistance(myHero, enemy) <= spellData[_E].range-30 and GoS:GetDistance(myHero, enemy) > 0 then 
        CastTargetSpell(enemy,_E)
          end
		elseif MonTourMenu.KS.Q:Value() and GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, QDmg) then
      local QPred = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(enemy), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
        if QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end  		
		elseif MonTourMenu.KS.R:Value() and GoS:ValidTarget(enemy, spellData[_R].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, RDmg) then
    if RREADY and GoS:IsInDistance(enemy, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= MonTourMenu.KS.RE:Value() then
        CastTargetSpell(enemy,_R)
    end
		elseif MonTourMenu.KS.QE:Value() and GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, EDmg + QDmg) then			
 		local QPred = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(enemy), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
		if QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end   
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > 50 and GoS:GetDistance(myHero, enemy) <= spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end    
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range+50) <= 0 and AuraofDespairOn and not GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end
  	if EREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(enemy, spellData[_E].range) and GoS:GetDistance(myHero, enemy) <= spellData[_E].range-30 and GoS:GetDistance(myHero, enemy) > 0 then 
        CastTargetSpell(enemy,_E)
    end
		elseif MonTourMenu.KS.QR:Value() and GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, RDmg + QDmg) then			
      local QPred = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(enemy), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
        if QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
      end  
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > 50 and GoS:GetDistance(myHero, enemy) <= spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end    
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range+50) <= 0 and AuraofDespairOn and not GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end
    if RREADY and GoS:IsInDistance(enemy, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= MonTourMenu.KS.RE2:Value() then
        CastTargetSpell(enemy,_R)
    end    
		elseif MonTourMenu.KS.QER:Value() and GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, 0, QDmg  + EDmg + RDmg) then			
 		local QPred = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(enemy), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
		if MonTourMenu.Harass.Q:Value() and QREADY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end   
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range) >= 1 and AuraofDespairOff and GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > 50 and GoS:GetDistance(myHero, enemy) <= spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end    
    if WREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_W].range+50) <= 0 and AuraofDespairOn and not GoS:IsInDistance(enemy, spellData[_W].range) and GoS:GetDistance(myHero, enemy) > spellData[_W].range then 
        CastTargetSpell(enemy,_W) 
    end
  	if EREADY and GoS:EnemiesAround(GetOrigin(myHero), spellData[_E].range) >= 1 and GoS:IsInDistance(enemy, spellData[_E].range) and GoS:GetDistance(myHero, enemy) <= spellData[_E].range-30 and GoS:GetDistance(myHero, enemy) > 0 then 
        CastTargetSpell(enemy,_E)
    end
    if RREADY and GoS:IsInDistance(enemy, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= MonTourMenu.KS.RE3:Value() then
        CastTargetSpell(enemy,_R)
    end	
		end
	end	
end

  function GLOBALULTNOTICE()
        if not RREADY then return end
        info1 = ""
        if RREADY then
       		for _,unit in pairs(GoS:GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = GoS:CalcDamage(myHero, unit, spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
                        if realdmg > hp then
                                info1 = info1..GetObjectName(unit)
                                if not GoS:IsInDistance(unit, spellData[_R].range) then
                                        info1 = info1.." not in Range but"                                                        
                                end
                                info1 = info1.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info1,MonTourMenu.Misc.MGUNSIZE:Value(),MonTourMenu.Misc.MGUNX:Value(),MonTourMenu.Misc.MGUNY:Value(),0xffff0000)                	
end

function GLOBALULTNOTICE2()
  if not RREADY then return end
       info = ""
        if RREADY then
       		for _,unit in pairs(GoS:GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        if GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range) == 1  then
                                info = "1 Enemy will be stunned"
                        elseif GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range) == 2  then
                                info = "2 Enemys will be stunned"  
                        elseif GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range) == 3  then
                                info = "3 Enemys will be stunned"  
                        elseif GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range) == 4  then
                                info = "4 Enemys will be stunned" 
                         elseif GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range) >= 5  then
                                info = "5 Enemys will be stunned"  
                        end        
 --                               info = info.." will be stunned \n"
                        
        		 end               
			end
		end		 
    DrawText(info,MonTourMenu.Misc.MGUNSIZE2:Value(),MonTourMenu.Misc.MGUNX2:Value(),MonTourMenu.Misc.MGUNY2:Value(),0xffff0000)                	
end

function GLOBALULTNOTICEDEBUG()	 
  if MonTourMenu.Misc.MGUNDEB:Value() then  
    DrawText("I am in Range but not killable - TESTMODE ON",MonTourMenu.Misc.MGUNSIZE:Value(),MonTourMenu.Misc.MGUNX:Value(),MonTourMenu.Misc.MGUNY:Value(),0xffff0000)  
  end 
    if MonTourMenu.Misc.MGUNDEB2:Value() then  
    DrawText("0 Enemys will be stunned - TESTMODE ON",MonTourMenu.Misc.MGUNSIZE2:Value(),MonTourMenu.Misc.MGUNX2:Value(),MonTourMenu.Misc.MGUNY2:Value(),0xffff0000)  
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

function JMinionAround(pos, range)
  local c = 0
  if pos == nil then return 0 end
  for k,v in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do 
    if v and GoS:ValidTarget(v) and GoS:GetDistanceSqr(pos,GetOrigin(v)) < range*range then
      c = c + 1
    end
  end
  return c
end

addInterrupterCallback(function(unit, spellType)
    local unit = GetCurrentTarget()
    for _,unit in pairs(GoS:GetEnemyHeroes()) do
    if spellType == CHANELLING_SPELLS and MonTourMenu.Interrupt.InterruptQ:Value() then
      local QPred = GetPredictionForPlayer(GetOrigin(myHero), unit, GetMoveSpeed(unit), spellData[_Q].speed, spellData[_Q].delay, spellData[_Q].range, spellData[_Q].width, true, true)
      if CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
      end
    elseif spellType == CHANELLING_SPELLS and MonTourMenu.Interrupt.InterruptR:Value() and CanUseSpell(myHero,_Q) ~= READY then  
      if CanUseSpell(myHero,_R) == READY and GoS:IsInDistance(unit, spellData[_R].range) and GoS:EnemiesAround(GetOrigin(myHero), spellData[_R].range-10) >= 1 then
        CastTargetSpell(unit,_R)
      end
    end
    end
end)
