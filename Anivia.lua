if GetObjectName(GetMyHero()) ~= "Anivia" then return end

if not pcall( require, "MapPositionGOS" ) then PrintChat("You are missing Walls Library - Go download it and save it Common!") return end
if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua - Go download it and save it Common!") return end
if not pcall( require, "Deftlib" ) then PrintChat("You are missing Deftlib.lua - Go download it and save it in Common!") return end
if not pcall( require, "DamageLib" ) then PrintChat("You are missing DamageLib.lua - Go download it and save it in Common!") return end

print("Anivia - SingleVersion - MoT Reworked v1.1")  

require("MapPositionGOS")
require("Inspired")
require("Deftlib")
require("DamageLib")
--RLastHit = false
--RLaneClear = false
--RJungleClear = false
local MoTAnivia = MenuConfig("MoTAnivia", "MoTAnivia")
MoTAnivia:SubMenu("Combo", "Combo")
MoTAnivia.Combo:Boolean("Q","Use Q",true)
MoTAnivia.Combo:Boolean("QS","Use Q AutoStun in Combo?",true)
MoTAnivia.Combo:Boolean("QS2","Always AutoStun if possible?",true)
MoTAnivia.Combo:Boolean("W","Use W Auto Wall",false)
MoTAnivia.Combo:Key("CW", "Create Wall", string.byte("T"))
MoTAnivia.Combo:Boolean("E","Use E",true)
MoTAnivia.Combo:Boolean("ES","E only with Debuff?",true)
MoTAnivia.Combo:Boolean("R","Use R ",true)
MoTAnivia.Combo:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
MoTAnivia.Combo:Info("AniviaMoT141", "Delay for Turn Off R")
MoTAnivia.Combo:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
MoTAnivia.Combo:Slider("Imax", "Delay max.", 1055, 100, 3500, 1) 
MoTAnivia:SubMenu("Harass", "Harass")
MoTAnivia.Harass:Boolean("Q","Use Q",false)
MoTAnivia.Harass:Boolean("QS","Use Q AutoStun in Combo?",true)
MoTAnivia.Harass:Boolean("QS2","Always AutoStun if possible?",true)
MoTAnivia.Harass:Boolean("W","Use W Auto Wall",false)
MoTAnivia.Harass:Boolean("E","Use E",true)
MoTAnivia.Harass:Boolean("ES","E only with Debuff?",true)
MoTAnivia.Harass:Boolean("R","Use R ",true)
MoTAnivia.Harass:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
MoTAnivia.Harass:Info("AniviaMoT142", "Delay for Turn Off R")
MoTAnivia.Harass:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
MoTAnivia.Harass:Slider("Imax", "Delay max.", 1055, 100, 3500, 1)
MoTAnivia:SubMenu("LastHit", "LastHit")
MoTAnivia.LastHit:Boolean("E","Use E",true)
MoTAnivia.LastHit:Boolean("R","Use R",true)
MoTAnivia.LastHit:Info("AniviaMoT142", "Delay for Turn Off R")
MoTAnivia.LastHit:Slider("Imin", "Delay min.", 1000, 10, 3500, 1)
MoTAnivia.LastHit:Slider("Imax", "Delay max.", 1250, 100, 3500, 1)
MoTAnivia.LastHit:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
MoTAnivia:SubMenu("LaneClear", "LaneClear")
MoTAnivia.LaneClear:Boolean("E","Use E",true)
MoTAnivia.LaneClear:Boolean("R","Use R",true)
MoTAnivia.LaneClear:Info("AniviaMoT142", "Delay for Turn Off R")
MoTAnivia.LaneClear:Slider("Imin", "Delay min.", 120, 10, 3500, 1) 
MoTAnivia.LaneClear:Slider("Imax", "Delay max.", 1147, 100, 3500, 1)
MoTAnivia.LaneClear:Slider("RM", "Enable if > x Minion Around MousePos", 5, 1, 20, 1)
MoTAnivia.LaneClear:Slider("RP", "Disable if < x Minion Around RPos", 1, 1, 10, 1)
MoTAnivia.LaneClear:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
--MoTAnivia:SubMenu("JungleClear", "JungleClear")
--MoTAnivia.JungleClear:Key("JC", "JungleClear", string.byte("A"))
--MoTAnivia.JungleClear:Boolean("E","Use E",true)
--MoTAnivia.JungleClear:Boolean("R","Use R",true)
--MoTAnivia.JungleClear:Slider("RM", "Enable if > x Minion Around MousePos", 5, 1, 20, 1)
--MoTAnivia.JungleClear:Slider("RP", "Disable if < x Minion Around RPos", 1, 1, 10, 1)
--MoTAnivia.JungleClear:Slider("Mana", "if Mana > x%", 30, 0, 80, 1)
MoTAnivia:SubMenu("Items", "Items & Ignite")
MoTAnivia.Items:Boolean("Ignite","AutoIgnite if OOR and Q/E NotReady",true)
MoTAnivia.Items:Boolean("QSS", "Always Use QSS", true)
MoTAnivia.Items:Boolean("QSS2", "Use QSS when SLowed?",false)
MoTAnivia.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
MoTAnivia.Items:Boolean("Zhonya", "Always Use Zhonyas", true)
MoTAnivia.Items:Slider("ZhonyaHP", "if My Health < x% (Def.30)", 30, 0, 90, 1)
MoTAnivia:SubMenu("KS", "KillSteal")
MoTAnivia.KS:Boolean("Q","Use Q",true)
MoTAnivia.KS:Boolean("E","Use E",true)
MoTAnivia.KS:Boolean("R","Use R",true)
MoTAnivia:SubMenu("Interrupter", "Interrupter")
MoTAnivia.Interrupter:Boolean("Q","Use Q",true)
MoTAnivia.Interrupter:Boolean("W","Use W",true)
MoTAnivia.Interrupter:Info("AniviaMoT14", "Delay for Interrupts min/max")
MoTAnivia.Interrupter:Slider("Imin", "Delay min.", 324, 10, 3500, 1)
MoTAnivia.Interrupter:Slider("Imax", "Delay max.", 515, 100, 3500, 1) 
MoTAnivia:SubMenu("Misc2", "Misc")
MoTAnivia.Misc2:Boolean("ALVL","Auto Level Up Skills", true)
MoTAnivia:SubMenu("Misc", "Drawings")
--MoTAnivia.Misc:Boolean("MGUN","Killable Notifier", true)
--MoTAnivia.Misc:Slider("MGUNSIZE", "Kill Text Size", 17, 10, 21, 1)
--MoTAnivia.Misc:ColorPick("CTSCKS", "Current Target Color", {255,255,0,0})
--MoTAnivia.Misc:Slider("MGUNX", "Kill X POS", 753, 0, 1700, 1)
--MoTAnivia.Misc:Slider("MGUNY", "Kill Y POS", 809, 0, 1100, 1)
MoTAnivia.Misc:Boolean("Wall","Draw Wall",true)
MoTAnivia.Misc:Boolean("DOH","Draw Damage Over HpBar",true)
MoTAnivia.Misc:Boolean("DCC","Draw Casted Circles",true)
MoTAnivia.Misc:Boolean("CTS","Draw Current Target",true)
MoTAnivia.Misc:ColorPick("CTSC", "Current Target Color", {255,23,255,120})
MoTAnivia.Misc:ColorPick("CTSC2", "Underground Target Color", {197,109,65,74})
targetsselect = TargetSelector(1200, TARGET_LESS_CAST, DAMAGE_MAGIC)
MoTAnivia:TargetSelector("ts", "TargetSelector", targetsselect)
MoTAnivia:Info("AniviaMoT", "")
MoTAnivia:Info("AniviaMoT3", "MoTBase "..GetObjectName(myHero)..": v1.1 Reworked")

DelayAction(function()
  local QWERSLOT = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,unit in pairs(GetEnemyHeroes()) do
      local unitname = GetObjectName(unit)
        if spell["Name"] == unitname then
        MoTAnivia.Interrupter:Boolean(GetObjectName(unit).."Interrupting", "On "..unitname.." "..(type(spell.Spellslot) == 'number' and QWERSLOT[spell.Spellslot]), true)
        end
    end
  end	
end, 20)

local Qattack = myHero
local Rattack = myHero  
local Eattack = myHero
local Wattack = myHero
local unitname = myHero
local minW = 1
local maxW = 2
local gametimeQ = 0
local gametimeW = 0
local gametimeE = 0
local gametimeR = 0
local OverAllDmgAnivia = 0
local target = MoTAnivia.ts:GetTarget()--IOW:GetTarget()

 
OnDraw(function(myHero)
--  DrawWall()
--TEST()
--MakeWall(target)
--MoT:NoteEnemys(false,OverAllDmgAnivia,0,0,0,0,0,0,0,0)
if MoTAnivia.Misc.Wall:Value() then
local target = MoTAnivia.ts:GetTarget() 
DrawWall(target)
end
if MoTAnivia.Misc.CTS:Value() then  
DrawENEMY()
end
Checks() 
if MoTAnivia.Misc.DCC:Value() then
CirclesbyCast()
end
if MoTAnivia.Misc.DOH:Value() then
DMGoverHpDraw()
end

--DrawText(string.format("x = %d", GetOrigin(myHero).x),20,200,50,0xff00ff00);
--DrawText(string.format("y = %f", GetOrigin(myHero).y),20,200,65,0xff00ff00);
--DrawText(string.format("z = %f", GetOrigin(myHero).z),20,200,80,0xff00ff00);

--DrawText(string.format("x = %d", GetMousePos().x),20,200,100,0xff00ff00);
--DrawText(string.format("y = %f", GetMousePos().y),20,200,115,0xff00ff00);
--DrawText(string.format("z = %f", GetMousePos().z),20,200,130,0xff00ff00);
end)

OnTick(function(myHero)
if IOW:Mode() == "Combo" then 
DoCombo()
end
if IOW:Mode() == "Harass" then
DoHarass()   
end
if IOW:Mode() == "LastHit" then
DoLastHit()
end
if IOW:Mode() == "LaneClear" then
DoLaneClear()
end
local target = MoTAnivia.ts:GetTarget()
if MoTAnivia.Combo.CW:Value() then
MakeWall(target)
end
--if MoTAnivia.JungleClear.JC:Value() then
--JungleClear()
--end
if MoTAnivia.Misc2.ALVL:Value() then
AutoLevel()
end
QRProcess()
--MakeWall()    
QSSuse()
Igniteit()
DMGCALCnKS()
Zhonyas()
end)


function CastQ(target) 
if ValidTarget(target,1200) then 
  local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1000,120,1175,75,false,true) 
  if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then 
      CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
  end 
  if GotBuff(myHero,"FlashFrost") == 1 and GetDistance(target) <= 175 then 
      CastSpell(_Q)
  end  
end 
end

function Echilled(target)  
  if ValidTarget(target,650) and IsReady(_E) then
    for i,unit in pairs(GetEnemyHeroes()) do 
--      DrawText(NameCheck(),12,200,100,0xff00ff00);
--      DrawText(GetObjectName(unit),12,200,140,0xff00ff00);
      if GotBuff(unit,"chilled") == 1 and NameCheck() == GetObjectName(unit) then
        CastTargetSpell(unit, _E)
      elseif (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) and NameCheck() == GetObjectName(unit) and ((CanUseSpell(myHero,_R) ~= READY and GotBuff(myHero,"GlacialStorm") == 0) or (GetCastLevel(myHero,_R) == 0)) then
        CastTargetSpell(unit, _E)
      elseif GetCastLevel(myHero,_Q) == 0 and NameCheck() == GetObjectName(unit) then 
        CastTargetSpell(unit, _E)
      elseif GetCastLevel(myHero,_R) == 0 and NameCheck() == GetObjectName(unit) then 
        CastTargetSpell(unit, _E)  
      elseif GotBuff(unit,"chilled") == 1 and NameCheck() ~= GetObjectName(unit) then
        CastTargetSpell(unit, _E)  
      end
    end
  end
end

function ENonechilled(target) 
  if ValidTarget(target,650) and IsReady(_E) then
        CastTargetSpell(target, _E)
  end 
end

function CastR(target)
if ValidTarget(target,625+275) then--ValidTarget(target,625+280)
local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),2500,0,615,400,false,false) 
local RPredX=RPred.PredPos.x+math.random(-55,55)
local RPredY=RPred.PredPos.y+math.random(-55,55)
local RPredZ=RPred.PredPos.z+math.random(-55,55)
local RPredRnDNor = math.random(175,275)
local MyVectorHero = Vector(GetOrigin(myHero))
local RPred2 = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),2500,0,615,400,false,false) 
--DrawCircle(RPred2.PredPos,420,1,100,0xff00FFff)
RPred2.PredPos = Vector(RPred2.PredPos)+((MyVectorHero-Vector(RPred2.PredPos)):normalized()*RPredRnDNor)
  if GetDistance(target) < 625 and GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and RPred.HitChance == 1 then  
      CastSkillShot(_R,RPredX,RPredY,RPredZ) 
--print("range")
--DrawCircle(RPred2.PredPos,420,1,100,0xff0000ff)
  elseif GetDistance(target) > 625 and GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) then  --and RPred2.HitChance == 1
      CastSkillShot(_R,RPred2.PredPos.x,RPred2.PredPos.y,RPred2.PredPos.z) 
  end  
end
end
  
function DoCombo()
  local target = MoTAnivia.ts:GetTarget()
  if MoTAnivia.Combo.Q:Value() then
    CastQ(target) 
  end 
  if MoTAnivia.Combo.E:Value() and MoTAnivia.Combo.ES:Value() then
    Echilled(target) 
  end  
  if MoTAnivia.Combo.E:Value() and MoTAnivia.Combo.ES:Value() == false then
    ENonechilled(target)
  end
  if MoTAnivia.Combo.R:Value() then
    CastR(target)
  end  
  if MoTAnivia.Combo.W:Value() then
    MakeWall(target)
  end
end

function DoHarass()
  local target = MoTAnivia.ts:GetTarget() 
  if MoTAnivia.Harass.Q:Value() then
    CastQ(target) 
  end  
  if MoTAnivia.Harass.E:Value() and MoTAnivia.Harass.ES:Value() then
    Echilled(target) 
  end 
  if MoTAnivia.Harass.E:Value() and MoTAnivia.Harass.ES:Value() == false then
    ENonechilled(target)
  end
  if MoTAnivia.Harass.R:Value() then
    CastR(target)
  end
  if MoTAnivia.Harass.W:Value() then
    MakeWall(target)
  end  
end  

function DrawENEMY()
  local target = MoTAnivia.ts:GetTarget()
	local hpbar = GetHPBarPos(myHero)
  local x = hpbar.x 
  local y = hpbar.y 
  if x > 0 and y > 0 then
		FillRect(x, y+13, 107, 11,MoTAnivia.Misc.CTSC2:Value())
    FillRect(x, y+22, 107, 2,ARGB(255,0,0,0))
	if target ~= nil then
        DrawText(GetObjectName(target),14,x+113-GetTextArea(GetObjectName(target).."  ",14)/2, y+10,MoTAnivia.Misc.CTSC:Value())
	else
    DrawText("No Target found!",14,x+113-GetTextArea("No Target found",14)/2, y+10,MoTAnivia.Misc.CTSC:Value())
  end
  end
end

function DoLastHit()
--for i=1, IOW.mobs.maxObjects do
--  local minion = IOW.mobs.objects[i]
for i,minion in pairs(minionManager.objects) do
  if GetTeam(minion) == MINION_ENEMY then  
  local MousePos = GetMousePos()
  local Edmg = getdmg("E",minion,myHero,3) --50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero) 
  local EdmgNoDebuff = getdmg("E",minion,myHero)--25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local ManaCheck = GetPercentMP(myHero) >= MoTAnivia.LastHit.Mana:Value()
    if IOW:Mode() == "LastHit" and ManaCheck then
      if MoTAnivia.LastHit.R:Value() then
        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and ValidTarget(minion, 650) and ManaCheck then 
          if MinionsAround(MousePos, 420, MINION_ENEMY) > MoTAnivia.LaneClear.RM:Value() then --MinionsAround(MousePos, 420, MINION_ENEMY)
            CastSkillShot(_R, MousePos.x, MousePos.y, MousePos.z)
          end
        end 
        if GotBuff(myHero,"GlacialStorm") == 1 and Rattack ~= myHero then --and RLastHit == true
            DelayAction(function() CastSpell(_R) end, math.random(MoTAnivia.LastHit.Imin:Value(),MoTAnivia.LastHit.Imax:Value()))
        end
      end  
      if MoTAnivia.LastHit.E:Value() and ValidTarget(minion, 650) and ((GetObjectName(minion):find("Siege")) or (GetObjectName(minion):find("super"))) and ManaCheck  then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < Edmg and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < EdmgNoDebuff and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end        
--      elseif MoTAnivia.LastHit.E:Value() and ValidTarget(minion, 750) and not ((GetObjectName(minion):find("Siege")) or (GetObjectName(minion):find("super"))) and ManaCheck  then
--        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < Edmg and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(minion, _E)
--        end
--        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < EdmgNoDebuff and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(minion, _E)
--        end        
      end      
    end    
end
end
end

function DoLaneClear()
--for i=1, IOW.mobs.maxObjects do
--  local minion = IOW.mobs.objects[i] --MINION_ENEMY
for i,minion in pairs(minionManager.objects) do
  if GetTeam(minion) == MINION_ENEMY then
  local MousePos = GetMousePos()
  local Edmg = getdmg("E",minion,myHero,3) --50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero) 
  local EdmgNoDebuff = getdmg("E",minion,myHero)--25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
  local ManaCheck = GetPercentMP(myHero) >= MoTAnivia.LaneClear.Mana:Value()
    if IOW:Mode() == "LaneClear" then
      if MoTAnivia.LaneClear.R:Value() then
        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and ValidTarget(minion, 650) and ManaCheck then 
          if MinionsAround(MousePos, 420, MINION_ENEMY) > MoTAnivia.LaneClear.RM:Value() then --MinionsAround(MousePos, 420, MINION_ENEMY)
            CastSkillShot(_R, MousePos.x, MousePos.y, MousePos.z)
          end
        end  
        if GotBuff(myHero,"GlacialStorm") == 1 and Rattack ~= myHero then -- and RLaneClear == true
          if MinionsAround(GetOrigin(Rattack), 420, MINION_ENEMY) < MoTAnivia.LaneClear.RP:Value()  then --and RLaneClear == false
            DelayAction(function() CastSpell(_R) end, math.random(MoTAnivia.LaneClear.Imin:Value(),MoTAnivia.LaneClear.Imax:Value()))
          end
        end
      end  
      if MoTAnivia.LaneClear.E:Value() and ValidTarget(minion, 650) and ((GetObjectName(minion):find("Siege")) or (GetObjectName(minion):find("super"))) and ManaCheck then
        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < Edmg and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end
        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < EdmgNoDebuff and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
          CastTargetSpell(minion, _E)
        end         
--      elseif MoTAnivia.LaneClear.E:Value() and ValidTarget(minion, 750) and not ((GetObjectName(minion):find("Siege")) or (GetObjectName(minion):find("super"))) and ManaCheck then
--        if GotBuff(minion,"chilled") == 1 and GetCurrentHP(minion) < Edmg and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(minion, _E)
--        end
--        if GotBuff(minion,"chilled") == 0 and ((GetCastLevel(myHero,_R) < 1) or (GetCastLevel(myHero,_Q) < 1)) and GetCurrentHP(minion) < EdmgNoDebuff and GetCurrentHP(minion) > CalcDamage(myHero, minion, GetBonusDmg(myHero)+GetBaseDamage(myHero), 0) then  
--          CastTargetSpell(minion, _E)
--        end         
      end      
    end    
end
end
end

function Checks()
MoTAnivia.ts.range = 1200 
local target = MoTAnivia.ts:GetTarget()--IOW:GetTarget()
end


function NameCheck()
local target = MoTAnivia.ts:GetTarget()
if target ~= nil then
return GetObjectName(target)
else
return GetObjectName(myHero)
end 
--DrawText(NameCheck(),20,200,450,0xff00ff00);
end

function CirclesbyCast()
if Qattack ~= myHero then
DrawCircle(GetOrigin(Qattack).x,GetOrigin(Qattack).y,GetOrigin(Qattack).z,180,6,100,0xff3111e1)    
end
if Rattack ~= myHero then
DrawCircle(GetOrigin(Rattack).x,GetOrigin(Rattack).y,GetOrigin(Rattack).z,420,6,100,0xffff0000)    
end
end

function DMGoverHpDraw()
for i,unit in pairs(GetEnemyHeroes()) do 
local enemyhp = GetHP2(unit)
if enemyhp <= OverAllDmgAnivia then
DrawDmgOverHpBar(unit,enemyhp,0,enemyhp,ARGB(255, 255, 0, 0)) 
elseif enemyhp > OverAllDmgAnivia then
DrawDmgOverHpBar(unit,enemyhp,0,OverAllDmgAnivia,ARGB(255, 255, 255, 255)) 
end
end
end


function DMGCALCnKS() 
OverAllDmgAnivia = 0
for i,unit in pairs(GetEnemyHeroes()) do 
local Qdmg = getdmg("Q",unit,myHero,3)
local EdmgNoDebuff = getdmg("E",unit,myHero)
local Edmg = getdmg("E",unit,myHero,3) 
local Rdmg =  getdmg("R",unit,myHero)
local enemyhp = GetHP2(unit)
local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,120,1175,75,false,true) 
local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2500,0,615,400,false,false) 
local RPredX=RPred.PredPos.x+math.random(-55,55)
local RPredY=RPred.PredPos.y+math.random(-55,55)
local RPredZ=RPred.PredPos.z+math.random(-55,55)
if IsReady(_Q) and IsReady(_E) and (IsReady(_R) or GotBuff(myHero,"GlacialStorm") == 1) then
  OverAllDmgAnivia = Qdmg+Edmg+Rdmg
  if MoTAnivia.KS.Q:Value() and MoTAnivia.KS.E:Value() and MoTAnivia.KS.R:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,1100) then 
        if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
            if EnemiesAround(GetOrigin(Qattack), 180) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPredX,RPredY,RPredZ) 
        end
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end
    end 
   end 
elseif CanUseSpell(myHero,_Q) ~= READY and IsReady(_E) and (IsReady(_R) or GotBuff(myHero,"GlacialStorm") == 1) then
  OverAllDmgAnivia = Edmg+Rdmg
  if MoTAnivia.KS.E:Value() and MoTAnivia.KS.R:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPredX,RPredY,RPredZ) 
        end
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end
    end 
  end  
elseif IsReady(_Q) and CanUseSpell(myHero,_E) ~= READY and (IsReady(_R) or GotBuff(myHero,"GlacialStorm") == 1) then
  OverAllDmgAnivia = Qdmg+Rdmg
  if MoTAnivia.KS.Q:Value() and MoTAnivia.KS.R:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,1100) then 
        if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
            if EnemiesAround(GetOrigin(Qattack), 180) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and RPred.HitChance == 1 then  
        CastSkillShot(_R,RPredX,RPredY,RPredZ) 
        end
      end
    end
  end  
elseif IsReady(_Q) and IsReady(_E) and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  OverAllDmgAnivia = Qdmg+Edmg
  if MoTAnivia.KS.Q:Value() and MoTAnivia.KS.E:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,1100) then 
        if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
            if EnemiesAround(GetOrigin(Qattack), 180) >= 1 then
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
elseif IsReady(_Q) and CanUseSpell(myHero,_E) ~= READY and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  OverAllDmgAnivia = Qdmg
  if MoTAnivia.KS.Q:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,1100) then 
        if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then  
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
          if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
            if EnemiesAround(GetOrigin(Qattack), 180) >= 1 then
            CastSpell(_Q) 
            end
          end
        end 
      end
    end 
  end  
elseif CanUseSpell(myHero,_Q) ~= READY and IsReady(_E) and (CanUseSpell(myHero,_R) ~= READY or GotBuff(myHero,"GlacialStorm") == 0) then
  if GotBuff(unit,"chilled") == 1 then
  OverAllDmgAnivia = Edmg
  elseif GotBuff(unit,"chilled") == 0 then
  OverAllDmgAnivia = EdmgNoDebuff
  end
  if MoTAnivia.KS.E:Value() then
    if enemyhp < OverAllDmgAnivia then
      if ValidTarget(unit,650) then 
        if GotBuff(unit,"chilled") == 1 then
        CastTargetSpell(unit, _E)
        end
      end 
    elseif enemyhp < EdmgNoDebuff then
      if ValidTarget(unit,650) then 
        ENonechilled(unit)
      end
    end 
  end  
elseif CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and (IsReady(_R) or GotBuff(myHero,"GlacialStorm") == 1) then  
  OverAllDmgAnivia = Rdmg
  if MoTAnivia.KS.R:Value() then
    CastR(unit)
    end 
  end  
end
end


function AutoLevel()
local mapID = GetMapID()
local LevelUp = {_Q, _E, _E, _Q, _E, _R, _E, _W, _E, _W, _R, _W, _W, _W, _Q, _R, _Q, _Q}
if GetLevel(myHero) == 3 and (mapID == CRYSTAL_SCAR or mapID == HOWLING_ABYSS) then
DelayAction(function() LevelSpell(LevelUp[1]) end, math.random(math.random(1000,1500),math.random(2500,3000)))
DelayAction(function() LevelSpell(LevelUp[2]) end, math.random(math.random(1000,1500),math.random(2500,3000)))
DelayAction(function() LevelSpell(LevelUp[3]) end, math.random(math.random(1000,1500),math.random(2500,3000)))
else
DelayAction(function() LevelSpell(LevelUp[GetLevel(myHero)]) end, math.random(math.random(1000,1500),math.random(2500,3000)))
end
end

function QSSuse()
local itemtable = {3139,3140}
for _,item in pairs(itemtable) do 
local QSS = GetItemSlot(myHero,item)
if MoTAnivia.Items.QSS:Value() and QSS > 0 then 
  if IsReady(QSS) then
    if MoTAnivia.Items.QSS2:Value() then
      if IsSlowed(myHero) or IsImmobile(myHero) or toQSS and GetPercentHP(myHero) <= MoTAnivia.Items.QSSHP:Value() then
        CastSpell(QSS)
      end
    elseif MoTAnivia.Items.QSS2:Value() == false then  
      if IsImmobile(myHero) or toQSS and GetPercentHP(myHero) <= MoTAnivia.Items.QSSHP:Value() then
        CastSpell(QSS)
      end      
    end
  end
end 
end
end   

function Igniteit()  
  for i,enemy in pairs(GetEnemyHeroes()) do
  	if Ignite and MoTAnivia.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and GetDistance(enemy)>=525 then
          if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
          CastTargetSpell(enemy, Ignite)
          end
    end
  end          
end

function Zhonyas()
if MoTAnivia.Items.Zhonya:Value() and GetItemSlot(myHero,3157) > 0 and ValidTarget(target, 1000) and GetPercentHP(myHero) <= MoTAnivia.Items.ZhonyaHP:Value()  then
  CastSpell(GetItemSlot(myHero,3157))
end
end                  

function RangeW()
local wrangetable = {400,500,600,700,800}
if GetCastLevel(myHero,_W) > 0 then
return wrangetable[GetCastLevel(myHero,_W)]/2
end
end

function MakeWall(target)
if GetCastLevel(myHero,_W) > 0 then  
local WallMax = 0
local WallMaxEC = 0
local MaxRangeHero = GetHitBox(myHero) + GetRange(myHero)
local extrarange = 0
if ValidTarget(target, MaxRangeHero) then 
local MyVectorHero = Vector(GetOrigin(myHero))
local MyVectorEnemy = Vector(GetOrigin(target))
DrawCircle(MyVectorEnemy,100,1,100,0xff00FFff)
if GetDistance(target) <= MaxRangeHero then
WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)-(extrarange*2)))
WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)+250))
else
WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250))
WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250+250))
end
local Wall = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250))
--local WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)))
local WallR = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular())
local WallL = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
local WallRMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular())
local WallLMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
local WallRMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized()*(RangeW()/2)):perpendicular())
local WallLMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized()*(RangeW()/2)):perpendicular2())
local LineR = Line(Point(WallRMax.x, WallRMax.y, WallRMax.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))
local LineL = Line(Point(WallLMax.x, WallLMax.y, WallLMax.z), Point(WallLMax2.x, WallLMax2.y, WallLMax2.z))
local LineMid = Line(Point(WallLMax2.x, WallLMax2.y, WallLMax2.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))
--DrawCircle(Wall,10,1,100,ARGB(100,0,255,0))
--DrawCircle(WallMax,10,1,100,ARGB(100,0,255,0))
--DrawCircle(WallR,10,1,100,ARGB(100,255,0,0))
--DrawCircle(WallL,10,1,100,ARGB(100,0,0,255))
--DrawCircle(WallRMax,12,4,100,ARGB(200,255,0,0))
--DrawCircle(WallLMax,12,4,100,ARGB(200,0,0,255))
--DrawCircle(WallRMax2,10,1,100,ARGB(100,255,255,255))
--DrawCircle(WallLMax2,10,1,100,ARGB(100,255,255,255))
--DrawLine3D(WallR.x,WallR.y,WallR.z,WallL.x,WallL.y,WallL.z,5,ARGB(100,255,255,0))
--DrawLine3D(WallRMax.x,WallRMax.y,WallRMax.z,WallLMax.x,WallLMax.y,WallLMax.z,5,ARGB(100,255,255,0))
  for i, Rpos in pairs(LineR:__getPoints()) do
    for i, Lpos in pairs(LineL:__getPoints()) do  
      for i, Mpos in pairs(LineMid:__getPoints()) do      
        if MapPosition:inWall(Mpos) == true then return end
        if CountObjectsOnLineSegment(WallMax, WallMaxEC, RangeW()+10, GetEnemyHeroes()) < 1 then --and GetDistance(target) < GetPredictedPos(target,250) then--EnemiesAround(WallMax,RangeW()) < 2 then GetDistance(target) < GetPredictedPos(target,250) then --and 
        if MapPosition:inWall(Lpos) and MapPosition:inWall(Rpos) and MapPosition:inWall(Mpos) == false then
--          DrawText("IT IS OKAY - R AND L",30,200,140,ARGB(100,255,255,0)); 
          CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
        elseif MapPosition:inWall(Lpos) == false and MapPosition:inWall(Rpos) and MapPosition:inWall(Mpos) == false then
--          DrawText("IT IS OKAY - R",30,200,140,ARGB(255,255,0,0));  
          CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
        elseif MapPosition:inWall(Lpos) and MapPosition:inWall(Rpos) == false and MapPosition:inWall(Mpos) == false then
--          DrawText("IT IS OKAY - L",30,200,140,ARGB(255,0,0,255));  
          CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
        end  
        end
      end
      end
    end
end
end
end

function DrawWall(target)
if GetCastLevel(myHero,_W) > 0 then  
local WallMax = 0
local WallMaxEC = 0
local MaxRangeHero = GetHitBox(myHero) + GetRange(myHero)
local extrarange = 0
if ValidTarget(target, MaxRangeHero) then 
local MyVectorHero = Vector(GetOrigin(myHero))
local MyVectorEnemy = Vector(GetOrigin(target))
DrawCircle(MyVectorEnemy,100,1,100,0xff00FFff)
if GetDistance(target) <= MaxRangeHero then
WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)-(extrarange*2)))
WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)+250))
else
WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250))
WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250+250))
end
local Wall = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(250))
--local WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized()*(910-GetDistance(target)))
local WallR = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular())
local WallL = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
local WallRMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular())
local WallLMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
local WallRMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized()*(RangeW()/2)):perpendicular())
local WallLMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized()*(RangeW()/2)):perpendicular2())
local LineR = Line(Point(WallRMax.x, WallRMax.y, WallRMax.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))
local LineL = Line(Point(WallLMax.x, WallLMax.y, WallLMax.z), Point(WallLMax2.x, WallLMax2.y, WallLMax2.z))
local LineMid = Line(Point(WallLMax2.x, WallLMax2.y, WallLMax2.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))
--DrawCircle(Wall,10,1,100,ARGB(100,0,255,0))
--DrawCircle(WallMax,10,1,100,ARGB(100,0,255,0))
--DrawCircle(WallR,10,1,100,ARGB(100,255,0,0))
--DrawCircle(WallL,10,1,100,ARGB(100,0,0,255))
--DrawCircle(WallRMax,12,4,100,ARGB(200,255,0,0))
--DrawCircle(WallLMax,12,4,100,ARGB(200,0,0,255))
--DrawCircle(WallRMax2,10,1,100,ARGB(100,255,255,255))
--DrawCircle(WallLMax2,10,1,100,ARGB(100,255,255,255))
--DrawLine3D(WallR.x,WallR.y,WallR.z,WallL.x,WallL.y,WallL.z,5,ARGB(100,255,255,0))
DrawLine3D(WallRMax.x,WallRMax.y,WallRMax.z,WallLMax.x,WallLMax.y,WallLMax.z,5,ARGB(100,255,255,0))
end
end
end

function DrawRectangleOutline(startPos, endPos, width)
	local c1 = startPos+Vector(Vector(endPos)-startPos):perpendicular():normalized()*width/2
	local c2 = startPos+Vector(Vector(endPos)-startPos):perpendicular2():normalized()*width/2
	local c3 = endPos+Vector(Vector(startPos)-endPos):perpendicular():normalized()*width/2
	local c4 = endPos+Vector(Vector(startPos)-endPos):perpendicular2():normalized()*width/2
	DrawLine3D(c1.x,c1.y,c1.z,c2.x,c2.y,c2.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c3.x,c3.y,c3.z,c4.x,c4.y,c4.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	local c1 = startPos+Vector(Vector(endPos)-startPos):perpendicular():normalized()*width
	local c2 = startPos+Vector(Vector(endPos)-startPos):perpendicular2():normalized()*width
	local c3 = endPos+Vector(Vector(startPos)-endPos):perpendicular():normalized()*width
	local c4 = endPos+Vector(Vector(startPos)-endPos):perpendicular2():normalized()*width
	DrawLine3D(c1.x,c1.y,c1.z,c2.x,c2.y,c2.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c2.x,c2.y,c2.z,c3.x,c3.y,c3.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c3.x,c3.y,c3.z,c4.x,c4.y,c4.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c1.x,c1.y,c1.z,c4.x,c4.y,c4.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
end

function DrawLine3D(x,y,z,a,b,c,width,col)
	local p1 = WorldToScreen(0, Vector(x,y,z))
	local p2 = WorldToScreen(0, Vector(a,b,c))
	DrawLine(p1.x, p1.y, p2.x, p2.y, width, col)
end

function QRProcess()
for i,unit in pairs(GetEnemyHeroes()) do
if (MoTAnivia.Combo.QS:Value() and IOW:Mode() == "Combo" and MoTAnivia.Combo.QS2:Value() == false) or (MoTAnivia.Harass.QS:Value() and IOW:Mode() == "Harass" and MoTAnivia.Harass.QS2:Value() == false) then  
  if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
    if EnemiesAround(GetOrigin(Qattack), 175) >= 1 and NameCheck() == GetObjectName(unit) then
    CastSpell(_Q) 
    elseif EnemiesAround(GetOrigin(Qattack), 175) >= 1 and NameCheck() ~= GetObjectName(unit) then
    CastSpell(_Q) 
    end    
  end
end 
if MoTAnivia.Combo.QS2:Value() or MoTAnivia.Harass.QS2:Value() then  
  if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero  then
    if EnemiesAround(GetOrigin(Qattack), 180) >= 1 and NameCheck() == GetObjectName(unit) then
    CastSpell(_Q) 
    elseif EnemiesAround(GetOrigin(Qattack), 180) >= 1 and NameCheck() ~= GetObjectName(unit) then
    CastSpell(_Q) 
    end 
  end
end 
if (IOW:Mode() == "Combo" and MoTAnivia.Combo.RS:Value()) or (IOW:Mode() == "Harass" and MoTAnivia.Harass.RS:Value()) then  
  if GotBuff(myHero,"GlacialStorm") == 1 and Rattack ~= myHero then
    if EnemiesAround(GetOrigin(Rattack), 420) <= 0 then
    if IOW:Mode() == "Combo" then  
    DelayAction(function() CastSpell(_R) end, math.random(MoTAnivia.Combo.Imin:Value(),MoTAnivia.Combo.Imax:Value()))
    elseif IOW:Mode() == "Harass" then 
    DelayAction(function() CastSpell(_R) end, math.random(MoTAnivia.Harass.Imin:Value(),MoTAnivia.Harass.Imax:Value()))
    end
  end  
end
end
end
if IsReady(_Q) and IsReady(_E) then
  gametimeQ = GetGameTimer()+1
  end
end

OnProcessSpell(function(unit, spell)
  for _,unit in pairs(GetEnemyHeroes()) do
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_W) and MoTAnivia.Interrupter.W:Value() then
      if CHANELLING_SPELLS[spell.name] and ValidTarget(unit,1000) then
        if IsInDistance(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and MoTAnivia.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1850,100,1000,45,false,true) 
          if WPred.HitChance == 1 then
          DelayAction(function() CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z) end,math.random(MoTAnivia.Interrupter.Imin:Value(),MoTAnivia.Interrupter.Imax:Value()))
          end
        end
      end
     elseif GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_Q) and CanUseSpell(myHero,_W) ~= READY and GotBuff(myHero,"FlashFrost") == 0 and MoTAnivia.Interrupter.Q:Value() then 
      if CHANELLING_SPELLS[spell.name] and ValidTarget(unit,900) then
        if IsInDistance(unit, 900) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and MoTAnivia.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,100,1175,75,false,true) 
            if QPred.HitChance == 1 then
              DelayAction(function() CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) end,math.random(MoTAnivia.Interrupter.Imin:Value(),MoTAnivia.Interrupter.Imax:Value()))
                if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
                  if EnemiesAround(GetOrigin(Qattack), 175) >= 1 then
                  CastSpell(_Q) 
                  end
                end
            end 
        end 
       end 
     elseif GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_Q) and GotBuff(myHero,"FlashFrost") == 0 and MoTAnivia.Interrupter.Q:Value() and MoTAnivia.Interrupter.W:Value() == false then 
      if CHANELLING_SPELLS[spell.name] and ValidTarget(unit,900) then
        if IsInDistance(unit, 900) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and MoTAnivia.Interrupter[GetObjectName(unit).."Interrupting"]:Value() then 
          local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1000,100,1175,75,false,true) 
            if QPred.HitChance == 1 then  
              DelayAction(function() CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) end,math.random(MoTAnivia.Interrupter.Imin:Value(),MoTAnivia.Interrupter.Imax:Value()))
                if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
                  if EnemiesAround(GetOrigin(Qattack), 175) >= 1 then
                  CastSpell(_Q) 
                  end
                end
            end 
        end         
      end
    end
  end  
end)


OnCreateObj(function(Object)
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
Qattack = Object
gametimeQ = 0
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
Rattack = Object
gametimeR = 0
end
if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
Eattack = Object
gametimeE = 0
end
--if GetObjectBaseName(Object) == "cryo_Cristalize.troy" then
--Wattack = Object
--gametimeW = 0
--end
end)

OnDeleteObj(function(Object)
if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
Qattack = myHero
gametimeQ = GetGameTimer()
end
if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
Rattack = myHero
gametimeR = GetGameTimer()
end
if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
Eattack = myHero
gametimeE = GetGameTimer()
end
--if GetObjectBaseName(Object) == "cryo_Cristalize.troy" then
--Wattack = myHero
--gametimeW = GetGameTimer()
--end
end)



function TEST()
  local mymouse = GetMousePos()
DrawCircle(mymouse,175,0.9,100,0xff0000ff)
local Q = GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q))
local CDR = GetCDR(myHero)
local Q3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q))
local W = GetCastCooldown(myHero,_W,GetCastLevel(myHero,_W))
local W3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_W,GetCastLevel(myHero,_W))
local E = GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E))
local E3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E))
local R = GetCastCooldown(myHero,_R,GetCastLevel(myHero,_R))
local R3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_R,GetCastLevel(myHero,_R))

--      DrawText(GetObjectName(unit),12,200,20,0xff00ff00);
--      DrawText("GLOBAL CDR: "..CDR,20,200,20,0xff00ff00);  
--      DrawText("Q CDR: "..Q,20,200,40,0xff00ff00);
--      DrawText("CDR Q: "..Q3,20,200,60,0xff00ff00);      
--      DrawText("W CDR: "..W,20,200,80,0xff00ff00);
--      DrawText("CDR W: "..W3,20,200,100,0xff00ff00);
--      DrawText("E CDR: "..E,20,200,120,0xff00ff00);
--      DrawText("CDR E: "..E3,20,200,140,0xff00ff00);
--      DrawText("R CDR: "..R,20,200,160,0xff00ff00);
--      DrawText("CDR R: "..R3,20,200,180,0xff00ff00);
if CanUseSpell(myHero,_Q) ~= READY then
  gametime = GetGameTimer()
end
DrawText("Q gametime: "..gametimeQ,20,200,200,0xff00ff00);
DrawText("Q gametime Ready: "..gametimeQ+Q3,20,200,220,0xff00ff00);
if gametimeQ+Q3-GetGameTimer() > 0 then
DrawText("ONCOOLDOWN Q: "..gametimeQ+Q3-GetGameTimer(),20,200,240,0xff00ff00);
else
DrawText("READY Q: Yes",20,200,240,0xff00ff00);
end

DrawText("R gametime: "..gametimeR,20,200,260,0xff00ff00);
DrawText("R gametime Ready: "..gametimeR+R3,20,200,280,0xff00ff00);
if gametimeR+R3-GetGameTimer() > 0 then
DrawText("ONCOOLDOWN R: "..gametimeR+R3-GetGameTimer(),20,200,300,0xff00ff00);
else
DrawText("READY R: Yes",20,200,300,0xff00ff00);
end

DrawText("E gametime: "..gametimeE,20,200,320,0xff00ff00);
DrawText("E gametime Ready: "..gametimeE+E3,20,200,340,0xff00ff00);
if gametimeE+E3-GetGameTimer() > 0 then
DrawText("ONCOOLDOWN E: "..gametimeE+E3-GetGameTimer(),20,200,360,0xff00ff00);
else
DrawText("READY R: Yes",20,200,360,0xff00ff00);
end

DrawText("W gametime: "..gametimeW,20,200,380,0xff00ff00);
DrawText("W gametime Ready: "..gametimeW+W3,20,200,400,0xff00ff00);
if gametimeW+W3-GetGameTimer() > 0 then
DrawText("ONCOOLDOWN W: "..gametimeW+W3-GetGameTimer(),20,200,420,0xff00ff00);
else
DrawText("READY W: Yes",20,200,420,0xff00ff00);
end

if (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
  DrawText("E AVAILABLE",20,200,450,0xff00ff00);
elseif (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() < (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
  DrawText("E NOT AVAILABLE",20,200,450,0xff00ff00);
end
end
--function JungleClear()
--	for _,mob in pairs(minionManager.objects) do
--	if GetObjectName(mob) == "SRU_Blue" or GetObjectName(mob) == "SRU_Red" or GetObjectName(mob) == "SRU_Krug" or GetObjectName(mob) == "SRU_Murkwolf" or GetObjectName(mob) == "SRU_Razorbeak" or GetObjectName(mob) == "SRU_Gromp" or GetObjectName(mob) == "Sru_Crab" or GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron" or GetTeam(mob) == MINION_JUNGLE then
--  local MousePos = GetMousePos()
--  local hpbar = GetHPBarPos(myHero)
--  local Edmg = 50 + 60*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
--  local EdmgNoDebuff = 25 + 30*GetCastLevel(myHero,_E)+GetBonusAP(myHero)
--  local ManaCheck = 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= MoTAnivia.JungleClear.Mana:Value()
--  local mobPos = GetOrigin(mob)
--    if MoTAnivia.JungleClear.JC:Value() then
--      if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and ValidTarget(mob, 615) and ManaCheck then  
--        CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
--      elseif GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero and ValidTarget(mob, 615) then
----        if GetDistanceSqr(GetOrigin(Qattack),mobPos) <= 150*150 then
--          if GetOrigin(Qattack) == mobPos then
--            CastSpell(_Q) 
--          end
--      end
--      if MoTAnivia.JungleClear.R:Value() then
--        if GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and Rattack == myHero and ValidTarget(mob, 615) and ManaCheck then 
--          DrawCircle(MousePos,420,0.9,100,0xff0000ff)
----          if GetDistanceSqr(GetOrigin(Qattack),mobPos) <= 420*420 then
--            CastSkillShot(_R, mobPos.x, mobPos.y, mobPos.z)
----          end 
--        elseif GotBuff(myHero,"GlacialStorm") == 1 and Rattack ~= myHero and not ValidTarget(mob, 680) and not (ValidTarget(mob, 680) or GetObjectName(mob) == "SRU_Blue" or GetObjectName(mob) == "SRU_Red" or GetObjectName(mob) == "SRU_Krug" or GetObjectName(mob) == "SRU_Murkwolf" or GetObjectName(mob) == "SRU_Razorbeak" or GetObjectName(mob) == "SRU_Gromp" or GetObjectName(mob) == "Sru_Crab" or GetObjectName(mob) == "SRU_Dragon" or GetObjectName(mob) == "SRU_Baron") then
----          if MinionsAround(GetOrigin(Rattack), 420, mobPos) < 1 then
----            if GetDistanceSqr(GetOrigin(Qattack),mobPos) <= 420*420 then
--                CastSpell(_R) 
--        end
--      end  
--      if MoTAnivia.JungleClear.E:Value() and ValidTarget(mob, 650) and ManaCheck then
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



--	if MoTAnivia.Misc.MGUN:Value() then
--		GLOBALULTNOTICE()
--	end	
--local mymouse = GetMousePos()
--DrawCircle(mymouse,175,0.9,100,0xff0000ff)
--local Q = GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q))
--local CDR = GetCDR(myHero)
--local Q3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q))
--local W = GetCastCooldown(myHero,_W,GetCastLevel(myHero,_W))
--local W3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_W,GetCastLevel(myHero,_W))
--local E = GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E))
--local E3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E))
--local R = GetCastCooldown(myHero,_R,GetCastLevel(myHero,_R))
--local R3 = (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_R,GetCastLevel(myHero,_R))

----      DrawText(GetObjectName(unit),12,200,20,0xff00ff00);
----      DrawText("GLOBAL CDR: "..CDR,20,200,20,0xff00ff00);  
----      DrawText("Q CDR: "..Q,20,200,40,0xff00ff00);
----      DrawText("CDR Q: "..Q3,20,200,60,0xff00ff00);      
----      DrawText("W CDR: "..W,20,200,80,0xff00ff00);
----      DrawText("CDR W: "..W3,20,200,100,0xff00ff00);
----      DrawText("E CDR: "..E,20,200,120,0xff00ff00);
----      DrawText("CDR E: "..E3,20,200,140,0xff00ff00);
----      DrawText("R CDR: "..R,20,200,160,0xff00ff00);
----      DrawText("CDR R: "..R3,20,200,180,0xff00ff00);
----if CanUseSpell(myHero,_Q) ~= READY then
----  gametime = GetGameTimer()
----end
--DrawText("Q gametime: "..gametimeQ,20,200,200,0xff00ff00);
--DrawText("Q gametime Ready: "..gametimeQ+Q3,20,200,220,0xff00ff00);
--if gametimeQ+Q3-GetGameTimer() > 0 then
--DrawText("ONCOOLDOWN Q: "..gametimeQ+Q3-GetGameTimer(),20,200,240,0xff00ff00);
--else
--DrawText("READY Q: Yes",20,200,240,0xff00ff00);
--end

--DrawText("R gametime: "..gametimeR,20,200,260,0xff00ff00);
--DrawText("R gametime Ready: "..gametimeR+R3,20,200,280,0xff00ff00);
--if gametimeR+R3-GetGameTimer() > 0 then
--DrawText("ONCOOLDOWN R: "..gametimeR+R3-GetGameTimer(),20,200,300,0xff00ff00);
--else
--DrawText("READY R: Yes",20,200,300,0xff00ff00);
--end

--DrawText("E gametime: "..gametimeE,20,200,320,0xff00ff00);
--DrawText("E gametime Ready: "..gametimeE+E3,20,200,340,0xff00ff00);
--if gametimeE+E3-GetGameTimer() > 0 then
--DrawText("ONCOOLDOWN E: "..gametimeE+E3-GetGameTimer(),20,200,360,0xff00ff00);
--else
--DrawText("READY R: Yes",20,200,360,0xff00ff00);
--end

--DrawText("W gametime: "..gametimeW,20,200,380,0xff00ff00);
--DrawText("W gametime Ready: "..gametimeW+W3,20,200,400,0xff00ff00);
--if gametimeW+W3-GetGameTimer() > 0 then
--DrawText("ONCOOLDOWN W: "..gametimeW+W3-GetGameTimer(),20,200,420,0xff00ff00);
--else
--DrawText("READY W: Yes",20,200,420,0xff00ff00);
--end

--if (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
--  DrawText("E AVAILABLE",20,200,420,0xff00ff00);
--elseif (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() < (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) then
--  DrawText("E NOT AVAILABLE",20,200,420,0xff00ff00);
--end
--MoT2:NoteEnemys(false,OverAllDmgAnivia,0,0,0,0,0,0,0,0)
--MoT2:NoteAllys()


--function CheckForSelection()
--if IOW:Mode() == "LastHit" then
--RLastHit = true
--else
--RLastHit = false
--end
--for i=1, IOW.mobs.maxObjects do
--local minion = IOW.mobs.objects[i]
--if IOW:Mode() == "LaneClear" and ValidTarget(minion, 615) then
--RLaneClear = true
--else
--RLaneClear = false
--end
--end
--for _,mob in pairs(minionManager.objects) do
--if GetTeam(mob) == MINION_JUNGLE then
--if MoTAnivia.JungleClear.JC:Value() and ValidTarget(mob, 615) then
--RJungleClear = true
--else
--RJungleClear = false
--end
--end
--end
--end