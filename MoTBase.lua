require("Inspired")
local MoTBaseVersion = "MoTBase: v1.2 by MarCiii"
-------------Anivia----------------

class "Anivia"
function Anivia:__init()
print(MoTBaseVersion)  
self.Version = "1.2"
self.Qattack = myHero
self.Rattack = myHero  
self.Eattack = myHero
self.Wattack = myHero
self.unitname = myHero
self.minW = 1
self.maxW = 2
self.gametimeQ = 0
self.gametimeW = 0
self.gametimeE = 0
self.gametimeR = 0
self.OverAllDmgAnivia = 0
self.MonTourMenu = MenuConfig("MoTAnivia", "MoTAnivia")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Boolean("Q","Use Q",true)
self.MonTourMenu.Combo:Boolean("QS","Use Q AutoStun in Combo?",true)
self.MonTourMenu.Combo:Boolean("QS2","Always AutoStun if possible?",true)
self.MonTourMenu.Combo:Boolean("W","Use W Auto Wall",false)
self.MonTourMenu.Combo:Slider("minW", "Delay W min.", 800, 10, 3500, 1)
self.MonTourMenu.Combo:Slider("maxW", "Delay W max.", 1100, 100, 3500, 1) 
self.MonTourMenu.Combo:Boolean("E","Use E",true)
self.MonTourMenu.Combo:Boolean("ES","E only with Debuff?",true)
self.MonTourMenu.Combo:Boolean("R","Use R ",true)
self.MonTourMenu.Combo:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
self.MonTourMenu.Combo:Info("AniviaMoT141", "Delay for Turn Off R")
self.MonTourMenu.Combo:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
self.MonTourMenu.Combo:Slider("Imax", "Delay max.", 1055, 100, 3500, 1) 
self.MonTourMenu:SubMenu("Harass", "Harass")
self.MonTourMenu.Harass:Boolean("Q","Use Q",false)
self.MonTourMenu.Harass:Boolean("QS","Use Q AutoStun in Combo?",true)
self.MonTourMenu.Harass:Boolean("QS2","Always AutoStun if possible?",true)
self.MonTourMenu.Harass:Boolean("W","Use W Auto Wall",false)
self.MonTourMenu.Harass:Slider("minW", "Delay W min.", 800, 10, 3500, 1)
self.MonTourMenu.Harass:Slider("maxW", "Delay W max.", 1100, 100, 3500, 1) 
self.MonTourMenu.Harass:Boolean("E","Use E",true)
self.MonTourMenu.Harass:Boolean("ES","E only with Debuff?",true)
self.MonTourMenu.Harass:Boolean("R","Use R ",true)
self.MonTourMenu.Harass:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
self.MonTourMenu.Harass:Info("AniviaMoT142", "Delay for Turn Off R")
self.MonTourMenu.Harass:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
self.MonTourMenu.Harass:Slider("Imax", "Delay max.", 1055, 100, 3500, 1)
self.MonTourMenu:SubMenu("LastHit", "LastHit")
self.MonTourMenu.LastHit:Boolean("E","Use E",true)
self.MonTourMenu.LastHit:Boolean("R","Use R",true)
self.MonTourMenu.LastHit:Info("AniviaMoT142", "Delay for Turn Off R")
self.MonTourMenu.LastHit:Slider("Imin", "Delay min.", 1000, 10, 3500, 1)
self.MonTourMenu.LastHit:Slider("Imax", "Delay max.", 1250, 100, 3500, 1)
self.MonTourMenu.LastHit:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
self.MonTourMenu:SubMenu("LaneClear", "LaneClear")
self.MonTourMenu.LaneClear:Boolean("E","Use E",true)
self.MonTourMenu.LaneClear:Boolean("R","Use R",true)
self.MonTourMenu.LaneClear:Info("AniviaMoT142", "Delay for Turn Off R")
self.MonTourMenu.LaneClear:Slider("Imin", "Delay min.", 120, 10, 3500, 1) 
self.MonTourMenu.LaneClear:Slider("Imax", "Delay max.", 1147, 100, 3500, 1)
self.MonTourMenu.LaneClear:Slider("RM", "Enable if > x Minion Around MousePos", 5, 1, 20, 1)
self.MonTourMenu.LaneClear:Slider("RP", "Disable if < x Minion Around RPos", 1, 1, 10, 1)
self.MonTourMenu.LaneClear:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
--will come soon
--self.MonTourMenu:SubMenu("JungleClear", "JungleClear")
--self.MonTourMenu.JungleClear:Key("JC", "JungleClear", string.byte("A"))
--self.MonTourMenu.JungleClear:Boolean("E","Use E",true)
--self.MonTourMenu.JungleClear:Boolean("R","Use R",true)
--self.MonTourMenu.JungleClear:Slider("RM", "Enable if > x Minion Around MousePos", 5, 1, 20, 1)
--self.MonTourMenu.JungleClear:Slider("RP", "Disable if < x Minion Around RPos", 1, 1, 10, 1)
--self.MonTourMenu.JungleClear:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
self.MonTourMenu:SubMenu("Items", "Items & Ignite")
self.MonTourMenu.Items:Boolean("Ignite","AutoIgnite if OOR and Q/E NotReady",true)
self.MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
self.MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
self.MonTourMenu.Items:Boolean("Zhonya", "Always Use Zhonyas", true)
self.MonTourMenu.Items:Slider("ZhonyaHP", "if My Health < x% (Def.30)", 30, 0, 90, 1)
self.MonTourMenu:SubMenu("KS", "KillSteal")
self.MonTourMenu.KS:Boolean("Q","Use Q",true)
self.MonTourMenu.KS:Boolean("E","Use E",true)
self.MonTourMenu.KS:Boolean("R","Use R",true)
self.MonTourMenu:SubMenu("Interrupter", "Interrupter")
self.MonTourMenu.Interrupter:Boolean("Q","Use Q",true)
self.MonTourMenu.Interrupter:Boolean("W","Use W",true)
self.MonTourMenu.Interrupter:Info("AniviaMoT14", "Delay for Interrupts min/max")
self.MonTourMenu.Interrupter:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
self.MonTourMenu.Interrupter:Slider("Imax", "Delay max.", 1055, 100, 3500, 1) 
self.MonTourMenu:SubMenu("Misc", "Drawings")
self.MonTourMenu.Misc:Boolean("Wall","Draw Wall Circle",true)
self.MonTourMenu.Misc:Boolean("DOH","Draw Damage Over HpBar",true)
self.MonTourMenu.Misc:Boolean("DCC","Draw Casted Circles",true)
self.MonTourMenu.Misc:Boolean("CTS","Draw Current Target",true)
self.MonTourMenu.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
self.MonTourMenu.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
self.targetsselect = TargetSelector(1200, TARGET_LESS_CAST, DAMAGE_MAGIC)
self.MonTourMenu:TargetSelector("ts", "TargetSelector", self.targetsselect)
self.MonTourMenu:Info("AniviaMoT", "")
self.MonTourMenu:Info("AniviaMoT2", MoTBaseVersion)
self.MonTourMenu:Info("AniviaMoT3", "MoTBase "..GetObjectName(myHero)..": v"..self.Version)

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
OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
OnCreateObj(function(Object) self:CreateObj(Object) end)
OnDeleteObj(function(Object) self:DeleteObj(Object) end)
OnProcessSpell(function(unit, spell) self:ProcessSpell2(unit, spell) end)
end
 
function Anivia:Draw(myHero) 
if self.MonTourMenu.Misc.CTS:Value() then  
self:DrawENEMY()
end
self:Checks() 
--self:CheckForSelection()
  self:Combo()
if self.MonTourMenu.Misc.DCC:Value() then
self:CirclesbyCast()
end
if self.MonTourMenu.Misc.DOH:Value() then
self:DMGoverHpDraw()
end

if (self.gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
  DrawText("E AVAILABLE",20,200,420,0xff00ff00);
elseif (self.gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() < (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
  DrawText("E NOT AVAILABLE",20,200,420,0xff00ff00);
end
end

function Anivia:Tick(myHero)
self:MakeWall()    
self:EnemyChilledUseE()  
self:EnemyNoneChilledUseE()
self:QSSuse()
self:Igniteit()
self:DMGCALCnKS()
self:Zhonyas()
if IOW:Mode() == "LastHit" then
self:LastHit()
end
if IOW:Mode() == "LaneClear" then
self:LaneClear()
end
end

function Anivia:DrawENEMY()
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

function Anivia:Combo()
if (self.MonTourMenu.Combo.Q:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.Q:Value() and IOW:Mode() == "Harass") then
if ValidTarget(self.target,1200) then 
  local QPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),1000,120,1175,75,false,true) 
  if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then 
      CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
  end 
end 
end
if (self.MonTourMenu.Combo.R:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.R:Value() and IOW:Mode() == "Harass") then
if ValidTarget(self.target,615) then
local RPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),2500,0,615,400,false,false)  
  if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
      CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
  end
end  
end
end

function Anivia:LastHit()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i]
  local MousePos = GetMousePos()
  local Edmg = 50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local EdmgNoDebuff = 25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local ManaCheck = 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= self.MonTourMenu.LastHit.Mana:Value()
    if IOW:Mode() == "LastHit" and ManaCheck then
      if self.MonTourMenu.LaneClear.R:Value() then
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and ValidTarget(minion, 650) then 
            CastSkillShot(_R, MousePos.x, MousePos.y, MousePos.z)
        end  
        if GotBuff(myHero,"GlacialStorm") == 1 and self.Rattack ~= myHero then --and self.RLastHit == true
            DelayAction(function() CastSpell(_R) end, math.random(self.MonTourMenu.LastHit.Imin:Value(),self.MonTourMenu.LastHit.Imax:Value()))
        end
      end  
      if self.MonTourMenu.LastHit.E:Value() and ValidTarget(minion, 650) and ValidTarget(minion, 650)  then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, Edmg) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, EdmgNoDebuff) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) and ManaCheck then  
          CastTargetSpell(minion, _E)
        end        
      end
    end    
end
end

function Anivia:LaneClear()
for i=1, IOW.mobs.maxObjects do
  local minion = IOW.mobs.objects[i] --MINION_ENEMY
  local MousePos = GetMousePos()
  local Edmg = 50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local EdmgNoDebuff = 25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local ManaCheck = 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= self.MonTourMenu.LaneClear.Mana:Value()
    if IOW:Mode() == "LaneClear" then
      if self.MonTourMenu.LaneClear.R:Value() then
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and ValidTarget(minion, 650) and ManaCheck then 
          if MinionsAround(MousePos, 420, MINION_ENEMY) > self.MonTourMenu.LaneClear.RM:Value() then
            CastSkillShot(_R, MousePos.x, MousePos.y, MousePos.z)
          end
        end  
        if GotBuff(myHero,"GlacialStorm") == 1 and self.Rattack ~= myHero then -- and RLaneClear == true
          if MinionsAround(GetOrigin(self.Rattack), 420, MINION_ENEMY) < self.MonTourMenu.LaneClear.RP:Value()  then --and RLaneClear == false
            DelayAction(function() CastSpell(_R) end, math.random(self.MonTourMenu.LaneClear.Imin:Value(),self.MonTourMenu.LaneClear.Imax:Value()))
          end
        end
      end  
      if self.MonTourMenu.LaneClear.E:Value() and ValidTarget(minion, 650) and ManaCheck then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, Edmg) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, EdmgNoDebuff) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) and ManaCheck then  
          CastTargetSpell(minion, _E)
        end         
      end
    end    
end
end

function Anivia:Checks()
self.MonTourMenu.ts.range = 1200
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
if IOW:Mode() == "Combo" then
self.minW = self.MonTourMenu.Combo.minW:Value()
self.maxW = self.MonTourMenu.Combo.maxW:Value()
elseif IOW:Mode() == "Harass" then
self.minW = self.MonTourMenu.Harass.minW:Value()
self.maxW = self.MonTourMenu.Harass.maxW:Value()
end
if self.target ~= nil then
self.unitname = GetObjectName(self.target)
else
self.unitname = GetObjectName(myHero)
end
end

function Anivia:CirclesbyCast()
if self.Qattack ~= myHero then
DrawCircle(GetOrigin(self.Qattack).x,GetOrigin(self.Qattack).y,GetOrigin(self.Qattack).z,150,6,100,0xff3111e1)    
end
if self.Rattack ~= myHero then
DrawCircle(GetOrigin(self.Rattack).x,GetOrigin(self.Rattack).y,GetOrigin(self.Rattack).z,420,6,100,0xffff0000)    
end
end

function Anivia:DMGoverHpDraw()
for i,unit in pairs(GetEnemyHeroes()) do 
  local enemyhp = GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
if enemyhp < self.OverAllDmgAnivia then
DrawDmgOverHpBar(unit,enemyhp,0,self.OverAllDmgAnivia,0xfffde782) 
elseif enemyhp > self.OverAllDmgAnivia then
DrawDmgOverHpBar(unit,enemyhp,0,self.OverAllDmgAnivia,0xffffffff) 
end
end
end

function Anivia:DMGCALCnKS() 
self.OverAllDmgAnivia = 0
local Qdmg = 60 + 60*GetCastLevel(myHero,_Q)+GetBonusAP(myHero) --30 + 30*GetCastLevel(myHero,_Q)+GetBonusAP(myHero)120 / 180 / 240 / 300 / 360 (+ 100% AP) or 60 / 90 / 120 / 150 / 180 (+ 50% AP)
local EdmgNoDebuff = 25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero) --55 / 85 / 115 / 145 / 175 (+ 50% AP)
local Edmg = 50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero) --110 / 170 / 230 / 290 / 350 (+ 100% AP)
local Rdmg =  40 + 40*GetCastLevel(myHero,_R)+0.25*GetBonusAP(myHero) --80 / 120 / 160 (+ 25% AP)
for i,unit in pairs(GetEnemyHeroes()) do 
local enemyhp = GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY and (CanUseSpell(myHero,_R) == READY or GotBuff(myHero,"GlacialStorm") == 1) then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Qdmg+Edmg+Rdmg)
  if self.MonTourMenu.KS.Q:Value() and self.MonTourMenu.KS.E:Value() and self.MonTourMenu.KS.R:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,120,1175,75,false,true) 
        if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
            if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
      local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2500,0,615,400,false,false)  
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
        end
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end
    end 
   end 
elseif CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) == READY and (CanUseSpell(myHero,_R) == READY or GotBuff(myHero,"GlacialStorm") == 1) then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Edmg+Rdmg)
  if self.MonTourMenu.KS.E:Value() and self.MonTourMenu.KS.R:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,615) then 
      local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2500,0,615,400,false,false)  
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
        end
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end
    end 
  end  
elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) ~= READY and (CanUseSpell(myHero,_R) == READY or GotBuff(myHero,"GlacialStorm") == 1) then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Qdmg+Rdmg)
  if self.MonTourMenu.KS.Q:Value() and self.MonTourMenu.KS.R:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,120,1175,75,false,true) 
        if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
            if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
      local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2500,0,615,400,false,false)  
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
        end
      end
    end
  end  
elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Qdmg+Edmg)
  if self.MonTourMenu.KS.Q:Value() and self.MonTourMenu.KS.E:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1100,0,1175,75,false,true) 
        if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
            if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end
    end
  end  
elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) ~= READY and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Qdmg)
  if self.MonTourMenu.KS.Q:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,120,1175,75,false,true) 
        if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
            if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
      end
    end 
  end  
elseif CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) == READY and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  if GotBuff(unit,"chilled") == 1 then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Edmg)
  elseif GotBuff(unit,"chilled") == 0 then
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,EdmgNoDebuff)
  end
  if self.MonTourMenu.KS.E:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end 
    elseif enemyhp < CalcDamage(myHero, unit,0,EdmgNoDebuff) then
      if ValidTarget(unit,650) then 
        if GotBuff(unit,"chilled") == 0 then
        CastTargetSpell(unit, _E)
        end
      end
    end 
  end  
elseif CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and (CanUseSpell(myHero,_R) == READY or GotBuff(myHero,"GlacialStorm") == 1) then  
  self.OverAllDmgAnivia = CalcDamage(myHero, unit,0,Rdmg)
  if self.MonTourMenu.KS.R:Value() then
    if enemyhp < self.OverAllDmgAnivia then
      if ValidTarget(unit,615) then 
      local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2500,0,615,400,false,false)  
        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
        end
      end
    end 
  end  
end
end
end

function Anivia:EnemyChilledUseE() 
--if IOW:Mode() == "Combo" or IOW:Mode() == "Harass" then
  if (self.MonTourMenu.Combo.E:Value() and self.MonTourMenu.Combo.ES:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.E:Value() and self.MonTourMenu.Harass.ES:Value() and IOW:Mode() == "Harass") then
  if ValidTarget(self.target,650) and CanUseSpell(myHero,_E) == READY then
    for i,unit in pairs(GetEnemyHeroes()) do 
      if GotBuff(unit,"chilled") == 1 and GetObjectName(self.target) == GetObjectName(unit) then
        CastTargetSpell(unit, _E)
      elseif (self.gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) and GetObjectName(self.target) == GetObjectName(unit) and ((CanUseSpell(myHero,_R) ~= READY and GotBuff(myHero,"GlacialStorm") == 0) or (GetCastLevel(myHero,_R) == 0)) then
        CastTargetSpell(unit, _E)
      elseif GetCastLevel(myHero,_Q) == 0 and GetObjectName(self.target) == GetObjectName(unit) then 
        CastTargetSpell(unit, _E)
      elseif GetCastLevel(myHero,_R) == 0 and GetObjectName(self.target) == GetObjectName(unit) then 
        CastTargetSpell(unit, _E)  
      elseif GotBuff(unit,"chilled") == 1 and GetObjectName(self.target) ~= GetObjectName(unit) then
        CastTargetSpell(unit, _E)  
      end
    end
  end
--  end
end 
end

function Anivia:EnemyNoneChilledUseE() 
--if IOW:Mode() == "Combo"  or IOW:Mode() == "Harass" then
if (self.MonTourMenu.Combo.E:Value() and self.MonTourMenu.Combo.ES:Value() == false and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.E:Value() and self.MonTourMenu.Harass.ES:Value() == false and IOW:Mode() == "Harass") then
  if ValidTarget(self.target,650) and CanUseSpell(myHero,_E) == READY then
        CastTargetSpell(self.target, _E)
  end
  end
--end 
end

--Thanks to Deftsu for QSS Code :)
function Anivia:QSSuse()
if GetItemSlot(myHero,3140) > 0 and self.MonTourMenu.Items.QSS:Value() then 
  if GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
    CastTargetSpell(myHero, GetItemSlot(myHero,3140))
  end
end
if GetItemSlot(myHero,3139) > 0 and self.MonTourMenu.Items.QSS:Value() then 
  if GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourMenu.Items.QSSHP:Value() then
    CastTargetSpell(myHero, GetItemSlot(myHero,3139))
  end
end  
end  

function Anivia:Igniteit()  
  for i,enemy in pairs(GetEnemyHeroes()) do
  	if Ignite and self.MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and GetDistance(enemy)>=525 then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
    end
  end          
end

function Anivia:Zhonyas()
if self.MonTourMenu.Items.Zhonya:Value() and GetItemSlot(myHero,3157) > 0 and ValidTarget(self.target, 1000) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) <= self.MonTourMenu.Items.ZhonyaHP:Value()  then
  CastTargetSpell(myHero, GetItemSlot(myHero,3157))
end
end                  

function Anivia:MakeWall()
local distance = 0
local unitname = self.unitname
local minW = self.minW --= self.MonTourMenu.Combo.minW:Value()
local maxW = self.maxW --= self.MonTourMenu.Combo.maxW:Value() 
local target = self.MonTourMenu.ts:GetTarget()
      
      if EnemiesAround(GetOrigin(myHero), 1200) <= 1 then
        distance = 155  
      elseif EnemiesAround(GetOrigin(myHero), 1200) > 1 then
        distance = 230
      end 
-- if ValidTarget(self.target,1200) then     
 if (self.MonTourMenu.Combo.W:Value() and IOW:Mode() == "Combo") or (self.MonTourMenu.Harass.W:Value() and IOW:Mode() == "Harass") then
  if CanUseSpell(myHero,_W) == READY then  
    for _,unit in pairs(GetEnemyHeroes()) do
      if ValidTarget(unit,1200) then    
			local enemyposx,enemyposy,enemyposz,selfx,selfy,selfz    
			local enemyposition = GetOrigin(unit)
			local enemyposx=enemyposition.x
			local enemyposy=enemyposition.y
			local enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
			local self=GetOrigin(myHero)
			local selfx = self.x
			local selfy = self.y
    	local selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
			local wPos = TargetPos-(TargetPos-HeroPos)*(-distance/GetDistance(unit))
--DrawText(""..unitname,12,200,20,0xff00ff00);
      DrawText(GetObjectName(unit),12,200,20,0xff00ff00);
        if CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and GetObjectName(unit) == unitname then
        DelayAction(function() CastSkillShot(_W,wPos.x, wPos.y, wPos.z) end, math.random(minW,maxW))
        end  
      end
    end
  end
 end
--end
end

function Anivia:DrawWall()
local distance = 0
local unitname = self.unitname
local target = self.MonTourMenu.ts:GetTarget()
if EnemiesAround(GetOrigin(myHero), 1200) <= 1 then
        distance = 155  
      elseif EnemiesAround(GetOrigin(myHero), 1200) > 1 then
        distance = 230
end 
-- if ValidTarget(self.target,1200) then     
 if self.MonTourMenu.Misc.Wall:Value() then
  if CanUseSpell(myHero,_W) == READY then  
    for _,unit in pairs(GetEnemyHeroes()) do
      if ValidTarget(unit,1250) then    
			local enemyposx,enemyposy,enemyposz,selfx,selfy,selfz    
			local enemyposition = GetOrigin(unit)
			local enemyposx=enemyposition.x
			local enemyposy=enemyposition.y
			local enemyposz=enemyposition.z
			local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
      local TargetPos2 = Vector(enemyposx+150,enemyposy,enemyposz)
      local TargetPos3 = Vector(enemyposx-150,enemyposy,enemyposz)
			local self=GetOrigin(myHero)
			local selfx = self.x
			local selfy = self.y
    	local selfz = self.z
			local HeroPos = Vector(selfx, selfy, selfz)
      local HeroPos2 = Vector(selfx+150, selfy+150, selfz+150)
      local HeroPos3 = Vector(selfx-150, selfy-150, selfz-150)
			local wPos = TargetPos-(TargetPos-HeroPos)*(-distance/GetDistance(unit))
      local wPos2 = TargetPos2-(TargetPos2-HeroPos2)*(-distance/GetDistance(unit))
      local wPos3 = TargetPos3-(TargetPos3-HeroPos3)*(-distance/GetDistance(unit))
      if GetObjectName(unit) == unitname then 
      DrawCircle(wPos.x,wPos.y,wPos.z,6,6,100,0xffff0000)
end
end
end
end
end
end

function Anivia:ProcessSpell(unit, spell)
for i,unit in pairs(GetEnemyHeroes()) do
if (self.MonTourMenu.Combo.QS:Value() and IOW:Mode() == "Combo" and self.MonTourMenu.Combo.QS2:Value() == false) or (self.MonTourMenu.Harass.QS:Value() and IOW:Mode() == "Harass" and self.MonTourMenu.Harass.QS2:Value() == false) then  
  if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
    if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 and GetObjectName(self.target) == GetObjectName(unit) then
    CastSpell(_Q) 
    elseif EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 and GetObjectName(self.target) ~= GetObjectName(unit) then
    CastSpell(_Q) 
    end    
  end
end 
if self.MonTourMenu.Combo.QS2:Value() or self.MonTourMenu.Harass.QS2:Value() then  
  if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero  then
    if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 and GetObjectName(self.target) == GetObjectName(unit) then
    CastSpell(_Q) 
    elseif EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 and GetObjectName(self.target) ~= GetObjectName(unit) then
    CastSpell(_Q) 
    end 
  end
end 
if (IOW:Mode() == "Combo" and self.MonTourMenu.Combo.RS:Value()) or (IOW:Mode() == "Harass" and self.MonTourMenu.Harass.RS:Value()) then  
  if GotBuff(myHero,"GlacialStorm") == 1 and self.Rattack ~= myHero then
    if EnemiesAround(GetOrigin(self.Rattack), 420) <= 0 then
    if IOW:Mode() == "Combo" then  
    DelayAction(function() CastSpell(_R) end, math.random(self.MonTourMenu.Combo.Imin:Value(),self.MonTourMenu.Combo.Imax:Value()))
    elseif IOW:Mode() == "Harass" then 
    DelayAction(function() CastSpell(_R) end, math.random(self.MonTourMenu.Harass.Imin:Value(),self.MonTourMenu.Harass.Imax:Value()))
    end
  end  
end
end
end
if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
  self.gametimeQ = GetGameTimer()+1
  end
end

function Anivia:ProcessSpell2(unit, spell)
  for _,unit in pairs(GetEnemyHeroes()) do
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero,_W) == READY and self.MonTourMenu.Interrupter.W:Value() then
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,1000) then
        if IsInDistance(unit, 1000) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1850,100,1000,45,false,true) 
          if WPred.HitChance == 1 then
          DelayAction(function() CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z) end,math.random(self.MonTourMenu.Interrupter.Imin:Value(),self.MonTourMenu.Interrupter.Imax:Value()))
          end
        end
      end
     elseif GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) ~= READY and GotBuff(myHero,"FlashFrost") == 0 and self.MonTourMenu.Interrupter.Q:Value() then 
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,900) then
        if IsInDistance(unit, 900) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,100,1175,75,false,true) 
            if QPred.HitChance == 1 then
              DelayAction(function() CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) end,math.random(self.MonTourMenu.Interrupter.Imin:Value(),self.MonTourMenu.Interrupter.Imax:Value()))
                if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
                  if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
                  CastSpell(_Q) 
                  end
                end
            end 
        end 
       end 
     elseif GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero,_Q) == READY and GotBuff(myHero,"FlashFrost") == 0 and self.MonTourMenu.Interrupter.Q:Value() and self.MonTourMenu.Interrupter.W:Value() == false then 
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,900) then
        if IsInDistance(unit, 900) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,100,1175,75,false,true) 
            if QPred.HitChance == 1 then  
              DelayAction(function() CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) end,math.random(self.MonTourMenu.Interrupter.Imin:Value(),self.MonTourMenu.Interrupter.Imax:Value()))
                if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
                  if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
                  CastSpell(_Q) 
                  end
                end
            end 
        end         
      end
    end
  end  
end


function Anivia:CreateObj(Object) 
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
self.Qattack = Object
self.gametimeQ = 0
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
self.Rattack = Object
self.gametimeR = 0
end
if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
self.Eattack = Object
self.gametimeE = 0
end
end

function Anivia:DeleteObj(Object)
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
self.Qattack = myHero
self.gametimeQ = GetGameTimer()
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
self.Rattack = myHero
self.gametimeR = GetGameTimer()
end
if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
self.Eattack = myHero
self.gametimeE = GetGameTimer()
end
end

-------------TWISTED FATE----------------

class "TwistedFate"
function TwistedFate:__init()
print(MoTBaseVersion)  
self.Version = "1.0"
self.MonTourMenu = Menu("MoT-TwistedFate", "MoT-TwistedFate")
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
      local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,250,1450,40,false,true)    
	if CanUseSpell(myHero,_Q) == READY and GetCastName(myHero,_W) == "goldcardlock" then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens)	
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,550) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end         
    end
  elseif CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "redcardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens)	
    if hp < self.OverAllDmgTwisted then
        if ValidTarget(unit,550) then
          CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)	
        end 
        if ValidTarget(unit,525) then
          AttackUnit(unit)
        end 
    end    
  elseif CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "bluecardlock" and GetCastLevel(myHero,_W) > 0 then
		self.OverAllDmgTwisted = CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens)	
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
    DrawDmgOverHpBar(unit,enemyhp,0,self.OverAllDmgTwisted,0xfffde782) 
  elseif enemyhp > self.OverAllDmgTwisted then
    DrawDmgOverHpBar(unit,enemyhp,0,self.OverAllDmgTwisted,0xffffffff) 
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
  local minion = IOW.mobs.objects[i] 
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
if ValidTarget(minion, 525+250) then
  if self.MonTourMenu.Farm.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > self.tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			self.selectedcard = "goldcardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"goldcardpreattack") == 1 and GetCurrentHP(minion) < ycard then 
		AttackUnit(minion)	
	end  
  if self.MonTourMenu.Farm.prio:Value() == 2 and GetTickCount() > self.tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
  if GotBuff(myHero,"bluecardpreattack") == 1  and GetCurrentHP(minion) < bcard then 
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
  local minion = IOW.mobs.objects[i] 
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
  if GotBuff(myHero,"goldcardpreattack") == 1 and GetCurrentHP(minion) < ycard then 
		AttackUnit(minion)	
	end   
  if self.MonTourMenu.Farm2.prio:Value() == 2 and curdmax > ManaValue and GetTickCount() > self.tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			self.selectedcard = "bluecardlock"
			self.tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
  if GotBuff(myHero,"bluecardpreattack") == 1  and GetCurrentHP(minion) < bcard then 
		AttackUnit(minion) 	
	end    
	if self.MonTourMenu.Farm2.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > self.tick then 
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

if _G[GetObjectName(myHero)] then
	_G[GetObjectName(myHero)]()
end	
