local version = 4
--MonTour - MarCiii on Tour V2.0.0.7

-- Worktime for Leona = 10 Std
-- Worktime for Lux = 4 Days - It is much (just learning to code) but i want it perfect :) Lux has a much of Features
-- Worktime for Draven 5 Hours
-- Worktime for Aatrox 10 Hours
-- Worktime for Amumu 5 Hours
-- Worktime for Shaco 30 minutes

--Credits to Inspired, Deftsu, Platypus, Snowbell, TheWelder and ilovesona
--for some code ive used here for trying and learning :)

up=Updater.new("powerblobb/GoS-Scripts-for-LoL/master/MonTour.lua", "Common\\MonTour", version)
if up.newVersion() then 
	up.update() end

supportedHero = {["Leona"] = true ,["Lux"] = true ,["Draven"] = true ,["Aatrox"] = true ,["Amumu"] = true ,["Shaco"] = true}

require('IAC')  
myHero = GetMyHero()
myIAC = IAC()

minion = GetAllMinions(MINION_ENEMY)
unit = GetCurrentTarget()
mymouse = GetMousePos()
require('DLib') 

if supportedHero[GetObjectName(myHero)] == true then 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------- L E O N A ------------------------------------------------------------------------------------- L E O N A ------------------------------------------------------
---------------------------------------------------------------------------- L E O N A ------------------------------------------------------------------------------------------------
---------------------- L E O N A ------------------------------------------------------------------------------------- L E O N A ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Leona"
function Leona:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
  --OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
  --  return self
	self.spellData = 
	{
	[_Q] = {dmg = function () return 35 + 25*GetCastLevel(myHero,_Q) + 0.55*GetBonusAP(myHero) end,  
			mana = function () return 40 + 5*GetCastLevel(myHero,_Q) end,
			range = 400},  
	[_W] = {dmg = function () return 10 + 50*GetCastLevel(myHero,_W) + 0.4*GetBonusAP(myHero) end,  
			mana = 60,
			range = 600},
	[_E] = {dmg = function () return 20 + 40*GetCastLevel(myHero,_E) + 0.4*GetBonusAP(myHero) end, 
			mana = 100,			
			speed = 1900,
			delay = 500,			 			
			range = 875, 
			width = 70},
	[_R] = {dmg = function () return 50 + 100*GetCastLevel(myHero,_R) + 0.8*GetBonusAP(myHero) end, 
			mana = 100,			
			speed = 1900,
			delay = 500,			 			
			range = 1200, 
			width = 70},					
	}
  
  local root = menu.addItem(SubMenu.new("Leona on Tour"))
  local Combo = root.addItem(SubMenu.new("Combo"))
CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
CUseW = Combo.addItem(MenuBool.new("Use W",true))
CUseE = Combo.addItem(MenuBool.new("Use E",true))
CUseR = Combo.addItem(MenuBool.new("Use R",true))
ComboActive = Combo.addItem(MenuKeyBind.new("Combo", 32))
  
  local Harass= root.addItem(SubMenu.new("Harass"))
HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
HUseW = Harass.addItem(MenuBool.new("Use W",true))
HUseE = Harass.addItem(MenuBool.new("Use E",true))
HUseR = Harass.addItem(MenuBool.new("Use R",false))
HarassActive = Harass.addItem(MenuKeyBind.new("Harass", 67))  
  
  local KSmenu = root.addItem(SubMenu.new("Killsteal"))
KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", true))
KSW = KSmenu.addItem(MenuBool.new("Killsteal with W", true))
KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", true))
KSR = KSmenu.addItem(MenuBool.new("Killsteal with R", true))
KSEWQ = KSmenu.addItem(MenuBool.new("Killsteal with E W Q", true))  
KSEQR = KSmenu.addItem(MenuBool.new("Killsteal with E Q R", true))  
KSEWQR = KSmenu.addItem(MenuBool.new("Killsteal with E W Q R", true))    
  
  local Drawings = root.addItem(SubMenu.new("Drawings"))
DMGOVERHPBAR = Drawings.addItem(MenuBool.new("Draw DMG over HP", true))
  
  local Special = root.addItem(SubMenu.new("Special"))  
SpecialUSE = Special.addItem(MenuKeyBind.new("Perfect R", 78))  
    
  local Farm = root.addItem(SubMenu.new("Farm"))
LCW = Farm.addItem(MenuBool.new("Use W LaneClear",true))
LCWMINION = Farm.addItem(MenuSlider.new("W if X Minion in Around", 3, 0, 10, 1))
LaneClearActive = Farm.addItem(MenuKeyBind.new("LaneClear", 86))
  
--  local Misc= root.addItem(SubMenu.new("Misc"))
--  local MDraw = Misc.addItem(MenuBool.new("Use W",true))
--  local MKS = Misc.addItem(MenuBool.new("Use E",true))  
  
--if supportedHero[GetObjectName(myHero)] == true then
--	self.Config = scriptConfig("MonTourLeona", "Leona on Tour")
--		self.Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("R", "Use R in combo", SCRIPT_PARAM_ONOFF, true)	    
--  self.Config2 = scriptConfig("MonTourLeona2", "Leona MISC")
--		self.Config2.addParam("LCW", "Use W LaneClear", SCRIPT_PARAM_ONOFF, true)		
--		self.Config2.addParam("Draw", "DMGoHPBARs", SCRIPT_PARAM_ONOFF, true)
--		self.Config2.addParam("KS", "KillSteal QWER", SCRIPT_PARAM_ONOFF, true)				
--		self.Config2.addParam("U", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
-- end   
end

function Leona:Loop(myHero)
	self:Checks()
  self:Killsteal()
	if DMGOVERHPBAR.getValue() then 
		self:Draws()
	end
	if LaneClearActive.getValue() then
    	self:LaneClear(minion)
    end	
	if ComboActive.getValue() then
		self:Combo()
	end
	if HarassActive.getValue() then
		self:Harass()
	end
	
	if SpecialUSE.getValue() then
		self:Special()
	end	
  Globalfunc:DoWalk2()

end


function Leona:Draws()
local rangeofdraws = 20000
	for _,unit in pairs(GetEnemyHeroes()) do
	--Ready Q + W + E + R
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + W + (E) + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + self.spellData[_R].dmg()),0xffffffff)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WREADY and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_W].dmg()),0xffffffff)		
	--Ready Q + (W) + E + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.WREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.WREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.WREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.WREADY and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg()),0xffffffff)
	--Ready (Q) + W + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_W].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_W].dmg() + self.spellData[_E].dmg()),0xffffffff)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WREADY and not self.EREADY and self.RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_W].dmg() + self.spellData[_R].dmg()),0xffffffff)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WREADY and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_W].dmg()),0xffffffff)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.WREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.WREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg()),0xffffffff)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.WREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_R].dmg()),0xffffffff)
	end
	end	
end

function Leona:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GetTarget(1250, DAMAGE_MAGIC)
	self.targetDRAW = GetTarget(20000, DAMAGE_MAGIC)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	self.Qstack = GotBuff(myHero,"LeonaShieldOfDaybreak")
	self.Wstack = GotBuff(myHero,"LeonaSolarBarrier")
end

function Leona:CastPredE(unit)
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range-25, self.spellData[_E].width, false, true)
		if self.EREADY and EPred.HitChance == 1 then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
end

function Leona:CastQ(unit)
	if self.QREADY and IsInDistance(unit, 400) then 
		CastTargetSpell(unit,_Q)
	end
end

function Leona:CastW(unit)
	if self.WREADY and IsInDistance(unit, 600) then 
		CastTargetSpell(unit,_W)
	end
end

function Leona:CastPredR(unit)
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, true, true)
		if self.RREADY and RPred.HitChance == 1 then
			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end
end

function Leona:LaneClear(minion)
local eminion = CountMinions()
		if self.WREADY and LCW.getValue() then 
			for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do		
				if Globalfunc:MinionAround(myHeroPos, self.spellData[_W].range) >= LCWMINION.getValue() and IsInDistance(minion, 675) and ValidTarget(minion, 675) then 
					CastSpell(_W)
				end		
			end
		end
end
			
function Leona:Combo()
	if ValidTarget(self.target, self.spellData[_R].range+50) then
		if self.EREADY and CUseE.getValue() then
			self:CastPredE(self.target)
		elseif self.QREADY and CUseQ.getValue() then
			self:CastQ(self.target)	 
		elseif self.WREADY and CUseW.getValue() then
			self:CastW(self.target)	 
		elseif self.RREADY and CUseR.getValue() then
			self:CastPredR(self.target)			
		end	
	end
end

function Leona:Harass()
	if ValidTarget(self.target, self.spellData[_R].range+50) then
		if self.EREADY and HUseE.getValue() then
			self:CastPredE(self.target)
		elseif self.QREADY and HUseQ.getValue()  then
			self:CastQ(self.target)	 
		elseif self.WREADY and HUseW.getValue() then
			self:CastW(self.target)	 
		elseif self.RREADY and HUseR.getValue() then
			self:CastPredR(self.target)			
		end	
	end
end

function Leona:Special()
 IAC:Move()
	for i,enemy in pairs(GetEnemyHeroes()) do
	if ValidTarget(enemy, self.spellData[_R].range+50) then
		if self.RREADY then
			self:CastPredR(enemy)
		end	
	end
	end
end

function Leona:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
		if KSW.getValue() and ValidTarget(enemy, self.spellData[_W].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_W].dmg()) then
			self:CastW(enemy)
		elseif KSE.getValue() and ValidTarget(enemy, self.spellData[_E].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_E].dmg()) then
			self:CastPredE(enemy)
		elseif KSQ.getValue() and ValidTarget(enemy, self.spellData[_Q].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_Q].dmg()) then
			self:CastQ(enemy)		
		elseif KSE.getValue() and ValidTarget(enemy, self.spellData[_R].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_R].dmg()) then
			self:CastPredR(enemy)
		elseif KSEWQ.getValue() and ValidTarget(enemy, self.spellData[_E].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_E].dmg() + self.spellData[_W].dmg() + self.spellData[_Q].dmg()) then			
			self:CastPredE(enemy) DelayAction(function() self:CastW(enemy) DelayAction(function() self:CastQ(enemy) end, 125) end, 250)
		elseif KSEQR.getValue() and ValidTarget(enemy, self.spellData[_R].range+50) and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()) then			
			self:CastPredE(enemy) DelayAction(function() self:CastQ(enemy) DelayAction(function() self:CastPredR(enemy) end, 125) end, 250)			
		elseif KSEWQR.getValue() and ValidTarget(enemy, self.spellData[_R].range+50) and enemyhp < CalcDamage(myHero, enemy, 0	, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()) then			
			self:CastPredE(enemy) DelayAction(function() self:CastW(enemy) DelayAction(function() self:CastQ(enemy) DelayAction(function() self:CastPredR(enemy) end, 125) end, 250) end, 375)		
		end
	end	
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------- L U X ------------------------------------------------------------------------------------- L U X --------------------------------------------------------------
-------------------------------------------------------------------------- L U X ----------------------------------------------------------------------------------------------------
-------------------- L U X ------------------------------------------------------------------------------------- L U X --------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Lux"
function Lux:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
	self.spellData = 
	{
	[_Q] = {dmg = function () return 10 + GetCastLevel(myHero,_Q) * 50 + GetBonusAP(myHero)*0.75 end,  
			mana = function () return 40 + GetCastLevel(myHero,_Q) * 10 end,
			speed = 1100,
			delay = 250,			 			
			range = 1175, 
			width = 60},			  
	[_W] = {dmg = function () return 10 + GetCastLevel(myHero,_Q)*0 end, 
			shield = function () return 0 end,	 
			mana = function () return 60 end,
			speed = 1100,
			delay = 250,			 			
			range = 1000, 
			width = 75},			
	[_E] = {dmg = function () return 15 + GetCastLevel(myHero, _E) * 45 + GetBonusAP(myHero)*0.6 end, 
			mana = function () return 55 + GetCastLevel(myHero,_E) * 15 end,			
			speed = 1300,
			delay = 250,			 			
			range = 1100, 
			width = 340},
	[_R] = {dmg = function () return 200 + GetCastLevel(myHero,_R) * 100 + GetBonusAP(myHero) * 0.75 end, 
			mana = function () return 100 end,		
			speed = math.huge,
			delay = 1000,			 			
			range = 3340, 
			width = 190},					
	}
  
  local root = menu.addItem(SubMenu.new("Lux on Tour"))
  local Combo = root.addItem(SubMenu.new("Combo"))
CUseQ = Combo.addItem(MenuBool.new("Use Q",true))
CUseE = Combo.addItem(MenuBool.new("Use E",true))
CUseR = Combo.addItem(MenuBool.new("Use R",false))
CUseRkill = Combo.addItem(MenuBool.new("Use R for Kill in Combo",true))
ComboActive = Combo.addItem(MenuKeyBind.new("Combo", 32))
  
  local Harass= root.addItem(SubMenu.new("Harass"))
HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
HUseE = Harass.addItem(MenuBool.new("Use E",true))
HUseR = Harass.addItem(MenuBool.new("Use R",true))
HarassActive = Harass.addItem(MenuKeyBind.new("Harass", 67))  
  
  local KSmenu = root.addItem(SubMenu.new("Killsteal"))
KSQ = KSmenu.addItem(MenuBool.new("Killsteal with Q", false))
KSE = KSmenu.addItem(MenuBool.new("Killsteal with E", false))
KSR = KSmenu.addItem(MenuBool.new("Killsteal with R", false))
KSQE = KSmenu.addItem(MenuBool.new("Killsteal with Q E", false)) 
KSQR = KSmenu.addItem(MenuBool.new("Killsteal with Q R", false)) 
KSER = KSmenu.addItem(MenuBool.new("Killsteal with E R", false)) 
KSQER = KSmenu.addItem(MenuBool.new("Killsteal with Q E R", false))   
  
  local Drawings = root.addItem(SubMenu.new("Drawings"))
DMGOVERHPBAR = Drawings.addItem(MenuBool.new("Draw DMG over HP", true))
  
  local Special = root.addItem(SubMenu.new("Special&Shield"))  
SpecialUSE = Special.addItem(MenuKeyBind.new("Perfect R", 78)) 
AEOFFCAST = Special.addItem(MenuBool.new("Auto E Offcast",false))
UseShield = Special.addItem(MenuBool.new("AutoShield",true))
UseWShieldAlly = Special.addItem(MenuSlider.new("AutoShield Ally if HP < x%", 20, 1, 80, 1))
UseWShieldMe = Special.addItem(MenuSlider.new("AutoShield Me if HP < x%", 20, 1, 80, 1))
    
  local Farm = root.addItem(SubMenu.new("Farm/Jungle"))
LCE = Farm.addItem(MenuBool.new("Use E LaneClear",false))
LCEMINION = Farm.addItem(MenuSlider.new("E if X Minion Around Target", 3, 1, 10, 1))
LCEJUNGLE = Farm.addItem(MenuBool.new("Use E JungleClear",true))
LaneClearActive = Farm.addItem(MenuKeyBind.new("Lane/JungleClear", 86))

  local JungleSteal = root.addItem(SubMenu.new("JungleSteal"))
KSBaron = JungleSteal.addItem(MenuBool.new("Use R Baron",true))
KSDragon = JungleSteal.addItem(MenuBool.new("Use R Dragon",true))
KSBlue = JungleSteal.addItem(MenuBool.new("Use R Blue",false))
KSRed = JungleSteal.addItem(MenuBool.new("Use R Red",false))
KSKrug = JungleSteal.addItem(MenuBool.new("Use E Krug",false))
KSWolf = JungleSteal.addItem(MenuBool.new("Use E Wolf",false))
KSwraiths = JungleSteal.addItem(MenuBool.new("Use E Wraiths",false))
KSgromp = JungleSteal.addItem(MenuBool.new("Use E Gromp",false))
KScrab = JungleSteal.addItem(MenuBool.new("Use E Crab",false))

  local Misc = root.addItem(SubMenu.new("Misc"))  
MGUN = Misc.addItem(MenuBool.new("Ultimate Notifier",true))
MALVL = Misc.addItem(MenuBool.new("AutoLevelUp Skills",false))


  --OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)

--	self.Config = scriptConfig("MonTourLux", "Lux on Tour")
--		self.Config.addParam("Q", "Q in combo", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("E", "E in combo", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("R", "R in combo", SCRIPT_PARAM_ONOFF, false)
--		self.Config.addParam("KSQ", "Auto Q for kill", SCRIPT_PARAM_ONOFF, false)
--		self.Config.addParam("KSE", "Auto E for kill", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("KSQE", "Auto QE for kill", SCRIPT_PARAM_ONOFF, false)
--		self.Config.addParam("KSER", "Auto ER for kill", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("KSQER", "Auto QER for kill", SCRIPT_PARAM_ONOFF, false)	
--		self.Config.addParam("W", "AutoShield Ally/Me", SCRIPT_PARAM_ONOFF, true)				
--		self.Config.addParam("LCW", "Use E LaneClear", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("KSR", "Auto R for kill", SCRIPT_PARAM_ONOFF, true)				
--		self.Config.addParam("Draw", "DMGBAR ON/OFF", SCRIPT_PARAM_ONOFF, true)						
--		self.Config.addParam("EAutoOFF", "Auto E Offcast", SCRIPT_PARAM_ONOFF, false)
--		self.Config.addParam("RN", "Ultimate Notifier", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("AL", "AutoLvLSkillsUp", SCRIPT_PARAM_ONOFF, false)										
--		self.Config.addParam("U", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
end


function Lux:Loop(myHero)		
	self:Checks()
	
	if ComboActive.getValue() then
		self:Combo()
	end
	if HarassActive.getValue() then
		self:Harass()
	end
	
	if MGUN.getValue() then
		self:GLOBALULTNOTICE()
	end
  if UseShield.getValue() then
  self:CastPredWforShield()
end

	if AEOFFCAST.getValue() then
		self:CastPredEOFF(unit)
	end
  
	if DMGOVERHPBAR.getValue() then 
		self:Draws()
	end

	if LaneClearActive.getValue() then
      if LCE.getValue() then
    	self:LaneClear(minion)
      end
      if LCEJUNGLE.getValue() then
    	self:JungleClear(minionj) 
      end
  end	
  
	if SpecialUSE.getValue() then
		self:Special()
	end	
	
	if MALVL.getValue() then
		self:AutoLvL()
	end
	
	self:OnProcessSpellJungle()
	self:Killsteal()
  Globalfunc:DoWalk()

end

function Lux:OnProcessSpellJungle(mob)
  for _,mob in pairs(GetAllMinions(MINION_JUNGLE)) do
    local RDmg = self.spellData[_R].dmg() or 0
    local EDmg = self.spellData[_E].dmg() or 0    
    local DamageR = CalcDamage(myHero, mob, 0, RDmg)
    local DamageE = CalcDamage(myHero, mob, 0, EDmg)    
    local mobPos = GetOrigin(mob)
	  if IsInDistance(mob, GetCastRange(myHero,_R)) and self.RREADY and GetObjectName(mob) == "SRU_Baron" and KSBaron.getValue() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z)
	  elseif IsInDistance(mob, GetCastRange(myHero,_R)) and self.RREADY and GetObjectName(mob) == "SRU_Dragon" and KSDragon.getValue() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z) 
    elseif IsInDistance(mob, GetCastRange(myHero,_R)) and self.RREADY and GetObjectName(mob) == "SRU_Blue" and KSBlue.getValue() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z)
    elseif IsInDistance(mob, GetCastRange(myHero,_R)) and self.RREADY and GetObjectName(mob) == "SRU_Red" and KSRed.getValue() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z) 
    elseif IsInDistance(mob, GetCastRange(myHero,_E)) and self.RREADY and GetObjectName(mob) == "SRU_Krug" and KSKrug.getValue() and GetCurrentHP(mob) < DamageE then
					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z) 
    elseif IsInDistance(mob, GetCastRange(myHero,_E)) and self.RREADY and GetObjectName(mob) == "SRU_Murkwolf" and KSWolf.getValue() and GetCurrentHP(mob) < DamageE then
					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)    
    elseif IsInDistance(mob, GetCastRange(myHero,_E)) and self.RREADY and GetObjectName(mob) == "SRU_Razorbeak" and KSwraiths.getValue() and GetCurrentHP(mob) < DamageE then
					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)  
    elseif IsInDistance(mob, GetCastRange(myHero,_E)) and self.RREADY and GetObjectName(mob) == "SRU_Gromp" and KSgromp.getValue() and GetCurrentHP(mob) < DamageE then
					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z) 
    elseif IsInDistance(mob, GetCastRange(myHero,_E)) and self.RREADY and GetObjectName(mob) == "Sru_Crab" and KScrab.getValue() and GetCurrentHP(mob) < DamageE then
					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)                  
    end
  end
 end 

function Lux:AutoLvL()
if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
end
if GetLevel(myHero) == 2 then
	LevelSpell(_E)
end
if GetLevel(myHero) == 3 then
	LevelSpell(_W)
  LevelSpell(_Q)
  LevelSpell(_E)
end 
if GetLevel(myHero) == 4 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 5 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 6 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 7 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 8 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 9 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 10 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 11 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 12 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 13 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 14 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 15 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 16 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 17 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 18 then
	LevelSpell(_W)
end
end

function Lux:Draws()
local rangeofdraws = 20000
	for _,unit in pairs(GetEnemyHeroes()) do		
	--Ready Q + (W) + E + R			
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg()),0xffffffff)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg()),0xffffffff)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_R].dmg()),0xffffffff)
	end
	end	
end

function Lux:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GetTarget(3450, DAMAGE_MAGIC)
	self.targetDRAW = GetTarget(20000, DAMAGE_MAGIC)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	minionPos = GetOrigin(minion)	
	self.Estack0 = GotBuff(myHero,"LuxLightStrikeKugel") == 0
	self.Estack1 = GotBuff(myHero,"LuxLightStrikeKugel") == 1	
	self.WbuffSelf = GotBuff(myHero,"luxprismaticwaveshieldself")
	self.EnemyPassive = GotBuff(unit,"luxilluminatingfraulein") == 1	
	self.EnemyQstack0 = GotBuff(unit,"LuxLightBindingMis") == 0
	self.EnemyQstack1 = GotBuff(unit,"LuxLightBindingMis") == 1
	
end

function Lux:CastPredQ(unit)
		local QPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, true, true)
		if QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
end

function Lux:CastPredQkill(unit)
		local QPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, true, true)
		if QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
end

function Lux:CastPredE(unit)
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
		if EPred.HitChance == 1 then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		elseif self.Estack1 then
				CastSpell(_E)			
		end
end

function Lux:CastPredEkill(unit)
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
		if EPred.HitChance == 1 then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		elseif self.Estack1 then
				CastSpell(_E)			
		end
end

function Lux:CastPredEkill2(unit)
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
		if EPred.HitChance == 1 and self.EnemyQstack1 and IsObjectAlive(unit) then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		elseif self.Estack1 then
				CastSpell(_E)			
		end
end

function Lux:CastPredEOFF()
	local unitPos = GetOrigin()
		if self.Estack1 then
			CastSpell(_E)			
		end
end

function Lux:CastPredR(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, false)
		if RPred.HitChance == 1 then
      HoldPosition()
			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end
	end		
end

function Lux:CastPredRkill(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, false)
		if RPred.HitChance == 1 and IsObjectAlive(unit) then
      HoldPosition()
			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end	
	end		
end

function Lux:CastPredRkill2(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, false)
		if RPred.HitChance == 1 and self.EnemyQstack1 and IsObjectAlive(unit) then
      HoldPosition()
			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end	
	end		
end

function Lux:CastPredRSpecial(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, false)
		if self.RREADY and RPred.HitChance == 1 then
      HoldPosition()
			CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		end	
	end		
end


function Lux:CastPredWforShield()
	for _, ally in pairs(GetAllyHeroes()) do
	for i,unit in pairs(GetEnemyHeroes()) do	
	local WPred = GetPredictionForPlayer(myHeroPos,ally,GetMoveSpeed(ally), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, false)	
		if (GetCurrentHP(ally)/GetMaxHP(ally)) < (UseWShieldAlly.getValue()/100) and self.WREADY and IsInDistance(ally, self.spellData[_W].range-5) and ValidTarget(unit, self.spellData[_W].range+700) then 
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		if (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (UseWShieldMe.getValue()/100) and self.WREADY and IsInDistance(unit, 650) then --and ValidTarget(unit, 650) and IsInDistance(unit, 650) then <0.3 
			CastSpell(_W) --			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)			
		end
	end
	end	
end

function Lux:LaneClear(minion)
	local EPred = GetPredictionForPlayer(myHeroPos, minion, GetMoveSpeed(minion), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true) 	
		if self.WREADY then --and EPred.HitChance == 1 
			for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do
				local EPred = GetPredictionForPlayer(myHeroPos, minion, GetMoveSpeed(minion), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
				local eminion = CountMinions(minion)
				local minionPos = GetOrigin(minion) 
        if IsInDistance(minion, self.spellData[_E].range) then--and ValidTarget(minion, self.spellData[_E].range-15) then 
				if Globalfunc:MinionAround(minionPos, 350) >= LCEMINION.getValue() then				
					CastSkillShot(_E,minionPos.x,minionPos.y,minionPos.z)
					end
				end
				if self.Estack1 then
				CastSpell(_E)					
				end	
			end
		end
end

function Lux:JungleClear(minionj)
	local EPred = GetPredictionForPlayer(myHeroPos, minionj, GetMoveSpeed(minionj), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true) 	
		if self.WREADY then --and EPred.HitChance == 1 
			for i,minionj in pairs(GetAllMinions(MINION_JUNGLE)) do
				local EPred = GetPredictionForPlayer(myHeroPos, minionj, GetMoveSpeed(minionj), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
				local eminionj = CountMinions(minionj)
				local minionPosj = GetOrigin(minionj) 
        if IsInDistance(minionj, self.spellData[_E].range) and ValidTarget(minionj, self.spellData[_E].range) then 			
					CastSkillShot(_E,minionPosj.x,minionPosj.y,minionPosj.z)
				end
				if self.Estack1 then
				CastSpell(_E)					
				end	
			end
		end
end
			
function Lux:Combo()
  for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
  local RDmg = self.RREADY and self.spellData[_R].dmg() or 0
	if ValidTarget(self.target, self.spellData[_E].range+20) then
		if self.QREADY and CUseQ.getValue()  then
			self:CastPredQ(self.target)
		elseif self.EREADY and CUseE.getValue() then
			self:CastPredE(self.target)	 
		elseif self.RREADY and CUseR.getValue() then
			self:CastPredR(self.target)	 
    elseif self.RREADY and CUseRkill.getValue() and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_R].range) and IsObjectAlive(enemy) and enemyhp < CalcDamage(myHero, enemy, 0, RDmg) then
			self:CastPredRkill(enemy)	
		end	
    end
	end
end

function Lux:Harass()
	if ValidTarget(self.target, self.spellData[_E].range) then
		if self.QREADY and HUseQ.getValue()  then
			self:CastPredQ(self.target)
		elseif self.EREADY and HUseE.getValue()then
			self:CastPredE(self.target)	 
		elseif self.RREADY and HUseR.getValue() then
			self:CastPredR(self.target)	 			
		end	
	end
end

function Lux:Special()
 Globalfunc:Move()
	for i,enemy in pairs(GetEnemyHeroes()) do
	if ValidTarget(enemy, self.spellData[_R].range) then
		if self.RREADY and IsTargetable(unit) and IsObjectAlive(unit) then
			self:CastPredRSpecial(enemy)
		end	
	end
	end
end

function Lux:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
	local QDmg = self.QREADY and self.spellData[_Q].dmg() or 0
    local WDmg = self.WREADY and self.spellData[_W].dmg() or 0
    local EDmg = self.EREADY and self.Estack0 and self.spellData[_E].dmg() or 0
    local RDmg = self.RREADY and self.spellData[_R].dmg() or 0
	local igotmana = GetCurrentMana(myHero)
	local Qmana = self.spellData[_Q].mana() 
	local Emana = self.spellData[_E].mana()
	local Rmana = self.spellData[_R].mana()				 				
		local QPred = GetPredictionForPlayer(myHeroPos, enemy, GetMoveSpeed(enemy), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range-10, self.spellData[_Q].width, true, true)	
		if KSQ.getValue() and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, QDmg) and igotmana >= Qmana then
			self:CastPredQ(enemy)
		elseif KSE.getValue() and ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, 0, EDmg) and igotmana >= Emana  then
			self:CastPredEkill(enemy)	
		elseif KSR.getValue() and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_R].range) and enemyhp < CalcDamage(myHero, enemy, 0, RDmg) and igotmana >= Rmana then
			self:CastPredRkill(enemy)
		elseif KSQE.getValue() and ValidTarget(enemy, self.spellData[_Q].range)  and enemyhp < CalcDamage(myHero, enemy, 0, QDmg + EDmg) and igotmana >= Qmana + Emana then			
			self:CastPredQkill(enemy) DelayAction(function() self:CastPredEkill2(enemy) end, 125)
		elseif KSQR.getValue() and ValidTarget(enemy, self.spellData[_Q].range) and QPred.HitChance == 1 and enemyhp < CalcDamage(myHero, enemy, 0, QDmg + RDmg)  and igotmana >= Qmana + Rmana then			
			self:CastPredQkill(enemy) DelayAction(function() self:CastPredRkill2(enemy) end, 125)
		elseif KSER.getValue() and ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, 0, EDmg + RDmg)  and igotmana >= Emana + Rmana then			
			self:CastPredEkill(enemy) DelayAction(function() self:CastPredRkill(enemy) end, 125)						
		elseif KSQER.getValue() and ValidTarget(enemy, self.spellData[_Q].range)and QPred.HitChance == 1 and enemyhp < CalcDamage(myHero, enemy, 0, QDmg + EDmg + RDmg) and igotmana >= Qmana + Emana + Rmana then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredEkill2(enemy) DelayAction(function() self:CastPredRkill2(enemy) DelayAction(function() end, 125) end, 325) end, 550) --self:CastEOFF(enemy)					
		end
	end	
end

function Lux:GLOBALULTNOTICE()
        if not self.RREADY then return end
        info = ""
        if self.RREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, self.spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not ValidTarget(unit, self.spellData[_R].range) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,30,60,200,0xffff0000)                	
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------- D R A V E N ------------------------------------------------------------------------------------- D R A V E N --------------------------------------------------
---------------------------------------------------------------------------- D R A V E N ----------------------------------------------------------------------------------------------
---------------------- D R A V E N ------------------------------------------------------------------------------------- D R A V E N --------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Draven"
function Draven:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
	self.spellData = 
	{
	[_Q] = {dmg = function () return (GetBonusDmg(myHero)+GetBaseDamage(myHero))*(0.35 + GetCastLevel(myHero,_Q)*0.1) end,  
			CDR = function () return GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)) end,
			mana = 45,
			range = 600},  
	[_W] = {dmg = function () return 0 end,  
			mana = 40,
			range = 600},
	[_E] = {dmg = function () return 35 + 35*GetCastLevel(myHero,_E) + 0.5*GetBonusDmg(myHero) end, 
			mana = 70,			
			speed = 1600,
			delay = 250,			 			
			range = 1050, 
			width = 70},
	[_R] = {dmg = function () return 75 + 100*GetCastLevel(myHero,_R) + 1.1*GetBonusDmg(myHero) end, 
			mana = 120,			
			speed = 2000,
			delay = 1000,			 			
			range = 20000, 
			width = 80},					
	}

	self.Config = scriptConfig("MonTourDraven", "Draven on Tour")
		self.Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("LCQ", "Use Q LaneClear", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("LCJQ", "Use Q JungleClear", SCRIPT_PARAM_ONOFF, true)		
		self.Config.addParam("AL", "AutoLvLSkillsUp", SCRIPT_PARAM_ONOFF, true)			
		self.Config.addParam("LHQ", "Use Q LastHit", SCRIPT_PARAM_ONOFF, true)				
		self.Config.addParam("R", "KillSteal R", SCRIPT_PARAM_ONOFF, true)		
		self.Config.addParam("Draw", "DMGoHPBARs", SCRIPT_PARAM_ONOFF, true)	
		self.Config.addParam("KSER", "KillSteal ON/OFF", SCRIPT_PARAM_ONOFF, true)	
		self.Config.addParam("RN", "Ultimate Notifier", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("QAA", "Draw QAA Text", SCRIPT_PARAM_ONOFF, true)									
		self.Config.addParam("U", "Gapclose E", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
require('Baseult')		
end

function Draven:Loop(myHero)
	self:Checks()
	if self.Config.Draw then 
		self:Draws()
	end
	if _G.IWalkConfig.LastHit then
    	self:LastHit(minion)
    end	
	if _G.IWalkConfig.LaneClear then
    	self:LaneClear(minion)
      self:JungleClear(jminion)
    end	
	if _G.IWalkConfig.Combo then
		self:Combo()
	end
	if _G.IWalkConfig.Harass then
		self:Harass()
	end
	if self.Config.U then
		self:Special()
	end	
	if self.Config.RN then
		self:GLOBALULTNOTICE()
	end	
	if self.Config.QAA then
		self:QAA()
	end	
	if self.Config.KSER then
		self:Killsteal()
	end	
	if self.Config.AL then
		self:AutoLvL()
	end	

end



function Draven:QAA()
	for i,unit in pairs(GetEnemyHeroes()) do
		local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
		local unitPos = GetOrigin(unit)
		local dmgE = self.spellData[_Q].dmg() + TotalDmg	
		local dmg = CalcDamage(myHero, unit, dmgE)
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
        if dmg > 0 then 
          DrawText(math.ceil(hp/dmg).." QAA", 15, hPos.x+45, hPos.y+20, 0xffffffff)
	 	end 	
end
end

function Draven:Draws()
local rangeofdraws = 20000
local Alldmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	for _,unit in pairs(GetEnemyHeroes()) do			
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + Alldmg, 0),0xffffffff)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QSpinn1 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + Alldmg, 0),0xffffffff)
	end		
	end
end

function Draven:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GetTarget(1250, DAMAGE_PHYSICAL)
	self.targetDRAW = GetTarget(20000, DAMAGE_PHYSICAL)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	self.Q0 = GotBuff(myHero,"dravenspinningattack") == 0	
	self.Q1 = GotBuff(myHero,"dravenspinningattack") == 1
	self.Q2 = GotBuff(myHero,"dravenspinningattack") == 2
	self.QL0 = GotBuff(myHero,"dravenspinningleft") == 0	
	self.QL1 = GotBuff(myHero,"dravenspinningleft") == 1		
	self.QSpinn0 = GotBuff(myHero,"DravenSpinning") == 0	
	self.QSpinn1 = GotBuff(myHero,"DravenSpinning") == 1
  self.enemygotbansheesveil = GotBuff(unit,"bansheesveil") == 1 
end

function Draven:PassiveGetGold()
	if ValidTarget(self.target, self.spellData[_Q].range) then
		if self.QREADY and IsTargetable(unit) then
			self:CastQ(self.target)					
		end	
	end
end

function Draven:LastHit(minion)
local eminion = CountMinions()
	for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do
		if self.QREADY and self.Config.LHQ then
			if self.QSpinn0 and self.Q0 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100) then			
				CastSpell(_Q) 
			end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100) then
			end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100)then	
			end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100)then	
			end
		end
	end
end

function Draven:LaneClear(minion)
local eminion = CountMinions()
	for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do   
		if self.QREADY and self.Config.LCQ then
			if self.QSpinn0 and self.Q0 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100) then			
				CastSpell(_Q) 
			end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100) then
			
			end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100)then	
				
			end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(minion, self.spellData[_Q].range+100) and ValidTarget(minion, self.spellData[_Q].range+100)then	
        
      end
      end
	end
end

function Draven:JungleClear(jminion)
		for i,jminion in pairs(GetAllMinions(MINION_JUNGLE)) do
      if self.QREADY and self.Config.LCJQ then
			if self.QSpinn0 and self.Q0 and IsInDistance(jminion, self.spellData[_Q].range+100) and ValidTarget(jminion, self.spellData[_Q].range+100) then			
				CastSpell(_Q)
      end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(jminion, self.spellData[_Q].range+100) and ValidTarget(jminion, self.spellData[_Q].range+100) then
			-- DelayAction(function() AttackUnit(jminion) end, 100) 
      end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(jminion, self.spellData[_Q].range+100) and ValidTarget(jminion, self.spellData[_Q].range+100)then	
		--	DelayAction(function() AttackUnit(jminion) end, 100) 
      end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(jminion, self.spellData[_Q].range+100) and ValidTarget(jminion, self.spellData[_Q].range+100)then	
			--	 DelayAction(function() AttackUnit(jminion) end, 100) 
    end
    end
		end		
end

  function Draven:Move()
    local movePos = GenerateMovePos()
    if GetDistance(GetMousePos()) > GetHitBox(myHero) then
      MoveToXYZ(movePos.x, GetMyHeroPos().y, movePos.z)
    end
  end


function Draven:CastPredE(unit)
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range-25, self.spellData[_E].width, false, true)
		if self.EREADY and IsTargetable(unit) and self.Config.E and EPred.HitChance == 1 then
			if GetDistance(myHero, unit) > self.spellData[_Q].range and GetDistance(myHero, unit) <= self.spellData[_E].range then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end		
end

function Draven:CastPredEBanshe(unit)
  for _,unit in pairs(GetEnemyHeroes()) do 
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range-25, self.spellData[_E].width, false, true)
		if self.EREADY and IsTargetable(unit) and self.Config.E and EPred.HitChance == 1 then
			if GetDistance(myHero, unit) > self.spellData[_Q].range and GetDistance(myHero, unit) <= self.spellData[_E].range then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end	
    end
end

function Draven:CastQ(unit)
       	for _,unit in pairs(GetEnemyHeroes()) do
       	if self.QREADY and IsTargetable(unit) and self.Config.Q then
			if self.QSpinn0 and self.Q0 and IsInDistance(unit, self.spellData[_Q].range+100) and ValidTarget(unit, self.spellData[_Q].range+100) then			
				CastSpell(_Q)
			end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(unit, self.spellData[_Q].range+100) and ValidTarget(unit, self.spellData[_Q].range+100) then
			end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(unit, self.spellData[_Q].range+100) and ValidTarget(unit, self.spellData[_Q].range+100)then			
			end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(unit, self.spellData[_Q].range+100) and ValidTarget(unit, self.spellData[_Q].range+100)then			
			end
		end				
		end
end

function Draven:CastW(unit)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = self.spellData[_Q].mana
	local Wmana = self.spellData[_W].mana
  for _,unit in pairs(GetEnemyHeroes()) do
	if self.WREADY and IsTargetable(unit) and self.Config.W and igotmana >= Qmana + Wmana then
	 	if ValidTarget(self.target, self.spellData[_Q].range*1.7) and GetDistance(myHero, unit) > self.spellData[_Q].range+50 and  GetDistance(myHero, unit) < self.spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
	end
  end
end

function Draven:CastWnoMana(unit)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = self.spellData[_Q].mana
	local Wmana = self.spellData[_W].mana
	if self.WREADY and IsTargetable(unit) and self.Config.W then
	 	if ValidTarget(self.target, self.spellData[_Q].range*1.7) and GetDistance(myHero, unit) > self.spellData[_Q].range+50 and  GetDistance(myHero, unit) < self.spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
	end
end

function Draven:CastPredR(unit)
	local unitPos = GetOrigin(unit)
	local RPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, true)
		if self.Config.R and IsTargetable(unit) then --and self.Wstack
				if GetDistance(myHero, unit) > 750 and GetDistance(myHero, unit) < 3000 and IsObjectAlive(unit) then		
			if self.RREADY and RPred.HitChance == 1 then
				CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
				end
			end
		end		
end

			
function Draven:Combo()
		if self.QREADY then
		self:CastQ(self.target)					
		elseif self.WREADY then
		self:CastW(self.target)	 
    elseif self.EREADY and self.enemygotbansheesveil then
    self:CastPredEBanshe(unit)
		end
end	
function Draven:Harass()
		if self.QREADY then
		self:CastQ(self.target)
    elseif self.EREADY and self.enemygotbansheesveil then
    self:CastPredEBanshe(unit)    
		end
end

function Draven:Special()
 IAC:Move()
	for i,enemy in pairs(GetEnemyHeroes()) do
	if ValidTarget(enemy, self.spellData[_E].range) then
		if self.EREADY and IsTargetable(enemy) then
			self:CastPredE(enemy)
		end	
	end
	end
end

function Draven:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local QDmg = self.QREADY and self.spellData[_Q].dmg() or 0
	local QDmg2 = self.spellData[_Q].dmg() or 0	
    local EDmg = self.EREADY and self.spellData[_E].dmg() or 0
    local RDmg = self.RREADY and self.spellData[_R].dmg() or 0
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
	local Alldmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	local unitPos = GetOrigin(enemy)
--	local MoveToUnit = MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
		if ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, EDmg, 0) then
			self:CastPredE(enemy)
		elseif ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, QDmg + Alldmg, 0) then
			self:CastQ(enemy)
		elseif ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, QDmg2 + Alldmg, 0) and self.QSpinn1 then          
		elseif ValidTarget(enemy, self.spellData[_R].range) and enemyhp < CalcDamage(myHero, enemy, RDmg, 0) then
			self:CastPredR(enemy)
		elseif ValidTarget(enemy, self.spellData[_E].range) and GetDistance(myHero, enemy) > 550 and GetDistance(myHero, enemy) < 700 and enemyhp < CalcDamage(myHero, enemy, QDmg + Alldmg + EDmg, 0) then		
			self:CastPredE(enemy) DelayAction(function() self:CastWnoMana(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 100) end, 200) end, 300)
		elseif ValidTarget(enemy, self.spellData[_E].range) and GetDistance(myHero, enemy) > 550 and GetDistance(myHero, enemy) < 700 and enemyhp < CalcDamage(myHero, enemy, QDmg2 + Alldmg + EDmg, 0) and self.QSpinn1 then			
			self:CastPredE(enemy) DelayAction(function() self:CastWnoMana(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 100) end, 200) end, 300)				
		end	
	end	
end

function Draven:AttackUnitKS(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do  
  if IsTargetable(enemy) and IsInDistance(enemy, GetRange(myHero)) and GetDistance(myHero, enemy) <= (GetRange(myHero)-10) and GetDistance(myHero, enemy) >= 10 then 
    AttackUnit(enemy)
  end
  end
end

function Draven:GLOBALULTNOTICE()
        if not self.RREADY then return end
        info = ""
        if self.RREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, self.spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe"                                                        
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,30,60,200,0xffff0000)                	
end

function Draven:AutoLvL()
if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
end
if GetLevel(myHero) == 2 then
	LevelSpell(_E)
end
if GetLevel(myHero) == 3 then
	LevelSpell(_W)
end 
if GetLevel(myHero) == 4 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 5 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 6 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 7 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 8 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 9 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 10 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 11 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 12 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 13 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 14 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 15 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 16 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 17 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 18 then
	LevelSpell(_E)
end
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------- A T R O X ------------------------------------------------------------------------------------- A T R O X ------------------------------------------------------
-------------------------------------------------------------------------- A T R O X ------------------------------------------------------------------------------------------------
-------------------- A T R O X ------------------------------------------------------------------------------------- A T R O X ------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Aatrox"
function Aatrox:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
	self.spellData = 
	{
	[_Q] = {dmg = function () return 25 + GetCastLevel(myHero,_Q) * 45 + GetBonusDmg(myHero)*0.60 end,  
			costhealth = function () return GetMaxHP(myHero)/100*10 end, --GetCurrentHP(myHero)
			speed = math.huge,
			delay = 550,			 			
			range = 650, 
			width = 200},			  
	[_W] = {dmg = function () return 25 + GetCastLevel(myHero,_W) * 35 + GetBonusDmg(myHero) end,  ---Bonus Schaden bei Aktiviert
			costhealth = function () return 0.25 * GetBonusDmg(myHero) + 8.75 + GetCastLevel(myHero,_W) * 6.25 end,	 --Lebenskosten beim 3. Angriff bei Aktiviert
			gethealth = function () return 5 + 15 * GetCastLevel(myHero,_W) + 0.25 * GetBonusDmg(myHero) end,    --Heilung bei Deaktiviert
      gethealth50 = function () return 15 + 25 * GetCastLevel(myHero,_W) + 0.75 * GetBonusDmg(myHero) end, --Erweiterte Heilung bei Deaktiviert
			speed = 1100,
			delay = 250,			 			
			range = 0, 
			width = 0},			
	[_E] = {dmg = function () return 35 + GetCastLevel(myHero, _E) * 40 + GetBonusDmg(myHero) * 0.6 + GetBonusAP(myHero) * 0.6 end, 
			costhealth = function () return GetCurrentHP(myHero)/100*5 end,			
			speed = 1100,
			delay = 250,			 			
			range = 1000, 
			width = 80},
	[_R] = {dmg = function () return 100 + GetCastLevel(myHero,_R) * 100 + GetBonusAP(myHero) end, 		
			speed = math.huge,
			delay = 250,			 			
			range = 500, 
			width = 500},					
	}

	self.Config = scriptConfig("MonTourAatrox", "Aatrox on Tour")
		self.Config.addParam("Q", "Q in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("E", "E in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("R", "R in harass", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSQ", "Auto Q for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSE", "Auto E for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSW", "AutoHit WBuff for kill", SCRIPT_PARAM_ONOFF, true)    
		self.Config.addParam("KSQE", "Auto QE for kill", SCRIPT_PARAM_ONOFF, true)
--		self.Config.addParam("KSER", "Auto ER for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSQER", "Auto QER for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSQW", "Auto QW for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSQWE", "Auto QWE for kill", SCRIPT_PARAM_ONOFF, true)  
		self.Config.addParam("KSQRW", "Auto QRW for kill", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSQRWE", "Auto QRWE for kill", SCRIPT_PARAM_ONOFF, true)     
		self.Config.addParam("W", "Auto W combo", SCRIPT_PARAM_ONOFF, true)				
		self.Config.addParam("LCW", "Use W LaneClear", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("KSR", "Auto R for kill", SCRIPT_PARAM_ONOFF, false)				
		self.Config.addParam("Draw", "DMGBAR ON/OFF", SCRIPT_PARAM_ONOFF, true)	
		self.Config.addParam("DrawR", "DMGBAR R ON/OFF", SCRIPT_PARAM_ONOFF, true)	    
		self.Config.addParam("RN", "Ultimate Notifier", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("AL", "AutoLvLSkillsUp", SCRIPT_PARAM_ONOFF, true)	
 		self.Config.addParam("WAA", "Show WAA", SCRIPT_PARAM_ONOFF, true)		   
		self.Config.addParam("U", "E Poke", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
end

function Aatrox:Loop(myHero)		
	self:Checks()
	
--      info = GetObjectName(self.target)
	 
--    DrawText(info,30,60,250,0xffff0000)  
  
--        info2 = GetMaxMana(myHero)
	 
--    DrawText(info2,30,60,280,0xffff0000) 
    
--            info3 = GetCurrentMana(myHero)
	 
--    DrawText(info3,30,60,310  ,0xffff0000) 
  
	if _G.IWalkConfig.Combo then
		self:Combo()
	end
  
	if _G.IWalkConfig.Harass then
		self:Harass()
	end
	
	if self.Config.WAA then
		self:WAA()
	end

	  
	if self.Config.Draw then 
		self:Draws()
	end

	if _G.IWalkConfig.LaneClear then
    	self:LaneClear(minion)
    end	
	
	if self.Config.U then
		self:Special()
	end	
	
	if self.Config.AL then
		self:AutoLvL()
	end	
  
  if self.Config.RN then
    self:GLOBALULTNOTICE()
  end 
  
	self:DoWalk()
	self:Killsteal()

end

function Aatrox:DoWalk()
      IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
  
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))
--    if IWalkConfig.C then Circle(myHero,self.myRange):draw() end
--    local addRange = ((self.gapcloserTable[myHeroName] and CanUseSpell(myHero, gapcloserTable[myHeroName]) == READY) and 250 or 0) + (GetObjectName(myHero) == "Jinx" and (GetCastLevel(myHero, _Q)*25+50) or 0)
    IWalkTarget = GetTarget(self.myRange, DAMAGE_PHYSICAL) --+ addRange
    if _G.IWalkConfig.LaneClear then
      IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if (_G.IWalkConfig.Harass or _G.IWalkConfig.Combo) and ValidTarget(unit) then --self:DoChampionPlugins(unit) end
    if ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
        else
          self:Move()
       end 
      end
    end
  end


function Aatrox:Draws()
local rangeofdraws = 20000
local alldmg = GetBonusDmg(myHero) + GetBaseDamage(myHero)
	for _,unit in pairs(GetEnemyHeroes()) do
--	if Config.DrawR and Config.Draw then
	--Ready Q + W + E + R
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + W + (E) + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_R].dmg(), self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg),0xffffffff)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg, 0),0xffffffff)		
	--Ready (Q) + W + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and not self.EREADY and self.RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, self.spellData[_R].dmg()),0xffffffff)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, 0),0xffffffff)
	
  
  	--Ready Q + W + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and not self.WcostHealth and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and not self.WcostHealth and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + W + (E) + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and not self.WcostHealth and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, self.spellData[_R].dmg()),0xffffffff)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and not self.WcostHealth and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, 0),0xffffffff)		
	--Ready (Q) + W + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and not self.WcostHealth and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, alldmg, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and not self.WcostHealth and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, alldmg, self.spellData[_E].dmg()),0xffffffff)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.EREADY and not self.WcostHealth and self.RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, alldmg, self.spellData[_R].dmg()),0xffffffff)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.EREADY and not self.WcostHealth and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, alldmg, 0),0xffffffff)   
--	end
end
--	if Config.Draw and not Config.DrawR then
--	--Ready Q + W + E 
--	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and self.EREADY then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)	
--	--Ready Q + W + (E)
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.WcostHealth and not self.EREADY then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + self.spellData[_W].dmg() + alldmg, 0),0xffffffff)							
--	--Ready (Q) + W + E 
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and self.EREADY then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)	
--	--Ready (Q) + W + (E)		
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.WcostHealth and not self.EREADY then		
--	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_W].dmg() + alldmg, 0),0xffffffff)		
	
  
--  	--Ready Q + W + E 
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and not self.WcostHealth then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, self.spellData[_E].dmg()),0xffffffff)	
--	--Ready Q + W + (E) 
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and not self.WcostHealth then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg() + alldmg, 0),0xffffffff)				
--	--Ready (Q) + W + E 
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and not self.WcostHealth then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, alldmg, self.spellData[_E].dmg()),0xffffffff)			
--	--Ready (Q) + W + (E) 		
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.EREADY and not self.WcostHealth then		
--	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, alldmg),0xffffffff)		
--	end
--end
end

end

function Aatrox:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GetTarget(1100, DAMAGE_PHYSICAL)
	self.targetDRAW = GetTarget(20000, DAMAGE_PHYSICAL)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	minionPos = GetOrigin(minion)	
	self.WisOn = GotBuff(myHero,"aatroxwpower") == 1
	self.WisOff = GotBuff(myHero,"aatroxwlife") == 1
	self.WisOff2 = GotBuff(myHero,"aatroxwparticle") == 1		
	self.WgetHealth = GotBuff(myHero,"aatroxwonhlifebuff") == 1
 	self.WcostHealth = GotBuff(myHero,"aatroxwonhpowerbuff") == 1 
 	self.passivready = GotBuff(myHero,"aatroxpassiveready") == 1 
 	self.enemygotbansheesveil = GotBuff(unit,"bansheesveil") == 1  

end

function Aatrox:CastW()
	for i,unit in pairs(GetEnemyHeroes()) do	
		if (GetCurrentHP(myHero)/GetMaxHP(myHero)) < 0.35 and self.WREADY and IsInDistance(unit, 650) and ValidTarget(unit, 650) and GetCastName(myHero,_W) == "aatroxw2" then 
			CastSpell(_W) 
      
    elseif (GetCurrentHP(myHero)/GetMaxHP(myHero)) > 0.35 and self.WREADY and IsInDistance(unit, 650) and ValidTarget(unit, 650) and GetCastName(myHero,_W) == "AatroxW" then
			CastSpell(_W)
      
--		elseif (GetCurrentHP(myHero)/GetMaxHP(myHero)) < 0.20 and self.WREADY and IsInDistance(unit, 650) and ValidTarget(unit, 650) and self.WcostHealth then 
--			CastSpell(_W) 
      
--    elseif (GetCurrentHP(myHero)/GetMaxHP(myHero)) > 0.60 and self.WREADY and IsInDistance(unit, 650) and ValidTarget(unit, 650) and self.WgetHealth then
--			CastSpell(_W)
      
		end
	end
end

function Aatrox:CastPredQ(unit)
		local QPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, false, true)
		if self.QREADY and self.Config.Q and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
end


function Aatrox:CastPredE(unit)
	local unitPos = GetOrigin(unit)
  local EPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, false, true)
		if self.EREADY and self.Config.E then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
end

function Aatrox:CastPredR(unit)
	for i,unit in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	if self.Config.KSR and GetDistance(myHero, unit) > 150 and GetDistance(myHero, unit) <= 540 then --and self.Wstack
		if self.RREADY then
			CastSpell(_R)
		end
	end	
	end		
end

function Aatrox:CastPredRHarass(unit)
	for i,unit in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
	if self.Config.R and GetDistance(myHero, unit) > 350 and GetDistance(myHero, unit) <= 540 then --and self.Wstack
		if self.RREADY then
			CastSpell(_R)
		end
	end	
	end		
end


function Aatrox:CastPredQSpecial(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	local unitPos = GetOrigin(unit)
		local QPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, false, true)
		if self.QREADY and self.Config.QR and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
end		
end


function Aatrox:LaneClear(minion)
      for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do
        if self.WREADY and self.Config.LCW then --Globalfunc:MinionAround(myHeroPos, 250) > 2 then 
            local eminion = CountMinions(minion)
            local minionPos = GetOrigin(minion)
          	local igotmana = GetCurrentMana(myHero)
            local mymaxmana = GetMaxMana(myHero) 
            local mymaxhp = GetMaxHP(myHero)             
            local igothealth = GetCurrentHP(myHero)
            local lifesteal = GetLifeSteal(myHero)
            if (igotmana/mymaxmana) < 1 and IsInDistance(minion, 350) and (igothealth/mymaxhp) > 0.70 and (igothealth/mymaxhp) < 0.90 and GetCastName(myHero,_W) == "AatroxW"  then 
              CastSpell(_W) 
            end
            if (igotmana/mymaxmana) >= 1 and IsInDistance(minion, 350) and GetCastName(myHero,_W) == "aatroxw2" and (igothealth/mymaxhp) < 0.70 then           
              CastSpell(_W) 
            end
            if (igotmana/mymaxmana) >= 1 and IsInDistance(minion, 350) and GetCastName(myHero,_W) == "AatroxW" and (igothealth/mymaxhp) >= 0.90 then            
              CastSpell(_W) 
            end  
             if (igotmana/mymaxmana) >= 1 and IsInDistance(minion, 350) and GetCastName(myHero,_W) == "aatroxw2" and (igothealth/mymaxhp) <= 0.90 then          
              CastSpell(_W) 
            end               
        end  
      end
end

			
function Aatrox:Combo()
	if ValidTarget(self.target, self.spellData[_E].range) then
    if self.EREADY and self.enemygotbansheesveil then
			self:CastPredE(self.target)  
		elseif self.QREADY then
			self:CastPredQ(self.target)
		elseif self.EREADY then
			self:CastPredE(self.target)	 
		elseif self.WREADY then
			self:CastW(self.target)	       	 			
		end	
	end
end

function Aatrox:Harass()
	if ValidTarget(self.target, self.spellData[_E].range) then	
    if self.EREADY and self.enemygotbansheesveil then
			self:CastPredE(self.target)  
		elseif self.QREADY then
			self:CastPredQ(self.target)
    elseif self.RREADY then
			self:CastPredRHarass(self.target)      
		elseif self.EREADY then
			self:CastPredE(self.target)	 
		elseif self.WREADY then
			self:CastW(self.target)	 
    end
  end 
end

function Aatrox:Special()
 IAC:Move()
	for i,enemy in pairs(GetEnemyHeroes()) do
	if ValidTarget(enemy, self.spellData[_E].range) then
		if self.EREADY then
			self:CastPredE(self.target)
		end	
	end
	end
end

function Aatrox:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
	local QDmg = self.QREADY and self.spellData[_Q].dmg() or 0
  local WDmg = self.WREADY and self.spellData[_W].dmg() or 0
  local EDmg = self.EREADY and self.spellData[_E].dmg() or 0
  local RDmg = self.RREADY and self.spellData[_R].dmg() or 0
  local alldmg = GetBonusDmg(myHero) + GetBaseDamage(myHero)
--	local igothealth = GetCurrentHP(myHero)
--	local Qmana = self.spellData[_Q].costhealth() or 0
--	local Wmana = self.spellData[_E].costhealth() or 0
--	local Emana = self.spellData[_R].costhealth()	or 0			 					
		if self.Config.KSQ and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, QDmg) then
			self:CastPredQ(enemy) 
 		elseif self.Config.KSQW and self.WcostHealth and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, QDmg + WDmg + alldmg) then
			self:CastPredQ(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 200)        
		elseif self.Config.KSE and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, EDmg, 0) then
			self:CastPredE(enemy)	
		elseif self.Config.KSR and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_R].range) and enemyhp < CalcDamage(myHero, enemy, RDmg, 0) then
			self:CastPredR(enemy)
		elseif self.Config.KSW and self.WcostHealth and IsObjectAlive(enemy) and ValidTarget(enemy, GetRange(myHero)) and enemyhp < CalcDamage(myHero, enemy, 0, WDmg + alldmg) then
			self:AttackUnitKS(unit)      
		elseif self.Config.KSQE and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range)  and enemyhp < CalcDamage(myHero, enemy, EDmg, QDmg) then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredE(enemy) end, 125)
		elseif self.Config.KSQWE and self.WcostHealth and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range)  and enemyhp < CalcDamage(myHero, enemy, EDmg, QDmg + WDmg + alldmg) then			
			self:CastPredQ(enemy) DelayAction(function() self:AttackUnitKS(enemy) DelayAction(function() self:CastPredE(enemy) end, 200) end, 300)     
		elseif self.Config.KSQR and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, RDmg, QDmg)  then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredR(enemy) end, 125)
		elseif self.Config.KSQRW and self.WcostHealth and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, RDmg, QDmg + WDmg + alldmg)  then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredR(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 125) end, 250)      
--		elseif self.Config.KSER and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, EDmg, RDmg, 0) then			
--			self:CastPredE(enemy) DelayAction(function() self:CastPredR(enemy) end, 125)						
		elseif self.Config.KSQER and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, EDmg + RDmg, QDmg) then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredR(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() end, 125) end, 225) end, 550) --self:CastEOFF(enemy)
		elseif self.Config.KSQRWE and self.WcostHealth and IsObjectAlive(enemy) and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, EDmg + RDmg, QDmg) then			
			self:CastPredQ(enemy) DelayAction(function() self:CastPredR(enemy) DelayAction(function() self:AttackUnitKS(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() end, 125) end, 225) end, 450) end, 800) --self:CastEOFF(enemy)      
		end
	end	
end

function Aatrox:AttackUnitKS(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do  
  if IsInDistance(enemy, GetRange(myHero)) and GetDistance(myHero, enemy) <= (GetRange(myHero)-10) and GetDistance(myHero, enemy) >= 10 then 
    AttackUnit(enemy)
  end
  end
end

function Aatrox:GLOBALULTNOTICE()
        if not self.RREADY then return end
        info = ""
        if self.RREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, self.spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not ValidTarget(unit, self.spellData[_R].range) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,30,60,200,0xffff0000)                	
end

--function Aatrox:MinionAround(pos, range)
--    local c = 0
--    if pos == nil then return 0 end
--    for k,v in pairs(GetAllMinions(MINION_ENEMY)) do 
--        if v and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
--            c = c + 1
--        end
--    end
--    return c
--end

function Aatrox:WAA()
	for i,unit in pairs(GetEnemyHeroes()) do
		local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
		local unitPos = GetOrigin(unit)
		local dmgE = self.spellData[_W].dmg() + TotalDmg
		local dmgE2 = TotalDmg    
		local dmg = CalcDamage(myHero, unit, dmgE)    
		local dmg2 = CalcDamage(myHero, unit, dmgE2)
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
        if dmg > 0 and GetCastName(myHero,_W) == "aatroxw2" then --and self.WcostHealth
          DrawText(math.ceil((hp/dmg+hp/dmg2+hp/dmg2)/3).." WAA", 15, hPos.x+45, hPos.y+20, 0xffffffff)
--        elseif dmg > 0 and GetCastName(myHero,_W) == "AatroxW" then --and self.WcostHealth
--          DrawText(math.ceil((hp/dmg2+hp/dmg2+hp/dmg2)/3).." AA", 15, hPos.x+45, hPos.y+20, 0xffffffff)
        end 	
  end
end

function Aatrox:AutoLvL()
if GetLevel(myHero) == 1 then
	LevelSpell(_E)
end
if GetLevel(myHero) == 2 then
	LevelSpell(_Q)
end
if GetLevel(myHero) == 3 then
	LevelSpell(_W)
end 
if GetLevel(myHero) == 4 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 5 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 6 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 7 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 8 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 9 then
	LevelSpell(_E)
end
 if GetLevel(myHero) == 10 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 11 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 12 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 13 then
	LevelSpell(_W)
end
 if GetLevel(myHero) == 14 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 15 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 16 then
	LevelSpell(_R)
end
 if GetLevel(myHero) == 17 then
	LevelSpell(_Q)
end
 if GetLevel(myHero) == 18 then
	LevelSpell(_Q)
end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------- A M U M U ------------------------------------------------------------------------------------ A M U M U ------------------------------------------------------
---------------------------------------------------------------------------- A M U M U -----------------------------------------------------------------------------------------------
---------------------- A M U M U------------------------------------------------------------------------------------- A M U M U ------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Amumu"
function Amumu:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
  self.spellData = 
	{
	[_Q] = {dmg = function () return 30 + 50*GetCastLevel(myHero,_Q) + 0.7*GetBonusAP(myHero) end,  
			mana = function () return 70 + 10*GetCastLevel(myHero,_Q) end,
      speed = math.huge,
			delay = 250,			 			
			range = 1100, 
			width = 65},  
	[_W] = {dmg = function () for _,unit in pairs(GetEnemyHeroes()) do return 4 + 4*GetCastLevel(myHero,_W) + GetMaxHP(unit)/100*(GetCastLevel(myHero,_W)*0.5+0.5) end end, 
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

	self.Config = scriptConfig("MonTourAmumu", "Amumu on Tour")
		self.Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("W", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("LCW", "Use W LaneClear", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("LCE", "Use E LaneClear", SCRIPT_PARAM_ONOFF, true)			
		self.Config.addParam("R", "Use R killsteal", SCRIPT_PARAM_ONOFF, true)		
		self.Config.addParam("Draw", "DMGoHPBARs", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("WAA", "Show W seconds", SCRIPT_PARAM_ONOFF, true)    
		self.Config.addParam("KS", "KillSteal QWER", SCRIPT_PARAM_ONOFF, true)				
		self.Config.addParam("U", "Perfect R key", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
 		self.Config.addParam("U3", "Perfect R 3Hit", SCRIPT_PARAM_ONOFF, true)  
 		self.Config.addParam("UH3", "Harass R 3Hit", SCRIPT_PARAM_ONOFF, true)     
end

function Amumu:Loop(myHero)
  
  self:Checks()
  self:WAA()
  self:GLOBALULTNOTICE()
  self:GLOBALULTNOTICE2()
  --self:TargetCircle()
	if self.Config.Draw then 
		self:Draws()
	end
	if self.Config.KS then
		self:Killsteal()
		end
	if _G.IWalkConfig.LaneClear then
    	self:LaneClear(minion)
    end	
	if _G.IWalkConfig.Combo then
		self:Combo()
	end
	if _G.IWalkConfig.Harass then
		self:Harass()
	end
	
	if self.Config.U then
		self:Special()
	end	
  self:DoWalk()

  end

function Amumu:TargetCircle()
  local infotarget = GetObjectName(self.target)
  local unitPos = GetOrigin(self.target)
  if ValidTarget(unit, 1500) and IsInDistance(unit, 1500) and IsObjectAlive(unit) then
  DrawText(infotarget,30,600,5,0xffff0000) 
  DrawCircle(unitPos.x,unitPos.y,unitPos.z,30,0,0,0xffffffff)
  end
  if unitPos ~=nil then
  unitPos = GetOrigin(self.target) 
  DrawText(infotarget,30,600,5,0xffff0000) 
  DrawCircle(unitPos.x,unitPos.y,unitPos.z,30,0,0,0xffffffff)
end
end


function Amumu:GLOBALULTNOTICE()
        if not self.RREADY then return end
        info1 = ""
        if self.RREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, self.spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info1 = info1..GetObjectName(unit)
                                if not IsInDistance(unit, self.spellData[_R].range) then
                                        info1 = info1.." not in Range but"                                                        
                                end
                                info1 = info1.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info1,30,60,200,0xffff0000)                	
end

function Amumu:GLOBALULTNOTICE2()
  if not self.RREADY then return end
       info = ""
        if self.RREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        if EnemiesAround(myHeroPos, self.spellData[_R].range) == 1  then
                                info = "1 Enemy will be stunned"
                        elseif EnemiesAround(myHeroPos, self.spellData[_R].range) == 2  then
                                info = " 2 Enemys will be stunned"  
                        elseif EnemiesAround(myHeroPos, self.spellData[_R].range) == 3  then
                                info = " 3 Enemys will be stunned"  
                        elseif EnemiesAround(myHeroPos, self.spellData[_R].range) == 4  then
                                info = " 4 Enemys will be stunned" 
                         elseif EnemiesAround(myHeroPos, self.spellData[_R].range) >= 5  then
                                info = " 5 Enemys will be stunned"  
                        end        
 --                               info = info.." will be stunned \n"
                        
        		 end               
			end
		end		 
    DrawText(info,25,700,785,0xffff0000)                	
end


function Amumu:dmgper100() 
  for _,unit in pairs(GetEnemyHeroes()) do
  if GetBonusAP(myHero) >= 0 and GetBonusAP(myHero) <= 50 then return GetMaxHP(unit)/100*0 end
  if GetBonusAP(myHero) >= 50 and GetBonusAP(myHero) <= 100 then return GetMaxHP(unit)/100*1 end 
  if GetBonusAP(myHero) >= 100 and GetBonusAP(myHero) <= 200 then return GetMaxHP(unit)/100*2 end 
  if GetBonusAP(myHero) >= 200 and GetBonusAP(myHero) <= 300 then return GetMaxHP(unit)/100*3 end 
  if GetBonusAP(myHero) >= 300 and GetBonusAP(myHero) <= 400 then return GetMaxHP(unit)/100*4 end 
  if GetBonusAP(myHero) >= 400 and GetBonusAP(myHero) <= 500 then return GetMaxHP(unit)/100*5 end 
  if GetBonusAP(myHero) >= 500 and GetBonusAP(myHero) <= 600 then return GetMaxHP(unit)/100*6 end 
  if GetBonusAP(myHero) >= 600 and GetBonusAP(myHero) <= 700 then return GetMaxHP(unit)/100*7 end 
  if GetBonusAP(myHero) >= 700 and GetBonusAP(myHero) <= 800 then return GetMaxHP(unit)/100*8 end 
  if GetBonusAP(myHero) >= 800 and GetBonusAP(myHero) <= 900 then return GetMaxHP(unit)/100*9 end 
  if GetBonusAP(myHero) >= 900 and GetBonusAP(myHero) <= 1000 then return GetMaxHP(unit)/100*10 end 
  if GetBonusAP(myHero) >= 1000 and GetBonusAP(myHero) <= 1100 then return GetMaxHP(unit)/100*11 end 
  end
end

function Amumu:DoWalk()
      IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
  
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))
--    if IWalkConfig.C then Circle(myHero,self.myRange):draw() end
--    local addRange = ((self.gapcloserTable[myHeroName] and CanUseSpell(myHero, gapcloserTable[myHeroName]) == READY) and 250 or 0) + (GetObjectName(myHero) == "Jinx" and (GetCastLevel(myHero, _Q)*25+50) or 0)
    IWalkTarget = GetTarget(self.myRange, DAMAGE_PHYSICAL) --+ addRange
    if _G.IWalkConfig.LaneClear then
      IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if (_G.IWalkConfig.Harass or _G.IWalkConfig.Combo) and ValidTarget(unit) then --self:DoChampionPlugins(unit) end
    if ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
        else
          IAC:Move()
       end 
      end
    end
  end

function Amumu:WAA()
	for i,unit in pairs(GetEnemyHeroes()) do
		local unitPos = GetOrigin(unit)
		local dmgW = self.spellData[_W].dmg() + self:dmgper100()  
		local dmg = CalcDamage(myHero, unit, 0, dmgW)    
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
        if GetCastLevel(myHero,_W) >= 1 and dmg > 0 then --and self.WcostHealth
          DrawText(math.ceil(hp/dmg).." Wsec", 15, hPos.x+45, hPos.y+20, 0xffffffff)
--        elseif not IsObjectAlive(unit) and GetCastLevel(myHero,_W) >= 1 then --and self.WcostHealth
--          DrawText(math.ceil((hp/dmg2+hp/dmg2+hp/dmg2)/3).." AA", 15, hPos.x+45, hPos.y+20, 0xffffffff)
        end 
  end
end

function Amumu:Draws()
local rangeofdraws = 20000
	for _,unit in pairs(GetEnemyHeroes()) do
	--Ready Q + W + E + R
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_E].dmg()),0xffffffff)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg() + self.spellData[_R].dmg()),0xffffffff)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_Q].dmg()),0xffffffff)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg() + self.spellData[_R].dmg()),0xffffffff)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and self.EREADY and not self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg()),0xffffffff)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(self.targetDRAW,rangeofdraws) and not self.QREADY and not self.EREADY and self.RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_R].dmg()),0xffffffff)
	end
	end	
end

function Amumu:Checks()
 
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.EREADYONCOOLDOWN = CanUseSpell(myHero,_E) == ONCOOLDOWN
	self.RREADY = CanUseSpell(myHero,_R) == READY  
	self.target = GetTarget(1500, DAMAGE_MAGIC)
	self.targetDRAW = GetTarget(20000, DAMAGE_MAGIC)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
  self.AuraofDespairOff = GotBuff(myHero,"AuraofDespair") == 0
  self.AuraofDespairOn = GotBuff(myHero,"AuraofDespair") == 1
end


function Amumu:MinionAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GetAllMinions(MINION_ENEMY)) do 
        if v and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
            c = c + 1
        end
    end
    return c
end

function Amumu:CastPredE(unit)
	local unitPos = GetOrigin(unit)
	if self.EREADY and self.Config.E and EnemiesAround(myHeroPos, self.spellData[_E].range) >= 1 and IsInDistance(unit, self.spellData[_E].range+50) and GetDistance(myHero, unit) <= self.spellData[_E].range-10 then --GetDistance(myHero, unit) > 0 and 
		CastTargetSpell(unit,_E) 
	end
end

function Amumu:CastPredECombo(unit) ------------------------------------------------------------------- http://gamingonsteroids.com/topic/974-gos-lua-api-alpha-version-009/
	for i,unit in pairs(GetEnemyHeroes()) do   
	local unitPos = GetOrigin(unit)
--	if self.EREADY and self.Config.E and IsInDistance(unit, self.spellData[_E].range+50) and GetDistance(myHero, unit) <= self.spellData[_E].range then --GetDistance(myHero, unit) > 0 and 
--		CastTargetSpell(unit,_E)  
--	end
  	if self.Config.E and EnemiesAround(myHeroPos, self.spellData[_E].range) >= 1 and IsInDistance(unit, self.spellData[_E].range) and GetDistance(myHero, unit) <= self.spellData[_E].range-30 and GetDistance(myHero, unit) > 0 then 
		CastTargetSpell(unit,_E)
--     	elseif self.EREADYONCOOLDOWN and self.Config.E and EnemiesAround(myHeroPos, self.spellData[_E].range) >= 1 and IsInDistance(unit, self.spellData[_E].range-30) and GetDistance(myHero, unit) <= self.spellData[_E].range-30 then --GetDistance(myHero, unit) > 0 and 
--		CastTargetSpell(unit,_E)
	end
  end
end



function Amumu:CastQ(unit)
		local QPred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), self.spellData[_Q].speed, self.spellData[_Q].delay, self.spellData[_Q].range, self.spellData[_Q].width, true, true)
		if self.QREADY and self.Config.Q and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
end

function Amumu:CastW(unit)
	for i,unit in pairs(GetEnemyHeroes()) do  
        if self.WREADY and self.Config.LCW and EnemiesAround(myHeroPos, self.spellData[_W].range) >= 1 and self.Config.LCW and self.AuraofDespairOff and IsInDistance(unit, self.spellData[_W].range) and GetDistance(myHero, unit) > 50 and GetDistance(myHero, unit) <= self.spellData[_W].range then 
        CastTargetSpell(unit,_W) 
        elseif self.WREADY and self.Config.LCW and EnemiesAround(myHeroPos, self.spellData[_W].range+50) <= 0 and self.Config.LCW and self.AuraofDespairOn and not IsInDistance(unit, self.spellData[_W].range) and GetDistance(myHero, unit) > self.spellData[_W].range then 
        CastTargetSpell(unit,_W) 
end
end
end

function Amumu:CastPredR(unit)
	local unitPos = GetOrigin(unit)
	if self.Config.R then 
	if self.RREADY and self.Config.R and IsInDistance(unit, self.spellData[_R].range) and EnemiesAround(myHeroPos, self.spellData[_W].range-10) >= 1 then--GetDistance(myHero, unit) <= self.spellData[_R].range-5 then --and GetDistance(myHero, unit) > 0 and 
		CastTargetSpell(unit,_R)
	end
	end	
end

function Amumu:LaneClear(minion)
local eminion = CountMinions()
			for i,minion in pairs(GetAllMinions(MINION_ENEMY)) do		
        if self.WREADY and self.Config.LCW and Globalfunc:MinionAround(myHeroPos, self.spellData[_W].range) > 2 and self.Config.LCW and self.AuraofDespairOff and IsInDistance(minion, self.spellData[_W].range) and GetDistance(myHero, minion) > 50 and GetDistance(myHero, minion) <= self.spellData[_W].range then 
        CastTargetSpell(minion,_W) 
        elseif self.WREADY and self.Config.LCW and Globalfunc:MinionAround(myHeroPos, self.spellData[_W].range) <= 1 and self.Config.LCW and self.AuraofDespairOn and not IsInDistance(minion, self.spellData[_W].range) and GetDistance(myHero, minion) > self.spellData[_W].range then 
        CastTargetSpell(minion,_W) 
        elseif self.EREADY and self.Config.LCE and Globalfunc:MinionAround(myHeroPos, self.spellData[_E].range) > 3 and self.Config.LCE and IsInDistance(minion, self.spellData[_E].range) and GetDistance(myHero, minion) >= 10 and GetDistance(myHero, minion) <= self.spellData[_E].range then 
        CastTargetSpell(minion,_E) 
				end		
			end
end
			
function Amumu:Combo()
	if ValidTarget(self.target, self.spellData[_Q].range+50)  then
    if self.QREADY then
			self:CastQ(self.target)	
		elseif self.WREADY then
			self:CastW(self.target)	      
    elseif self.EREADY then
			self:CastPredECombo(unit) 
--		elseif self.RREADY then
--			self:CastPredR(self.target)			
		end	
	end
end

function Amumu:Harass()
	if ValidTarget(self.target, self.spellData[_Q].range+50) then
    if self.QREADY then
			self:CastQ(self.target)	
		elseif self.WREADY then
			self:CastW(self.target)	      
    elseif self.EREADY then
			self:CastPredECombo(self.target)
    elseif self.RREADY then
			self:HarassR(self.target)      
     end 
	end
end

function Amumu:HarassR(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do
	if self.Config.UH3 and ValidTarget(enemy, self.spellData[_R].range+50) and EnemiesAround(myHeroPos, self.spellData[_R].range-10) >= 3 then
		if self.RREADY then
      CastTargetSpell(enemy,_R)
		end	
	end
	if not self.Config.UH3 and ValidTarget(enemy, self.spellData[_R].range+50) and EnemiesAround(myHeroPos, self.spellData[_R].range-10) >= 1 then
		if self.RREADY then
      CastTargetSpell(enemy,_R)
		end	
	end  
	end
end

function Amumu:Special()
 IAC:Move()
	for i,enemy in pairs(GetEnemyHeroes()) do
	if self.Config.U3 and ValidTarget(enemy, self.spellData[_R].range+50) and EnemiesAround(myHeroPos, self.spellData[_R].range-10) >= 3 then
		if self.RREADY then
			CastTargetSpell(enemy,_R)
		end	
	end
	if not self.Config.U3 and ValidTarget(enemy, self.spellData[_R].range+50) and EnemiesAround(myHeroPos, self.spellData[_R].range-10) >= 1 then
		if self.RREADY then
			CastTargetSpell(enemy,_R)
		end	
	end  
	end
end

function Amumu:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
  local QDmg = self.QREADY and self.spellData[_Q].dmg() or 0
 -- local WDmg = self.WREADY and self.spellData[_W].dmg() or 0
  local EDmg = self.EREADY and self.spellData[_E].dmg() or 0
  local RDmg = self.RREADY and self.spellData[_R].dmg() or 0
		if ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, 0, EDmg) then
			self:CastPredE(enemy)
		elseif ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, QDmg) then
			self:CastQ(enemy)		
		elseif self.Config.R and ValidTarget(enemy, self.spellData[_R].range) and enemyhp < CalcDamage(myHero, enemy, 0, RDmg) then
			self:HarassR(enemy)
		elseif ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, EDmg + QDmg) then			
			self:CastQ(enemy) DelayAction(function() self:CastW(enemy) DelayAction(function() self:CastPredE(enemy) end, 125) end, 250)
		elseif self.Config.R and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0, RDmg + QDmg) then			
			self:CastQ(enemy) DelayAction(function() self:CastW(enemy) DelayAction(function() self:CastPredR(unit) end, 125) end, 250)      		
		elseif self.Config.R and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, 0	, QDmg  + EDmg + RDmg) then			
			self:CastQ(enemy) DelayAction(function() self:CastW(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() self:CastPredR(unit) end, 125) end, 250) end, 375)		
		end
	end	
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------- S H A C O ------------------------------------------------------------------------------------- S H A C O ------------------------------------------------------
---------------------------------------------------------------------------- S H A C O ------------------------------------------------------------------------------------------------
---------------------- S H A C O ------------------------------------------------------------------------------------- S H A C O ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class "Shaco"
function Shaco:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
	self.spellData = 
	{
	[_Q] = {dmg = function () return (GetBonusDmg(myHero)+GetBaseDamage(myHero)) / 100 * (120 + 20*GetCastLevel(myHero,_Q)) end,  
			mana = function () return 100 - 10*GetCastLevel(myHero,_Q) end,
			range = 400},  
	[_W] = {dmg = function () return 10 + 50*GetCastLevel(myHero,_W) + 0.4*GetBonusAP(myHero) end,  
			mana = function () return 45 + 5*GetCastLevel(myHero,_Q) end,
			range = 425},
	[_E] = {dmg = function () return 10 + 40*GetCastLevel(myHero,_E) + GetBonusAP(myHero) + GetBonusDmg(myHero) end, 
			mana = function () return 45 + 5*GetCastLevel(myHero,_Q) end,			
			delay = 500,			 			
			range = 625}, 
	[_R] = {dmg = function () return 150 + 150*GetCastLevel(myHero,_R) + GetBonusAP(myHero) end, 
			mana = 100,			
			delay = 500,			 			
			range = 1125}, 				
	}
--if supportedHero[GetObjectName(myHero)] == true then
	self.Config = scriptConfig("MonTourShaco", "Shaco on Tour")
		self.Config.addParam("E", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
		self.Config.addParam("Q", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)   	
		self.Config.addParam("Draw", "DMGoHP E", SCRIPT_PARAM_ONOFF, true)	
		self.Config.addParam("Ekillnote", "Global E KillNotice", SCRIPT_PARAM_ONOFF, true)	
	self.Config2 = scriptConfig("MonTourShaco2", "Killsteal")    
  		self.Config2.addParam("KS", "KS ON/OFF", SCRIPT_PARAM_ONOFF, true)
   		self.Config2.addParam("KSQ", "KS Q", SCRIPT_PARAM_ONOFF, true)    
      self.Config2.addParam("KSE", "KS E", SCRIPT_PARAM_ONOFF, true)   
      self.Config2.addParam("KSE2", "KS E gapclose Q", SCRIPT_PARAM_ONOFF, true) 
      self.Config2.addParam("KSQE", "KS EQ", SCRIPT_PARAM_ONOFF, true)         
--		self.Config.addParam("U", "Perfect R", SCRIPT_PARAM_KEYDOWN, string.byte("N"))
-- end   
end

function Shaco:Loop(myHero)
--if supportedHero[GetObjectName(myHero)] == true then--.Leona or supportedHero.Lux or supportedHero.Draven then
	self:Checks()
	if self.Config.Draw then 
		self:Draws()
	end
	if self.Config2.KS then
		self:Killsteal()
		end
	if _G.IWalkConfig.Combo then
		self:Combo()
	end
	if _G.IWalkConfig.Harass then
		self:Harass()
	end
  if self.Config.Ekillnote then
  self:Ekillnote()
  end
  self:DoWalk()
--end
end

function Shaco:DoWalk()
      IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
  
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))
--    if IWalkConfig.C then Circle(myHero,self.myRange):draw() end
--    local addRange = ((self.gapcloserTable[myHeroName] and CanUseSpell(myHero, gapcloserTable[myHeroName]) == READY) and 250 or 0) + (GetObjectName(myHero) == "Jinx" and (GetCastLevel(myHero, _Q)*25+50) or 0)
    IWalkTarget = GetTarget(self.myRange, DAMAGE_PHYSICAL) --+ addRange
    if _G.IWalkConfig.LaneClear then
      IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if (_G.IWalkConfig.Harass or _G.IWalkConfig.Combo) and ValidTarget(unit) then --self:DoChampionPlugins(unit) end
    if ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
        else
          IAC:Move()
       end 
      end
    end
  end

function Shaco:Draws()
local rangeofdraws = 20000
	for _,unit in pairs(GetEnemyHeroes()) do
		
	--Ready Q + (W) + E + (R)			
--	if ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and self.EREADY then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg(), self.spellData[_E].dmg()),0xffffffff)		
--	--Ready Q + (W) + (E) + (R)		
--	elseif ValidTarget(self.targetDRAW,rangeofdraws) and self.QREADY and not self.EREADY then
--		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, self.spellData[_Q].dmg(),0 ),0xffffffff)	
	--Ready (Q) + (W) + E + (R)			
	if ValidTarget(self.targetDRAW,rangeofdraws) and self.EREADY then --not self.QREADY and 
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, self.targetDRAW, 0, self.spellData[_E].dmg()),0xffffffff)		
	end
	end	
end

function Shaco:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GetTarget(1250, DAMAGE_MAGIC)
	self.targetDRAW = GetTarget(20000, DAMAGE_MAGIC)	
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	self.Qstack = GotBuff(myHero,"Deceive") == 1
end

function Shaco:CastPredE(unit)
	local unitPos = GetOrigin(unit)
	if self.EREADY and self.Config.E and IsInDistance(unit, self.spellData[_E].range) then 
		CastTargetSpell(unit,_E)
	end
end

function Shaco:CastQ(unit)
  	local unitPos = GetOrigin(unit)
	if self.QREADY and self.Config.Q and IsInDistance(unit, self.spellData[_Q].range+15) then 
		CastSkillShot(_Q,unitPos)
	end
end

function Shaco:CastQKS(unit)
  	local unitPos = GetOrigin(unit)
	if self.QREADY and self.Config.Q and IsInDistance(unit, self.spellData[_Q].range + self.spellData[_E].range) then 
		CastSkillShot(_Q,unitPos)
	end
end
			
function Shaco:Combo()
	if ValidTarget(self.target, self.spellData[_E].range + self.spellData[_Q].range) then
		if self.EREADY then
			self:CastPredE(self.target)
		elseif self.QREADY then
			self:CastQ(self.target)	 		
		end	
	end
end

function Shaco:Harass()
	if ValidTarget(self.target, self.spellData[_E].range+50) then
		if self.EREADY then
			self:CastPredE(self.target) 		
		end
	end
end


function Shaco:Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
		if self.Config2.KSE and ValidTarget(enemy, self.spellData[_E].range) and GetDistance(myHero, enemy) <= self.spellData[_E].range and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_E].dmg()) then
			self:CastPredE(enemy)
		elseif self.Config2.KSQ and ValidTarget(enemy, self.spellData[_Q].range) and GetDistance(myHero, enemy) <= self.spellData[_Q].range-5 and enemyhp < CalcDamage(myHero, enemy, self.spellData[_Q].dmg(), 0) then
			self:CastQ(enemy)	DelayAction(function() self:AttackUnitKS(enemy) end, 125)  	
		elseif self.Config2.KSQE and ValidTarget(enemy, self.spellData[_E].range-10) and GetDistance(myHero, enemy) <= self.spellData[_E].range-10 and enemyhp < CalcDamage(myHero, enemy, self.spellData[_Q].dmg(), self.spellData[_E].dmg()) then			
			self:CastPredE(enemy) DelayAction(function() self:CastQ(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 125) end, 250)
		elseif self.Config2.KSE2 and ValidTarget(enemy, self.spellData[_E].range + self.spellData[_Q].range+10) and GetDistance(myHero, enemy) >= self.spellData[_E].range + self.spellData[_Q].range - 10 and enemyhp < CalcDamage(myHero, enemy, 0, self.spellData[_E].dmg()) then			
			self:CastQKS(enemy) DelayAction(function() self:CastPredE(enemy) end, 125)      
		end
	end	
end

function Shaco:AttackUnitKS(unit)
	for i,enemy in pairs(GetEnemyHeroes()) do  
  if IsInDistance(enemy, GetRange(myHero)) and GetDistance(myHero, enemy) <= (GetRange(myHero)-10) and GetDistance(myHero, enemy) >= 10 then 
    AttackUnit(enemy)
  end
  end
end

function Shaco:Ekillnote()
        if not self.EREADY then return end
        info1 = ""
        if self.EREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, self.spellData[_E].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info1 = info1..GetObjectName(unit)
                                if not IsInDistance(unit, self.spellData[_E].range+50) then
                                        info1 = info1.." not in Range but"                                                        
                                end
                                info1 = info1.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info1,30,60,200,0xffff0000)                	
end



if supportedHero[GetObjectName(myHero)] == true then--.Leona or supportedHero.Lux or supportedHero.Draven then
if _G[GetObjectName(myHero)] then
	_G[GetObjectName(myHero)]()
end	
local upv = "If you like UpVote!"
local sig = "Made by MarCiii"
local ver = "2.0.0.7"
local info = "MarCiii on Tour Loaded"
textTable = {info,upv,sig,ver} 
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])
PrintChat(textTable[4])	
end




class 'Globalfunc'

  function Globalfunc:Move()
    local movePos = GenerateMovePos()
    if GetDistance(GetMousePos()) > GetHitBox(myHero) then
      MoveToXYZ(movePos.x, GetMyHeroPos().y, movePos.z)
    end
  end

  function Globalfunc:IWalk()
    if IWalkConfig.LastHit or IWalkConfig.LaneClear or IWalkConfig.Harass then
      for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
        local targetPos = GetOrigin(k)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        local hp = self:PredictHealth(k, self.orbTable.windUp + GetDistance(k)/self:GetProjectileSpeed(myHero) - 0.07)
        local dmg = CalcDamage(myHero, k, GetBonusDmg(myHero)+GetBaseDamage(myHero))
        if dmg > hp then
          if (IWalkConfig.LastHit or IWalkConfig.LaneClear or IWalkConfig.Harass) and IsInDistance(k, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation then
            AttackUnit(k)
            return
          end
        end
      end
    end
    if IWalkConfig.Combo or IWalkConfig.Harass or IWalkConfig.LastHit or IWalkConfig.LaneClear then
      self:DoWalk()
    end
  end

function Globalfunc:DoWalk()
      IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
  
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))
    IWalkTarget = GetTarget(self.myRange, DAMAGE_PHYSICAL) --+ addRange
    if _G.IWalkConfig.LaneClear then
      IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_JUNGLE) or GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if (_G.IWalkConfig.Harass or _G.IWalkConfig.Combo) and ValidTarget(unit) then --self:DoChampionPlugins(unit) end
    if ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
        else
          self:Move()
       end 
      end
    end
  end
  
  function Globalfunc:DoWalk2()
      IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
  
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))
    IWalkTarget = GetTarget(self.myRange, DAMAGE_PHYSICAL) --+ addRange
    if LaneClearActive.getValue() then
    IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_JUNGLE) or GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if HarassActive.getValue() or ComboActive.getValue() and ValidTarget(unit) then --self:DoChampionPlugins(unit) end
    if ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
        else
          self:Move()
       end 
      end
    end
  end
  
  function Globalfunc:MinionAround(pos, range)
    local c = 0
    if pos == nil then return 0 end
    for k,v in pairs(GetAllMinions(MINION_ENEMY)) do 
        if v and GetDistanceSqr(pos,GetOrigin(v)) < range*range then
            c = c + 1
        end
    end
    return c
end


end