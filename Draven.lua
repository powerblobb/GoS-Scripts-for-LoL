if GetObjectName(myHero) ~= "Draven" then return end
--MonTour Draven:V1.0.0.4 - updated GoS:myHeroPos() to GetOrigin(myHero)
PrintChat(string.format("<font color='#80F5F5'>MonTour Draven:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.4</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Cloud for Axes Code</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> iLoveSona for Interrupter</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))
require('RecallUlt') 
DravenMenu = Menu("Draven", "Draven")
DravenMenu:SubMenu("Info", "Info about Auto Q Walk")
DravenMenu.Info:Info("Draven", "Info: Use Catch Q AutoWalk")
DravenMenu.Info:Info("Draven", "for Catching the Axes of Q by")
DravenMenu.Info:Info("Draven", "Single Pressing the Button. ")
DravenMenu.Info:Info("Draven", "Do not HOLD the Catch Q AutoWalk")
DravenMenu.Info:Info("Draven", "Button, cause of Forcing Movement!")
DravenMenu.Info:Info("Draven", "You need to train, before jump into ranked!")
DravenMenu:SubMenu("Combo", "Combo")
DravenMenu.Combo:Key("CQ", "Catch Q AutoWalk", string.byte("A"))
DravenMenu.Combo:Info("Draven", "Pickup Q if Range")
DravenMenu.Combo:Slider("CQPR", " Axe/MyMouse < X (def: 400)", 400, 50, 1000, 1)
DravenMenu.Combo:Boolean("CM", "Draw Q Catch Circle", true)
DravenMenu.Combo:Boolean("QC", "Draw Q Mouse Circle", true)
DravenMenu.Combo:Boolean("CWS", "Use W to Catch", true)
DravenMenu.Combo:Boolean("Q", "Use Q", true)
DravenMenu.Combo:Boolean("W", "Use W", true)
DravenMenu.Combo:Slider("WMANA", "Use W Only if Mana > x%", 60, 1, 90, 1)
DravenMenu.Combo:Boolean("E", "Use E OOR", true)
DravenMenu.Combo:Boolean("EB", "Use E if Banshees", true)
DravenMenu.Combo:Boolean("R", "Use R", false)

DravenMenu:SubMenu("Items", "Items")
DravenMenu.Items:Info("Draven", "Only in Combo and Harass")
DravenMenu.Items:Boolean("Ignite", "Use Ignite", true)
DravenMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
DravenMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
DravenMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
DravenMenu.Items:Info("Draven", " ")
DravenMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
DravenMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
DravenMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
DravenMenu.Items:Info("Draven", " ")
DravenMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
DravenMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
DravenMenu.Items:Info("Draven", " ")
DravenMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
DravenMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
DravenMenu.Items:Info("Draven", " ")
DravenMenu.Items:Boolean("QSS", "Always Use QSS", true)
DravenMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)

DravenMenu:SubMenu("Harass", "Harass")
DravenMenu.Harass:Boolean("QH", "Use Q", true)
DravenMenu.Harass:Boolean("WH", "Use W", true)
DravenMenu.Harass:Slider("WMANA", "Use Only W if Mana > x%", 60, 1, 90, 1)
DravenMenu.Harass:Boolean("EH", "Use E OOR", true)
DravenMenu.Harass:Boolean("EHB", "Use E if Banshees", true)
DravenMenu.Harass:Boolean("RH", "Use R", false)

DravenMenu:SubMenu("Clear", "Farming/Jungle")
DravenMenu.Clear:Boolean("LHQ", "Use Q LastHit", true)
DravenMenu.Clear:Boolean("LCQ", "Use Q LaneClear", true)
DravenMenu.Clear:Boolean("LCJQ", "Use Q Jungle", true)

DravenMenu:SubMenu("Steal", "JungleSteal")
DravenMenu.Steal:Boolean("Dragon", "Use R Dragon", true)
DravenMenu.Steal:Boolean("Baron", "Use R Baron", true)

DravenMenu:SubMenu("Killsteal", "Killsteal")
DravenMenu.Killsteal:Boolean("KSQE", "KillSteal with Q/E", true)
DravenMenu.Killsteal:Boolean("KSR", "Killsteal with R", true)

DravenMenu:SubMenu("Misc", "Misc")
DravenMenu.Misc:Boolean("AL","AutoLevelSkills", true)
DravenMenu.Misc:Boolean("QAA","Draw QAA Text", true)
DravenMenu.Misc:Boolean("DOHP","Draw DMG over HP", true)
DravenMenu.Misc:Info("Draven", " ")
DravenMenu.Misc:Boolean("MGUN","Ultimate Notifier", true)
DravenMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
DravenMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 25, 5, 60, 1)
DravenMenu.Misc:Slider("MGUNX", "UN X POS", 35, 0, 1600, 1)
DravenMenu.Misc:Slider("MGUNY", "UN Y POS", 394, 0, 1055, 1)
 
minionManager = {}
minionManager.maxObjects = 0
minionManager.objects = {}
minionManager.unsorted = {}
minionManager.tick = 0
mapID = GetMapID()
spellData = 
	{
	[_Q] = {dmg = function () return (GetBonusDmg(myHero)+GetBaseDamage(myHero))*(0.35 + GetCastLevel(myHero,_Q)*0.1) end,  
			CDR = function () return GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)) end,
			mana = 45,
			range = 550},  
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

GAPCLOSER_SPELLS = {
    ["Aatrox"]                      = {_Q},
    ["Akali"]                       = {_R},
    ["Alistar"]                     = {_W},
    ["Amumu"]                       = {_Q},
    ["Corki"]                       = {_W},
    ["Diana"]                       = {_R},
    ["Elise"]                       = {_Q, _E},
    ["FiddleSticks"]                = {_R},
    ["Ezreal"]                      = {_E},
    ["Fiora"]                       = {_Q},
    ["Fizz"]                        = {_Q},
    ["Gnar"]                        = {_E},
    ["Gragas"]                      = {_E},
    ["Graves"]                      = {_E},
    ["Hecarim"]                     = {_R},
    ["Irelia"]                      = {_Q},
    ["JarvanIV"]                    = {_Q, _R},
    ["Jax"]                         = {_Q},
    ["Jayce"]                       = {_Q},
    ["Katarina"]                    = {_E},
    ["Kassadin"]                    = {_R},
    ["Kennen"]                      = {_E},
    ["KhaZix"]                      = {_E},
    ["Lissandra"]                   = {_E},
    ["LeBlanc"]                     = {_W, _R},
    ["LeeSin"]                      = {_Q, _W},
    ["Leona"]                       = {_E},
    ["Lucian"]                      = {_E},
    ["Malphite"]                    = {_R},
    ["MasterYi"]                    = {_Q},
    ["MonkeyKing"]                  = {_E},
    ["Nautilus"]                    = {_Q},
    ["Nocturne"]                    = {_R},
    ["Olaf"]                        = {_R},
    ["Pantheon"]                    = {_W, _R},
    ["Poppy"]                       = {_E},
    ["RekSai"]                      = {_E},
    ["Renekton"]                    = {_E},
    ["Riven"]                       = {_Q, _E},
    ["Rengar"]                      = {_R},
    ["Sejuani"]                     = {_Q},
    ["Sion"]                        = {_R},
    ["Shen"]                        = {_E},
    ["Shyvana"]                     = {_R},
    ["Talon"]                       = {_E},
    ["Thresh"]                      = {_Q},
    ["Tristana"]                    = {_W},
    ["Tryndamere"]                  = {_E},
    ["Udyr"]                        = {_E},
    ["Volibear"]                    = {_Q},
    ["Vi"]                          = {_Q},
    ["XinZhao"]                     = {_E},
    ["Yasuo"]                       = {_E},
    ["Zac"]                         = {_E},
    ["Ziggs"]                       = {_W},
}

reticles = {}
local spellText = { "Q", "W", "E", "R" }

local callback = nil
local myTeam = GetTeam(GetMyHero())

local d = require 'DLib'
local GetEnemyHeroes = d.GetEnemyHeroes
local CHANELLING_SPELLS_enemy = {}
local GAPCLOSER_SPELLS_enemy = {}
--local submenu = menu.addItem(SubMenu.new("interrupter"))

--local submenuGapClose = submenu.addItem(SubMenu.new("gap close spell"))
--local submenuChannell = submenu.addItem(SubMenu.new("chanelling spell"))

DravenMenu:SubMenu("interrupt", "Interrupt Spells")
DravenMenu:SubMenu("gapclose", "Gap Close Spells")

--DravenMenu.interrupt:Boolean("Interrupt", "Auto Interrupt Spells", true)

local loaded = false
unit = GetCurrentTarget()
target = GetCurrentTarget()

d.initCallback(function(result)
    if result then
        for _,enemy in pairs(GetEnemyHeroes()) do
            local name = GetObjectName(enemy)
            
            local list = GAPCLOSER_SPELLS[name]
            if list then
                for _, spellSlot in pairs(list) do
                    GAPCLOSER_SPELLS_enemy[name..spellSlot] = DravenMenu.gapclose:Boolean("gapclose", name.." "..spellText[spellSlot+1], true)
                end
            end
            list = CHANELLING_SPELLS[name]
            if list then
                for _, spellSlot in pairs(list) do
                    CHANELLING_SPELLS_enemy[name..spellSlot] = DravenMenu.interrupt:Boolean("interrupt", name.." "..spellText[spellSlot+1], true)
                end
            end
            -- PrintChat(name)
        end
        loaded = true
        PrintChat("[interrupter] : loaded")
    end
end)


OnProcessSpell(function(unit, spell)    
    if not loaded and not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == myTeam then return end
    for _,unit in pairs(GetEnemyHeroes()) do
    local unitName = GetObjectName(unit)
    local unitChanellingSpells = CHANELLING_SPELLS[unitName]
    local unitGapcloserSpells = GAPCLOSER_SPELLS[unitName]
    local spellName = spell.name

    if unitChanellingSpells then
        for _, spellSlot in pairs(unitChanellingSpells) do
            -- PrintChat(spell.name.." "..GetCastName(unit, spellSlot))
            if spellName == GetCastName(unit, spellSlot) and DravenMenu.interrupt.interrupt:Value() then callback(unit, CHANELLING_SPELLS, spell) end
        end
    elseif unitGapcloserSpells then
        for _, spellSlot in pairs(unitGapcloserSpells) do
            if spellName == GetCastName(unit, spellSlot) and DravenMenu.gapclose.gapclose:Value() then callback(unit, GAPCLOSER_SPELLS, spell) end
        end
    end
    end
end)

function addInterrupterCallback( callback0 )
	callback = callback0
end

PrintChat("[interrupter] : loading...")
tick = 0
tick2 = 0
OnCreateObj(function(Object)
  -- Creation of the reticle position
  if GetObjectBaseName(Object) == "Draven_Base_Q_reticle_self.troy" then
    table.insert(reticles, Object)
    tick = GetGameTimer() + 1.8
    tick2 = GetGameTimer() + 1.8
  end
end)

OnDeleteObj(function(Object)
  myHer0 = GetOrigin(myHero)
if GetObjectBaseName(Object) == "Draven_Base_Q_reticle_self.troy" then
  table.remove(reticles, 1)
end
end)

OnLoop(function(myHero)
	Checks()
 --CircleQM()
   ItemUse()
   Killsteal()
   CatchQ()   
   Ignite()
	if DravenMenu.Misc.DOHP:Value() then 
		Draws()
	end
	if IOW:Mode() == "LastHit" then 
    	LastHit(minion)
    end	  
	if IOW:Mode() == "LaneClear" then
    IOW:EnableMovement()
    	LaneClear(minion)
      JungleClear(jminion)
    end	
	if IOW:Mode() == "Combo" then
    IOW:EnableMovement()
		Combo()
	end
	if IOW:Mode() == "Harass" then
    IOW:EnableMovement()
		Harass()
	end
	if DravenMenu.Misc.MGUN:Value() then
		GLOBALULTNOTICE()
	end	
  if DravenMenu.Misc.MGUNDEB:Value() then
    GLOBALULTNOTICEDEBUG()
  end
	if DravenMenu.Misc.QAA:Value() then
		QAA()
	end		
	if DravenMenu.Misc.AL:Value() then --and mapID == SUMMONERS_RIFT
		AutoLvL()
	end	
end)
  
function QAA()
	for i,unit in pairs(Gos:GetEnemyHeroes()) do
		local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
		local unitPos = GetOrigin(unit)
		local dmgE = spellData[_Q].dmg() + TotalDmg	
		local dmg = GoS:CalcDamage(myHero, unit, dmgE)
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
        if dmg > 0 then 
          DrawText(math.ceil(hp/dmg).." QAA", 15, hPos.x, hPos.y+20, 0xffffffff)
	 	end 	
end
end

function Draws()
  	for _,unit in pairs(Gos:GetEnemyHeroes()) do	
  local Qdmg = spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero)
local QREADY = QREADY or QSpinn1
	if GoS:ValidTarget(unit,20000) and QREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,GoS:CalcDamage(myHero, unit, Qdmg, 0),0xffffffff)	
  end  
  end
end

function Checks()
	QREADY = CanUseSpell(myHero,_Q) == READY
	WREADY = CanUseSpell(myHero,_W) == READY
	EREADY = CanUseSpell(myHero,_E) == READY
	RREADY = CanUseSpell(myHero,_R) == READY
	target = GetCurrentTarget()--GetTarget(1250, DAMAGE_PHYSICAL)
	--targetDRAW = GetTarget(20000, DAMAGE_PHYSICAL)  
	targetPos = GetOrigin(target)
	myHeroPos = GetOrigin(myHero)
	Q0 = GotBuff(myHero,"dravenspinningattack") == 0	
	Q1 = GotBuff(myHero,"dravenspinningattack") == 1
	Q2 = GotBuff(myHero,"dravenspinningattack") == 2
	QL0 = GotBuff(myHero,"dravenspinningleft") == 0	
	QL1 = GotBuff(myHero,"dravenspinningleft") == 1		
	QSpinn0 = GotBuff(myHero,"DravenSpinning") == 0	
	QSpinn1 = GotBuff(myHero,"DravenSpinning") == 1
  enemygotbansheesveil = GotBuff(target,"bansheesveil") == 1 
  
--buffdatas2 = GetBuffData(myHero,"dravenpassive");
--DrawText(string.format("[dravenpassive INFO]", buffdatas2.Type),12,200,20,0xff00ff00);
--DrawText(string.format("Type = %d", buffdatas2.Type),12,200,30,0xff00ff00);
--DrawText(string.format("Name = %s", buffdatas2.Name),12,200,40,0xff00ff00);
--DrawText(string.format("Count = %d", buffdatas2.Count),12,200,50,0xff00ff00);
--DrawText(string.format("Stacks = %f", buffdatas2.Stacks),12,200,60,0xff00ff00);
--DrawText(string.format("StartTime = %f", buffdatas2.StartTime),12,200,70,0xff00ff00);
--DrawText(string.format("ExpireTime = %f", buffdatas2.ExpireTime),12,200,80,0xff00ff00);
--DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,200,90,0xff00ff00);
--DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas2.Type)),12,200,110,0xffffff00);
 
--buffdatas = GetBuffData(myHero,"dravenpassivestacks");
--DrawText(string.format("[dravenpassivestacks INFO]", buffdatas.Type),12,200,130,0xff00ff00);
--DrawText(string.format("Type = %d", buffdatas.Type),12,200,140,0xff00ff00);
--DrawText(string.format("Name = %s", buffdatas.Name),12,200,150,0xff00ff00);
--DrawText(string.format("Count = %d", buffdatas.Count),12,200,160,0xff00ff00);
--DrawText(string.format("Stacks = %f", buffdatas.Stacks),12,200,170,0xff00ff00);
--DrawText(string.format("StartTime = %f", buffdatas.StartTime),12,200,180,0xff00ff00);
--DrawText(string.format("ExpireTime = %f", buffdatas.ExpireTime),12,200,190,0xff00ff00);
--DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,200,200,0xff00ff00);
--DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas.Type)),12,200,220,0xffffff00); 
end

function LastHit(minion)
    --  Move()
    for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
      local QDmg = spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero) or 0  
      local DamageQ = GoS:CalcDamage(myHero, minion, QDmg, 0)
      local  targetPos123 = GetOrigin(minion) 
    if DravenMenu.Clear.LHQ:Value() and GetCurrentHP(minion) < DamageQ then
			if QREADY and QSpinn0 and Q0 and GoS:IsInDistance(minion, spellData[_Q].range) and GoS:ValidTarget(minion, spellData[_Q].range) then			
				CastSpell(_Q) GoS:DelayAction(function() AttackUnitM(minion) end, 100)
			end
			if QSpinn1 and Q1 and Q2 and GoS:IsInDistance(minion, spellData[_Q].range) and GoS:ValidTarget(minion, spellData[_Q].range) then
        AttackUnitM(minion)
			end
			if QSpinn1 and Q2 and QL0 and GoS:IsInDistance(minion, spellData[_Q].range) and GoS:ValidTarget(minion, spellData[_Q].range)then	
        AttackUnitM(minion)
			end
			if QSpinn1 and Q2 and QL1 and GoS:IsInDistance(minion, spellData[_Q].range) and GoS:ValidTarget(minion, spellData[_Q].range)then	
        AttackUnitM(minion)
      end
			if QSpinn1 and GoS:IsInDistance(minion, spellData[_Q].range) and GoS:ValidTarget(minion, spellData[_Q].range)then	
        AttackUnitM(minion)
      end
    end
  end
end

--function CatchQ()
--      if DravenMenu.Combo.CQ:Value() then
--      for i, reticle in pairs(reticles) do
--        local Reticlepos = GetOrigin(reticle)
--        local myHer0 = GetOrigin(myHero)
--        local mymouse = GetCursorPos()
--        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,120,1,100,0xff0000ff)
--        DrawCircle(mymouse.x, mymouse.y, mymouse.z,DravenMenu.Combo.CQPR:Value(),1,100,0xff0000ff)
--          if GoS:GetDistance(Reticlepos, myHer0) < DravenMenu.Combo.CQPR:Value() then 
--          MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z)
--          end
--      end
--      end
--end

function CatchQ()
      if DravenMenu.Combo.CQ:Value() and DravenMenu.Combo.QC:Value() then
        local mymouse = GetMousePos()
        DrawCircle(mymouse,DravenMenu.Combo.CQPR:Value(),0.9,100,0xff0000ff)
      end    
      for i, reticle in pairs(reticles) do
        local Reticlepos = GetOrigin(reticle)
        local myHer0 = GetOrigin(myHero)
        local mymouse = GetMousePos()
        local asTime = IOW:GetFullAttackSpeed()*60
        if DravenMenu.Combo.CM:Value() then
        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,120,3,100,0xff00ff7f)
        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,60,1,100,0xffff6600)
        end
        if DravenMenu.Combo.CQ:Value() then
          if GoS:GetDistance(Reticlepos, mymouse) < DravenMenu.Combo.CQPR:Value() and tick > GetGameTimer() then --and GetTickCount() < tick
          IOW:DisableMovement() GoS:DelayAction(function()  GoS:DelayAction(function() MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z) GoS:DelayAction(function() IOW:EnableMovement() end, 1) end, 1) end, 100) --tick = 0
          end
        end
        if DravenMenu.Combo.CWS:Value() and GetCurrentMana(myHero)/GetMaxMana(myHero) > (DravenMenu.Combo.WMANA:Value()/100) then
          local catchtime = GoS:GetDistance(Reticlepos, myHero)/GetMoveSpeed(myHero)
          if catchtime > (tick2-GetGameTimer()) then 
          CastSpell(_W)
          end
        end
      end
end

function AttackUnitM(minion)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
  if GoS:IsInDistance(minion, GetRange(myHero)) and GoS:GetDistance(myHero, minion) <= (GetRange(myHero)) and GoS:GetDistance(myHero, minion) >= 1 then 
    AttackUnit(minion)
  end
  end
end


--function CircleQM()
--    for i,minionQM in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
--      local QDmg = spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero) or 0  
--      local DamageQ = GoS:CalcDamage(myHero, minionQM, QDmg, 0)
--      local  targetPos123 = GetOrigin(minionQM) 
--      --local eminion = CountMinions()
----local HP = PredictHealth(minion, orbTable.windUp + GoS:GetDistance(minion)/1700.0000 - 0.07)
--    if DravenMenu.Clear.LHQCircle:Value() and GetCurrentHP(minionQM) < DamageQ and GoS:IsInDistance(minion, spellData[_Q].range+100)then	
--				      DrawCircle(targetPos123.x,targetPos123.y,targetPos123.z,50,0,0,0xffff0000)
--    end
--  end
--end

function LaneClear(minion)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do   
		if QREADY and DravenMenu.Clear.LCQ:Value() then
			if QSpinn0 and Q0 and GoS:IsInDistance(minion, spellData[_Q].range+100) and GoS:ValidTarget(minion, spellData[_Q].range+100) then			
				CastSpell(_Q) 
			end
			if QSpinn1 and Q1 and Q2 and GoS:IsInDistance(minion, spellData[_Q].range+100) and GoS:ValidTarget(minion, spellData[_Q].range+100) then
			
			end
			if QSpinn1 and Q2 and QL0 and GoS:IsInDistance(minion, spellData[_Q].range+100) and GoS:ValidTarget(minion, spellData[_Q].range+100)then	
				
			end
			if QSpinn1 and Q2 and QL1 and GoS:IsInDistance(minion, spellData[_Q].range+100) and GoS:ValidTarget(minion, spellData[_Q].range+100)then	
        
      end
    end
	end
end

function JungleClear(jminion)
		for i,jminion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
      if QREADY and DravenMenu.Clear.LCJQ:Value() then
			if QSpinn0 and Q0 and GoS:IsInDistance(jminion, spellData[_Q].range+100) and GoS:ValidTarget(jminion, spellData[_Q].range+100) then			
				CastSpell(_Q)
      end
			if QSpinn1 and Q1 and Q2 and GoS:IsInDistance(jminion, spellData[_Q].range+100) and GoS:ValidTarget(jminion, spellData[_Q].range+100) then
			-- DelayAction(function() AttackUnit(jminion) end, 100) 
      end
			if QSpinn1 and Q2 and QL0 and GoS:IsInDistance(jminion, spellData[_Q].range+100) and GoS:ValidTarget(jminion, spellData[_Q].range+100)then	
		--	DelayAction(function() AttackUnit(jminion) end, 100) 
      end
			if QSpinn1 and Q2 and QL1 and GoS:IsInDistance(jminion, spellData[_Q].range+100) and GoS:ValidTarget(jminion, spellData[_Q].range+100)then	
			--	 DelayAction(function() AttackUnit(jminion) end, 100) 
      end
    end
		end		
end

function AttackUnitJ(minion)
	for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do  
  if GoS:IsInDistance(minion, GetRange(myHero)) and GoS:GetDistance(myHero, minion) <= (GetRange(myHero)) and GoS:GetDistance(myHero, minion) >= 1 then 
    AttackUnit(minion)
  end
  end
end

function CastPredE(target)
	local unitPos = GetOrigin(target)
		local EPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), spellData[_E].speed, spellData[_E].delay, spellData[_E].range-25, spellData[_E].width, false, true)
		if EREADY and EPred.HitChance == 1 then
			if GoS:GetDistance(myHero, target) > spellData[_Q].range and GoS:GetDistance(myHero, target) <= spellData[_E].range and GoS:ValidTarget(unit, spellData[_E].range) then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end		
end

function CastPredEBanshe(target)
  for _,unit in pairs(Gos:GetEnemyHeroes()) do 
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(GetOrigin(myHero), unit, GetMoveSpeed(unit), spellData[_E].speed, spellData[_E].delay, spellData[_E].range-25, spellData[_E].width, false, true)
		if EREADY and EPred.HitChance == 1 then
			if GoS:GetDistance(myHero, unit) > spellData[_Q].range and GoS:GetDistance(myHero, unit) <= spellData[_E].range and GoS:ValidTarget(unit, spellData[_E].range) then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end	
    end
end

function CastQ(target)
  --     	for _,unit in pairs(Gos:GetEnemyHeroes()) do
       	if QREADY and GoS:ValidTarget(target, spellData[_Q].range+100) then
			if QSpinn0 and Q0 and GoS:IsInDistance(target, spellData[_Q].range+100) and GoS:ValidTarget(target, spellData[_Q].range+100) then			
				CastSpell(_Q)
			end
			if QSpinn1 and Q1 and Q2 and GoS:IsInDistance(target, spellData[_Q].range+100) and GoS:ValidTarget(target, spellData[_Q].range+100) then
			end
			if QSpinn1 and Q2 and QL0 and GoS:IsInDistance(target, spellData[_Q].range+100) and GoS:ValidTarget(target, spellData[_Q].range+100)then			
			end
			if QSpinn1 and Q2 and QL1 and GoS:IsInDistance(target, spellData[_Q].range+100) and GoS:ValidTarget(target, spellData[_Q].range+100)then			
			end
		end				
	--	end
end

function CastW(target)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = spellData[_Q].mana
	local Wmana = spellData[_W].mana
  --for _,unit in pairs(Gos:GetEnemyHeroes()) do
	if WREADY and igotmana >= Qmana + Wmana then
	 	if GoS:ValidTarget(target, spellData[_Q].range*1.7) and GoS:GetDistance(myHero, target) > spellData[_Q].range+50 and  GoS:GetDistance(myHero, target) < spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
	--end
  end
end

function CastWnoMana(target)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = spellData[_Q].mana
	local Wmana = spellData[_W].mana
	if WREADY then
	 	if GoS:ValidTarget(target, spellData[_Q].range*1.7) and GoS:GetDistance(myHero, target) > spellData[_Q].range+50 and  GoS:GetDistance(myHero, target) < spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
	end
end

function CastPredR(target)
	local unitPos = GetOrigin(target)
	local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target), spellData[_R].speed, spellData[_R].delay, spellData[_R].range, spellData[_R].width, false, true)
				if GoS:GetDistance(myHero, target) > 750 and GoS:GetDistance(myHero, target) < 4000 and IsObjectAlive(target) then		
			if RREADY and GoS:ValidTarget(target, spellData[_R].range) and RPred.HitChance == 1 then
				CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
				end
			end	
end

			
function Combo()
  local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
		if DravenMenu.Combo.Q:Value() then
		CastQ(target)
    end
		if DravenMenu.Combo.W:Value() and GetCurrentMana(myHero)/GetMaxMana(myHero) > (DravenMenu.Combo.WMANA:Value()/100) then
		CastW(target)
    end
    if DravenMenu.Combo.EB:Value() and enemygotbansheesveil then
    CastPredEBanshe(target)
    end
    if DravenMenu.Combo.E:Value() then
    CastPredE(target)
    end  
    if DravenMenu.Combo.R:Value() then
    CastPredR(target)
    end
end	
function Harass()
    local unit = GetCurrentTarget()
    local target = GetCurrentTarget()
    if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
		if DravenMenu.Harass.QH:Value() then
		CastQ(target)		
    end
		if DravenMenu.Harass.WH:Value() and GetCurrentMana(myHero)/GetMaxMana(myHero) > (DravenMenu.Harass.WMANA:Value()/100) then
		CastW(target)	 
    end
    if DravenMenu.Harass.EHB:Value() and enemygotbansheesveil then
    CastPredEBanshe(target)
     end
    if DravenMenu.Harass.EH:Value() then
    CastPredE(target)
    end  
    if DravenMenu.Harass.RH:Value() then
    CastPredR(target)
    end
end

function Killsteal()
	for i,enemy in pairs(Gos:GetEnemyHeroes()) do
	local QDmg = QREADY and spellData[_Q].dmg() or 0
	local QDmg2 = spellData[_Q].dmg() or 0	
    local EDmg = EREADY and spellData[_E].dmg() or 0
    local RDmg = RREADY and spellData[_R].dmg() or 0
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy)
	local Alldmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	local unitPos = GetOrigin(enemy)
--	local MoveToUnit = MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
		if DravenMenu.Killsteal.KSQE:Value() and GoS:ValidTarget(enemy, spellData[_E].range) and enemyhp < GoS:CalcDamage(myHero, enemy, EDmg, 0) then
			CastPredE(enemy)
		elseif GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, QDmg + Alldmg, 0) then
			CastQ(enemy)
		elseif DravenMenu.Killsteal.KSQE:Value() and GoS:ValidTarget(enemy, spellData[_Q].range) and enemyhp < GoS:CalcDamage(myHero, enemy, QDmg2 + Alldmg, 0) and QSpinn1 then 
      AttackUnitKS(enemy)
		elseif DravenMenu.Killsteal.KSR:Value() and GoS:ValidTarget(enemy, spellData[_R].range) and enemyhp < GoS:CalcDamage(myHero, enemy, RDmg, 0) then
			CastPredR(enemy)
		elseif DravenMenu.Killsteal.KSQE:Value() and GoS:ValidTarget(enemy, spellData[_E].range) and GoS:GetDistance(myHero, enemy) > 550 and GoS:GetDistance(myHero, enemy) < 700 and enemyhp < GoS:CalcDamage(myHero, enemy, QDmg + Alldmg + EDmg, 0) then		
			CastPredE(enemy) GoS:DelayAction(function() CastWnoMana(enemy) GoS:DelayAction(function() CastPredE(enemy) GoS:DelayAction(function() AttackUnitKS(enemy) end, 100) end, 200) end, 300)
		elseif DravenMenu.Killsteal.KSQE:Value() and GoS:ValidTarget(enemy, spellData[_E].range) and GoS:GetDistance(myHero, enemy) > 550 and GoS:GetDistance(myHero, enemy) < 700 and enemyhp < GoS:CalcDamage(myHero, enemy, QDmg2 + Alldmg + EDmg, 0) and QSpinn1 then			
			CastPredE(enemy) GoS:DelayAction(function() CastWnoMana(enemy) GoS:DelayAction(function() CastPredE(enemy) GoS:DelayAction(function() AttackUnitKS(enemy) end, 100) end, 200) end, 300)				
		end	
	end	
end

function Ignite()
      local Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
    if GoS:ValidTarget(unit, 700) and Ignite and DravenMenu.Items.Ignite:Value() and CanUseSpell(myHero,_W) ~= READY and  GoS:GetDistance(unit) > 500 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function ItemUse()
  for _,target in pairs(Gos:GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and DravenMenu.Items.bork:Value() and GoS:ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (DravenMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (DravenMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and DravenMenu.Items.CutBlade:Value() and GoS:ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (DravenMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (DravenMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and DravenMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GoS:ValidTarget(target, DravenMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and DravenMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < DravenMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and DravenMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < DravenMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if DravenMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(target,DravenMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
      end
end      

function AttackUnitKS(target)
	for i,enemy in pairs(Gos:GetEnemyHeroes()) do  
  if GoS:IsInDistance(enemy, GetRange(myHero)) and GoS:GetDistance(myHero, enemy) <= (GetRange(myHero)-10) and GoS:GetDistance(myHero, enemy) >= 10 then 
    AttackUnit(enemy)
  else
  end
  end
end

function GLOBALULTNOTICE()
      if not RREADY then return end
        info = ""
        if RREADY then
       		for _,unit in pairs(Gos:GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = GoS:CalcDamage(myHero, unit, spellData[_R].dmg())
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not GoS:ValidTarget(unit, spellData[_R].range) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,DravenMenu.Misc.MGUNSIZE:Value(),DravenMenu.Misc.MGUNX:Value(),DravenMenu.Misc.MGUNY:Value(),0xffff0000)   
end

function GLOBALULTNOTICEDEBUG()	 
    DrawText("I am in Range but not killable - TESTMODE ON",DravenMenu.Misc.MGUNSIZE:Value(),DravenMenu.Misc.MGUNX:Value(),DravenMenu.Misc.MGUNY:Value(),0xffff0000)   
end

function AutoLvL()
if GetLevel(myHero) == 1 and GetLevel(myHero) < 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 and GetLevel(myHero) < 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 3 and GetLevel(myHero) < 4 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 4 and GetLevel(myHero) < 5 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 5 and GetLevel(myHero) < 6 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 and GetLevel(myHero) < 8 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 and GetLevel(myHero) < 9 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 9 and GetLevel(myHero) < 10 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 10 and GetLevel(myHero) < 11 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 11 and GetLevel(myHero) < 12 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 12 and GetLevel(myHero) < 13 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 13 and GetLevel(myHero) < 14 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 14 and GetLevel(myHero) < 15 then
	LevelSpell(_E)
 elseif GetLevel(myHero) == 15 and GetLevel(myHero) < 16 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 16 and GetLevel(myHero) < 17 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 17 and GetLevel(myHero) < 18 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
	LevelSpell(_E)
end
end

OnProcessSpell(function(unit, spell) 
  for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
    local RDmg = spellData[_R].dmg() or 0
    local QDmg = spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero) or 0  
    local EDmg = spellData[_E].dmg() or 0      
    local DamageR = GoS:CalcDamage(myHero, mob, RDmg, 0)
    local DamageE = GoS:CalcDamage(myHero, mob, EDmg, 0) 
    local DamageQ = GoS:CalcDamage(myHero, mob, QDmg, 0)    
    local mobPos = GetOrigin(mob) 
--    if GoS:IsInDistance(mob, GetCastRange(myHero,_E)) and EREADY and GetObjectName(mob) == "SRU_Baron" and KSBlueE.getValue() and GetCurrentHP(mob) < DamageE then
--					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)
--    elseif GoS:IsInDistance(mob, GetCastRange(myHero,_E)) and EREADY and GetObjectName(mob) == "SRU_Dragon" and KSRedE.getValue() and GetCurrentHP(mob) < DamageE then
--					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)      
--    elseif GoS:IsInDistance(mob, GetCastRange(myHero,_E)) and EREADY and GetObjectName(mob) == "SRU_Blue" and KSBlueE.getValue() and GetCurrentHP(mob) < DamageE then
--					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)
--    elseif GoS:IsInDistance(mob, GetCastRange(myHero,_E)) and EREADY and GetObjectName(mob) == "SRU_Red" and KSRedE.getValue() and GetCurrentHP(mob) < DamageE then
--					CastSkillShot(_E,mobPos.x,mobPos.y,mobPos.z)
--	  elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Baron" and KSBaronQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)
--	  elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Dragon" and KSDragonQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q) 
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Blue" and KSBlueQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Red" and KSRedQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)          
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Krug" and KSKrugQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q) 
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Murkwolf" and KSWolfQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)    
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Razorbeak" and KSwraithsQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)  
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "SRU_Gromp" and KSgrompQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q) 
--    elseif GoS:IsInDistance(mob, 550) and (QREADY or QSpinn1) and GetObjectName(mob) == "Sru_Crab" and KScrabQ.getValue() and GetCurrentHP(mob) < DamageQ then
--					CastTargetSpell(mob,_Q)
	  if GoS:IsInDistance(mob, GetCastRange(myHero,_R)) and GoS:GetDistance(myHero, mob) >= (GetCastRange(myHero,_Q)+100) and RREADY and GetObjectName(mob) == "SRU_Baron" and DravenMenu.Steal.Baron:Value() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z)
	  elseif GoS:IsInDistance(mob, GetCastRange(myHero,_R)) and GoS:GetDistance(myHero, mob) >= (GetCastRange(myHero,_Q)+100) and RREADY and GetObjectName(mob) == "SRU_Dragon" and DravenMenu.Steal.Dragon:Value() and GetCurrentHP(mob) < DamageR then
					CastSkillShot(_R,mobPos.x,mobPos.y,mobPos.z)          
    end
  end
 end)

addInterrupterCallback(function(target, spellType, spell)
    local EPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), spellData[_E].speed, spellData[_E].delay, spellData[_E].range, spellData[_E].width, false, true)
    if GoS:IsInDistance(target, spellData[_E].range) and EREADY then --and DravenMenu.Close.Gapclose:Value() and spellType == GAPCLOSER_SPELLS then   
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)  
--    elseif GoS:IsInDistance(target, spellData[_E].range-5) and EREADY and DravenMenu.Close.Interrupt:Value() and spellType == CHANELLING_SPELLS then   
--      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) 
    end  
end) 

--AddGapcloseEvent(_E, 1000, true)

--notification("MarCiii on Tour´s Draven loaded.", 10000)