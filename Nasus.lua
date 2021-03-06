if GetObjectName(GetMyHero()) ~= "Nasus" then return end
--MonTour Nasus:V1.0.0.5 - fixed Ignite ... hopefully
PrintChat(string.format("<font color='#80F5F5'>MonTour Nasus:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.5</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Cloud for Old Q Stack Thank you</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Feretorix for everything and GetBuffData in new API</font>"))
PrintChat(string.format("<font color='#80F5F5'>Credits to:</font> <font color='#EFF0F0'> Deftsu for ItemsUse Code</font>"))
local QStack = 0 
local MonTourMenu = Menu("Nasus", "Nasus")
MonTourMenu:SubMenu("Combo", "Combo")
MonTourMenu.Combo:Boolean("Q","Use Q",true)
MonTourMenu.Combo:Boolean("W","Use W",true)
MonTourMenu.Combo:Boolean("E","Use E",true)
MonTourMenu.Combo:Boolean("R","Use R",true)
MonTourMenu.Combo:Slider("RHP", "Use R if my HP < x%", 20, 5, 80, 1)
MonTourMenu:SubMenu("Harass", "Harass")
MonTourMenu.Harass:Boolean("Q","Use Q",true)
MonTourMenu.Harass:Boolean("W","Use W",true)
MonTourMenu.Harass:Boolean("E","Use E",false)
MonTourMenu.Harass:Boolean("R","Use R",true)
MonTourMenu.Harass:Slider("RHP", "Use R if my HP < x%", 20, 5, 80, 1)
MonTourMenu:SubMenu("Stacks", "LastHit/LaneClear/Jungle")
MonTourMenu.Stacks:Boolean("Q","Use LastHit Q",true)
MonTourMenu.Stacks:Boolean("AQ","Auto LastHit Q if",true)
MonTourMenu.Stacks:Slider("AQR", "Minion Range < x (Def.250)", 250, 50, 1500, 1)
MonTourMenu.Stacks:Boolean("QLC","Use LaneClear Q",true)
MonTourMenu:SubMenu("Items", "Items & Ignite")
MonTourMenu.Items:Info("Nasus", "Only in Combo and Harass")
MonTourMenu.Items:Boolean("Ignite","AutoIgnite if OOR and W+E NotReady",true)
MonTourMenu.Items:Boolean("useTiamat", "Tiamat", true)
MonTourMenu.Items:Boolean("useHydra", "Hydra", true)
MonTourMenu.Items:Info("Nasus", " ")
MonTourMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
MonTourMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Info("Nasus", " ")
MonTourMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
MonTourMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
MonTourMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
MonTourMenu.Items:Info("Nasus", " ")
MonTourMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
MonTourMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
MonTourMenu.Items:Info("Nasus", " ")
MonTourMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
MonTourMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
MonTourMenu.Items:Info("Nasus", " ")
MonTourMenu.Items:Boolean("QSS", "Always Use QSS", true)
MonTourMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
MonTourMenu:SubMenu("KS", "KillSteal")
MonTourMenu.KS:Boolean("Q","Use Q KS",true)
MonTourMenu.KS:Boolean("E","Use E KS",true)
MonTourMenu.KS:Boolean("WQ","Use W+Q KS",false)
MonTourMenu.KS:Boolean("WEQ","Use W+E+Q KS",false)
MonTourMenu:SubMenu("Misc", "Misc")
MonTourMenu.Misc:Boolean("QAA","Draw QAA",true)
MonTourMenu.Misc:Boolean("DMG","Draw DMG over HP",true)
MonTourMenu.Misc:Info("Nasus", " ")
MonTourMenu.Misc:Boolean("MGUN","Ultimate Notifier", true)
MonTourMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
MonTourMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 25, 5, 60, 1)
MonTourMenu.Misc:Slider("MGUNX", "UN X POS", 35, 0, 1600, 1)
MonTourMenu.Misc:Slider("MGUNY", "UN Y POS", 394, 0, 1055, 1)

function Stacking()
  nasusQstacks = GetBuffData(myHero,"nasusqstacks")
  QStack = nasusQstacks.Stacks
end

OnLoop(function(myHero)
    target = GetCurrentTarget()
    Stacking() 
    ItemUse()
    Ignite()
    Killsteal()    
    
  if MonTourMenu.Misc.DMG:Value() then     
    DMGOHP()
  end  
  if MonTourMenu.Misc.QAA:Value() then  
    QAA()
  end  
	if IOW:Mode() == "Combo" then 
    	Combo()
  end  
	if IOW:Mode() == "Harass" then 
    	Harass()
  end   
	if IOW:Mode() == "LastHit" and MonTourMenu.Stacks.Q:Value() then 
    	LastHit(minion)
      JungleClear(jminion)
  end
  	if IOW:Mode() == "LastClear" and MonTourMenu.Stacks.QLC:Value() then 
    	LastHit(minion)
      JungleClear(jminion)
  end
  if not (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and MonTourMenu.Stacks.AQ:Value() then 
      AutoLastHit(minion)
      AutoJungleClear(jminion)
  end
  if KeyIsDown(0x10) then  
      DrawText(string.format("QStack = %f", QStack),20,100,300,0xffffffff); 
  end
  if MonTourMenu.Misc.MGUNDEB:Value() then
  GLOBALULTNOTICEDEBUG()
end
  if MonTourMenu.Misc.MGUN:Value() then
GLOBALULTNOTICE()
end
end)


function Combo()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if GoS:ValidTarget(target, 1000) then
  if MonTourMenu.Combo.W:Value() then
    if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(target, 600) then --and IsObjectAlive(target) 
      CastTargetSpell(target, _W)
    end
  end  
  if MonTourMenu.Combo.E:Value() then           
    local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1700,250,650,70,true,false)
    if CanUseSpell(myHero, _E) == READY  and GoS:IsInDistance(target, 650) then --and IsObjectAlive(target)
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
  end  
  if MonTourMenu.Combo.Q:Value() then
    if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(target, 300) then --and IsObjectAlive(target) 
      CastSpell(_Q)
    end  
  end
  if MonTourMenu.Combo.R:Value() then
    if CanUseSpell(myHero, _R) == READY  and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (MonTourMenu.Combo.RHP:Value()/100) then --and IsObjectAlive(target)
      CastSpell(_R)
    end  
  end
end
end

function Harass()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if GoS:ValidTarget(target, 1000) then
  if MonTourMenu.Harass.W:Value() then
    if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(target, 600) then --and IsObjectAlive(target) 
      CastTargetSpell(target, _W)
    end
  end  
  if MonTourMenu.Harass.E:Value() then           
    local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1700,250,650,70,true,false)
    if CanUseSpell(myHero, _E) == READY  and GoS:IsInDistance(target, 650) then --and IsObjectAlive(target)
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
  end  
  if MonTourMenu.Harass.Q:Value() then
    if CanUseSpell(myHero, _Q) == READY  and GoS:IsInDistance(target, 300) then --and IsObjectAlive(target)
      CastSpell(_Q)
    end  
  end
  if MonTourMenu.Combo.R:Value() then
    if CanUseSpell(myHero, _R) == READY and IsObjectAlive(target) and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (MonTourMenu.Harass.RHP:Value()/100) then
      CastSpell(_R)
    end  
  end
end
end

function Ignite()
      --local Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
      for _, k in pairs(GoS:GetEnemyHeroes()) do
    if GoS:ValidTarget(k, 700) and Ignite and MonTourMenu.Items.Ignite:Value() and CanUseSpell(myHero,_E) ~= READY and CanUseSpell(myHero,_W) ~= READY and  GoS:GetDistance(k) > 460 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        
            if CanUseSpell(GetMyHero(), Ignite) == READY and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GoS:GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function ItemUse()
  for _,target in pairs(Gos:GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and MonTourMenu.Items.bork:Value() and GoS:ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (MonTourMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (MonTourMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and MonTourMenu.Items.CutBlade:Value() and GoS:ValidTarget(target, 550) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (MonTourMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (MonTourMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and MonTourMenu.Items.ghostblade:Value() and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") and GoS:ValidTarget(target, MonTourMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and MonTourMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MonTourMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if MonTourMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and GoS:ValidTarget(target,MonTourMenu.Items.useRedPotR:Value()) and (IOW:Mode() == "Combo" or IOW:Mode() == "Harass") then --redpot
        if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
  if IOW:Mode() == "Combo" or IOW:Mode() == "Harass" then
   if MonTourMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and GoS:ValidTarget(target, 550) then --tiamat
        if GoS:GetDistance(target) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end       
    elseif MonTourMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and GoS:ValidTarget(target, 550) then --hydra
      if GoS:GetDistance(target) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
      end
    end
  end       
end
end      

function QAA()
	for i,unit in pairs(Gos:GetEnemyHeroes()) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0  
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end         
		local unitPos = GetOrigin(unit)
		local dmgQ = 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack
		local dmg = GoS:CalcDamage(myHero, unit, dmgQ, lichbane)
		local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
		local hPos = GetHPBarPos(unit)
    	local drawPos = WorldToScreen(1,unitPos.x,unitPos.y,unitPos.z)
        if dmg > 0 then 
          DrawText(math.ceil(hp/dmg).." QAA", 15, hPos.x, hPos.y+20, 0xffffffff)
	 	end 	
end
end

function DMGOHP()
  	for _,unit in pairs(Gos:GetEnemyHeroes()) do    
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GetItemSlot(myHero,3078) then
        sheendmg2 = sheendmg2 + 1
      end
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end        
  local Qdmg = 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack
	if GoS:ValidTarget(unit,20000) and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,GoS:CalcDamage(myHero, unit, Qdmg, lichbane),0xffffffff)	
  end  
  end
end

function LastHit(minion)
 for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end  
  local minionpos = GetOrigin(minion)
    if GoS:ValidTarget(minion, GetRange(myHero)+100) and GoS:CalcDamage(myHero, minion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(minion) and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) GoS:DelayAction(function() AttackUnit(minion) end, 100)
    end
  end
end

function AutoLastHit(minion)
 for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(minion)
    if GoS:ValidTarget(minion, MonTourMenu.Stacks.AQR:Value()) and GoS:CalcDamage(myHero, minion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(minion) and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) and GotBuff(myHero,"recall") == 0 then
        CastSpell(_Q) GoS:DelayAction(function() AttackUnit(minion) end, 100)
    end
  end
end
 
function AutoJungleClear(jminion)
 for _,jminion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(jminion)
    if GoS:ValidTarget(jminion, MonTourMenu.Stacks.AQR:Value()) and GoS:CalcDamage(myHero, jminion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(jminion) and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) GoS:DelayAction(function() AttackUnit(jminion) end, 100)
    end
  end
end

function JungleClear(jminion)
 for _,jminion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(jminion)
    if GoS:ValidTarget(jminion, GetRange(myHero)+100) and GoS:CalcDamage(myHero, jminion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(jminion) and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) GoS:DelayAction(function() AttackUnit(jminion) end, 100)
    end
  end
end

function Killsteal()
    local target = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy)
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
    local Edmg = (15 + 40*GetCastLevel(myHero,_E) + 0.6*GetBonusDmg(myHero))
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
      if MonTourMenu.KS.Q:Value() and GoS:ValidTarget(enemy, GetRange(myHero)+50) and GoS:CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > enemyhp and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) and GoS:IsInDistance(enemy, GetRange(myHero)+50) and GoS:GetDistance(myHero, enemy) <= (GetRange(myHero)+50) and GoS:GetDistance(myHero, enemy) >= 10 and GoS:IsInDistance(target, GetRange(myHero)+50) then
        CastSpell(_Q) GoS:DelayAction(function() AttackUnit(enemy) end, 100)
      end
      local EPred = GetPredictionForPlayer(GetOrigin(myHero),enemy,GetMoveSpeed(enemy),1700,250,650,70,true,false)
      if MonTourMenu.KS.E:Value() and GoS:ValidTarget(enemy, 650) and GoS:CalcDamage(myHero, enemy, 0, Edmg) > enemyhp and (CanUseSpell(myHero, _E) == READY) and GoS:IsInDistance(enemy, 650) then
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
      end
    if MonTourMenu.KS.WEQ:Value() and GoS:ValidTarget(enemy, 500) and GoS:CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane + Edmg) > enemyhp and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) and CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(enemy, GetRange(myHero)+50) and GoS:GetDistance(myHero, enemy) <= 500 and GoS:GetDistance(myHero, enemy) >= 10 and GoS:IsInDistance(target, 500) and IsObjectAlive(enemy) then
        CastTargetSpell(enemy, _W) GoS:DelayAction(function() CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) GoS:DelayAction(function() CastSpell(_Q) GoS:DelayAction(function() AttackUnit(enemy) end, 100) end, 200) end, 300)
    end
    if MonTourMenu.KS.WQ:Value() and GoS:ValidTarget(enemy, 500) and GoS:CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > enemyhp and (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) and CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(enemy, GetRange(myHero)+50) and GoS:GetDistance(myHero, enemy) <= 500 and GoS:GetDistance(myHero, enemy) >= 10 and GoS:IsInDistance(target, 500) then
        CastTargetSpell(enemy, _W) GoS:DelayAction(function() CastSpell(_Q) GoS:DelayAction(function() AttackUnit(enemy) end, 100) end, 200)
    end    
  end
end    

function GLOBALULTNOTICE()
      if not (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then return end
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end  
        info = ""
        if (CanUseSpell(myHero, _Q) == READY or GotBuff(myHero,"NasusQ") == 1) then
       		for _,unit in pairs(Gos:GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = GoS:CalcDamage(myHero, unit, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane)
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not GoS:ValidTarget(unit, GetRange(myHero)+50) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,MonTourMenu.Misc.MGUNSIZE:Value(),MonTourMenu.Misc.MGUNX:Value(),MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
end

function GLOBALULTNOTICEDEBUG()	 
    DrawText("I am in Range but not killable - TESTMODE ON",MonTourMenu.Misc.MGUNSIZE:Value(),MonTourMenu.Misc.MGUNX:Value(),MonTourMenu.Misc.MGUNY:Value(),0xffff0000)   
end

--OnLoop(function(myHero)
--local capspress = KeyIsDown(0x14); --Caps Lock key
--if capspress then
--	local itemid = GetItemID(myHero,ITEM_1);
--	local itemammo = GetItemAmmo(myHero,ITEM_1);
--	local itemstack = GetItemStack(myHero,ITEM_1);
--	PrintChat(string.format("itemID in Slot 1 is = %d", itemid));
--	PrintChat(string.format("AMMO! in Slot 1 is = %d", itemammo));
--	PrintChat(string.format("STACK in Slot 1 is = %d", itemstack));
--	end
--end)