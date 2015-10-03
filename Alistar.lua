if GetObjectName(myHero) ~= "Alistar" then return end
--MonTour Alistar:V1.0.0.2 - updated GoS:myHeroPos() to GetOrigin(myHero)
PrintChat(string.format("<font color='#80F5F5'>MonTour Alistar:</font> <font color='#EFF0F0'>loaded by MarCiii!</font>"))
PrintChat(string.format("<font color='#80F5F5'>Version:</font> <font color='#EFF0F0'>1.0.0.2</font>"))
   local MonTourMenu = Menu("Alistar", "Alistar")
    MonTourMenu:SubMenu("Combo", "Combo")
    MonTourMenu.Combo:Boolean("CQW", "Use QW Combo", false)
    MonTourMenu.Combo:Boolean("CWQ", "Use WQ Combo", true)    
    MonTourMenu.Combo:Boolean("R", "Use R", true)
    MonTourMenu.Combo:Slider("RHP", "Use R my HP < x%", 30, 5, 80, 1)
    MonTourMenu:SubMenu("Harass", "Harass")
    MonTourMenu.Harass:Boolean("HQW", "Use QW Combo", true)
    MonTourMenu.Harass:Boolean("HWQ", "Use WQ Combo", false)
    MonTourMenu.Harass:Boolean("R", "Use R", true)
    MonTourMenu.Harass:Slider("RHP", "Use R my HP < x%", 30, 5, 80, 1)    
    MonTourMenu:SubMenu("Healing", "Healing")    
    MonTourMenu.Healing:Boolean("Eally", "Use E Ally", true)
    MonTourMenu.Healing:Slider("EallyHP", "Use E if Ally HP < x%", 35, 5, 80, 1)
    MonTourMenu.Healing:Slider("EallyMana", "Use E if my Mana > x%", 40, 5, 80, 1)
    MonTourMenu.Healing:Boolean("Emy", "Use E Myself", true)
    MonTourMenu.Healing:Slider("EmyHP", "Use E if my HP < x%", 25, 5, 80, 1) 
    MonTourMenu.Healing:Slider("EmyMana", "Use E if my Mana > x%", 40, 5, 80, 1) 
    MonTourMenu:SubMenu("Interrupt", "Interrupt")
    MonTourMenu.Interrupt:Boolean("Interrupt", "Auto Interrupt Spells", true)

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
Combo()
Harass()
Heal()
end)

function Combo()
  local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Combo" then
if GoS:ValidTarget(unit, 1550) and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
            if MonTourMenu.Combo.CWQ:Value() then
                 if CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 650) then
           CastTargetSpell(unit, _W)
            end
        end
            if MonTourMenu.Combo.CWQ:Value() then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1200,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) ~= READY and GoS:IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
            if MonTourMenu.Combo.CQW:Value() then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1200,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
            if MonTourMenu.Combo.CQW:Value() then
                 if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(unit, 300) then
           CastTargetSpell(unit, _W)
            end
        end
            if MonTourMenu.Combo.R:Value() then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (MonTourMenu.Combo.RHP:Value()/100) and
                    CanUseSpell(myHero, _R) == READY and GoS:IsInDistance(unit, 1000) then
            CastSpell(_R)
            end
        end
end
end
end  

function Harass()
  local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if unit == nil or GetOrigin(unit) == nil or IsImmune(unit,myHero) or IsDead(unit) or not IsVisible(unit) or GetTeam(unit) == GetTeam(myHero) then return false end
if IOW:Mode() == "Harass" then
if GoS:ValidTarget(unit, 1550) and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) then
            if MonTourMenu.Harass.HWQ:Value() then
                 if CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 650) then
           CastTargetSpell(unit, _W)
            end
        end
            if MonTourMenu.Harass.HWQ:Value() then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1200,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) ~= READY and GoS:IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
            if MonTourMenu.Harass.HQW:Value() then
        local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1200,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
            if MonTourMenu.Harass.HQW:Value() then
                 if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(unit, 300) then
           CastTargetSpell(unit, _W)
            end
        end
            if MonTourMenu.Harass.R:Value() then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (MonTourMenu.Harass.RHP:Value()/100) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and GoS:IsInDistance(unit, 1000) then
            CastSpell(_R)
            end
        end
end
end
end 

function Heal()
  if GotBuff(myHero,"recall") == 1 then return end
            for _, ally in pairs(GoS:GetAllyHeroes()) do
            if MonTourMenu.Healing.Eally:Value() then
              if (GetCurrentHP(ally)/GetMaxHP(ally)) < (MonTourMenu.Healing.EallyHP:Value()/100) and GetCurrentMana(myHero)/GetMaxMana(myHero) > (MonTourMenu.Healing.EallyMana:Value()/100) and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(unit, 700) and GoS:IsInDistance(ally, 575) and IsObjectAlive(ally) then
                    CastSpell(_E)
              end
            end
          end
          local unit = GetCurrentTarget()
            if MonTourMenu.Healing.Emy:Value() then
              if (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (MonTourMenu.Healing.EmyHP:Value()/100) and GetCurrentMana(myHero)/GetMaxMana(myHero) > (MonTourMenu.Healing.EmyMana:Value():Value()/100) and CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(unit, 700) and GoS:IsInDistance(unit, 700) and IsObjectAlive(unit) then
                    CastSpell(_E)
              end
            end
end

addInterrupterCallback(function(unit, spellType)
    local unit = GetCurrentTarget()
        if spellType == CHANELLING_SPELLS and MonTourMenu.Interrupt.Interrupt:Value() then
            if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(unit, 300) then
            CastTargetSpell(unit, _W)
            end    
            local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1200,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and GoS:IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
end)
PrintChat(string.format("<font color='#198c19'>Alistar:</font> <font color='#ffff32'>loaded by MarCiii!</font>"))