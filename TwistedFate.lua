if GetObjectName(GetMyHero()) ~= "TwistedFate" then return end
--MonTour TwistedFate:V0.1.1.1 Beta
PrintChat(string.format("<font color='#80F5F5'>MonTour Nasus:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>0.1.1.1 Beta</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))

local TwistedFateMenu = Menu("TwistedFate", "Twisted Fate")
TwistedFateMenu:SubMenu("Combo", "Combo")
TwistedFateMenu.Combo:Boolean("Q", "Use Q", true)
TwistedFateMenu.Combo:Info("TwistedFate", "Use Q only in AA")
TwistedFateMenu.Combo:List("QR", "Range with Active Card?", 1, {"Yes", "No"})
TwistedFateMenu.Combo:List("QR2", "Use Q if Cards on CD?", 1, {"Yes", "No, At Any Time"})
TwistedFateMenu.Combo:Boolean("Card", "Use Cards in Combo?", true)
TwistedFateMenu.Combo:List("prio", "Which Card in Combo?", 1, {"Yellow", "Blue", "Red"})
TwistedFateMenu.Combo:Slider("Mana", "Use Blue Card if Mana < x%", 40, 1, 90, 1)
TwistedFateMenu.Combo:Key("Yellow", "Yellow Card", string.byte("A"))
TwistedFateMenu.Combo:Key("Blue", "Blue Card", string.byte("E"))
TwistedFateMenu.Combo:Key("Red", "Red Card", string.byte("T"))
TwistedFateMenu.Combo:Info("TwistedFate", "If manually pressing R")
TwistedFateMenu.Combo:Boolean("R", "then Auto use StunCard?", true)
TwistedFateMenu:SubMenu("Harass", "Harass")
TwistedFateMenu.Harass:Boolean("Q", "Use Q", true)
TwistedFateMenu.Harass:Info("TwistedFate", "Use Q only in AA")
TwistedFateMenu.Harass:List("QR", "Range with Active Card?", 2, {"Yes", "No"})
TwistedFateMenu.Harass:List("QR2", "Use Q if Cards on CD?", 2, {"Yes", "No, At Any Time"})
TwistedFateMenu.Harass:Boolean("Card", "Use Cards in Combo?", true)
TwistedFateMenu.Harass:List("prio", "Which Card in Combo?", 1, {"Yellow", "Blue", "Red"})
TwistedFateMenu.Harass:Slider("Mana", "Use Blue Card if Mana < x%", 40, 1, 90, 1)
TwistedFateMenu:SubMenu("Farm", "LastHit")
TwistedFateMenu.Farm:Boolean("Card", "LastHit with Cards?", true)
TwistedFateMenu.Farm:List("prio", "Which Card in LastHit?", 2, {"Yellow", "Blue", "Red"})
TwistedFateMenu.Farm:Slider("Mana", "Blue Card if Mana < x%", 60, 1, 90, 1)
TwistedFateMenu:SubMenu("Farm2", "LaneClear")
TwistedFateMenu.Farm2:Boolean("Card", "LaneClear with Cards?", true)
TwistedFateMenu.Farm2:List("prio", "Which Card in LaneClear?", 3, {"Yellow", "Blue", "Red"})
TwistedFateMenu.Farm2:Slider("Mana", "Blue Card if Mana < x%", 60, 1, 90, 1)
TwistedFateMenu:SubMenu("Items", "Items&Ignite")
TwistedFateMenu.Items:Boolean("Ignite", "Use Ignite", true)
TwistedFateMenu.Items:Boolean("QSS", "Always Use QSS", true)
TwistedFateMenu.Items:Slider("QSSHP", "if My Health < x% (Def.75)", 75, 0, 100, 1)
TwistedFateMenu.Items:Boolean("Zhonya", "Always Use Zhonyas", true)
TwistedFateMenu.Items:Slider("ZhonyaHP", "if My Health < x% (Def.30)", 30, 0, 90, 1)
TwistedFateMenu:SubMenu("Int", "Interrupt Spells")
TwistedFateMenu.Int:Boolean("Int", "Interrupt Spells", true)
TwistedFateMenu:SubMenu("Misc", "Misc")
TwistedFateMenu.Misc:Boolean("DOH", "Draw DmgOverHPBars", true)
TwistedFateMenu.Misc:Boolean("DKS", "Draw Killable Text", true)

--myHero = GetMyHero()
tick = 0
ultimateused = false
tickwarn = 0
selectedcard = ""
target = GetCurrentTarget()	
unit = GetCurrentTarget()



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
  Items()
  
  if TwistedFateMenu.Misc.DOH:Value() then
  DMGoHP()
end

  if TwistedFateMenu.Items.Ignite:Value() then
  Ignite()
end

	if selectedcard ~= "" then
		SelectCard()
	end	
	
	if TwistedFateMenu.Misc.DKS:Value() then
		Killable()
	end	
	
	if TwistedFateMenu.Farm.Card:Value() and IOW:Mode() == "LastHit" and GetTickCount() > tick then
    LastHit()
	end
  
	if TwistedFateMenu.Farm2.Card:Value() and IOW:Mode() == "LaneClear" and GetTickCount() > tick then
    IOW:EnableAutoAttacks()
		LaneClear()
	end	

	if TwistedFateMenu.Combo.Blue:Value() and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  
  if TwistedFateMenu.Combo.Yellow:Value() and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	
	if TwistedFateMenu.Combo.Red:Value() and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "redcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	if IOW:Mode() == "Combo" then
		Combo()
	end
  if IOW:Mode() == "Harass" then
    Harass()
  end
end)

OnProcessSpell(function(Object,spellProc)
	if not TwistedFateMenu.Combo.R:Value() then
		return
	end
	if Object and Object == myHero then
		local name = spellProc.name:lower()		    
		if name == "destiny" then
			ultimateused = true
		end
		if name == "gate" then 
			ultimateused = false
			selectedcard = "goldcardlock"			
			if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then					
				CastSpell(_W)
			end
		end
				
	end	
end)

function DMGoHP()
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
	for _,unit in pairs(GoS:GetEnemyHeroes()) do
  if not IsDead(unit) and GoS:ValidTarget(unit,20000) then
			local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
			local Qdmg = GoS:CalcDamage(myHero, unit, sheendmg, qdmg + Ludens) or 0      
			local Ydmg = GoS:CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens) or 0
      local ALLdmg = GoS:CalcDamage(myHero, unit, ad, EPassive) or 0
			local Bdmg = GoS:CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens) or 0
			local Rdmg = GoS:CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens) or 0	
      local YBRdmg = GoS:CalcDamage(myHero, unit, sheendmg, ((rcard + bcard + ycard)/3) + qdmg + lichbane + EPassive + Ludens) or 0	
      local YdmgmQ = GoS:CalcDamage(myHero, unit, sheendmg, ycard + lichbane + EPassive + Ludens) or 0
			local BdmgmQ = GoS:CalcDamage(myHero, unit, sheendmg, bcard + lichbane + EPassive + Ludens) or 0
			local RdmgmQ = GoS:CalcDamage(myHero, unit, sheendmg, rcard + lichbane + EPassive + Ludens) or 0	
			local YBRdmgmQ = GoS:CalcDamage(myHero, unit, sheendmg, ((rcard + bcard + ycard)/3) + lichbane + EPassive + Ludens) or 0	
      
	if CanUseSpell(myHero,_Q) == READY and GetCastName(myHero,_W) == "goldcardlock" then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,Ydmg,0xffffffff)	--and GotBuff(myHero,"goldcardpreattack") == 1
  end 
  if CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "redcardlock" and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,Rdmg,0xffffffff)	--and GotBuff(myHero,"redcardpreattack") == 1
  end 
  if CanUseSpell(myHero,_Q) == READY  and GetCastName(myHero,_W) == "bluecardlock" and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,Bdmg,0xffffffff)	--and GotBuff(myHero,"bluecardpreattack") == 1
  end
  if CanUseSpell(myHero,_Q) == READY and GetCastName(myHero,_W) == "PickACard" and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,YBRdmg,0xffffffff)	
  end
  	if (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "goldcardlock" and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,YdmgmQ,0xffffffff)	
  end 
  if (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "redcardlock" and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,RdmgmQ,0xffffffff)	
  end 
  if (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "bluecardlock" and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,BdmgmQ,0xffffffff)	
  end
  if (CanUseSpell(myHero,_Q) == ONCOOLDOWN or GetCastLevel(myHero,_Q) == 0) and GetCastName(myHero,_W) == "PickACard" and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCastLevel(myHero,_W) > 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,YBRdmgmQ,0xffffffff)	
  end
  if CanUseSpell(myHero,_Q) == READY and GetCastLevel(myHero,_W) == 0 then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,Qdmg,0xffffffff)	
  end
    if CanUseSpell(myHero,_Q) == ONCOOLDOWN and CanUseSpell(myHero,_Q) == ONCOOLDOWN then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,ALLdmg,0xffffffff)	
  end
  end
  end
end
  

function Killable()
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
	for _,unit in pairs(GoS:GetEnemyHeroes()) do
		if not IsDead(unit) and GoS:ValidTarget(unit,6500) then
			local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
			local Ydmg = GoS:CalcDamage(myHero, unit, sheendmg, ycard + qdmg + lichbane + EPassive + Ludens) or 0
			local Bdmg = GoS:CalcDamage(myHero, unit, sheendmg, bcard + qdmg + lichbane + EPassive + Ludens) or 0
			local Rdmg = GoS:CalcDamage(myHero, unit, sheendmg, rcard + qdmg + lichbane + EPassive + Ludens) or 0	
			if Ydmg > hp and tickwarn < GetTickCount() then
				local HPBARPOS = GetHPBarPos(myHero)
				if HPBARPOS.x > 0 then
					if HPBARPOS.y > 0 then				
						DrawText(string.format("You can kill %s(Q+YellowCard)",GetObjectName(unit)),12,HPBARPOS.x,HPBARPOS.y - 30,0xffffff00)						
					end
				end
				tickwarn = GetTickCount() + 5000
				return
			elseif Bdmg > hp then
				local HPBARPOS = GetHPBarPos(myHero)
				if HPBARPOS.x > 0 then
					if HPBARPOS.y > 0 then				
						DrawText(string.format("You can kill %s(Q+BlueCard)",GetObjectName(unit)),12,HPBARPOS.x,HPBARPOS.y - 30,0xffffff00)
					end
				end					
				tickwarn = GetTickCount() + 5000
				return
      elseif Rdmg > hp then
				local HPBARPOS = GetHPBarPos(myHero)
				if HPBARPOS.x > 0 then
					if HPBARPOS.y > 0 then				
						DrawText(string.format("You can kill %s(Q+RedCard)",GetObjectName(unit)),12,HPBARPOS.x,HPBARPOS.y - 30,0xffffff00)
					end
				end					
				tickwarn = GetTickCount() + 5000
				return  
			end
		end
	end
--  DrawText(string.format("EPassive= %f", EPassive),25,478,256,0xffffffff);
--  DrawText(string.format("lichbane= %f", lichbane),25,478,286,0xffffffff);
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,316,0xffffffff);
end

function SelectCard()
	local name = GetCastName(myHero,_W):lower()
	if name == "goldcardlock" and selectedcard == name then
		CastSpell(_W)
		selectedcard = ""			
	end
	if name == "redcardlock" and selectedcard == name then
		CastSpell(_W)
		selectedcard = ""			
	end
	if name == "bluecardlock" and selectedcard == name then
		CastSpell(_W)
		selectedcard = ""			
	end
end

function Combo()
  local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana
  local ManaValue = TwistedFateMenu.Combo.Mana:Value()/100
	local target = GetCurrentTarget()		
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1000,250,1450,40,false,true)
  local unit = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if GoS:ValidTarget(target,1450) then		  
  if TwistedFateMenu.Combo.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if TwistedFateMenu.Combo.prio:Value() == 2 and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	if TwistedFateMenu.Combo.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "redcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if (TwistedFateMenu.Combo.prio:Value() == 1 or TwistedFateMenu.Combo.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if TwistedFateMenu.Combo.Q:Value() and TwistedFateMenu.Combo.QR:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and GoS:GetDistance(myHero, target) <= 525 and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Combo.Q:Value() and TwistedFateMenu.Combo.QR:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Combo.Q:Value() and TwistedFateMenu.Combo.QR2:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN and GetCastName(myHero,_W) == "PickACard" and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Combo.Q:Value() and TwistedFateMenu.Combo.QR2:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
end  
end
function Harass()
  local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana
  local ManaValue = TwistedFateMenu.Harass.Mana:Value()/100
	local target = GetCurrentTarget()		
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1000,250,1450,40,false,true)
  local unit = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if GoS:ValidTarget(target,1450) then		  
  if TwistedFateMenu.Harass.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if TwistedFateMenu.Harass.prio:Value() == 2 and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
	if TwistedFateMenu.Harass.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "redcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if (TwistedFateMenu.Harass.prio:Value() == 1 or TwistedFateMenu.Harass.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if TwistedFateMenu.Harass.Q:Value() and TwistedFateMenu.Harass.QR:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and GoS:GetDistance(myHero, target) <= 525 and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Harass.Q:Value() and TwistedFateMenu.Harass.QR:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and (GotBuff(myHero,"redcardpreattack") == 1 or GotBuff(myHero,"bluecardpreattack") == 1 or GotBuff(myHero,"goldcardpreattack") == 1) and CanUseSpell(myHero,_W) ~= READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Harass.Q:Value() and TwistedFateMenu.Harass.QR2:Value() == 1 then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN and GetCastName(myHero,_W) == "PickACard" and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
  if TwistedFateMenu.Harass.Q:Value() and TwistedFateMenu.Harass.QR2:Value() == 2 then
		if CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)			
		end	
	end
end           
end

function LastHit()
    for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do 
	local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana
  local ManaValue = TwistedFateMenu.Farm.Mana:Value()/100
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
	local bcard = GoS:CalcDamage(myHero, minion,sheendmg, bdmg + lichbane + EPassive + Ludens)	
	local ycard = GoS:CalcDamage(myHero, minion,sheendmg, ydmg + lichbane + EPassive + Ludens)
	local rcard = GoS:CalcDamage(myHero, minion,sheendmg, rdmg + lichbane + EPassive + Ludens) 
  local ncardpassive = GoS:CalcDamage(myHero, minion, sheendmg + ad ,lichbane + EPassive + Ludens)
  local ncard = GoS:CalcDamage(myHero, minion, sheendmg + ad ,lichbane + Ludens)
  local addmg = GoS:CalcDamage(myHero, minion, ad ,0)
--  DrawText(string.format("EPassive= %f", EPassive),25,478,356,0xffffffff);
--  DrawText(string.format("lichbane= %f", lichbane),25,478,386,0xffffffff);
--  DrawText(string.format("sheendmg= %f", sheendmg),25,478,416,0xffffffff);
if GoS:ValidTarget(minion, 525+250) then
  if TwistedFateMenu.Farm.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"goldcardpreattack") == 1 and GetCurrentHP(minion) < ycard then --GetCastName(myHero,_W) == "goldcardlock"
		AttackUnit(minion)	
	end  
  if TwistedFateMenu.Farm.prio:Value() == 2 and GetTickCount() > tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
  if GotBuff(myHero,"bluecardpreattack") == 1  and GetCurrentHP(minion) < bcard then --GetCastName(myHero,_W) == "bluecardlock"
		AttackUnit(minion) 	
	end  
	if TwistedFateMenu.Farm.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "redcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if GotBuff(myHero,"redcardpreattack") == 1 and GetCurrentHP(minion) < rcard then
		AttackUnit(minion)
  end
  if (TwistedFateMenu.Farm.prio:Value() == 1 or TwistedFateMenu.Farm.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end   
  if GotBuff(myHero, "cardmasterstackparticle") == 1 and (GotBuff(myHero,"redcardpreattack") == 0 or GotBuff(myHero,"bluecardpreattack") == 0 or GotBuff(myHero,"goldcardpreattack") == 0) and GetCurrentHP(minion) < ncardpassive then
		AttackUnit(minion)  
	end
end
end
end

function LaneClear()
  for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	local currentmana = GetCurrentMana(myHero)
	local maxmana = GetMaxMana(myHero)
  local curdmax = currentmana/maxmana
  local ManaValue = TwistedFateMenu.Farm2.Mana:Value()/100
    
if GoS:ValidTarget(minion, 525+250) then
  if TwistedFateMenu.Farm2.prio:Value() == 1 and curdmax > ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
  if TwistedFateMenu.Farm2.prio:Value() == 2 and curdmax > ManaValue and GetTickCount() > tick then
    if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then   
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W) 
		end
	end
	if TwistedFateMenu.Farm2.prio:Value() == 3 and curdmax > ManaValue and GetTickCount() > tick then --and MinionAround(minion, 250) > 3
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "redcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end	
  if (TwistedFateMenu.Farm2.prio:Value() == 1 or TwistedFateMenu.Farm2.prio:Value() == 3) and curdmax < ManaValue and GetTickCount() > tick then
		if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "bluecardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W)
		end
	end
 
end
end
end


function Ignite()
  	local target = GetCurrentTarget()		
  local unit = GetCurrentTarget()
      local Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
    if GoS:ValidTarget(target, 700) and Ignite and CanUseSpell(myHero,_Q) ~= READY and GoS:GetDistance(target) > 525 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        for _, k in pairs(GoS:GetEnemyHeroes()) do
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function Items()
if GetItemSlot(myHero,3140) > 0 and TwistedFateMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < TwistedFateMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and TwistedFateMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < TwistedFateMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
if TwistedFateMenu.Items.Zhonya:Value() and GetItemSlot(myHero,3157) > 0 and GoS:ValidTarget(target, 900) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) <= TwistedFateMenu.Items.ZhonyaHP:Value()  then
                    CastTargetSpell(myHero, GetItemSlot(myHero,3157))
                    end      
end

addInterrupterCallback(function(unit, spellType)	
   -- for _,unit in pairs(GoS:GetEnemyHeroes()) do
    local unit = GetCurrentTarget()
    if spellType == CHANELLING_SPELLS and GoS:ValidTarget(target, GetRange(myHero)+50) and GetTickCount() > tick and TwistedFateMenu.Int.Int:Value() then
      if CanUseSpell(myHero,_W) == READY and GetCastName(myHero,_W) == "PickACard" then
			selectedcard = "goldcardlock"
			tick = GetTickCount() + 3000
			CastSpell(_W) GoS:DelayAction(function() AttackUnit(unit) end, 100)
      end
    end
   -- end
end)