require("Inspired")
--require("MoTBaseUtility")
local MoTreleaseversion = 1
local MoTAnivia = 4 - MoTreleaseversion       --4 == 1.3
local MoTTwistedFate = 1 - MoTreleaseversion  --1 == 1.0
local MoTDraven = 2                           --2 == 1.1
local MoTOlaf = 1                           --1 == 1.0
local MoTGnar = 2                           --2 == 1.1
local MoTFULLVERSION = MoTAnivia+MoTDraven+MoTTwistedFate+MoTOlaf+MoTGnar
local MoTBaseVersion = "MoTBase: v1."..MoTFULLVERSION.." by MarCiii"

-------------TWISTED FATE----------------

class "TwistedFate"
function TwistedFate:__init()
print(MoTBaseVersion)  
self.Version = "1.0"
self.MonTourMenu = MenuConfig("MoT-TwistedFate", "MoT-TwistedFate")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Boolean("Q", "Use Q", true)
self.MonTourMenu.Combo:Info("TwistedFate", "Use Q only in AA")
self.MonTourMenu.Combo:List("QR", "Range with Active Card?", 1, {"Yes", "No"})
self.MonTourMenu.Combo:List("QR2", "Use Q if Cards on CD?", 1, {"Yes", "No, At Any Time"})
self.MonTourMenu.Combo:Boolean("Card", "Use Cards in Combo?", true)
self.MonTourMenu.Combo:List("prio", "Which Card in Combo?", 1, {"Yellow", "Blue", "Red"})
self.MonTourMenu.Combo:Slider("Mana", "Use Blue Card if Mana < x%", 40, 1, 90, 1)
self.MonTourMenu.Combo:Key("Yellow", "Yellow Card", string.byte("A"))
self.MonTourMenu.Combo:Key("Blue", "Blue Card", string.byte("E"))
self.MonTourMenu.Combo:Key("Red", "Red Card", string.byte("T"))
self.MonTourMenu.Combo:Info("TwistedFate", "If manually pressing R")
self.MonTourMenu.Combo:Boolean("R", "then Auto use StunCard?", true)
self.MonTourMenu:SubMenu("Harass", "Harass")
self.MonTourMenu.Harass:Boolean("Q", "Use Q", true)
self.MonTourMenu.Harass:Info("TwistedFate", "Use Q only in AA")
self.MonTourMenu.Harass:List("QR", "Range with Active Card?", 2, {"Yes", "No"})
self.MonTourMenu.Harass:List("QR2", "Use Q if Cards on CD?", 2, {"Yes", "No, At Any Time"})
self.MonTourMenu.Harass:Boolean("Card", "Use Cards in Combo?", true)
self.MonTourMenu.Harass:List("prio", "Which Card in Combo?", 1, {"Yellow", "Blue", "Red"})
self.MonTourMenu.Harass:Slider("Mana", "Use Blue Card if Mana < x%", 40, 1, 90, 1)
self.MonTourMenu:SubMenu("Farm", "LastHit")
self.MonTourMenu.Farm:Boolean("Card", "LastHit with Cards?", true)
self.MonTourMenu.Farm:List("prio", "Which Card in LastHit?", 2, {"Yellow", "Blue", "Red"})
self.MonTourMenu.Farm:Slider("Mana", "Blue Card if Mana < x%", 60, 1, 90, 1)
self.MonTourMenu:SubMenu("Farm2", "LaneClear")
self.MonTourMenu.Farm2:Boolean("Card", "LaneClear with Cards?", true)
self.MonTourMenu.Farm2:List("prio", "Which Card in LaneClear?", 3, {"Yellow", "Blue", "Red"})
self.MonTourMenu.Farm2:Slider("Mana", "Blue Card if Mana < x%", 60, 1, 90, 1)
self.MonTourMenu:SubMenu("Items", "Items&Ignite")
self.MonTourMenu.Items:Boolean("Ignite", "Use Ignite", true)
self.MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
self.MonTourMenu.Items:Slider("QSSHP", "if My Health < x% (Def.75)", 75, 0, 100, 1)
self.MonTourMenu.Items:Boolean("Zhonya", "Always Use Zhonyas", true)
self.MonTourMenu.Items:Slider("ZhonyaHP", "if My Health < x% (Def.30)", 30, 0, 90, 1)
self.MonTourMenu:SubMenu("Interrupter", "Interrupter")
self.MonTourMenu:SubMenu("Misc", "Misc")
self.MonTourMenu.Misc:Boolean("DOH", "Draw DmgOverHPBars", true)
self.MonTourMenu.Misc:Boolean("DKS", "Draw Killable Text", true)
self.MonTourMenu.Misc:Boolean("CTS","Draw Current Target",true)
self.MonTourMenu.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
self.MonTourMenu.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
self.targetsselect = TargetSelector(1460, TARGET_LESS_CAST, DAMAGE_MAGIC)
self.MonTourMenu:TargetSelector("ts", "TargetSelector", self.targetsselect)
self.MonTourMenu:Info("TwistedFateMoT", "")
self.MonTourMenu:Info("TwistedFateMoT2", MoTBaseVersion)
self.MonTourMenu:Info("TwistedFateMoT3", "MoTBase "..GetObjectName(myHero)..": v"..self.Version)

self.tick = 0
self.ultimateused = false
self.tickwarn = 0
self.selectedcard = ""
self.OverAllDmgTwisted = 0

--Thanks to Deftsu for Interrupter :)
self.CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["Drain"]                       = {Name = "FiddleSticks", Spellslot = _W},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["FallenOne"]                   = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R},                        
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["UrgotSwap2"]                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                      = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R} 
}
DelayAction(function()
  local QWERSLOT = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(self.CHANELLING_SPELLS) do
    for _,unit in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(unit) then
        self.MonTourMenu.Interrupter:Boolean(GetObjectName(unit).."Interrupting", "On "..GetObjectName(unit).." "..(type(spell.Spellslot) == 'number' and QWERSLOT[spell.Spellslot]), true)
        end
    end
  end	
end, 20)

OnTick(function(myHero) self:Tick(myHero) end)
OnDraw(function(myHero) self:Draw(myHero) end)
OnProcessSpell(function(Object,spellProc) self:ProcessSpell(Object,spellProc) end)
OnProcessSpell(function(unit,spell) self:ProcessSpell2(unit,spell) end)
end

function TwistedFate:Tick(myHero)
  self:Items() 
  self:DMGCalcnKS()
if self.MonTourMenu.Items.Ignite:Value() then
  self:Igniteit()
end
	if self.selectedcard ~= "" then
		self:SelectCard()
	end		
	if self.MonTourMenu.Farm.Card:Value() and IOW:Mode() == "LastHit" and GetTickCount() > self.tick then
    self:LastHit()
	end 
	if self.MonTourMenu.Farm2.Card:Value() and IOW:Mode() == "LaneClear" and GetTickCount() > self.tick then
--    IOW:EnableAutoAttacks()
		self:LaneClear()
	end
	if IOW:Mode() == "Combo" then
		self:Combo()
	end
  if IOW:Mode() == "Harass" then
    self:Harass()
  end
  self:PickACard()
  self:Checks()
end

function TwistedFate:Draw(myHero)
if self.MonTourMenu.Misc.DOH:Value() then
  self:DMGoHP()
end  
	if self.MonTourMenu.Misc.DKS:Value() then
		self:Killable()
	end
if self.MonTourMenu.Misc.CTS:Value() then  
self:DrawENEMY()
end
end  

function TwistedFate:DrawENEMY()
	local hpbar = GetHPBarPos(myHero)
    if hpbar.x > 0 then
			if hpbar.y > 0 then  
      FillRect(hpbar.x, hpbar.y+13, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
      FillRect(hpbar.x, hpbar.y+22, 107, 2,ARGB(255,0,0,0))
      FillRect(hpbar.x+106, hpbar.y-2, 1, 24,ARGB(255,0,0,0))
--    FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
      end
    end
	if self.target ~= nil then
    if hpbar.x > 0 then
      if hpbar.y > 0 then
        DrawText(GetObjectName(self.target),14,hpbar.x+113-GetTextArea(GetObjectName(self.target).."  ",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
      end
    end  
	else
    if hpbar.x > 0 then
			if hpbar.y > 0 then
        DrawText("No Target found!",14,hpbar.x+113-GetTextArea("No Target found",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
      end
    end  
  end
--  FillRect(hpbar.x, hpbar.y+24, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
--  FillRect(hpbar.x, hpbar.y+33, 107, 2,ARGB(255,0,0,0))
--  FillRect(hpbar.x, hpbar.y+25, 25, 8,ARGB(255,255,255,0))
--  FillRect(hpbar.x+106, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
--  FillRect(hpbar.x, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
--  DrawText(" Q",10,hpbar.x+6, hpbar.y+23,ARGB(255,255,0,255))
----  DrawText(GetObjectName(myHero),12,hpbar.x+113-GetTextArea(GetObjectName(myHero),14)/2, hpbar.y+22,self.MonTourMenu.Misc.CTSC:Value())
--  DrawText("Lux",12,hpbar.x+107-GetTextArea("Lux",14)/2, hpbar.y+22,self.MonTourMenu.Misc.CTSC:Value())
	end

function TwistedFate:Checks()
self.MonTourMenu.ts.range = 1460
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()  
end

function TwistedFate:PickACard()
	if self.MonTourMenu.Combo.Blue:Value() and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  
  if self.MonTourMenu.Combo.Yellow:Value() and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	
	if self.MonTourMenu.Combo.Red:Value() and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "redcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
end

function TwistedFate:DMGCalcnKS()
  self.OverAllDmgTwisted = 0
	local ad = GetBonusDmg(myHero) + GetBaseDamage(myHero)
	local Wlevel = GetCastLevel(myHero,_W) - 1
	local Qlevel = GetCastLevel(myHero,_Q) - 1
	local Elevel = GetCastLevel(myHero,_E) - 1  
  local EPassive = 0
  local lichbane = 0 
  local sheendmg = 0	
  local Ludens = 0
  local bcard = (40 + (20 * Wlevel) + (ad) + (GetBonusAP(myHero) * 0.5 ))		
	local ycard = (15 + (7.5 * Wlevel) + (ad) + (GetBonusAP(myHero) * 0.5 ))
  local rcard = (30 + (15 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5))
	local qdmg = (60 + (50 * Qlevel) + (GetBonusAP(myHero) * 0.65 )) 
  if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
    lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
  end 
  if GotBuff(myHero, "sheen") >= 1 and GetItemSlot(myHero,3057) then
    sheendmg = sheendmg + GetBaseDamage(myHero)
  end
  if GotBuff(myHero, "cardmasterstackparticle") == 1 then
    EPassive = EPassive + 55 + (25 * Elevel) + (GetBonusAP(myHero) * 0.5 )
  end
  if GotBuff(myHero, "itemmagicshankcharge") > 99 then
    Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
  end    
	for _,unit in pairs(GetEnemyHeroes()) do 
			local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
--			local Qdmg = CalcDamage(myHero, unit, sheendmg, qdmg + Ludens) or 0      
--			local Ydmg = CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens) or 0
--      local ALLdmg = CalcDamage(myHero, unit, ad, EPassive) or 0
--			local Bdmg = CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens) or 0
--			local Rdmg = CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens) or 0	
--      local YBRdmg = CalcDamage(myHero, unit, sheendmg, ((rcard + bcard + ycard)/3) + qdmg + lichbane + EPassive + Ludens) or 0	
--      local YdmgmQ = CalcDamage(myHero, unit, sheendmg, ycard + lichbane + EPassive + Ludens) or 0
--			local BdmgmQ = CalcDamage(myHero, unit, sheendmg, bcard + lichbane + EPassive + Ludens) or 0
--			local RdmgmQ = CalcDamage(myHero, unit, sheendmg, rcard + lichbane + EPassive + Ludens) or 0	
--			local YBRdmgmQ = CalcDamage(myHero, unit, sheendmg, ((rcard + bcard + ycard)/3) + lichbane + EPassive + Ludens) or 0	
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,250,1450,40,false,true)    
	if CanUseSpell(myHero,_Q) == READY and GetCastName(myHero,_W) == "goldcardlock" then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens)	--and GotBuff(myHero,"goldcardpreattack") == 1
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,550) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end         
    end
  elseif CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "redcardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens)	--and GotBuff(myHero,"redcardpreattack") == 1
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,550) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "bluecardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens)	--and GotBuff(myHero,"bluecardpreattack") == 1
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,550) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif CanUseSpell(myHero,_Q) == READY and GetCastName(myHero,_W) == "PickACard" and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,600) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
          if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
              self.selectedcard = "bluecardlock"
              self.tick = GetTickCount() + 3000
              CastSpell(_W)
          end
        end
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end
    end    
  elseif (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "goldcardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, ycard + lichbane + EPassive + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "redcardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, rcard + lichbane + EPassive + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "bluecardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, bcard + lichbane + EPassive + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "PickACard" and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, bcard + lichbane + EPassive + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,600) then
          if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
              self.selectedcard = "bluecardlock"
              self.tick = GetTickCount() + 3000
              CastSpell(_W)
          end
        end
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif CanUseSpell(myHero,_Q) == READY and GetCastLevel(myHero,_W) == 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, qdmg + Ludens)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,600) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
    end    
  elseif CanUseSpell(myHero,_Q) == ONCOOLDOWN and CanUseSpell(myHero,_W) == ONCOOLDOWN then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, ad, EPassive)
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  end    
end
end
  
function TwistedFate:DMGoHP()
for i,unit in pairs(GetEnemyHeroes()) do 
if ValidTarget(unit,20000) then  
local enemyhp = GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
  if enemyhp < self.OverAllDmgTwisted then
    DrawDmgOverHpBar(unit,enemyhp,0,enemyhp,ARGB(255, 255, 0, 0)) 
  elseif enemyhp > self.OverAllDmgTwisted then
    DrawDmgOverHpBar(unit,enemyhp,0,self.OverAllDmgTwisted,ARGB(255, 255, 255, 255)) 
  end
end
end
end

function TwistedFate:Killable()
	local ad = GetBonusDmg(myHero) + GetBaseDamage(myHero)
	local Wlevel = GetCastLevel(myHero,_W) - 1
	local Qlevel = GetCastLevel(myHero,_Q) - 1
	local Elevel = GetCastLevel(myHero,_E) - 1  
  local EPassive = 0
  local lichbane = 0 
  local sheendmg = 0	
  local Ludens = 0
	local bcard = (40 + (20 * Wlevel) + (ad) + (GetBonusAP(myHero) * 0.5 ))		
	local ycard = (15 + (7.5 * Wlevel) + (ad) + (GetBonusAP(myHero) * 0.5 ))
  local rcard = (30 + (15 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5))
	local qdmg = (60 + (50 * Qlevel) + (GetBonusAP(myHero) * 0.65 ))
 if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
    lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
  end 
  if GotBuff(myHero, "sheen") >= 1 and GetItemSlot(myHero,3057) then
    sheendmg = sheendmg + GetBaseDamage(myHero)
  end
  if GotBuff(myHero, "cardmasterstackparticle") == 1 then
    EPassive = EPassive + 55 + (25 * Elevel) + (GetBonusAP(myHero) * 0.5 )
  end
  if GotBuff(myHero, "itemmagicshankcharge") > 99 then
    Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
  end    
	for _,unit in pairs(GetEnemyHeroes()) do
		if not IsDead(unit) and ValidTarget(unit,6500) then
			local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
			local Ydmg = CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens) or 0
			local Bdmg = CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens) or 0
			local Rdmg = CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens) or 0	
			if Ydmg > hp and self.tickwarn < GetTickCount() then
        local hpbar = GetHPBarPos(myHero)
				if hpbar.x > 0 then
					if hpbar.y > 0 then
  FillRect(hpbar.x, hpbar.y+24, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
  FillRect(hpbar.x, hpbar.y+33, 107, 2,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+25, 25, 8,ARGB(255,255,255,0))
  FillRect(hpbar.x+106, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  DrawText(" Q",10,hpbar.x+6, hpbar.y+23,ARGB(255,255,0,255))
  DrawText(GetObjectName(unit),12,hpbar.x+107-GetTextArea(GetObjectName(unit),14)/2, hpbar.y+22,self.MonTourMenu.Misc.CTSC:Value())		
					end
				end
				self.tickwarn = GetTickCount() + 5000
				return
			elseif Bdmg > hp then
				local hpbar = GetHPBarPos(myHero)
				if hpbar.x > 0 then
					if hpbar.y > 0 then
  FillRect(hpbar.x, hpbar.y+24, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
  FillRect(hpbar.x, hpbar.y+33, 107, 2,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+25, 25, 8,ARGB(255,0,0,255))
  FillRect(hpbar.x+106, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  DrawText(" Q",10,hpbar.x+6, hpbar.y+23,ARGB(255,255,255,255))
  DrawText(GetObjectName(unit),12,hpbar.x+107-GetTextArea(GetObjectName(unit),14)/2, hpbar.y+22,self.MonTourMenu.Misc.CTSC:Value())
					end
				end					
				self.tickwarn = GetTickCount() + 5000
				return
      elseif Rdmg > hp then
				local hpbar = GetHPBarPos(myHero)
				if hpbar.x > 0 then
					if hpbar.y > 0 then
  FillRect(hpbar.x, hpbar.y+24, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
  FillRect(hpbar.x, hpbar.y+33, 107, 2,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+25, 25, 8,ARGB(255,255,0,0))
  FillRect(hpbar.x+106, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  FillRect(hpbar.x, hpbar.y+24, 1, 11,ARGB(255,0,0,0))
  DrawText(" Q",10,hpbar.x+6, hpbar.y+23,ARGB(255,255,0,255))
  DrawText(GetObjectName(unit),12,hpbar.x+107-GetTextArea(GetObjectName(unit),14)/2, hpbar.y+22,self.MonTourMenu.Misc.CTSC:Value())
					end
				end					
				self.tickwarn = GetTickCount() + 5000
				return  
			end
		end
	end
--  DrawText(string.format("EPassive= %f", EPassive),25,478,256,ARGB(255, 255, 255, 255));
--  DrawText(string.format("lichbane= %f", lichbane),25,478,286,ARGB(255, 255, 255, 255));
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,316,ARGB(255, 255, 255, 255));
end

function TwistedFate:SelectCard()
	local name = GetCastName(myHero,_W):lower()
	if name == "goldcardlock" and self.selectedcard == name then
		CastSpell(_W)
		self.selectedcard = ""			
	end
	if name == "redcardlock" and self.selectedcard == name then
		CastSpell(_W)
		self.selectedcard = ""			
	end
	if name == "bluecardlock" and self.selectedcard == name then
		CastSpell(_W)
		self.selectedcard = ""			
	end
end

function TwistedFate:Combo()
  local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana*100
  local ManaValue = self.MonTourMenu.Combo.Mana:Value()	
if ValidTarget(self.target,1450) then
  	local QPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),1000,250,1450,40,false,true)
  if self.MonTourMenu.Combo.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if self.MonTourMenu.Combo.prio:Value() == 2 and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	if self.MonTourMenu.Combo.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "redcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if (self.MonTourMenu.Combo.prio:Value() == 1 or self.MonTourMenu.Combo.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if self.MonTourMenu.Combo.Q:Value() and self.MonTourMenu.Combo.QR:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and GetDistance(myHero, self.target) <= 525 and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Combo.Q:Value() and self.MonTourMenu.Combo.QR:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Combo.Q:Value() and self.MonTourMenu.Combo.QR2:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN and GetCastName(myHero,_W) == "PickACard" and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Combo.Q:Value() and self.MonTourMenu.Combo.QR2:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
end  
end
function TwistedFate:Harass()
  local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana*100
  local ManaValue = self.MonTourMenu.Harass.Mana:Value()	
if ValidTarget(self.target,1450) then		
  	local QPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),1000,250,1450,40,false,true)
  if self.MonTourMenu.Harass.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if self.MonTourMenu.Harass.prio:Value() == 2 and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	if self.MonTourMenu.Harass.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "redcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if (self.MonTourMenu.Harass.prio:Value() == 1 or self.MonTourMenu.Harass.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if self.MonTourMenu.Harass.Q:Value() and self.MonTourMenu.Harass.QR:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and GetDistance(myHero, self.target) <= 525 and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Harass.Q:Value() and self.MonTourMenu.Harass.QR:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Harass.Q:Value() and self.MonTourMenu.Harass.QR2:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN and GetCastName(myHero,_W) == "PickACard" and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if self.MonTourMenu.Harass.Q:Value() and self.MonTourMenu.Harass.QR2:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
end           
end

function TwistedFate:LastHit()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i] --MINION_ENEMY 
	local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana*100
  local ManaValue = self.MonTourMenu.Farm.Mana:Value()
  local ad = GetBonusDmg(myHero) + GetBaseDamage(myHero)
	local Wlevel = GetCastLevel(myHero,_W) - 1
	local Qlevel = GetCastLevel(myHero,_Q) - 1
  local Elevel = GetCastLevel(myHero,_E) - 1 
  local EPassive = 0
  local lichbane = 0 
  local sheendmg = 0
  local Ludens = 0
	local qdmg = (60 + (50 * Qlevel) + (GetBonusAP(myHero) * 0.65 ))
  if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
    lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
  end 
  if GotBuff(myHero, "sheen") >= 1 and GetItemSlot(myHero,3057) then
    sheendmg = sheendmg + GetBaseDamage(myHero)
  end
  if GotBuff(myHero, "cardmasterstackparticle") == 1 then
    EPassive = EPassive + 55 + (25 * Elevel) + (GetBonusAP(myHero) * 0.5 )
  end 
  if GotBuff(myHero, "itemmagicshankcharge") > 99 then
    Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
  end  
  local bdmg = (40 + (20 * Wlevel)  + ad + (GetBonusAP(myHero) * 0.5)) or 0
  local ydmg = (15 + (7.5 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5)) or 0
  local rdmg = (30 + (15 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5)) or 0
	local bcard = CalcDamage(myHero, minion,sheendmg, bdmg + lichbane + EPassive + Ludens)	
	local ycard = CalcDamage(myHero, minion,sheendmg, ydmg + lichbane + EPassive + Ludens)
	local rcard = CalcDamage(myHero, minion,sheendmg, rdmg + lichbane + EPassive + Ludens) 
  local ncardpassive = CalcDamage(myHero, minion, sheendmg + ad ,lichbane + EPassive + Ludens)
  local ncard = CalcDamage(myHero, minion, sheendmg + ad ,lichbane + Ludens)
  local addmg = CalcDamage(myHero, minion, ad ,0)
--  DrawText(string.format("EPassive= %f", EPassive),25,478,356,ARGB(255, 255, 255, 255));
--  DrawText(string.format("lichbane= %f", lichbane),25,478,386,ARGB(255, 255, 255, 255));
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,416,ARGB(255, 255, 255, 255));
if ValidTarget(minion, 525+250) then
  if self.MonTourMenu.Farm.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"goldcardpreattack") == 1 and GetCurrentHP(minion) < ycard then --GetCastName(myHero,_W) == "goldcardlock"
		AttackUnit(minion)	
	end  
  if self.MonTourMenu.Farm.prio:Value() == 2 and GetTickCount() > self.tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
  if GotBuff(myHero,"bluecardpreattack") == 1  and GetCurrentHP(minion) < bcard then --GetCastName(myHero,_W) == "bluecardlock"
		AttackUnit(minion) 	
	end  
	if self.MonTourMenu.Farm.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "redcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"redcardpreattack") == 1 and GetCurrentHP(minion) < rcard then
		AttackUnit(minion)
  end
  if (self.MonTourMenu.Farm.prio:Value() == 1 or self.MonTourMenu.Farm.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end   
  if GotBuff(myHero, "cardmasterstackparticle") == 1 and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCurrentHP(minion) < ncardpassive then
		AttackUnit(minion)  
	end
end
end
end

function TwistedFate:LaneClear()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i] --MINION_ENEMY
	local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana*100
  local ManaValue = self.MonTourMenu.Farm2.Mana:Value()
  local ad = GetBonusDmg(myHero) + GetBaseDamage(myHero)
	local Wlevel = GetCastLevel(myHero,_W) - 1
	local Qlevel = GetCastLevel(myHero,_Q) - 1
  local Elevel = GetCastLevel(myHero,_E) - 1 
  local EPassive = 0
  local lichbane = 0 
  local sheendmg = 0
  local Ludens = 0
	local qdmg = (60 + (50 * Qlevel) + (GetBonusAP(myHero) * 0.65 ))
  if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) then
    lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
  end 
  if GotBuff(myHero, "sheen") >= 1 and GetItemSlot(myHero,3057) then
    sheendmg = sheendmg + GetBaseDamage(myHero)
  end
  if GotBuff(myHero, "cardmasterstackparticle") == 1 then
    EPassive = EPassive + 55 + (25 * Elevel) + (GetBonusAP(myHero) * 0.5 )
  end 
  if GotBuff(myHero, "itemmagicshankcharge") > 99 then
    Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
  end  
  local bdmg = (40 + (20 * Wlevel)  + ad + (GetBonusAP(myHero) * 0.5)) or 0
  local ydmg = (15 + (7.5 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5)) or 0
  local rdmg = (30 + (15 * Wlevel) + ad + (GetBonusAP(myHero) * 0.5)) or 0
	local bcard = CalcDamage(myHero, minion,sheendmg, bdmg + lichbane + EPassive + Ludens)	
	local ycard = CalcDamage(myHero, minion,sheendmg, ydmg + lichbane + EPassive + Ludens)
	local rcard = CalcDamage(myHero, minion,sheendmg, rdmg + lichbane + EPassive + Ludens) 
  local ncardpassive = CalcDamage(myHero, minion, sheendmg + ad ,lichbane + EPassive + Ludens)
  local ncard = CalcDamage(myHero, minion, sheendmg + ad ,lichbane + Ludens)
  local addmg = CalcDamage(myHero, minion, ad ,0)
    
if ValidTarget(minion, 525+250) then
  if self.MonTourMenu.Farm2.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"goldcardpreattack") == 1 and GetCurrentHP(minion) < ycard then --GetCastName(myHero,_W) == "goldcardlock"
		AttackUnit(minion)	
	end   
  if self.MonTourMenu.Farm2.prio:Value() == 2 and curdmax > ManaValue and GetTickCount() > self.tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
  if GotBuff(myHero,"bluecardpreattack") == 1  and GetCurrentHP(minion) < bcard then --GetCastName(myHero,_W) == "bluecardlock"
		AttackUnit(minion) 	
	end    
	if self.MonTourMenu.Farm2.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > self.tick then --and MinionAround(minion, 250) > 3
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "redcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if GotBuff(myHero,"redcardpreattack") == 1 and GetCurrentHP(minion) < rcard then
		AttackUnit(minion)
  end  
  if (self.MonTourMenu.Farm2.prio:Value() == 1 or self.MonTourMenu.Farm2.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero, "cardmasterstackparticle") == 1 and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCurrentHP(minion) < ncardpassive then
		AttackUnit(minion)  
	end 
end
end
end

function TwistedFate:Igniteit()  
  for i,enemy in pairs(GetEnemyHeroes()) do
  	if Ignite and self.MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_W) ~= READY and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetDistance(enemy) > 525 then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
    end
  end          
end

function TwistedFate:Items()
if GetItemSlot(myHero,3140) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
if self.MonTourMenu.Items.Zhonya:Value() and GetItemSlot(myHero,3157) > 0 and ValidTarget(self.target, 900) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) <= self.MonTourMenu.Items.ZhonyaHP:Value()  then
                    CastTargetSpell(myHero, GetItemSlot(myHero,3157))
                    end      
end

function TwistedFate:ProcessSpell(Object,spellProc)
	if not self.MonTourMenu.Combo.R:Value() then
		return
	end
	if Object and Object == myHero then
		local name = spellProc.name:lower()		    
		if name == "destiny" then
			self.ultimateused = true
		end
		if name == "gate" then 
			self.ultimateused = false
			self.selectedcard = "goldcardlock"			
			if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then					
				CastSpell(_W)
			end
		end      
	end	
end

function TwistedFate:ProcessSpell2(unit, spell)
  for _,unit in pairs(GetEnemyHeroes()) do
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and GetCastLevel(myHero,_W) > 0 then
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,600) then
        if IsInDistance(unit, 525) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
                self.selectedcard = "goldcardlock"
                self.tick = GetTickCount() + 3000
                CastSpell(_W)
              end
              if GetCastName(myHero,_W) == "goldcardlock" then
                AttackUnit(unit)
              end  
        end  
      end
    end
  end  
end

--------------Draven--------------
class "Draven"
function Draven:__init()
print(MoTBaseVersion)  
self.Version = "1.1"
self.mapID = GetMapID()  
self.reticles = {}
self.tick = 0
self.tick2 = 0
self.MonTourMenu = MenuConfig("MoTDraven", "MoTDraven")
self.MonTourMenu:SubMenu("Info2", "Info about Auto Q Walk")
self.MonTourMenu.Info2:Info("Draven1234", "Info: Use Catch Q AutoWalk")
self.MonTourMenu.Info2:Info("Draven2345", "for Catching the Axes of Q by")
self.MonTourMenu.Info2:Info("Draven3456", "Single Pressing the Button. ")
self.MonTourMenu.Info2:Info("Draven4566", "Do not HOLD the Catch Q AutoWalk")
self.MonTourMenu.Info2:Info("Draven4775", "Button, cause of Forcing Movement!")
self.MonTourMenu.Info2:Info("Draven4747", "You need to train, before jump into ranked!")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Key("CQ", "Catch Q AutoWalk", string.byte("A"))
self.MonTourMenu.Combo:Info("Draven", "Pickup Q if Range")
self.MonTourMenu.Combo:Slider("CQPR", " Axe/MyMouse < X (def: 400)", 400, 50, 1000, 1)
self.MonTourMenu.Combo:Boolean("CM", "Draw Q Catch Circle", true)
self.MonTourMenu.Combo:Boolean("QC", "Draw Q Mouse Circle", true)
self.MonTourMenu.Combo:Boolean("CWS", "Use W to Catch", true)
self.MonTourMenu.Combo:Boolean("Q", "Use Q", true)
self.MonTourMenu.Combo:Boolean("W", "Use W", true)
self.MonTourMenu.Combo:Slider("WMANA", "Use W Only if Mana > x%", 60, 1, 90, 1)
self.MonTourMenu.Combo:Boolean("E", "Use E OOR", true)
self.MonTourMenu.Combo:Boolean("EB", "Use E if Banshees", true)
self.MonTourMenu.Combo:Boolean("R", "Use R", false)
self.MonTourMenu:SubMenu("Items", "Items")
self.MonTourMenu.Items:Info("Draven", "Only in Combo and Harass")
self.MonTourMenu.Items:Boolean("Ignite", "Use Ignite", true)
self.MonTourMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
self.MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("Draven", " ")
self.MonTourMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
self.MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("Draven", " ")
self.MonTourMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
self.MonTourMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("Draven", " ")
self.MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
self.MonTourMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("Draven", " ")
self.MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
self.MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
self.MonTourMenu:SubMenu("Harass", "Harass")
self.MonTourMenu.Harass:Boolean("QH", "Use Q", true)
self.MonTourMenu.Harass:Boolean("WH", "Use W", true)
self.MonTourMenu.Harass:Slider("WMANA", "Use Only W if Mana > x%", 60, 1, 90, 1)
self.MonTourMenu.Harass:Boolean("EH", "Use E OOR", true)
self.MonTourMenu.Harass:Boolean("EHB", "Use E if Banshees", true)
self.MonTourMenu.Harass:Boolean("RH", "Use R", false)
self.MonTourMenu:SubMenu("Clear", "Farming/Jungle")
self.MonTourMenu.Clear:Boolean("LHQ", "Use Q LastHit", true)
self.MonTourMenu.Clear:Boolean("LCQ", "Use Q LaneClear", true)
self.MonTourMenu.Clear:Boolean("LCJQ", "Use Q Jungle", true)
self.MonTourMenu:SubMenu("Killsteal", "Killsteal")
self.MonTourMenu.Killsteal:Boolean("KSQE", "KillSteal with Q/E", true)
self.MonTourMenu.Killsteal:Boolean("KSR", "Killsteal with R", true)
self.MonTourMenu:SubMenu("Misc", "Misc")
self.MonTourMenu.Misc:Boolean("AL","AutoLevelSkills", true)
self.MonTourMenu.Misc:Boolean("QAA","Draw QAA Text", true)
self.MonTourMenu.Misc:Boolean("DOH","Draw DMG over HP", true)
self.MonTourMenu.Misc:Boolean("MGUN","Ultimate Notifier", true)
self.MonTourMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
self.MonTourMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 25, 5, 60, 1)
self.MonTourMenu.Misc:Slider("MGUNX", "UN X POS", 35, 0, 1600, 1)
self.MonTourMenu.Misc:Slider("MGUNY", "UN Y POS", 394, 0, 1055, 1)
self.MonTourMenu.Misc:Boolean("CTS","Draw Current Target",true)
self.MonTourMenu.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
self.MonTourMenu.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
self.MonTourMenu:SubMenu("Interrupter", "Interrupter")
self.MonTourMenu.Interrupter:Info("Draven", "Delay for Interrupts min/max")
self.MonTourMenu.Interrupter:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
self.MonTourMenu.Interrupter:Slider("Imax", "Delay max.", 1055, 100, 3500, 1) 
self.targetsselect = TargetSelector(1250, TARGET_LESS_CAST, DAMAGE_PHYSICAL)
self.MonTourMenu:TargetSelector("ts", "TargetSelector", self.targetsselect)
self.MonTourMenu:Info("DravenMoT3535", " ")
self.MonTourMenu:Info("DravenMoT2789", MoTBaseVersion)
self.MonTourMenu:Info("DravenMoT3787", "MoTBase "..GetObjectName(myHero)..": v"..self.Version)
--Thanks to Deftsu for Interrupter :)
self.spellData = 
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

DelayAction(function()
  local QWERSLOT = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(self.CHANELLING_SPELLS) do
    for _,unit in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(unit) then
        self.MonTourMenu.Interrupter:Boolean(GetObjectName(unit).."Interrupting", "On "..GetObjectName(unit).." "..(type(spell.Spellslot) == 'number' and QWERSLOT[spell.Spellslot]), true)
        end
    end
  end	
end, 20)

OnTick(function(myHero) self:Tick(myHero) end)
OnDraw(function(myHero) self:Draw(myHero) end)
OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
OnCreateObj(function(Object) self:CreateObj(Object) end)
OnDeleteObj(function(Object) self:DeleteObj(Object) end)
--OnProcessSpell(function(unit, spell) self:ProcessSpell2(unit, spell) end)


 self.CHANELLING_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["Drain"]                       = {Name = "FiddleSticks", Spellslot = _W},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["FallenOne"]                   = {Name = "Karthus",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R},                        
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["UrgotSwap2"]                  = {Name = "Urgot",        Spellslot = _R},
    ["VarusQ"]                      = {Name = "Varus",        Spellslot = _Q},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R} 
} 
 
end


function Draven:CreateObj(Object)
  if GetObjectBaseName(Object) == "Draven_Base_Q_reticle_self.troy" then
    table.insert(self.reticles, Object)
    self.tick = GetGameTimer() + 1.8
    self.tick2 = GetGameTimer() + 1.8
  end
end

function Draven:DeleteObj(Object)
if GetObjectBaseName(Object) == "Draven_Base_Q_reticle_self.troy" then
  table.remove(self.reticles, 1)
end
end

function Draven:Tick(myHero)
	self:Checks()
 --self:CircleQM()
   self:ItemUse()
   self:Killsteal()  
   self:Igniteit()
	if IOW:Mode() == "LastHit" then 
    	self:LastHit()
    end	  
	if IOW:Mode() == "LaneClear" then
    IOW.movementEnabled = true
    	self:LaneClear()
      self:JungleClear()
    end	
	if IOW:Mode() == "Combo" then
    IOW.movementEnabled = true
		self:Combo()
	end
	if IOW:Mode() == "Harass" then
    IOW.movementEnabled = true
		self:Harass()
	end	
	if self.MonTourMenu.Misc.AL:Value() then --and mapID == SUMMONERS_RIFT
		self:AutoLvL()
	end	
end
 
function Draven:Draw(myHero) 
	if self.MonTourMenu.Misc.MGUN:Value() then
		self:GLOBALULTNOTICE()
	end	
  if self.MonTourMenu.Misc.MGUNDEB:Value() then
    self:GLOBALULTNOTICEDEBUG()
  end
	if self.MonTourMenu.Misc.DOH:Value() then 
		self:Draws()
	end 
	if self.MonTourMenu.Misc.QAA:Value() then
		self:QAA()
	end	  
if self.MonTourMenu.Misc.CTS:Value() then  
self:DrawENEMY()
end
   self:CatchQ() 
end  

function Draven:AutoLvL()
local leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E} 
		if GetLevel(myHero) == 3 then
			DelayAction(function() LevelSpell(leveltable[3])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[2])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[1])end, math.random(1000,2948)) 
		else
			DelayAction(function() LevelSpell(leveltable[GetLevel(myHero)])end, math.random(962,2948)) 
		end  
end

function Draven:DrawENEMY()
	local hpbar = GetHPBarPos(myHero)
      if hpbar.x > 0 then
			if hpbar.y > 0 then 
		FillRect(hpbar.x, hpbar.y+13, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
    FillRect(hpbar.x, hpbar.y+22, 107, 2,ARGB(255,0,0,0))
--    FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
	if self.target ~= nil then
        DrawText(GetObjectName(self.target),14,hpbar.x+113-GetTextArea(GetObjectName(self.target).."  ",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
	else
    DrawText("No Target found!",14,hpbar.x+113-GetTextArea("No Target found",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
  end
end
end
	end

function Draven:ProcessSpell(unit, spell)
  for _,unit in pairs(GetEnemyHeroes()) do
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and self.EREADY then
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,self.spellData[_E].range+30) then
        local EPred = GetPredictionForPlayer(GetOrigin(myHero), unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
          if EPred.HitChance == 1 then
            if ValidTarget(unit, self.spellData[_E].range) then 			
              DelayAction(function() CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) end,math.random(self.MonTourMenu.Interrupter.Imin:Value(),self.MonTourMenu.Interrupter.Imax:Value()))
            end
          end		
      end     
    end
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
          DrawText(math.ceil(hp/dmg).." QAA", 15, hPos.x, hPos.y+20, ARGB(255, 255, 255, 255))
	 	end 	
end
end

function Draven:Draws()
  	for _,unit in pairs(GetEnemyHeroes()) do	
  local Qdmg = self.spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero)
  local enemyhp = GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
local QREADY = QREADY or QSpinn1
	if ValidTarget(unit,20000) and QREADY then
		DrawDmgOverHpBar(unit,enemyhp,0,CalcDamage(myHero, unit, Qdmg, 0),ARGB(255, 255, 255, 255))	
  end  
  end
end

function Draven:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.Q0 = GotBuff(myHero,"dravenspinningattack") == 0	
	self.Q1 = GotBuff(myHero,"dravenspinningattack") == 1
	self.Q2 = GotBuff(myHero,"dravenspinningattack") == 2
	self.QL0 = GotBuff(myHero,"dravenspinningleft") == 0	
	self.QL1 = GotBuff(myHero,"dravenspinningleft") == 1		
	self.QSpinn0 = GotBuff(myHero,"DravenSpinning") == 0	
	self.QSpinn1 = GotBuff(myHero,"DravenSpinning") == 1
--  self.enemygotbansheesveil = GotBuff(self.target,"bansheesveil") == 1 
  self.MonTourMenu.ts.range = 1250
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.targetPos = GetOrigin(self.target)
self.myHeroPos = GetOrigin(myHero)
if self.target ~= nil then
self.unitname = GetObjectName(self.target)
else
self.unitname = GetObjectName(myHero)
end

  
--local buffdatas2 = GetBuffData(myHero,"dravenpassive");
--DrawText(string.format("[dravenpassive INFO]", buffdatas2.Type),12,200,20,0xff00ff00);
--DrawText(string.format("Type = %d", buffdatas2.Type),12,200,30,0xff00ff00);
--DrawText(string.format("Name = %s", buffdatas2.Name),12,200,40,0xff00ff00);
--DrawText(string.format("Count = %d", buffdatas2.Count),12,200,50,0xff00ff00);
--DrawText(string.format("Stacks = %f", buffdatas2.Stacks),12,200,60,0xff00ff00);
--DrawText(string.format("StartTime = %f", buffdatas2.StartTime),12,200,70,0xff00ff00);
--DrawText(string.format("ExpireTime = %f", buffdatas2.ExpireTime),12,200,80,0xff00ff00);
--DrawText(string.format("[GameTime] = %f", GetGameTimer()),12,200,90,0xff00ff00);
--DrawText(string.format("GetBuffTypeToString = [%s]", GetBuffTypeToString(buffdatas2.Type)),12,200,110,0xffffff00);
 
--local buffdatas = GetBuffData(myHero,"dravenpassivestacks");
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

function Draven:LastHit()
    --  Move()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i]
      local QDmg = self.spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero) or 0  
      local DamageQ = CalcDamage(myHero, minion, QDmg, 0)
      local  targetPos123 = GetOrigin(minion) 
    if self.MonTourMenu.Clear.LHQ:Value() and GetCurrentHP(minion) < DamageQ then
			if self.QREADY and self.QSpinn0 and self.Q0 and IsInDistance(minion, self.spellData[_Q].range) and ValidTarget(minion, self.spellData[_Q].range) then			
				CastSpell(_Q) DelayAction(function() self:AttackUnitM(minion) end, 100)
			end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(minion, self.spellData[_Q].range) and ValidTarget(minion, self.spellData[_Q].range) then
        self:AttackUnitM(minion)
			end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(minion, self.spellData[_Q].range) and ValidTarget(minion, self.spellData[_Q].range)then	
        self:AttackUnitM(minion)
			end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(minion, self.spellData[_Q].range) and ValidTarget(minion, self.spellData[_Q].range)then	
        self:AttackUnitM(minion)
      end
			if self.QSpinn1 and IsInDistance(minion, self.spellData[_Q].range) and ValidTarget(minion, self.spellData[_Q].range)then	
        self:AttackUnitM(minion)
      end
    end
  end
end

--function Draven:CatchQ()
--      if self.MonTourMenu.Combo.CQ:Value() then
--      for i, reticle in pairs(self.reticles) do
--        local Reticlepos = GetOrigin(reticle)
--        local myHer0 = GetOrigin(myHero)
--        local mymouse = GetCursorPos()
--        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,120,1,100,0xff0000ff)
--        DrawCircle(mymouse.x, mymouse.y, mymouse.z,self.MonTourMenu.Combo.CQPR:Value(),1,100,0xff0000ff)
--          if GetDistance(Reticlepos, myHer0) < self.MonTourMenu.Combo.CQPR:Value() then 
--          MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z)
--          end
--      end
--      end
--end

function Draven:CatchQ()
      if self.MonTourMenu.Combo.CQ:Value() and self.MonTourMenu.Combo.QC:Value() then
        local mymouse = GetMousePos()
        DrawCircle(mymouse,self.MonTourMenu.Combo.CQPR:Value(),0.9,100,0xff0000ff)
      end    
      for i, reticle in pairs(self.reticles) do
        local Reticlepos = GetOrigin(reticle)
        local myHer0 = GetOrigin(myHero)
        local mymouse = GetMousePos()
        if self.MonTourMenu.Combo.CM:Value() then
        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,120,3,100,0xff00ff7f)
        DrawCircle(Reticlepos.x, Reticlepos.y, Reticlepos.z,60,1,100,0xffff6600)
        end
        if self.MonTourMenu.Combo.CQ:Value() then
          if GetDistance(Reticlepos, mymouse) < self.MonTourMenu.Combo.CQPR:Value() and self.tick > GetGameTimer() then --and GetTickCount() < self.tick
          IOW.movementEnabled = false DelayAction(function()  DelayAction(function() MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z) DelayAction(function() IOW.movementEnabled = true end, 1) end, 1) end, 100) --self.tick = 0
          end
        end
        if self.MonTourMenu.Combo.CWS:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > (self.MonTourMenu.Combo.WMANA:Value()) then
          local catchtime = GetDistance(Reticlepos, myHero)/GetMoveSpeed(myHero)
          if catchtime > (self.tick2-GetGameTimer()) then 
          CastSpell(_W)
          end
        end
      end
end

function Draven:AttackUnitM(minion)
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i] 
  if IsInDistance(minion, GetRange(myHero)) and GetDistance(myHero, minion) <= (GetRange(myHero)) and GetDistance(myHero, minion) >= 1 then 
    AttackUnit(minion)
  end
  end
end


--function Draven:CircleQM()
--    for i,minionQM in pairs(GetAllMinions(MINION_ENEMY)) do
--      local QDmg = self.spellData[_Q].dmg()+GetBonusDmg(myHero)+GetBaseDamage(myHero) or 0  
--      local DamageQ = CalcDamage(myHero, minionQM, QDmg, 0)
--      local  targetPos123 = GetOrigin(minionQM) 
--      --local eminion = CountMinions()
----local HP = PredictHealth(minion, orbTable.windUp + GetDistance(minion)/1700.0000 - 0.07)
--    if self.MonTourMenu.Clear.LHQCircle:Value() and GetCurrentHP(minionQM) < DamageQ and IsInDistance(minion, self.spellData[_Q].range+100)then	
--				      DrawCircle(targetPos123.x,targetPos123.y,targetPos123.z,50,0,0,0xffff0000)
--    end
--  end
--end

function Draven:LaneClear()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i]  
		if self.QREADY and self.MonTourMenu.Clear.LCQ:Value() then
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

function Draven:JungleClear()
	for _,jminion in pairs(minionManager.objects) do
--	if GetObjectName(jminion) == "SRU_Blue" or GetObjectName(jminion) == "SRU_Red" or GetObjectName(jminion) == "SRU_Krug" or GetObjectName(jminion) == "SRU_Murkwolf" or GetObjectName(jminion) == "SRU_Razorbeak" or GetObjectName(jminion) == "SRU_Gromp" or GetObjectName(jminion) == "Sru_Crab" or GetObjectName(jminion) == "SRU_Dragon" or GetObjectName(jminion) == "SRU_Baron" or GetTeam(mob) == MINION_JUNGLE then
      if self.QREADY and self.MonTourMenu.Clear.LCJQ:Value() then
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
--  end
end

--function Draven:AttackUnitJ(minion)
--	for i,minion in pairs(GetAllMinions(MINION_JUNGLE)) do  
--  if IsInDistance(minion, GetRange(myHero)) and GetDistance(myHero, minion) <= (GetRange(myHero)) and GetDistance(myHero, minion) >= 1 then 
--    AttackUnit(minion)
--  end
--  end
--end

function Draven:CastPredE(targeted)
	local unitPos = GetOrigin(targeted)
		local EPred = GetPredictionForPlayer(GetOrigin(myHero), targeted, GetMoveSpeed(targeted), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range, self.spellData[_E].width, false, true)
		if self.EREADY and EPred.HitChance == 1 then
			if GetDistance(myHero, targeted) >= 475 and GetDistance(myHero, targeted) <= self.spellData[_E].range and ValidTarget(unit, self.spellData[_E].range) then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end		
end

function Draven:CastPredEBanshe()
  for _,unit in pairs(GetEnemyHeroes()) do 
	local unitPos = GetOrigin(unit)
		local EPred = GetPredictionForPlayer(GetOrigin(myHero), unit, GetMoveSpeed(unit), self.spellData[_E].speed, self.spellData[_E].delay, self.spellData[_E].range-25, self.spellData[_E].width, false, true)
		if self.EREADY and EPred.HitChance == 1 and GotBuff(unit,"bansheesveil") == 1 then
			if GetDistance(myHero, unit) > self.spellData[_Q].range and GetDistance(myHero, unit) <= self.spellData[_E].range and ValidTarget(unit, self.spellData[_E].range) then 			
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end	
    end
end

function Draven:CastQ(targeted)
  --     	for _,unit in pairs(GetEnemyHeroes()) do
      if self.QREADY and ValidTarget(targeted, self.spellData[_Q].range+100) then
			if self.QSpinn0 and self.Q0 and IsInDistance(targeted, self.spellData[_Q].range+100) and ValidTarget(targeted, self.spellData[_Q].range+100) then			
				CastSpell(_Q)
			end
			if self.QSpinn1 and self.Q1 and self.Q2 and IsInDistance(targeted, self.spellData[_Q].range+100) and ValidTarget(targeted, self.spellData[_Q].range+100) then
			end
			if self.QSpinn1 and self.Q2 and self.QL0 and IsInDistance(targeted, self.spellData[_Q].range+100) and ValidTarget(targeted, self.spellData[_Q].range+100)then			
			end
			if self.QSpinn1 and self.Q2 and self.QL1 and IsInDistance(targeted, self.spellData[_Q].range+100) and ValidTarget(targeted, self.spellData[_Q].range+100)then			
			end
		end				
end

function Draven:CastW(targeted)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = self.spellData[_Q].mana
	local Wmana = self.spellData[_W].mana
	if self.WREADY then
	 	if ValidTarget(targeted, self.spellData[_Q].range*1.7) and GetDistance(myHero, targeted) > self.spellData[_Q].range+50 and  GetDistance(myHero, targeted) < self.spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
  end
end

function Draven:CastWnoMana(targeted)
	local igotmana = GetCurrentMana(myHero)
	local Qmana = self.spellData[_Q].mana
	local Wmana = self.spellData[_W].mana
	if self.WREADY then
	 	if ValidTarget(targeted, self.spellData[_Q].range*1.7) and GetDistance(myHero, targeted) > self.spellData[_Q].range+50 and  GetDistance(myHero, targeted) < self.spellData[_Q].range*1.7 then 
			CastSpell(_W)
	 	end	
	end
end

function Draven:CastPredR(targeted)
	local unitPos = GetOrigin(targeted)
	local RPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted), self.spellData[_R].speed, self.spellData[_R].delay, self.spellData[_R].range, self.spellData[_R].width, false, true)
				if GetDistance(myHero, targeted) > 750 and GetDistance(myHero, targeted) < 4000 and IsObjectAlive(targeted) then		
			if self.RREADY and ValidTarget(targeted, self.spellData[_R].range) and RPred.HitChance == 1 then
				CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
				end
			end	
end

			
function Draven:Combo()
if self.target == nil or GetOrigin(self.target) == nil or IsImmune(self.target,myHero) or IsDead(self.target) or not IsVisible(self.target) or GetTeam(self.target) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Combo.Q:Value() then
		self:CastQ(self.target)
    end
		if self.MonTourMenu.Combo.W:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > self.MonTourMenu.Combo.WMANA:Value() then
		self:CastW(self.target)
    end
    if self.MonTourMenu.Combo.EB:Value() then
    self:CastPredEBanshe(self.target)
    end
    if self.MonTourMenu.Combo.E:Value() then
    self:CastPredE(self.target)
    end  
    if self.MonTourMenu.Combo.R:Value() then
    self:CastPredR(self.target)
    end
end	
function Draven:Harass()
    if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Harass.QH:Value() then
		self:CastQ(self.target)		
    end
		if self.MonTourMenu.Harass.WH:Value() and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > self.MonTourMenu.Harass.WMANA:Value() then
		self:CastW(self.target)	 
    end
    if self.MonTourMenu.Harass.EHB:Value() then
    self:CastPredEBanshe(self.target)
     end
    if self.MonTourMenu.Harass.EH:Value() then
    self:CastPredE(self.target)
    end  
    if self.MonTourMenu.Harass.RH:Value() then
    self:CastPredR(self.target)
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
		if self.MonTourMenu.Killsteal.KSQE:Value() and ValidTarget(enemy, self.spellData[_E].range) and enemyhp < CalcDamage(myHero, enemy, EDmg, 0) then
			self:CastPredE(enemy)
		elseif ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, QDmg + Alldmg, 0) then
			self:CastQ(enemy)
		elseif self.MonTourMenu.Killsteal.KSQE:Value() and ValidTarget(enemy, self.spellData[_Q].range) and enemyhp < CalcDamage(myHero, enemy, QDmg2 + Alldmg, 0) and self.QSpinn1 then 
      self:AttackUnitKS(enemy)
		elseif self.MonTourMenu.Killsteal.KSR:Value() and ValidTarget(enemy, self.spellData[_R].range) and enemyhp < CalcDamage(myHero, enemy, RDmg, 0) then
			self:CastPredR(enemy)
		elseif self.MonTourMenu.Killsteal.KSQE:Value() and ValidTarget(enemy, self.spellData[_E].range) and GetDistance(myHero, enemy) > 550 and GetDistance(myHero, enemy) < 700 and enemyhp < CalcDamage(myHero, enemy, QDmg + Alldmg + EDmg, 0) then		
			self:CastPredE(enemy) DelayAction(function() self:CastWnoMana(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 100) end, 200) end, 300)
		elseif self.MonTourMenu.Killsteal.KSQE:Value() and ValidTarget(enemy, self.spellData[_E].range) and GetDistance(myHero, enemy) > 550 and GetDistance(myHero, enemy) < 700 and enemyhp < CalcDamage(myHero, enemy, QDmg2 + Alldmg + EDmg, 0) and self.QSpinn1 then			
			self:CastPredE(enemy) DelayAction(function() self:CastWnoMana(enemy) DelayAction(function() self:CastPredE(enemy) DelayAction(function() self:AttackUnitKS(enemy) end, 100) end, 200) end, 300)				
		end	
	end	
end

function Draven:Igniteit()
  for _, k in pairs(GetEnemyHeroes()) do
    if ValidTarget(k, 700) and Ignite and self.MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_W) ~= READY and  GetDistance(k) > 500 then 
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function Draven:ItemUse()
  for _,target in pairs(GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and self.MonTourMenu.Items.bork:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and self.MonTourMenu.Items.CutBlade:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and self.MonTourMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and ValidTarget(target, self.MonTourMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if self.MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and ValidTarget(target,self.MonTourMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
      end
end      

function Draven:AttackUnitKS(targeted)  
  if IsInDistance(targeted, GetRange(myHero)) and GetDistance(myHero, targeted) <= (GetRange(myHero)-10) and GetDistance(myHero, targeted) >= 10 then 
    AttackUnit(targeted)
  else
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
                                elseif not ValidTarget(unit, self.spellData[_R].range) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
end

function Draven:GLOBALULTNOTICEDEBUG()	 
    DrawText("I am in Range but not killable - TESTMODE ON",self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
end

--------------Olaf--------------
class "Olaf"
function Olaf:__init()
print(MoTBaseVersion)  
self.Version = "1.0"
self.Qattack = myHero
self.mapID = GetMapID()  
self.MonTourMenu = MenuConfig("MoTOlaf", "MoTOlaf")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Boolean("Q", "Use Q", true)
self.MonTourMenu.Combo:Boolean("W", "Use W", true)
self.MonTourMenu.Combo:Boolean("E", "Use E ", true)
self.MonTourMenu.Combo:Boolean("RSS", "Always Use R in CC", true)
self.MonTourMenu.Combo:Slider("RSSHP", "if My Health < x%", 75, 0, 100, 1)
self.MonTourMenu:SubMenu("Items", "Items")
self.MonTourMenu.Items:Info("MoTOlaf98", "Only in Combo and Harass")
self.MonTourMenu.Items:Boolean("Ignite", "Use Ignite", true)
self.MonTourMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
self.MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("MoTOlaf", " ")
self.MonTourMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
self.MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("MoTOlaf78", " ")
self.MonTourMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
self.MonTourMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("MoTOlaf67", " ")
self.MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
self.MonTourMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("MoTOlaf56", " ")
self.MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
self.MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
self.MonTourMenu:SubMenu("Harass", "Harass")
self.MonTourMenu.Harass:Boolean("QH", "Use Q", true)
self.MonTourMenu.Harass:Boolean("WH", "Use W", true)
self.MonTourMenu.Harass:Boolean("E", "Use E", true)
self.MonTourMenu:SubMenu("Clear", "Farming/Jungle")
self.MonTourMenu.Clear:Boolean("LHQ", "Use Q LastHit", true)
self.MonTourMenu.Clear:Boolean("LCQ", "Use Q LaneClear", true)
self.MonTourMenu.Clear:Boolean("LCJQ", "Use Q Jungle", true)
self.MonTourMenu:SubMenu("Killsteal", "Killsteal")
self.MonTourMenu.Killsteal:Boolean("KSQ", "Killsteal with Q", true)
self.MonTourMenu.Killsteal:Boolean("KSE", "Killsteal with E", true)
self.MonTourMenu.Killsteal:Boolean("KSQE", "KillSteal with Q/E", true)
self.MonTourMenu:SubMenu("Misc", "Misc")
self.MonTourMenu.Misc:Boolean("AL","AutoLevelSkills", true)
self.MonTourMenu.Misc:Boolean("QAA","Draw QAA Text", true)
self.MonTourMenu.Misc:Boolean("DOH","Draw DMG over HP", true)
self.MonTourMenu.Misc:Boolean("MGUN","W Notifier", true)
self.MonTourMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
self.MonTourMenu.Misc:ColorPick("CTSCKS", "Current Target Color", {255,255,0,0})
self.MonTourMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 25, 5, 60, 1)
self.MonTourMenu.Misc:Slider("MGUNX", "UN X POS", 35, 0, 1600, 1)
self.MonTourMenu.Misc:Slider("MGUNY", "UN Y POS", 394, 0, 1055, 1)
self.MonTourMenu.Misc:Boolean("CTS","Draw Current Target",true)
self.MonTourMenu.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
self.MonTourMenu.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
self.targetsselect = TargetSelector(1400, TARGET_LESS_CAST, DAMAGE_PHYSICAL)
self.MonTourMenu:TargetSelector("ts", "TargetSelector", self.targetsselect)
self.MonTourMenu:Info("MoTOlaf12", " ")
self.MonTourMenu:Info("MoTOlaf23", MoTBaseVersion)
self.MonTourMenu:Info("MoTOlaf45", "MoTBase "..GetObjectName(myHero)..": v"..self.Version)
OnTick(function(myHero) self:Tick(myHero) end)
OnDraw(function(myHero) self:Draw(myHero) end)
--OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
OnCreateObj(function(Object) self:CreateObj(Object) end)
OnDeleteObj(function(Object) self:DeleteObj(Object) end) 
end

function Olaf:CirclesbyCast()
if self.Qattack ~= myHero then
DrawCircle(GetOrigin(self.Qattack).x,GetOrigin(self.Qattack).y,GetOrigin(self.Qattack).z,70,6,100,0xff3111e1)    
end
end

function Olaf:CreateObj(Object)
  if GetObjectBaseName(Object) == "olaf_axe_totem_team_id_green.troy" then
self.Qattack = Object
  end
end

function Olaf:DeleteObj(Object)
if GetObjectBaseName(Object) == "olaf_axe_totem_team_id_green.troy" then
self.Qattack = myHero
end
end

function Olaf:Tick(myHero)
	 self:Checks()
   self:ItemUse()
   self:Killsteal()  
   self:Igniteit()
   self:RProcessSpell()
	if IOW:Mode() == "LastHit" then 
    	self:LastHit()
    end	  
	if IOW:Mode() == "LaneClear" then
    IOW.movementEnabled = true
    	self:LaneClear()
      self:JungleClear()
    end	
	if IOW:Mode() == "Combo" then
    IOW.movementEnabled = true
		self:Combo()
	end
	if IOW:Mode() == "Harass" then
    IOW.movementEnabled = true
		self:Harass()
	end	
--	if self.MonTourMenu.Misc.AL:Value() then --and mapID == SUMMONERS_RIFT
--		self:AutoLvL()
--	end	
end
 
function Olaf:Draw(myHero) 
  self:CirclesbyCast()
	if self.MonTourMenu.Misc.MGUN:Value() then
		self:GLOBALULTNOTICE()
	end	
  if self.MonTourMenu.Misc.MGUNDEB:Value() then
    self:GLOBALULTNOTICEDEBUG()
  end
	if self.MonTourMenu.Misc.DOH:Value() then 
		self:Draws()
	end 
	if self.MonTourMenu.Misc.QAA:Value() then
		self:EAA()
	end	  
if self.MonTourMenu.Misc.CTS:Value() then  
self:DrawENEMY()
end
end  

function Olaf:AutoLvL()
local leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E} 
		if GetLevel(myHero) == 3 then
			DelayAction(function() LevelSpell(leveltable[3])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[2])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[1])end, math.random(1000,2948)) 
		else
			DelayAction(function() LevelSpell(leveltable[GetLevel(myHero)])end, math.random(962,2948)) 
		end  
end

function Olaf:DrawENEMY()
	local hpbar = GetHPBarPos(myHero)
      if hpbar.x > 0 then
			if hpbar.y > 0 then 
		FillRect(hpbar.x, hpbar.y+13, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
    FillRect(hpbar.x, hpbar.y+22, 107, 2,ARGB(255,0,0,0))
--    FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
	if self.target ~= nil then
        DrawText(GetObjectName(self.target),14,hpbar.x+113-GetTextArea(GetObjectName(self.target).."  ",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
	else
    DrawText("No Target found!",14,hpbar.x+113-GetTextArea("No Target found",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
  end
end
end
	end

function Olaf:RProcessSpell()
      if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Combo.RSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Combo.RSSHP:Value() then
        CastTargetSpell(myHero, _R)
      end    

end

function Olaf:EAA()
	for i,unit in pairs(GetEnemyHeroes()) do
		local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
		local unitPos = GetOrigin(unit)
		local dmgE = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
      if hPos.x > 0 then
			if hPos.y > 0 then 
        if dmg > 0 then 
          DrawText(math.ceil(hp/dmgE).." EAA", 15, hPos.x, hPos.y+20, ARGB(255, 255, 255, 255))
      end
      end
	 	end 	
end
end

function Olaf:Draws()
  	for _,unit in pairs(GetEnemyHeroes()) do	
  local Edmg = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
	if ValidTarget(unit,20000) then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,Edmg,ARGB(255, 255, 255, 255))	
  end  
  end
end

function Olaf:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
  self.MonTourMenu.ts.range = 1400
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.targetPos = GetOrigin(self.target)
self.myHeroPos = GetOrigin(myHero)
if self.target ~= nil then
self.unitname = GetObjectName(self.target)
else
self.unitname = GetObjectName(myHero)
end
end

function Olaf:LastHit()
for i=1, IOW.mobs.maxObjects do
local minion = IOW.mobs.objects[i]
local realdmg = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
local hp =  GetCurrentHP(minion)
if ValidTarget(minion, GetCastRange(myHero, _E)) and realdmg > hp and ((GetObjectName(unit):find("Siege")) or (GetObjectName(unit):find("super"))) then--and GetBonusDmg(myHero)+GetBaseDamage(myHero) < hp then
  CastTargetSpell(minion, _E)
end
end
end

function Olaf:AttackUnitM(minion)
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i] 
  if IsInDistance(minion, GetRange(myHero)) and GetDistance(myHero, minion) <= (GetRange(myHero)) and GetDistance(myHero, minion) >= 1 then 
    AttackUnit(minion)
  end
  end
end

function Olaf:LaneClear()
    local BestPos, BestHit = GetLineFarmPosition(1100, 50)
    if self.QREADY then --GetCastName(myHero,_Q) == "GnarQ" and 
      if BestPos and BestHit > 0 then 
        CastSkillShot(_Q, BestPos)
      end 
    end 
end

function Olaf:JungleClear()
for _,jminion in pairs(minionManager.objects) do
  
end
end


function Olaf:CastE(targeted)
      if ValidTarget(targeted, GetCastRange(myHero, _E)) then
      if self.EREADY then --and IsInDistance(unit, GetCastRange(myHero, _E)) then
        CastTargetSpell(targeted, _E)
      end	
      end
end

function Olaf:CastQ(targeted)
local distance = 155
local unitname = self.unitname
local target = self.MonTourMenu.ts:GetTarget()
if ValidTarget(targeted, GetCastRange(myHero, _Q))   then 
 if (self.MonTourMenu.Combo.Q:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.Q:Value() and IOW:Mode() == "Harass") then
--  if self.QREADY then  
    local StartPos = Vector(myHero) - 110 * (Vector(myHero) - Vector(targeted)):normalized()
    local QPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),2200,625,1300,90,false,false)
    local PredPos = Vector(QPred.PredPos)
    local HeroPos = Vector(myHero)
    local maxQRange = PredPos - (PredPos - HeroPos) * ( - 100 / GetDistance(QPred.PredPos))
       DrawCircle(maxQRange.x,maxQRange.y,maxQRange.z,70,6,100,ARGB(255, 0, 0, 255)) 
                  if self.QREADY and QPred.HitChance == 1 then
                  CastSkillShot3(_Q,HeroPos,maxQRange)
                  end
end
end
end

function Olaf:CastW(targeted)
        if self.WREADY and ValidTarget(targeted,250) then
        CastTargetSpell(myHero, _W)
        end
end
			
function Olaf:Combo()
--if self.target == nil or GetOrigin(self.target) == nil or IsImmune(self.target,myHero) or IsDead(self.target) or not IsVisible(self.target) or GetTeam(self.target) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Combo.Q:Value() then
		self:CastQ(self.target)
    end
		if self.MonTourMenu.Combo.W:Value() then
		self:CastW(self.target)
    end
    if self.MonTourMenu.Combo.E:Value() then
    self:CastE(self.target)
    end
end	
function Olaf:Harass()
--    if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Harass.QH:Value() then
		self:CastQ(self.target)		
    end
		if self.MonTourMenu.Harass.WH:Value() then
		self:CastW(self.target)	 
    end
    if self.MonTourMenu.Harass.E:Value() then
    self:CastPredE(self.target)
    end  
end

function Olaf:Killsteal()
  for _,unit in pairs(GetEnemyHeroes()) do
    if  IsObjectAlive(unit) then
      realdmg = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
      hp =  GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
      if realdmg > hp then
        if ValidTarget(unit, GetCastRange(myHero, _E)) then
          if self.EREADY then --and IsInDistance(unit, GetCastRange(myHero, _E)) then
            CastTargetSpell(unit, _E)
          end	
        end
    end
    end
  end
end

function Olaf:Igniteit()
  for _, unit in pairs(GetEnemyHeroes()) do
    if ValidTarget(unit, 700) and Ignite and self.MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and GetDistance(unit) > 400 then 
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(unit)+GetHPRegen(unit)*2.5 and GetDistanceSqr(GetOrigin(unit)) < 600*600 then
                CastTargetSpell(unit, Ignite)
            end
        end
     end
end

function Olaf:ItemUse()
  for _,target in pairs(GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and self.MonTourMenu.Items.bork:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.borkmyhp:Value()) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and self.MonTourMenu.Items.CutBlade:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.CutBlademyhp:Value()) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and self.MonTourMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and ValidTarget(target, self.MonTourMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if self.MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and ValidTarget(target,self.MonTourMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
      end
end      

function Olaf:AttackUnitKS(targeted)  
  if IsInDistance(targeted, GetRange(myHero)) and GetDistance(myHero, targeted) <= (GetRange(myHero)-10) and GetDistance(myHero, targeted) >= 10 then 
    AttackUnit(targeted)
  else
  end
end

function Olaf:GLOBALULTNOTICE()
      if not self.EREADY then return end
        info = ""
        if self.EREADY then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not ValidTarget(unit, 1400) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),self.MonTourMenu.Misc.CTSCKS:Value())   
end

function Olaf:GLOBALULTNOTICEDEBUG()	 
    DrawText("I am in Range but not killable - TESTMODE ON",self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),self.MonTourMenu.Misc.CTSCKS:Value())   
end

--------------Gnar--------------
class "Gnar"
function Gnar:__init()
require("MapPositionGOS")
print(MoTBaseVersion)  
self.Version = "1.1"
self.Qattack = myHero
self.reticles = {}
self.tickQ = 0
self.tickQ2 = 0
self.unitname = myHero
self.GnarOverAllDmg = 0
self.GnarWallDmg = 0
self.mapID = GetMapID()  
self.circlepos = GetMousePos()
self.stunable = 0
self.MonTourMenu = MenuConfig("MoTGnar", "MoTGnar")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Info("MoTGnar56142", "Mini Gnar")
self.MonTourMenu.Combo:Boolean("Q", "Use Q", true)
self.MonTourMenu.Combo:List("QCWW", "Mouse or Hero as Trigger?", 2, {"Mouse", "Hero"})
self.MonTourMenu.Combo:Boolean("QCD", "Draw Q Mouse/Hero Circle", true)
self.MonTourMenu.Combo:List("QC", "Draw Q Mouse/Hero Circle..", 1, {"Always", "if Q used", "Never"})
self.MonTourMenu.Combo:Slider("QW", "Walk to Q Mouse/Hero Range", 500, 100, 1200, 1)
self.MonTourMenu.Combo:List("QCT", "Catch Q only with Togglekey?", 1, {"Only with Toggle", "Always in Mouse/Hero Range"})
self.MonTourMenu.Combo:Key("QT", "Catch Q Key", string.byte("A"))
self.MonTourMenu.Combo:Boolean("E", "Use E ", true)
self.MonTourMenu.Combo:Boolean("ET", "Use E on tired", false)
self.MonTourMenu.Combo:Info("MoTGnar561234", "Mega Gnar")
self.MonTourMenu.Combo:Boolean("MQ", "Use Q", true)
self.MonTourMenu.Combo:Boolean("MW", "Use W", true)
self.MonTourMenu.Combo:Boolean("ME", "Use E", true)
self.MonTourMenu.Combo:Boolean("MR", "Use R", true)
self.MonTourMenu:SubMenu("Items", "Items")
self.MonTourMenu.Items:Info("MoTGnar98", "Only in Combo and Harass")
self.MonTourMenu.Items:Boolean("Ignite", "Use Ignite", true)
self.MonTourMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
self.MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("MoTGnar", " ")
self.MonTourMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
self.MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
self.MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
self.MonTourMenu.Items:Info("MoTGnar78", " ")
self.MonTourMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
self.MonTourMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("MoTGnar67", " ")
self.MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
self.MonTourMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
self.MonTourMenu.Items:Info("MoTGnar56", " ")
self.MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
self.MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
self.MonTourMenu:SubMenu("Harass", "Harass")
self.MonTourMenu.Harass:Info("MoTGnar56142", "Mini Gnar")
self.MonTourMenu.Harass:Boolean("Q", "Use Q", true)
self.MonTourMenu.Harass:Boolean("E", "Use E", true)
self.MonTourMenu.Harass:Boolean("ET", "Use E on tired", true)
self.MonTourMenu.Harass:Info("MoTGnar561234", "Mega Gnar")
self.MonTourMenu.Harass:Boolean("MQ", "Use Q", true)
self.MonTourMenu.Harass:Boolean("MW", "Use W", true)
self.MonTourMenu.Harass:Boolean("ME", "Use E", true)
self.MonTourMenu.Harass:Boolean("MR", "Use R", true)
self.MonTourMenu:SubMenu("Clear", "Farming/Jungle")
self.MonTourMenu.Clear:Boolean("LHQ", "Use Q", true)
self.MonTourMenu:SubMenu("Killsteal", "Killsteal")
self.MonTourMenu.Killsteal:Boolean("KSQ", "KS with Q", true)
self.MonTourMenu.Killsteal:Boolean("KSW", "KS with W", true)
self.MonTourMenu.Killsteal:Boolean("KSE", "KS with E Mini", true)
self.MonTourMenu.Killsteal:Boolean("KSE2", "KS with E Big", true)
self.MonTourMenu.Killsteal:Boolean("KSR", "KS with R Wall", true)
self.MonTourMenu.Killsteal:Boolean("KSR2", "KS with R  No Wall", false)
self.MonTourMenu:SubMenu("Misc", "Misc")
self.MonTourMenu.Misc:Boolean("AL","AutoLevelSkills", true)
self.MonTourMenu.Misc:Boolean("AA","Draw AA Text", true)
self.MonTourMenu.Misc:Boolean("DOH","Draw DMG over HP", true)
self.MonTourMenu.Misc:Boolean("MGUN","Killable Notifier", true)
self.MonTourMenu.Misc:Slider("MGUNSIZE", "Kill Text Size", 25, 5, 60, 1)
--self.MonTourMenu.Misc:ColorPick("CTSCKS", "Current Target Color", {255,255,0,0})
self.MonTourMenu.Misc:Slider("MGUNX", "Kill X POS", 35, 0, 1600, 1)
self.MonTourMenu.Misc:Slider("MGUNY", "Kill Y POS", 394, 0, 1055, 1)
self.MonTourMenu.Misc:Boolean("CTS","Draw Current Target",true)
self.MonTourMenu.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
self.MonTourMenu.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
--self.MonTourMenu:SubMenu("Interrupter", "Interrupter")
self.targetsselect = TargetSelector(1400, TARGET_LESS_CAST, DAMAGE_PHYSICAL)
self.MonTourMenu:TargetSelector("ts", "TargetSelector", self.targetsselect)
self.MonTourMenu:Info("MoTGnar12", " ")
self.MonTourMenu:Info("MoTGnar23", MoTBaseVersion)
self.MonTourMenu:Info("MoTGnar45", "MoTBase "..GetObjectName(myHero)..": v"..self.Version)
OnTick(function(myHero) self:Tick(myHero) end)
OnDraw(function(myHero) self:Draw(myHero) end)
--OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
OnCreateObj(function(Object) self:CreateObj(Object) end)
OnDeleteObj(function(Object) self:DeleteObj(Object) end) 
end

function Gnar:CirclesbyCast()
if self.Qattack ~= myHero and self.MonTourMenu.Combo.QCD:Value() then
DrawCircle(GetOrigin(self.Qattack).x,GetOrigin(self.Qattack).y,GetOrigin(self.Qattack).z,70,6,100,ARGB(255, 0, 0, 255))  
MoTDrawLine3D(GetOrigin(myHero).x,GetOrigin(myHero).y,GetOrigin(myHero).z, GetOrigin(self.Qattack).x,GetOrigin(self.Qattack).y,GetOrigin(self.Qattack).z, 1, ARGB(255, 0, 0, 255))
end
end

function Gnar:CreateObj(Object)
if GetObjectBaseName(Object) == "Gnar_Base_Q_mis.troy" then
self.Qattack = Object
table.insert(self.reticles, Object)
self.tickQ = true
DelayAction(function() self.tickQ2 = true end, 950) 
end
if GetObjectBaseName(Object) == "GnarBig_Base_Q_Rock_Ground.troy" then
self.Qattack = Object
table.insert(self.reticles, Object)
self.tickQ = true
DelayAction(function() self.tickQ2 = true end, 950) 
end
end

function Gnar:DeleteObj(Object)
if GetObjectBaseName(Object) == "Gnar_Base_Q_mis.troy" then--or GetObjectBaseName(Object) == "Gnar_Base_Q_Catch_Spindown.troy" then
self.Qattack = myHero
table.remove(self.reticles, 1)
self.tickQ = false
self.tickQ2 = false
end
if GetObjectBaseName(Object) == "GnarBig_Base_Q_Rock_Ground.troy" then--or GetObjectBaseName(Object) == "Gnar_Base_Q_Catch_Spindown.troy" then
self.Qattack = myHero
table.remove(self.reticles, 1)
self.tickQ = false
self.tickQ2 = false
end
end

function Gnar:QProcessSpell()
for i, reticle in pairs(self.reticles) do  
local Reticlepos = GetOrigin(reticle)
local myHer0 = GetOrigin(myHero)
if GetCastName(myHero,_Q) == "GnarQ" then
if self.MonTourMenu.Combo.QCT:Value() == 2 then
  if self.MonTourMenu.Combo.QT:Value() == false and Reticlepos ~= myHer0 then
    if GetDistanceSqr(Reticlepos,self.circlepos) <= self.MonTourMenu.Combo.QW:Value()*self.MonTourMenu.Combo.QW:Value() then 
    if self.MonTourMenu.Combo.QCWW:Value() == 1 then
      MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z)  
    elseif self.MonTourMenu.Combo.QCWW:Value() == 2 and self.tickQ2 == true and Reticlepos ~= myHer0 then
      MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z) --end)--DelayAction(function() MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z)end, 950) IOW:AddCallback(ON_ATTACK, function() 
    end
    end
    else
  end
  if self.MonTourMenu.Combo.QT:Value() then
    HoldPosition()
  end  
elseif self.MonTourMenu.Combo.QCT:Value() == 1 and self.MonTourMenu.Combo.QT:Value() and Reticlepos ~= myHer0 then
  if  Reticlepos ~= myHer0 and GetDistanceSqr(Reticlepos,self.circlepos) <= self.MonTourMenu.Combo.QW:Value()*self.MonTourMenu.Combo.QW:Value() then 
    MoveToXYZ(Reticlepos.x, Reticlepos.y , Reticlepos.z) 
    else
  end
end
end
end
end

function Gnar:QProcessSpellDraw() 
if GetCastName(myHero,_Q) == "GnarQ" then
if self.MonTourMenu.Combo.QCD:Value() and self.MonTourMenu.Combo.QC:Value() == 1  then --QCD Draw ONOFF -- QC Draw Always Circle ON -- QCT Catch Always in Mouse Range
DrawCircle(self.circlepos.x,self.circlepos.y,self.circlepos.z,self.MonTourMenu.Combo.QW:Value(),2,100,0xff3111e1) 
elseif self.MonTourMenu.Combo.QCD:Value() and self.MonTourMenu.Combo.QC:Value() == 2 then --QCD Draw ONOFF -- QC Draw Q on CD Circle ON -- QCT Catch Always in Mouse Range
  if not self.QREADY and self.tickQ == true then
  DrawCircle(self.circlepos.x,self.circlepos.y,self.circlepos.z,self.MonTourMenu.Combo.QW:Value(),2,100,0xff3111e1) 
  end
elseif self.MonTourMenu.Combo.QCD:Value() and self.MonTourMenu.Combo.QC:Value() == 3 then
end
end
end

function Gnar:Tick(myHero)
   self:QProcessSpell()
	 self:Checks()
   self:ItemUse()
   self:Killsteal()  
   self:Igniteit()
	if IOW:Mode() == "LastHit" then 
    	self:LastHit()
    end	  
	if IOW:Mode() == "LaneClear" then
    IOW.movementEnabled = true
    	self:LaneClear()
    end	
	if IOW:Mode() == "Combo" then
    IOW.movementEnabled = true
		self:Combo()
	end
	if IOW:Mode() == "Harass" then
    IOW.movementEnabled = true
		self:Harass()
	end	
	if self.MonTourMenu.Misc.AL:Value() then
		self:AutoLvL()
	end	
end
 
function Gnar:Draw(myHero) 
  self:QProcessSpellDraw()
  self:CirclesbyCast()
	if self.MonTourMenu.Misc.DOH:Value() then 
		self:Draws()
	end 
	if self.MonTourMenu.Misc.AA:Value() then
		self:AA()
	end	  
if self.MonTourMenu.Misc.CTS:Value() then  
self:DrawENEMY()
end
MoT2:NoteEnemys(false,self.GnarOverAllDmg,0,0,0,0,0,0,0,0)
MoT2:NoteAllys()
--local test2 = GetCurrentMana(myHero)
--local test = GetCastRange(myHero, _E)

--DrawText(""..GetDistance(myHero, GetMousePos()),30,30,120,ARGB(255, 255, 255, 255))
--DrawText(test2,30,30,140,ARGB(255, 255, 255, 255))

end  

function Gnar:AutoLvL()
local leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E} 
		if GetLevel(myHero) == 3 then
			DelayAction(function() LevelSpell(leveltable[3])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[2])end, math.random(1000,2948)) 
			DelayAction(function() LevelSpell(leveltable[1])end, math.random(1000,2948)) 
		else
			DelayAction(function() LevelSpell(leveltable[GetLevel(myHero)])end, math.random(962,2948)) 
		end  
end

function Gnar:DrawENEMY()
	local hpbar = GetHPBarPos(myHero)
      if hpbar.x > 0 then
			if hpbar.y > 0 then 
		FillRect(hpbar.x, hpbar.y+13, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
    FillRect(hpbar.x, hpbar.y+22, 107, 2,ARGB(255,0,0,0))
--    FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
	if self.target ~= nil then
        DrawText(GetObjectName(self.target),14,hpbar.x+113-GetTextArea(GetObjectName(self.target).."  ",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
	else
    DrawText("No Target found!",14,hpbar.x+113-GetTextArea("No Target found",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
  end
end
end
	end



function Gnar:AA()
	for i,unit in pairs(GetEnemyHeroes()) do
		local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
		local unitPos = GetOrigin(unit)
		local dmgW = 10*GetCastLevel(myHero,_W)+(GetBonusAP(myHero)+(6+2*(GetCastLevel(myHero,_W)-1))/100*GetMaxHP(myHero))
    local realdmg = CalcDamage(myHero, unit,0,dmgW or 0)
		local hp = GetCurrentHP(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
      if hPos.x > 0 then
			if hPos.y > 0 then 
        if realdmg > 0 and GetCastName(myHero,_W) == "GnarW" and GetCastLevel(myHero,_W) >= 1 then 
          DrawText(math.ceil(hp/((realdmg+TotalDmg+TotalDmg)/3)).." AA", 15, hPos.x, hPos.y+20, ARGB(255, 255, 255, 255))
        elseif realdmg > 0 and ((GetCastName(myHero,_W) == "GnarW" and GetCastLevel(myHero,_W) < 1) or (GetCastName(myHero,_W) == "gnarbigw")) then 
          DrawText(math.ceil(hp/TotalDmg).." AA", 15, hPos.x, hPos.y+20, ARGB(255, 255, 255, 255))          
      end
      end
	 	end 	
end
end

function Gnar:Checks()
self.QREADY = CanUseSpell(myHero,_Q) == READY
self.WREADY = CanUseSpell(myHero,_W) == READY
self.EREADY = CanUseSpell(myHero,_E) == READY
self.RREADY = CanUseSpell(myHero,_R) == READY
self.MonTourMenu.ts.range = 1400
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.targetPos = GetOrigin(self.target)
self.myHeroPos = GetOrigin(myHero)
if self.target ~= nil then
self.unitname = GetObjectName(self.target)
else
self.unitname = GetObjectName(myHero)
end
if self.MonTourMenu.Combo.QCWW:Value() == 1 then
  self.circlepos = GetMousePos() 
end
if self.MonTourMenu.Combo.QCWW:Value() == 2 then
  self.circlepos = GetOrigin(myHero)
end 
end

function Gnar:LastHit()
--for i=1, IOW.mobs.maxObjects do
--local minion = IOW.mobs.objects[i] 
--local Emini = 10*GetCastLevel(myHero,_W)+(GetBonusAP(myHero)+(6+2*(GetCastLevel(myHero,_W)-1))/100*GetMaxHP(myHero))
--local EdmgMiniGnar = CalcDamage(myHero, minion,GetCastName(myHero,_Q) == "GnarW" and self.QREADY and Emini or 0,0)
--  if ValidTarget(minion, 1100) then
    local BestPos, BestHit = GetLineFarmPosition(1100, 50)
    if self.MonTourMenu.Clear.LHQ:Value() and self.QREADY then
      if BestPos and BestHit > 0 then 
        CastSkillShot(_Q, BestPos)
      end 
    end
--  end  
--  if ValidTarget(minion, GetRange(myHero)) then
--    if GetCurrentHP(minion) < EdmgMiniGnar and GotBuff(minion,"gnarwproc") == 2 and IsInDistance(minion, GetRange(myHero)) then			
--				AttackUnit(minion)
--		end
--  end
--end
end

function Gnar:AttackUnitM(minion)
--for i=1, IOW.mobs.maxObjects do
--local minion = IOW.mobs.objects[i] 
--  if IsInDistance(minion, GetRange(myHero)) and GetDistance(myHero, minion) <= (GetRange(myHero)) and GetDistance(myHero, minion) >= 1 then 
--    AttackUnit(minion)
--  end
--  end
end

function Gnar:LaneClear()
    local BestPos, BestHit = GetLineFarmPosition(1100, 50)
    if self.QREADY and self.MonTourMenu.Clear.LHQ:Value() then --GetCastName(myHero,_Q) == "GnarQ" and 
      if BestPos and BestHit > 0 then 
        CastSkillShot(_Q, BestPos)
      end 
    end
end

function Gnar:JungleClear()
for _,jminion in pairs(minionManager.objects) do
  
end
end

--((self.MonTourMenu.Combo.ME:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Combo.E:Value() and IOW:Mode() == "Harass"))
function Gnar:CastE(targeted)
  local unitpos = GetOrigin(targeted)
  if ValidTarget(targeted, 500) then
    if ((IOW:Mode() == "Combo" and (self.MonTourMenu.Combo.ME:Value() or self.MonTourMenu.Combo.E:Value())) or (IOW:Mode() == "Harass" and (self.MonTourMenu.Harass.ME:Value() or self.MonTourMenu.Harass.E:Value()))) then
      if GetCastName(myHero,_E) == "GnarE" and GotBuff(myHero,"gnartransformsoon") == 1 and GetCurrentMana(myHero) >= 100 then
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,120,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	 
      elseif self.MonTourMenu.Combo.ET:Value() and GetCastName(myHero,_E) == "GnarE" and GotBuff(myHero,"gnartransformtired") == 1 then  
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,120,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	 
      elseif self.MonTourMenu.Harass.ET:Value() and GetCastName(myHero,_E) == "GnarE" and GotBuff(myHero,"gnartransformtired") == 1 then  
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,120,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	        
      elseif GetCastName(myHero,_E) == "gnarbige" and GotBuff(myHero,"gnartransform") == 1 and GetCurrentMana(myHero) < 99.99 then  
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,475,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	
      end
    end 
  end  
end

function Gnar:CastEKS(targeted)
    if ValidTarget(targeted, 500) then
      if self.MonTourMenu.Killsteal.KSE:Value() and GetCastName(myHero,_E) == "GnarE" then  --and GetCurrentMana(myHero) > 99
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,120,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	 	      
      elseif self.MonTourMenu.Killsteal.KSE2:Value() and GetCastName(myHero,_E) == "gnarbige" and GetCurrentMana(myHero) < 99.99 then  
        local EPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1500,100,500,475,false,false)
        if self.EREADY and EPred.HitChance == 1 then
          CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
        end	
      end
    end 
end

function Gnar:JumptoTarget()
for _,minion in pairs(minionManager.objects) do   
  local minion = ClosestMinion(GetOrigin(myHero),(MINION_ENEMY or MINION_ALLY))
    if ValidTarget(minion, 500) and GetTeam(minion) == 200 then
        if GetCastName(myHero,_E) == "GnarE" and GetDistance(myHero, minion) >= 450 then  
        local EPred = GetOrigin(minion)
        if self.EREADY then
          CastSkillShot(_E,EPred.x,EPred.y,EPred.z)
        end	
      end
    end 
end    
local minion = ClosestMinion(GetOrigin(myHero),MINION_ALLY)
    if ValidTarget(minion, 500) then
        if GetCastName(myHero,_E) == "GnarE" and GetDistance(myHero, minion) >= 450 then  
        local EPred = GetOrigin(minion)
        if self.EREADY then
          CastSkillShot(_E,EPred.x,EPred.y,EPred.z)
        end	
      end
    end    
    
end

function Gnar:CastQ(targeted)
  if ValidTarget(targeted, 1100) then
  if (IOW:Mode() == "Combo" and self.MonTourMenu.Combo.Q:Value()) or (IOW:Mode() == "Harass" and self.MonTourMenu.Harass.Q:Value()) then
    if GetCastName(myHero,_Q) == "GnarQ" and GotBuff(myHero,"gnartransformsoon") == 0  then
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1400,100,1100,90,false,true)  
        if self.QREADY and QPred.HitChance == 1 then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end	
    end
   end 
  if (IOW:Mode() == "Combo" and self.MonTourMenu.Combo.MQ:Value()) or (IOW:Mode() == "Harass" and self.MonTourMenu.Harass.MQ:Value()) then    
    if GetCastName(myHero,_Q) == "gnarbigq" and (GotBuff(myHero,"gnartransform") == 1 or not self.EREADY) then
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),2100,100,1100,90,true,true)
        if self.QREADY and QPred.HitChance == 1 then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end	
    end  
  end  
  end
end

function Gnar:CastQKS(targeted)
    if GetCastName(myHero,_Q) == "GnarQ" then
      if ValidTarget(targeted, 1100) then  
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1400,100,1100,90,false,true)
        if self.QREADY and QPred.HitChance == 1 then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end	
      end     
    elseif GetCastName(myHero,_Q) == "gnarbigq" then
      if ValidTarget(targeted, 1100) and GetCurrentMana(myHero) < 99.99 then  
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),1400,100,1100,90,true,true)
        if self.QREADY and QPred.HitChance == 1 then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end	
      end
    end    
end

function Gnar:CastW(targeted)
  local CastRangeW = GetCastRange(myHero, _W) 
  if ValidTarget(targeted, 525) then
    if (IOW:Mode() == "Combo" and self.MonTourMenu.Combo.MW:Value()) or (IOW:Mode() == "Harass" and self.MonTourMenu.Harass.MW:Value()) then
      if GetCastName(myHero,_W) == "gnarbigw" and GotBuff(myHero,"gnartransformsoon") == 0 and GotBuff(myHero,"gnartransform") == 1 and GetCurrentMana(myHero) < 99.99 then  
        local WPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),600,250,525,90,false,true)
        if self.WREADY and WPred.HitChance == 1 then
          CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end	
      end
    end
    end
end

function Gnar:CastWKS(targeted)
  local CastRangeW = GetCastRange(myHero, _W) 
    if self.MonTourMenu.Combo.MW:Value() and ValidTarget(targeted, 525) then
      if GetCastName(myHero,_W) == "gnarbigw" and GetCurrentMana(myHero) < 99.99 then  
        local WPred = GetPredictionForPlayer(GetOrigin(myHero),targeted,GetMoveSpeed(targeted),600,250,525,90,false,true)
        if self.WREADY and WPred.HitChance == 1 then
          CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
        end	
      end
      end
end

function Gnar:CastR()
--local unitname = self.unitname
--then--and (GotBuff(myHero,"gnartransform") == 1 or GotBuff(myHero,"gnartransformsoon") == 1) then 
--GetCastName(myHero,_R) == "GnarR" and and (GotBuff(myHero,"gnartransform") == 1 or GotBuff(myHero,"gnartransformsoon") == 1)ValidTarget(unit, 590) and 
 for _,unit in pairs(GetEnemyHeroes()) do 
        local distance=590 - GetDistance(myHero,unit)
        local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,0,590,590,false,true)
        local PredPos = Vector(RPred.PredPos)
        local HeroPos = Vector(myHero)
        local maxRRange = PredPos - (PredPos - HeroPos) * ( - distance / GetDistance(RPred.PredPos))
        local shootLine = Line(Point(PredPos.x, PredPos.y, PredPos.z), Point(maxRRange.x, maxRRange.y, maxRRange.z))
  for i, Pos in pairs(shootLine:__getPoints()) do
--    if ValidTarget(unit, 20000) then 
--      DrawCircle(maxRRange.x,maxRRange.y,maxRRange.z,30,10,100,ARGB(255, 0, 0, 255)) 
--      DrawText(" "..EnemiesAround(GetOrigin(myHero), 590).." Thereit is!",30,30,200,ARGB(255, 255, 255, 255))
--    end  
	    if MapPosition:inWall(Pos) and self.RREADY and ValidTarget(unit, 590) and GetDistance(myHero, unit) <= 590 then --EnemiesAround(PosAround, 400) >= 0 and
--        DrawText(" "..EnemiesAround(GetOrigin(myHero), 590).." are Stunable",30,30,230,ARGB(255, 255, 255, 255))
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	    end
    end
  end
end

function Gnar:Combo()
--if self.target == nil or GetOrigin(self.target) == nil or IsImmune(self.target,myHero) or IsDead(self.target) or not IsVisible(self.target) or GetTeam(self.target) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Combo.Q:Value() or self.MonTourMenu.Combo.MQ:Value() then
		self:CastQ(self.target)
    end
		if self.MonTourMenu.Combo.MW:Value() then
		self:CastW(self.target)
    end
    if self.MonTourMenu.Combo.E:Value() or self.MonTourMenu.Combo.ME:Value() then
    self:CastE(self.target)
    end
--  self:JumptoTarget()
    if self.MonTourMenu.Combo.MR:Value() then
    self:CastR()
    end
end	
function Gnar:Harass()
--    if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
		if self.MonTourMenu.Harass.Q:Value() or self.MonTourMenu.Harass.MQ:Value() then
		self:CastQ(self.target)
    end
		if self.MonTourMenu.Harass.MW:Value() then
		self:CastW(self.target)
    end
    if self.MonTourMenu.Harass.E:Value() or self.MonTourMenu.Harass.ME:Value() then
    self:CastE(self.target)
    end 
    if self.MonTourMenu.Harass.MR:Value() then
    self:CastR()
    end  
end

function Gnar:Killsteal()
  for _,unit in pairs(GetEnemyHeroes()) do
      local Qmini = 5+30*GetCastLevel(myHero,_Q)+(GetBonusDmg(myHero)+GetBaseDamage(myHero))*1.15
      local Qbig = 5+40*GetCastLevel(myHero,_Q)+(GetBonusDmg(myHero)+GetBaseDamage(myHero))*1.2
      local Wmini = 10*GetCastLevel(myHero,_W)+(GetBonusAP(myHero)+(6+2*(GetCastLevel(myHero,_W)-1))/100*GetMaxHP(myHero))
      local Wbig = 25*GetCastLevel(myHero,_W)+(GetBonusDmg(myHero)+GetBaseDamage(myHero))
      local Egnar = 10+40*GetCastLevel(myHero,_E)+(6/100*GetMaxHP(myHero))
      local RnoWall = 100+(100*GetCastLevel(myHero,_R))+(GetBonusAP(myHero)*0.50)+(GetBonusDmg(myHero)*0.50)
      local RWall = 150+(150*GetCastLevel(myHero,_R))+(GetBonusAP(myHero)*0.75)+(GetBonusDmg(myHero)*0.75)
      local QdmgMiniGnar = CalcDamage(myHero, unit,GetCastName(myHero,_Q) == "GnarQ" and self.QREADY and Qmini or 0,0) --5 / 35 / 65 / 95 / 125 (+ 115% des Angriffsschadens)
      local QdmgMegaGnar = CalcDamage(myHero, unit,GetCastName(myHero,_Q) == "gnarbigq" and self.QREADY and Qbig or 0,0) --5 / 35 / 65 / 95 / 125 (+ 115% des Angriffsschadens)
      local WdmgMiniGnar = CalcDamage(myHero, unit,0,GotBuff(unit,"gnarwproc") == 2 and GetCastName(myHero,_Q) == "GnarW" and Wmini or 0) 
      local WdmgMegaGnar = CalcDamage(myHero, unit,GetCastName(myHero,_W) == "gnarbigw" and self.WREADY and Wbig or 0,0) --25 / 50 / 75 / 100 / 125 (+ 100% des Angriffsschadens)
      local EdmgGnar = CalcDamage(myHero, unit,self.EREADY and Egnar or 0,0) --20 / 60 / 100 / 140 / 180 (+ 6% von Gnars max. Leben)
      local RdmgMegaGnarNoWall = CalcDamage(myHero, unit,self.RREADY and RnoWall or 0,0) -- 200 / 300 / 400 (+ 50% des zusätzlichen Angriffsschaden) +50% AP
      local RdmgMegaGnarWall = CalcDamage(myHero, unit,self.RREADY and RWall or 0,0)
      local hp =  GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
      if self.MonTourMenu.Killsteal.KSQ:Value() and GetCastName(myHero,_Q) == "GnarQ" and self.QREADY and QdmgMiniGnar > hp and GetDistance(myHero, unit) <= 1099 then
        self:CastQKS(unit)
--      elseif GetCastName(myHero,_Q) == "GnarQ" and self.QREADY and QdmgMiniGnar > hp and GetDistance(myHero, unit) >= 1100 then
--        self:JumptoTarget() DelayAction(function() self:CastQKS(unit) end, 100)       
      elseif self.MonTourMenu.Killsteal.KSQ:Value() and GetCastName(myHero,_Q) == "gnarbigq" and self.QREADY and QdmgMegaGnar > hp then
        self:CastQKS(unit)
      elseif self.MonTourMenu.Killsteal.KSW:Value() and GetCastName(myHero,_W) == "gnarbigw" and self.WREADY and WdmgMegaGnar > hp then
        self:CastWKS(unit)
      elseif self.EREADY and EdmgGnar > hp then
        self:CastEKS(unit)
      elseif self.RREADY then  
        local distance=590 - GetDistance(myHero,unit)
        local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,0,590,70,false,true)
        local PredPos = Vector(RPred.PredPos)
        local HeroPos = Vector(myHero)
        local maxRRange = PredPos - (PredPos - HeroPos) * ( - distance / GetDistance(RPred.PredPos))
        local shootLine = Line(Point(PredPos.x, PredPos.y, PredPos.z), Point(maxRRange.x, maxRRange.y, maxRRange.z))
        for i, Pos in pairs(shootLine:__getPoints()) do
          if MapPosition:inWall(Pos) then 
            self.GnarWallDmg = RdmgMegaGnarWall
            if self.MonTourMenu.Killsteal.KSR:Value() and RdmgMegaGnarWall > hp and ValidTarget(unit, 600) then
            if GetDistance(myHero, unit) <= 590 then --EnemiesAround(PosAround, 400) >= 0 and
              CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
            end
          elseif MapPosition:inWall(Pos) == false then
            self.GnarWallDmg = RdmgMegaGnarNoWall
            if self.MonTourMenu.Killsteal.KSR2:Value() and RdmgMegaGnarNoWall > hp and ValidTarget(unit, 600) then
            if GetDistance(myHero, unit) <= 590 then --EnemiesAround(PosAround, 400) >= 0 and
              CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
            end
          end
        end
      end 
    self.GnarOverAllDmg = QdmgMiniGnar+QdmgMegaGnar+WdmgMiniGnar+WdmgMegaGnar+EdmgGnar+self.GnarWallDmg  
  end  
end

function Gnar:Draws()
  	for _,unit in pairs(GetEnemyHeroes()) do	
      local hp =  GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
	if ValidTarget(unit,20000) and hp > self.GnarOverAllDmg then--ARGB(255, 0, 0, 255)
		DrawDmgOverHpBar(unit,hp,0,self.GnarOverAllDmg,ARGB(255, 255, 255, 255))	
	elseif ValidTarget(unit,20000) and hp <= self.GnarOverAllDmg then--ARGB(255, 0, 0, 255)
		DrawDmgOverHpBar(unit,hp,0,hp,ARGB(255, 255, 0, 0)) 
  end
  end
end

function Gnar:GLOBALULTNOTICE()
local herocounter = 0
local killable = ""
for hero,unit in pairs(GetEnemyHeroes()) do
local percent=math.floor(GetCurrentHP(unit)/GetMaxHP(unit)*100)
local DMGpercent=math.floor(self.GnarOverAllDmg/GetCurrentHP(unit)*100)
local DMGpercent2=math.floor((GetBonusDmg(myHero)+GetBaseDamage(myHero))/GetCurrentHP(unit)*100)
local hp =  GetCurrentHP(unit) + GetHPRegen(unit)
local killsize = self.MonTourMenu.Misc.MGUNSIZE:Value()-17
local unitname = ""
if GetObjectName(unit) == "MonkeyKing" then
  unitname = "Wukong"
else
  unitname = GetObjectName(unit)
end  
if self.OverAllDmgAnivia >= hp and IsObjectAlive(unit) and IsObjectAlive(myHero) then
  killable = "is 100% killable!"
  killsize = killsize + 4
elseif self.OverAllDmgAnivia < hp and IsObjectAlive(unit) and IsObjectAlive(myHero) then
  killable = "is "..DMGpercent.."% killable!"
  killsize = killsize + 0
elseif CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and CanUseSpell(myHero,_R) ~= READY and GotBuff(myHero,"GlacialStorm") == 0 and IsObjectAlive(unit) and IsObjectAlive(myHero) then
killable = "is "..DMGpercent2.."% killable!"
killsize = killsize + 0
elseif not IsObjectAlive(unit) then
killable = "is dead!"
percent = 0
killsize = killsize - 4
elseif not IsObjectAlive(myHero) then
killable = "..."
killsize = killsize + 0
elseif not IsVisible(unit) and IsObjectAlive(unit) and IsObjectAlive(myHero) then
killable = "not visible!"
killsize = killsize - 4
end  
---GetTextArea(""..unitname.." ("..percent..") "..killable.."",self.MonTourMenu.Misc.MGUNSIZE:Value())/2
--GetTextArea("No Target found",14)/2
local barWidth = 175+(self.MonTourMenu.Misc.MGUNSIZE:Value()*self.MonTourMenu.Misc.MGUNSIZE:Value()/2)-self.MonTourMenu.Misc.MGUNSIZE:Value()
local rowHeight = 4 + self.MonTourMenu.Misc.MGUNSIZE:Value()
FillRect(self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value()-15+self.MonTourMenu.Misc.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,rowHeight,0x50000000)
FillRect(self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value()-15+self.MonTourMenu.Misc.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,1,0xC0000000)
DrawText(string.format("%s (%d%%) %s", unitname, percent, killable), self.MonTourMenu.Misc.MGUNSIZE:Value()+killsize, self.MonTourMenu.Misc.MGUNX:Value()+2+103-GetTextArea("%s (%d%%) %s",self.MonTourMenu.Misc.MGUNSIZE:Value())/2,self.MonTourMenu.Misc.MGUNSIZE:Value()-17+self.MonTourMenu.Misc.MGUNY:Value()+rowHeight*herocounter, MoTpercentToRGB(percent))
herocounter=herocounter+1
--end
end
end

function Gnar:Igniteit()
  for _, k in pairs(GetEnemyHeroes()) do
    if ValidTarget(k, 700) and Ignite and self.MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and GetDistance(k) > 400 then 
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function Gnar:ItemUse()
  for _,target in pairs(GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and self.MonTourMenu.Items.bork:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and self.MonTourMenu.Items.CutBlade:Value() and ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (self.MonTourMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (self.MonTourMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and self.MonTourMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and ValidTarget(target, self.MonTourMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if self.MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and ValidTarget(target,self.MonTourMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
      end
end      

function Gnar:AttackUnitKS(targeted)  
  if IsInDistance(targeted, GetRange(myHero)) and GetDistance(myHero, targeted) <= (GetRange(myHero)-10) and GetDistance(myHero, targeted) >= 10 then 
    AttackUnit(targeted)
  else
  end
end

--function Gnar:GLOBALULTNOTICE()
--      if not self.EREADY then return end
--        info = ""
--        if self.EREADY then
--       		for _,unit in pairs(GetEnemyHeroes()) do
--                if  IsObjectAlive(unit) then
--                        realdmg = ((45*GetLevel(GetMyHero())+25)+(GetBonusDmg(myHero)+GetBaseDamage(myHero)*0.4))
--                        hp =  GetCurrentHP(unit) + GetHPRegen(unit)
--                        if realdmg > hp then
--                                info = info..GetObjectName(unit)
--                                if not IsVisible(unit) then
--                                        info = info.." not Visible but maybe" 
--                                elseif not ValidTarget(unit, 1400) then
--                                        info = info.." not in Range but"                                                                               
--                                end
--                                info = info.." killable\n"
--                        end
--        		 end               
--			end
--		end		 
--    DrawText(info,self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
--end

--function Gnar:GLOBALULTNOTICEDEBUG()	 
--    DrawText("I am in Range but not killable - TESTMODE ON",self.MonTourMenu.Misc.MGUNSIZE:Value(),self.MonTourMenu.Misc.MGUNX:Value(),self.MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
--end

if _G[GetObjectName(myHero)] then
	_G[GetObjectName(myHero)]()
end	

function MoTpercentToRGB(percent) 
	local r, g
    if percent == 100 then
        percent = 99 end
		
    if percent < 50 then
        r = math.floor(255 * (percent / 50))
        g = 255
    else
        r = 255
        g = math.floor(255 * ((50 - percent % 50) / 50))
    end
	
    return 0xFF000000+g*0xFFFF+r*0xFF
end

local MoT2BaseUVersion = "MoTBaseUtility: v1.0 by MarCiii"

class "MoT2"
function MoT2:__init()
self.recalling = {}
print(MoT2BaseUVersion) 
self.MonTourMenu = MenuConfig("MoTHeroTracker", "MoTHeroTracker")
self.MonTourMenu:Boolean("MGUN","Enemy Notifier", true)
self.MonTourMenu:Slider("MGUNSIZE", "Enemy Text Size", 17, 10, 21, 1)
self.MonTourMenu:Slider("MGUNX", "Enemy X POS", 753, 0, 1920, 1)
self.MonTourMenu:Slider("MGUNY", "Enemy Y POS", 809, 0, 1080, 1)
self.MonTourMenu:ColorPick("MU", "Current Target Color", {153,0,0,44})
self.MonTourMenu:Key("M", "MoveBox", string.byte("A"))
self.MonTourMenu:Boolean("MGUN2","Ally Notifier", true)
self.MonTourMenu:Slider("MGUNSIZE2", "Ally Text Size", 17, 10, 21, 1)
self.MonTourMenu:Slider("MGUNX2", "Ally X POS", 1639, 0, 1920, 1)
self.MonTourMenu:Slider("MGUNY2", "Ally Y POS", 564, 0, 1080, 1)
self.MonTourMenu:ColorPick("MU2", "Current Target Color", {153,0,0,44})
self.MonTourMenu:Key("M2", "MoveBox", string.byte("S"))
self.MonTourMenu:Info("MoT2HeroTracker323", "")
self.MonTourMenu:Info("MoT2HeroTracker22323", ""..MoT2BaseUVersion)
OnTick(function(myHero) self:Tick(myHero) end)
--OnDraw(function(myHero) self:Draw(myHero) end)
--OnProcessRecall(function(Object,recallProc) self:ProcessRecall(Object,recallProc) end)
end
 
function MoT2:Draw(myHero)
--if self.MonTourMenu.MGUNUSE:Value() then  
--self:NoteEnemys(0,0,0,0,0,0,0,0,0,0)
--self:NoteAllys()
--end
end

function MoT2:Tick(myHero)
self.cpos = GetCursorPos()
end

function MoT2:NoteEnemys(check,overall,adQ,apQ,adW,apW,adE,apE,adR,apR) 
local herocounter = 0
local killable = ""
for _,unit in pairs(GetEnemyHeroes()) do
if check == false then  
local adQ = adQ or 0
local adW = adW or 0
local adE = adE or 0
local adR = adR or 0
local apQ = apQ or 0
local apW = apW or 0
local apE = apE or 0
local apR = apR or 0 
local overall = overall or 0
end
if check == true then  
local adQ = CalcDamage(myHero, unit,adQ,0) or 0
local adW = CalcDamage(myHero, unit,adW,0) or 0
local adE = CalcDamage(myHero, unit,adE,0) or 0
local adR = CalcDamage(myHero, unit,adR,0) or 0
local apQ = CalcDamage(myHero, unit,0,apQ) or 0
local apW = CalcDamage(myHero, unit,0,apW) or 0
local apE = CalcDamage(myHero, unit,0,apE) or 0
local apR = CalcDamage(myHero, unit,0,apR) or 0 
local overall = overall or 0
end
local overalldmg = overall+adQ+apQ+adW+apW+adE+apE+adR+apR  
local percent=math.floor(GetCurrentHP(unit)/GetMaxHP(unit)*100)
local DMGpercent=math.floor(overalldmg/GetCurrentHP(unit)*100)
local DMGpercent2=math.floor((GetBonusDmg(myHero)+GetBaseDamage(myHero))/GetCurrentHP(unit)*100)
local hp =  GetCurrentHP(unit) + GetHPRegen(unit)
local killsize = self.MonTourMenu.MGUNSIZE:Value()-17
local unitname = ""
local textkiller = 0
local RGB = self:percentToRGB(percent)
local y = 0
local xmenu = 0
local ymenu = 0
local moveNow = 0
local xmove = self.MonTourMenu.MGUNX:Value()
local ymove = self.MonTourMenu.MGUNY:Value()
if GetObjectName(unit) == "MonkeyKing" then
  unitname = "Wukong"
--if GetObjectName(unit) == GetObjectName(unit) then
--  unitname = "GalioTheMaster1"  
else
  unitname = GetObjectName(unit)
end 
if self.MonTourMenu.M:Value() and KeyIsDown(16) then
  moveNow = {xmenu = self.cpos.x, ymenu = self.cpos.y}
  xmove = math.min(math.max(self.cpos.x, 15), 1920)
  ymove = math.min(math.max(self.cpos.y, -5), 1080)
  self.MonTourMenu.MGUNX:Value(xmove)
  self.MonTourMenu.MGUNY:Value(ymove)
end
if check == true or check == false then
if not IsVisible(unit) then
  textkiller = GetGameTimer()
end  
if overalldmg >= hp and IsObjectAlive(unit) and IsObjectAlive(myHero) then
  killable = "is 100% killable!"
  killsize = killsize + 4
  if not IsVisible(unit) then
    killable = "is 100% killable(mis?)"
    killsize = killsize - 4
  end
elseif overalldmg < hp and IsObjectAlive(unit) and IsObjectAlive(myHero) then
  killable = "is "..DMGpercent.."% killable!"
  killsize = killsize + 0
  if not IsVisible(unit) then
    killable = "is "..DMGpercent.."% killable(mis?)"
    killsize = killsize -1 
  end
elseif not IsObjectAlive(unit) then
killable = "is dead!"
percent = 0
RGB = ARGB(255,255,0,0)
y = 1
killsize = killsize + 3
elseif not IsObjectAlive(myHero) then
killable = "..."
killsize = killsize + 0
end 
end
if check == 0 then
if percent < 4 and IsObjectAlive(unit) then
  killable = "ByeBye!!!"
  killsize = killsize + 6
elseif percent <= 10 and IsObjectAlive(unit) then
  killable = "Health CITICAL!"
  killsize = killsize + 5
elseif percent > 10 and percent < 35 and IsObjectAlive(unit) then
  killable = "Low Life++!"
  killsize = killsize + 4
elseif percent > 35 and percent < 50 and IsObjectAlive(unit) then
  killable = "Low Life+!"
  killsize = killsize + 4  
elseif percent >= 50 and percent < 70 and IsObjectAlive(unit) then
  killable = "Good Life!"
  killsize = killsize + 2
elseif percent >= 70 and percent < 98 and IsObjectAlive(unit) then
  killable = "Ready to fight+!"
  killsize = killsize + 1 
elseif percent >= 99 and IsObjectAlive(unit) then
  killable = "Ready to fight++!"
  killsize = killsize + 0    
elseif not IsObjectAlive(unit) then
killable = "is Dead!"
percent = 0
RGB = ARGB(255,255,0,0)
y = 3
killsize = killsize - 4
end 
end
if self.MonTourMenu.MGUN:Value() and (check == true or check == false) then
local barWidth = 175+(self.MonTourMenu.MGUNSIZE:Value()*self.MonTourMenu.MGUNSIZE:Value()/2)-self.MonTourMenu.MGUNSIZE:Value()
local rowHeight = 4 + self.MonTourMenu.MGUNSIZE:Value()
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,rowHeight,self.MonTourMenu.MU:Value())
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,1,0xC0000000)
DrawText(string.format("%s (%d%%) %s", unitname, percent, killable), self.MonTourMenu.MGUNSIZE:Value()+killsize, xmove+xmenu+2+103-GetTextArea("%s (%d%%) %s",self.MonTourMenu.MGUNSIZE:Value())/2,self.MonTourMenu.MGUNSIZE:Value()-17+ymove+ymenu+y+rowHeight*herocounter, RGB)
--DrawText(""..textkiller,40,220,30*herocounter,0xff00ff00);
herocounter=herocounter+1
elseif self.MonTourMenu.MGUN:Value() and check == 0 then
local barWidth = 175+(self.MonTourMenu.MGUNSIZE:Value()*self.MonTourMenu.MGUNSIZE:Value()/2)-self.MonTourMenu.MGUNSIZE:Value()
local rowHeight = 4 + self.MonTourMenu.MGUNSIZE:Value()
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,rowHeight,self.MonTourMenu.MU:Value())--0x50000000
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE:Value()+rowHeight*herocounter-2,barWidth,1,0xC0000000)
DrawText(string.format("%s (%d%%) %s", unitname, percent, killable), self.MonTourMenu.MGUNSIZE:Value()+killsize, xmove+xmenu+2+103-GetTextArea("%s (%d%%) %s",self.MonTourMenu.MGUNSIZE:Value())/2,self.MonTourMenu.MGUNSIZE:Value()-17+ymove+ymenu+y+rowHeight*herocounter, RGB)
--DrawText(""..textkiller,40,220,30*herocounter,0xff00ff00);
herocounter=herocounter+1
end
end
end

function MoT2:NoteAllys()
local herocounter = 0
local killable = "" 
for _,unit in pairs(GetAllyHeroes()) do
local percent=math.floor(GetCurrentHP(unit)/GetMaxHP(unit)*100)
local hp =  GetCurrentHP(unit) + GetHPRegen(unit)
local killsize = self.MonTourMenu.MGUNSIZE2:Value()-17
local unitname = ""
local textkiller = 0
local RGB = self:percentToRGB(percent)
local y = 0
local xmenu = 0
local ymenu = 0
local moveNow = 0
local xmove = self.MonTourMenu.MGUNX2:Value()
local ymove = self.MonTourMenu.MGUNY2:Value()
if GetObjectName(unit) == "MonkeyKing" then
  unitname = "Wukong" 
else
  unitname = GetObjectName(unit)
end  
if self.MonTourMenu.M2:Value() and KeyIsDown(16) then
  moveNow = {xmenu = self.cpos.x, ymenu = self.cpos.y}
  xmove = math.min(math.max(self.cpos.x, 15), 1920)
  ymove = math.min(math.max(self.cpos.y, -5), 1080)
  self.MonTourMenu.MGUNX2:Value(xmove)
  self.MonTourMenu.MGUNY2:Value(ymove)
end
if percent <= 4 and IsObjectAlive(unit) then
  killable = "ByeBye!!!"
  killsize = killsize + 6
elseif percent <= 10 and percent >= 4 and IsObjectAlive(unit) then
  killable = "Health CITICAL!"
  killsize = killsize + 5
elseif percent >= 10 and percent <= 35 and IsObjectAlive(unit) then
  killable = "Low Life++!"
  killsize = killsize + 4
elseif percent >= 35 and percent <= 50 and IsObjectAlive(unit) then
  killable = "Low Life+!"
  killsize = killsize + 4  
elseif percent >= 50 and percent <= 70 and IsObjectAlive(unit) then
  killable = "Good Life!"
  killsize = killsize + 2
elseif percent >= 70 and percent <= 98 and IsObjectAlive(unit) then
  killable = "Ready to fight+!"
  killsize = killsize + 1 
elseif percent >= 99 and IsObjectAlive(unit) then
  killable = "Ready to fight++!"
  killsize = killsize + 1    
elseif not IsObjectAlive(unit) then
killable = "is Dead!"
percent = 0
RGB = ARGB(255,255,0,0)
y = 3
killsize = killsize - 4
end 

if self.MonTourMenu.MGUN2:Value() then
local barWidth = 175+(self.MonTourMenu.MGUNSIZE2:Value()*self.MonTourMenu.MGUNSIZE2:Value()/2)-self.MonTourMenu.MGUNSIZE2:Value()
local rowHeight = 4 + self.MonTourMenu.MGUNSIZE2:Value()
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE2:Value()+rowHeight*herocounter-2,barWidth,rowHeight,self.MonTourMenu.MU2:Value())--0x50000000
FillRect(xmove+xmenu,ymove+ymenu-15+self.MonTourMenu.MGUNSIZE2:Value()+rowHeight*herocounter-2,barWidth,1,0xC0000000)
DrawText(string.format("%s (%d%%) %s", unitname, percent, killable), self.MonTourMenu.MGUNSIZE2:Value()+killsize, xmove+xmenu+2+103-GetTextArea("%s (%d%%) %s",self.MonTourMenu.MGUNSIZE2:Value())/2,self.MonTourMenu.MGUNSIZE2:Value()-17+ymove+ymenu+y+rowHeight*herocounter, RGB)
--DrawText(""..textkiller,40,220,30*herocounter,0xff00ff00);
herocounter=herocounter+1

end
end
end

--thanks to krystian
function MoT2:percentToRGB(percent) 
	local r, g
    if percent == 100 then
        percent = 99 end
		
    if percent < 50 then
        r = math.floor(255 * (percent / 50))
        g = 255
    else
        r = 255
        g = math.floor(255 * ((50 - percent % 50) / 50))
    end
	
    return 0xFF000000+g*0xFFFF+r*0xFF
end

--Thanks Inspired!
function MoTDrawLine3D(x,y,z,a,b,c,width,col)
	local p1 = WorldToScreen(0, Vector(x,y,z))
	local p2 = WorldToScreen(0, Vector(a,b,c))
	DrawLine(p1.x, p1.y, p2.x, p2.y, width, col)
end

if GetObjectName(myHero) == "Anivia" or GetObjectName(myHero) == "Gnar" then
_G.MoT2 = MoT2()
_G.mot2 = _G.MoT2
_G.Mot2 = _G.MoT2
_G.MOt2 = _G.MoT2
end