require("Inspired")
local MoTBaseVersion = "MoTBase: v1.0 by MarCiii"
print(MoTBaseVersion)

-------------Anivia----------------

class "Anivia"
function Anivia:__init()
self.Version = "1.0"
self.Qattack = myHero
self.Rattack = myHero  
self.Qattack = myHero
--self.RLastHit = false
--self.RLaneClear = false
--self.RJungleClear = false
self.OverAllDmgAnivia = 0
self.MonTourMenu = Menu("MoTAnivia", "MoTAnivia")
self.MonTourMenu:SubMenu("Combo", "Combo")
self.MonTourMenu.Combo:Boolean("Q","Use Q",true)
self.MonTourMenu.Combo:Boolean("QS","Use Q AutoStun in Combo?",true)
self.MonTourMenu.Combo:Boolean("QS2","Always AutoStun if possible?",true)
self.MonTourMenu.Combo:Boolean("W","Use W Auto Wall",false)
self.MonTourMenu.Combo:Boolean("E","Use E",true)
self.MonTourMenu.Combo:Boolean("ES","E only with Debuff?",true)
self.MonTourMenu.Combo:Boolean("R","Use R ",true)
self.MonTourMenu.Combo:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
self.MonTourMenu:SubMenu("LastHit", "LastHit")
self.MonTourMenu.LastHit:Boolean("E","Use E",true)
self.MonTourMenu.LastHit:Boolean("R","Use R",true)
self.MonTourMenu.LastHit:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
self.MonTourMenu:SubMenu("LaneClear", "LaneClear")
self.MonTourMenu.LaneClear:Boolean("E","Use E",true)
self.MonTourMenu.LaneClear:Boolean("R","Use R",true)
self.MonTourMenu.LaneClear:Slider("RM", "Enable if > x Minion Around MousePos", 5, 1, 20, 1)
self.MonTourMenu.LaneClear:Slider("RP", "Disable if < x Minion Around RPos", 1, 1, 10, 1)
self.MonTourMenu.LaneClear:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
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
self.MonTourMenu:SubMenu("KS", "KillSteal")
self.MonTourMenu.KS:Boolean("Q","Use Q",true)
self.MonTourMenu.KS:Boolean("E","Use E",true)
self.MonTourMenu.KS:Boolean("R","Use R",true)
self.MonTourMenu:SubMenu("Interrupter", "Interrupter")
self.MonTourMenu.Interrupter:Boolean("Q","Use Q",true)
self.MonTourMenu.Interrupter:Boolean("W","Use W",true)
self.MonTourMenu:SubMenu("Misc", "Drawings")
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
if IOW:Mode() == "Combo" then
  self:Combo()
end 
if self.MonTourMenu.Misc.DCC:Value() then
self:CirclesbyCast()
end
if self.MonTourMenu.Misc.DOH:Value() then
self:DMGoverHpDraw()
end
--local mymouse = GetMousePos()
--DrawCircle(mymouse,175,0.9,100,0xff0000ff)
end

function Anivia:Tick(myHero)
self:MakeWall()    
self:EnemyChilledUseE()  
self:EnemyNoneChilledUseE()
self:QSSuse()
self:Igniteit()
self:DMGCALCnKS()
if IOW:Mode() == "LastHit" then
self:LastHit()
end
if IOW:Mode() == "LaneClear" then
self:LaneClear()
end
--if self.MonTourMenu.JungleClear.JC:Value() then
--self:JungleClear()
--end
end

function Anivia:DrawENEMY()
	local hpbar = GetHPBarPos(myHero)
		FillRect(hpbar.x, hpbar.y+13, 107, 11,self.MonTourMenu.Misc.CTSC2:Value())
    FillRect(hpbar.x, hpbar.y+22, 107, 2,ARGB(255,0,0,0))
--    FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
	if self.target ~= nil then
--		DrawText(GetObjectName(self.target),14,hpbar.x+110-GetTextArea(GetObjectName(self.target),14)/2, hpbar.y+9,ARGB(255,52,210,35))
--    DrawText(GetObjectName(myHero),14,hpbar.x+113-GetTextArea(GetObjectName(myHero),14)/2, hpbar.y+11,ARGB(255,52,210,35))
--        DrawText("MonkeyKing",14,hpbar.x+113-GetTextArea("MonkeyKing",14)/2, hpbar.y+10,ARGB(255,255,0,0))
        DrawText(GetObjectName(self.target),14,hpbar.x+113-GetTextArea(GetObjectName(self.target).."  ",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
	else
    DrawText("No Target found!",14,hpbar.x+113-GetTextArea("No Target found",14)/2, hpbar.y+10,self.MonTourMenu.Misc.CTSC:Value())
  end
	end

function Anivia:Combo()
if self.MonTourMenu.Combo.Q:Value() then
if ValidTarget(self.target,1200) then 
  local QPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),1000,120,1175,75,false,true) 
  if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then 
      CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
  end 
end 
end
if self.MonTourMenu.Combo.R:Value() then
if ValidTarget(self.target,615) then
local RPred = GetPredictionForPlayer(GetOrigin(myHero),self.target,GetMoveSpeed(self.target),2500,0,615,400,false,false)  
  if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and RPred.HitChance == 1 then  
      CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
  end
end  
end
end

--function Anivia:CheckForSelection()
--if IOW:Mode() == "LastHit" then
--self.RLastHit = true
--else
--self.RLastHit = false
--end
--for i=1, IOW.mobs.maxObjects do
--local minion = IOW.mobs.objects[i]
--if IOW:Mode() == "LaneClear" and ValidTarget(minion, 615) then
--self.RLaneClear = true
--else
--self.RLaneClear = false
--end
--end
--for _,mob in pairs(minionManager.objects) do
--if GetTeam(mob) == MINION_JUNGLE then
--if self.MonTourMenu.JungleClear.JC:Value() and ValidTarget(mob, 615) then
--self.RJungleClear = true
--else
--self.RJungleClear = false
--end
--end
--end
--end

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
            DelayAction(function() CastSpell(_R) end, math.random(1000,1255))
        end
      end  
      if self.MonTourMenu.LastHit.E:Value() and ValidTarget(minion, 650) and ValidTarget(minion, 650)  then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, Edmg) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and GetCastLevel(myHero,_R) < 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, EdmgNoDebuff) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
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
            DelayAction(function() CastSpell(_R) end, math.random(120,1147)) 
          end
        end
      end  
      if self.MonTourMenu.LaneClear.E:Value() and ValidTarget(minion, 650) and ManaCheck then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, Edmg) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and GetCastLevel(myHero,_R) < 1 and GetCurrentHP(minion) < CalcDamage(myHero, minion, 0, EdmgNoDebuff) and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end         
      end
    end    
end
end

--function Anivia:JungleClear()
--	for _,mob in pairs(minionManager.objects) do
--	if GetObjectName(mob) == "SRU_Blue" or GetObjectName(mob) == "SRU_Red" or GetObjectName(mob) == "SRU_Krug" or GetObjectName(mob) == "SRU_Murkwolf" or GetObjectName(mob) == "SRU_Razorbeak" or GetObjectName(mob) == "SRU_Gromp" or GetObjectName(mob) == "Sru_Crab" or GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron" or GetTeam(mob) == MINION_JUNGLE then
--  local MousePos = GetMousePos()
--  local hpbar = GetHPBarPos(myHero)
--  local Edmg = 50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
--  local EdmgNoDebuff = 25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
--  local ManaCheck = 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= self.MonTourMenu.JungleClear.Mana:Value()
--  local mobPos = GetOrigin(mob)
--    if self.MonTourMenu.JungleClear.JC:Value() then
--      if GotBuff(myHero,"FlashFrost") == 0 and CanUseSpell(myHero,_Q) == READY and ValidTarget(mob, 615) and ManaCheck then  
--        CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
--      elseif GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero and ValidTarget(mob, 615) then
----        if GetDistanceSqr(GetOrigin(self.Qattack),mobPos) <= 150*150 then
--          if GetOrigin(self.Qattack) == mobPos then
--            CastSpell(_Q) 
--          end
--      end
--      if self.MonTourMenu.JungleClear.R:Value() then
--        if GotBuff(myHero,"GlacialStorm") == 0 and CanUseSpell(myHero,_R) == READY and self.Rattack == myHero and ValidTarget(mob, 615) and ManaCheck then 
--          DrawCircle(MousePos,420,0.9,100,0xff0000ff)
----          if GetDistanceSqr(GetOrigin(self.Qattack),mobPos) <= 420*420 then
--            CastSkillShot(_R, mobPos.x, mobPos.y, mobPos.z)
----          end 
--        elseif GotBuff(myHero,"GlacialStorm") == 1 and self.Rattack ~= myHero and not ValidTarget(mob, 680) and not (ValidTarget(mob, 680) or GetObjectName(mob) == "SRU_Blue" or GetObjectName(mob) == "SRU_Red" or GetObjectName(mob) == "SRU_Krug" or GetObjectName(mob) == "SRU_Murkwolf" or GetObjectName(mob) == "SRU_Razorbeak" or GetObjectName(mob) == "SRU_Gromp" or GetObjectName(mob) == "Sru_Crab" or GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron") then
----          if MinionsAround(GetOrigin(self.Rattack), 420, mobPos) < 1 then
----            if GetDistanceSqr(GetOrigin(self.Qattack),mobPos) <= 420*420 then
--                CastSpell(_R) 
--        end
--      end  
--      if self.MonTourMenu.JungleClear.E:Value() and ValidTarget(mob, 650) and ManaCheck then
--        if GotBuff(mob,"chilled") == 1 and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, Edmg) and GetCurrentHP(mob) > CalcDamage(myHero, mob, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(mob, _E)
--        end
--      end
--        if GotBuff(mob,"chilled") == 0 and GetCastLevel(myHero,_Q) < 1 and GetCastLevel(myHero,_R) < 1 and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, EdmgNoDebuff) and GetCurrentHP(mob) > CalcDamage(myHero, mob, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(mob, _E)
--        end
--        if GotBuff(mob,"chilled") == 0 and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) and CanUseSpell(myHero,_Q) ~= READY and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, EdmgNoDebuff) and GetCurrentHP(mob) > CalcDamage(myHero, mob, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(mob, _E)
--        end
--        if GotBuff(mob,"chilled") == 1 and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) and GetCurrentHP(mob) < CalcDamage(myHero, mob, 0, EdmgNoDebuff) and GetCurrentHP(mob) > CalcDamage(myHero, mob, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(mob, _E)
--        end    
--      if ValidTarget(mob, 600) then
--      AttackUnit(mob)
--      end
--    	if mob ~= nil and ValidTarget(mob, 600) then
--		DrawText(GetObjectName(mob),14,hpbar.x+110-GetTextArea(GetObjectName(mob),14)/2, hpbar.y+9,ARGB(255,52,210,35))
--	end
--    end    
--end
--end
--end


function Anivia:Checks()
self.MonTourMenu.ts.range = 1200
self.target = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()
self.unit = self.MonTourMenu.ts:GetTarget()--IOW:GetTarget()  
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
local Qdmg = 30 + 30*GetCastLevel(myHero,_Q)+GetBonusAP(myHero)--60 + 60*GetCastLevel(myHero,_Q)+GetBonusAP(myHero) --120 / 180 / 240 / 300 / 360 (+ 100% AP) or 60 / 90 / 120 / 150 / 180 (+ 50% AP)
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
  end
  if GotBuff(unit,"chilled") == 0 then
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
if IOW:Mode() == "Combo" then
  if self.MonTourMenu.Combo.E:Value() and self.MonTourMenu.Combo.ES:Value() then
  if ValidTarget(self.target,650) then
    for i,unit in pairs(GetEnemyHeroes()) do 
      if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
      end
    end
  end
  end
end 
end

function Anivia:EnemyNoneChilledUseE() 
if IOW:Mode() == "Combo" then
  if self.MonTourMenu.Combo.E:Value() and self.MonTourMenu.Combo.ES:Value() == false then
  if ValidTarget(self.target,650) then
        CastTargetSpell(self.target, _E)
  end
  end
end 
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

function Anivia:MakeWall()
--local unit = self.target
local distance = 0
      if EnemiesAround(GetOrigin(myHero), 1200) <= 1 then
        distance = 155  
      elseif EnemiesAround(GetOrigin(myHero), 1200) > 1 then
        distance = 230
      end 
 if self.MonTourMenu.Combo.W:Value() then
  if CanUseSpell(myHero,_W) == READY then  
    for _,unit in pairs(GetEnemyHeroes()) do
      if ValidTarget(unit,1200) then    
			local enemyposx,enemyposy,enemypoz,selfx,selfy,selfz    
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
        if CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY then   
        DelayAction(function() CastSkillShot(_W,wPos.x, wPos.y, wPos.z) end, math.random(800,1100))
        end  
      end
    end
  end
 end
end

function Anivia:ProcessSpell(unit, spell)
for i,unit in pairs(GetEnemyHeroes()) do
if self.MonTourMenu.Combo.QS:Value() and IOW:Mode() == "Combo" and self.MonTourMenu.Combo.QS2:Value() == false then  
  if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
    if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
    CastSpell(_Q) 
    end
  end
end 
if self.MonTourMenu.Combo.QS2:Value() then  
  if GotBuff(myHero,"FlashFrost") == 1 and self.Qattack ~= myHero then
    if EnemiesAround(GetOrigin(self.Qattack), 175) >= 1 then
    CastSpell(_Q) 
    end
  end
end 
if self.MonTourMenu.Combo.RS:Value() then
if IOW:Mode() == "Combo" then  
  if GotBuff(myHero,"GlacialStorm") == 1 and self.Rattack ~= myHero then
    if EnemiesAround(GetOrigin(self.Rattack), 420) <= 0 then
    DelayAction(function() CastSpell(_R) end, math.random(632,1155))
    end
  end  
end
end
end
end

function Anivia:ProcessSpell2(unit, spell)
  for _,unit in pairs(GetEnemyHeroes()) do
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero,_W) == READY and self.MonTourMenu.Interrupter.W:Value() then
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,1000) then
        if IsInDistance(unit, 1000) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1850,100,1000,45,false,true) 
          if WPred.HitChance == 1 then
          CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
          end
        end
      end
     elseif GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) ~= READY and GotBuff(myHero,"FlashFrost") == 0 and self.MonTourMenu.Interrupter.Q:Value() then 
      if self.CHANELLING_SPELLS[spell.name] and ValidTarget(unit,900) then
        if IsInDistance(unit, 900) and GetObjectName(unit) == self.CHANELLING_SPELLS[spell.name].Name and self.MonTourMenu.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,100,1175,75,false,true) 
            if QPred.HitChance == 1 then  
              CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
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
  end  
end


function Anivia:CreateObj(Object) 
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
self.Qattack = Object
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
self.Rattack = Object
end
end

function Anivia:DeleteObj(Object)
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
self.Qattack = myHero
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
self.Rattack = myHero
end
end

-------------TWISTED FATE----------------

class "TwistedFate"
function TwistedFate:__init()
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
--  DrawText(string.format("EPassive= %f", EPassive),25,478,256,0xffffffff);
--  DrawText(string.format("lichbane= %f", lichbane),25,478,286,0xffffffff);
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,316,0xffffffff);
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
--  DrawText(string.format("EPassive= %f", EPassive),25,478,356,0xffffffff);
--  DrawText(string.format("lichbane= %f", lichbane),25,478,386,0xffffffff);
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,416,0xffffffff);
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

if _G[GetObjectName(myHero)] then
	_G[GetObjectName(myHero)]()
end	