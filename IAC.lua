require('Inspired')

DelayAction(function() 
    if IWalkConfig == nil then
      iac = IAC(true)
      for _,k in pairs(iac.adcTable) do
        if k == myHeroName then
          PrintChat("<font color=\"#6699ff\"><b>[Inspireds Auto Carry]: Plugin '"..myHeroName.."' - </b></font> <font color=\"#FFFFFF\">Loaded.</font>") 
        end
      end
    end
  end, 100)

  function PredCast(spell, target, speed, delay, range, width, coll)
      local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target), speed, delay, range, width, coll, true)
      if Pred.HitChance >= 1 then
        CastSkillShot(spell, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
      end
  end

class 'IAC' -- {

    root = menu.addItem(SubMenu.new("Inspired's Auto Carry"))
    IWalkConfigUSEIAC = root.addItem(MenuBool.new("Use IAC Champion Plugins (2xF6)",true))  
    IWalkConfigD = root.addItem(MenuBool.new("Damage Calc",true))     
    IWalkConfigC = root.addItem(MenuBool.new("AA Range Circle",true)) 
    IWalkConfigLastHit = root.addItem(MenuKeyBind.new("LastHit", 88))     
    IWalkConfigHarass = root.addItem(MenuKeyBind.new("Harass", 67))        
    IWalkConfigLaneClear = root.addItem(MenuKeyBind.new("LaneClear", 86)) 
    IWalkConfigCombo = root.addItem(MenuKeyBind.new("Combo", 32)) 
    IWalkConfigI = root.addItem(MenuBool.new("Cast Items",true))  
    
 
  function IAC:__init(bool)
    IWalkTarget = nil
    myHero = GetMyHero()
    myHeroName = GetObjectName(myHero)
    waitTickCount = 0
    IWalkConfig = scriptConfig("IAC", "Inspired's Auto Carry")
    self.move = true
    self.aa = true
    self.orbTable = { lastAA = 0, windUp = 13.37, animation = 13.37 }
    self.AATable = {}
    self.aaResetTable = { ["Diana"] = {_E}, ["Darius"] = {_W}, ["Garen"] = {_Q}, ["Hecarim"] = {_Q}, ["Jax"] = {_W}, ["Jayce"] = {_W}, ["Rengar"] = {_Q}, ["Riven"] = {_W}, ["Sivir"] = {_W}, ["Talon"] = {_Q} }
    self.aaResetTable2 = { ["Ashe"] = {_W}, ["Diana"] = {_Q}, ["Graves"] = {_Q}, ["Lucian"] = {_W}, ["Quinn"] = {_Q}, ["Riven"] = {_Q}, ["Talon"] = {_W}, ["Yasuo"] = {_Q} }
    self.aaResetTable3 = { ["Jax"] = {_Q}, ["Lucian"] = {_Q}, ["Quinn"] = {_E}, ["Teemo"] = {_Q}, ["Tristana"] = {_E} }
    self.aaResetTable4 = { ["Graves"] = {_E},  ["Lucian"] = {_E},  ["Vayne"] = {_Q} }
    self.isAAaswellTable = { ["Quinn"] = "QuinnWEnhanced" }
    self.adcTable = {"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jinx", "Kalista", "KogMaw", "Lucian", "MissFortune", "Quinn", "Sivir", "Teemo", "Tristana", "Twitch", "Varus", "Vayne"}
    self.projectilespeeds = {["Velkoz"]= 2000,["TeemoMushroom"] = math.huge,["TestCubeRender"] = math.huge ,["Xerath"] = 2000.0000 ,["Kassadin"] = math.huge ,["Rengar"] = math.huge ,["Thresh"] = 1000.0000 ,["Ziggs"] = 1500.0000 ,["ZyraPassive"] = 1500.0000 ,["ZyraThornPlant"] = 1500.0000 ,["KogMaw"] = 1800.0000 ,["HeimerTBlue"] = 1599.3999 ,["EliseSpider"] = 500.0000 ,["Skarner"] = 500.0000 ,["ChaosNexus"] = 500.0000 ,["Katarina"] = 467.0000 ,["Riven"] = 347.79999 ,["SightWard"] = 347.79999 ,["HeimerTYellow"] = 1599.3999 ,["Ashe"] = 2000.0000 ,["VisionWard"] = 2000.0000 ,["TT_NGolem2"] = math.huge ,["ThreshLantern"] = math.huge ,["TT_Spiderboss"] = math.huge ,["OrderNexus"] = math.huge ,["Soraka"] = 1000.0000 ,["Jinx"] = 2750.0000 ,["TestCubeRenderwCollision"] = 2750.0000 ,["Red_Minion_Wizard"] = 650.0000 ,["JarvanIV"] = 20.0000 ,["Blue_Minion_Wizard"] = 650.0000 ,["TT_ChaosTurret2"] = 1200.0000 ,["TT_ChaosTurret3"] = 1200.0000 ,["TT_ChaosTurret1"] = 1200.0000 ,["ChaosTurretGiant"] = 1200.0000 ,["Dragon"] = 1200.0000 ,["LuluSnowman"] = 1200.0000 ,["Worm"] = 1200.0000 ,["ChaosTurretWorm"] = 1200.0000 ,["TT_ChaosInhibitor"] = 1200.0000 ,["ChaosTurretNormal"] = 1200.0000 ,["AncientGolem"] = 500.0000 ,["ZyraGraspingPlant"] = 500.0000 ,["HA_AP_OrderTurret3"] = 1200.0000 ,["HA_AP_OrderTurret2"] = 1200.0000 ,["Tryndamere"] = 347.79999 ,["OrderTurretNormal2"] = 1200.0000 ,["Singed"] = 700.0000 ,["OrderInhibitor"] = 700.0000 ,["Diana"] = 347.79999 ,["HA_FB_HealthRelic"] = 347.79999 ,["TT_OrderInhibitor"] = 347.79999 ,["GreatWraith"] = 750.0000 ,["Yasuo"] = 347.79999 ,["OrderTurretDragon"] = 1200.0000 ,["OrderTurretNormal"] = 1200.0000 ,["LizardElder"] = 500.0000 ,["HA_AP_ChaosTurret"] = 1200.0000 ,["Ahri"] = 1750.0000 ,["Lulu"] = 1450.0000 ,["ChaosInhibitor"] = 1450.0000 ,["HA_AP_ChaosTurret3"] = 1200.0000 ,["HA_AP_ChaosTurret2"] = 1200.0000 ,["ChaosTurretWorm2"] = 1200.0000 ,["TT_OrderTurret1"] = 1200.0000 ,["TT_OrderTurret2"] = 1200.0000 ,["TT_OrderTurret3"] = 1200.0000 ,["LuluFaerie"] = 1200.0000 ,["HA_AP_OrderTurret"] = 1200.0000 ,["OrderTurretAngel"] = 1200.0000 ,["YellowTrinketUpgrade"] = 1200.0000 ,["MasterYi"] = math.huge ,["Lissandra"] = 2000.0000 ,["ARAMOrderTurretNexus"] = 1200.0000 ,["Draven"] = 1700.0000 ,["FiddleSticks"] = 1750.0000 ,["SmallGolem"] = math.huge ,["ARAMOrderTurretFront"] = 1200.0000 ,["ChaosTurretTutorial"] = 1200.0000 ,["NasusUlt"] = 1200.0000 ,["Maokai"] = math.huge ,["Wraith"] = 750.0000 ,["Wolf"] = math.huge ,["Sivir"] = 1750.0000 ,["Corki"] = 2000.0000 ,["Janna"] = 1200.0000 ,["Nasus"] = math.huge ,["Golem"] = math.huge ,["ARAMChaosTurretFront"] = 1200.0000 ,["ARAMOrderTurretInhib"] = 1200.0000 ,["LeeSin"] = math.huge ,["HA_AP_ChaosTurretTutorial"] = 1200.0000 ,["GiantWolf"] = math.huge ,["HA_AP_OrderTurretTutorial"] = 1200.0000 ,["YoungLizard"] = 750.0000 ,["Jax"] = 400.0000 ,["LesserWraith"] = math.huge ,["Blitzcrank"] = math.huge ,["ARAMChaosTurretInhib"] = 1200.0000 ,["Shen"] = 400.0000 ,["Nocturne"] = math.huge ,["Sona"] = 1500.0000 ,["ARAMChaosTurretNexus"] = 1200.0000 ,["YellowTrinket"] = 1200.0000 ,["OrderTurretTutorial"] = 1200.0000 ,["Caitlyn"] = 2500.0000 ,["Trundle"] = 347.79999 ,["Malphite"] = 1000.0000 ,["Mordekaiser"] = math.huge ,["ZyraSeed"] = math.huge ,["Vi"] = 1000.0000 ,["Tutorial_Red_Minion_Wizard"] = 650.0000 ,["Renekton"] = math.huge ,["Anivia"] = 1400.0000 ,["Fizz"] = math.huge ,["Heimerdinger"] = 1500.0000 ,["Evelynn"] = 467.0000 ,["Rumble"] = 347.79999 ,["Leblanc"] = 1700.0000 ,["Darius"] = math.huge ,["OlafAxe"] = math.huge ,["Viktor"] = 2300.0000 ,["XinZhao"] = 20.0000 ,["Orianna"] = 1450.0000 ,["Vladimir"] = 1400.0000 ,["Nidalee"] = 1750.0000 ,["Tutorial_Red_Minion_Basic"] = math.huge ,["ZedShadow"] = 467.0000 ,["Syndra"] = 1800.0000 ,["Zac"] = 1000.0000 ,["Olaf"] = 347.79999 ,["Veigar"] = 1100.0000 ,["Twitch"] = 2500.0000 ,["Alistar"] = math.huge ,["Akali"] = 467.0000 ,["Urgot"] = 1300.0000 ,["Leona"] = 347.79999 ,["Talon"] = math.huge ,["Karma"] = 1500.0000 ,["Jayce"] = 347.79999 ,["Galio"] = 1000.0000 ,["Shaco"] = math.huge ,["Taric"] = math.huge ,["TwistedFate"] = 1500.0000 ,["Varus"] = 2000.0000 ,["Garen"] = 347.79999 ,["Swain"] = 1600.0000 ,["Vayne"] = 2000.0000 ,["Fiora"] = 467.0000 ,["Quinn"] = 2000.0000 ,["Kayle"] = math.huge ,["Blue_Minion_Basic"] = math.huge ,["Brand"] = 2000.0000 ,["Teemo"] = 1300.0000 ,["Amumu"] = 500.0000 ,["Annie"] = 1200.0000 ,["Odin_Blue_Minion_caster"] = 1200.0000 ,["Elise"] = 1600.0000 ,["Nami"] = 1500.0000 ,["Poppy"] = 500.0000 ,["AniviaEgg"] = 500.0000 ,["Tristana"] = 2250.0000 ,["Graves"] = 3000.0000 ,["Morgana"] = 1600.0000 ,["Gragas"] = math.huge ,["MissFortune"] = 2000.0000 ,["Warwick"] = math.huge ,["Cassiopeia"] = 1200.0000 ,["Tutorial_Blue_Minion_Wizard"] = 650.0000 ,["DrMundo"] = math.huge ,["Volibear"] = 467.0000 ,["Irelia"] = 467.0000 ,["Odin_Red_Minion_Caster"] = 650.0000 ,["Lucian"] = 2800.0000 ,["Yorick"] = math.huge ,["RammusPB"] = math.huge ,["Red_Minion_Basic"] = math.huge ,["Udyr"] = 467.0000 ,["MonkeyKing"] = 20.0000 ,["Tutorial_Blue_Minion_Basic"] = math.huge ,["Kennen"] = 1600.0000 ,["Nunu"] = 500.0000 ,["Ryze"] = 2400.0000 ,["Zed"] = 467.0000 ,["Nautilus"] = 1000.0000 ,["Gangplank"] = 1000.0000 ,["Lux"] = 1600.0000 ,["Sejuani"] = 500.0000 ,["Ezreal"] = 2000.0000 ,["OdinNeutralGuardian"] = 1800.0000 ,["Khazix"] = 500.0000 ,["Sion"] = math.huge ,["Aatrox"] = 347.79999 ,["Hecarim"] = 500.0000 ,["Pantheon"] = 20.0000 ,["Shyvana"] = 467.0000 ,["Zyra"] = 1700.0000 ,["Karthus"] = 1200.0000 ,["Rammus"] = math.huge ,["Zilean"] = 1200.0000 ,["Chogath"] = 500.0000 ,["Malzahar"] = 2000.0000 ,["YorickRavenousGhoul"] = 347.79999 ,["YorickSpectralGhoul"] = 347.79999 ,["JinxMine"] = 347.79999 ,["YorickDecayedGhoul"] = 347.79999 ,["XerathArcaneBarrageLauncher"] = 347.79999 ,["Odin_SOG_Order_Crystal"] = 347.79999 ,["TestCube"] = 347.79999 ,["ShyvanaDragon"] = math.huge ,["FizzBait"] = math.huge ,["Blue_Minion_MechMelee"] = math.huge ,["OdinQuestBuff"] = math.huge ,["TT_Buffplat_L"] = math.huge ,["TT_Buffplat_R"] = math.huge ,["KogMawDead"] = math.huge ,["TempMovableChar"] = math.huge ,["Lizard"] = 500.0000 ,["GolemOdin"] = math.huge ,["OdinOpeningBarrier"] = math.huge ,["TT_ChaosTurret4"] = 500.0000 ,["TT_Flytrap_A"] = 500.0000 ,["TT_NWolf"] = math.huge ,["OdinShieldRelic"] = math.huge ,["LuluSquill"] = math.huge ,["redDragon"] = math.huge ,["MonkeyKingClone"] = math.huge ,["Odin_skeleton"] = math.huge ,["OdinChaosTurretShrine"] = 500.0000 ,["Cassiopeia_Death"] = 500.0000 ,["OdinCenterRelic"] = 500.0000 ,["OdinRedSuperminion"] = math.huge ,["JarvanIVWall"] = math.huge ,["ARAMOrderNexus"] = math.huge ,["Red_Minion_MechCannon"] = 1200.0000 ,["OdinBlueSuperminion"] = math.huge ,["SyndraOrbs"] = math.huge ,["LuluKitty"] = math.huge ,["SwainNoBird"] = math.huge ,["LuluLadybug"] = math.huge ,["CaitlynTrap"] = math.huge ,["TT_Shroom_A"] = math.huge ,["ARAMChaosTurretShrine"] = 500.0000 ,["Odin_Windmill_Propellers"] = 500.0000 ,["TT_NWolf2"] = math.huge ,["OdinMinionGraveyardPortal"] = math.huge ,["SwainBeam"] = math.huge ,["Summoner_Rider_Order"] = math.huge ,["TT_Relic"] = math.huge ,["odin_lifts_crystal"] = math.huge ,["OdinOrderTurretShrine"] = 500.0000 ,["SpellBook1"] = 500.0000 ,["Blue_Minion_MechCannon"] = 1200.0000 ,["TT_ChaosInhibitor_D"] = 1200.0000 ,["Odin_SoG_Chaos"] = 1200.0000 ,["TrundleWall"] = 1200.0000 ,["HA_AP_HealthRelic"] = 1200.0000 ,["OrderTurretShrine"] = 500.0000 ,["OriannaBall"] = 500.0000 ,["ChaosTurretShrine"] = 500.0000 ,["LuluCupcake"] = 500.0000 ,["HA_AP_ChaosTurretShrine"] = 500.0000 ,["TT_NWraith2"] = 750.0000 ,["TT_Tree_A"] = 750.0000 ,["SummonerBeacon"] = 750.0000 ,["Odin_Drill"] = 750.0000 ,["TT_NGolem"] = math.huge ,["AramSpeedShrine"] = math.huge ,["OriannaNoBall"] = math.huge ,["Odin_Minecart"] = math.huge ,["Summoner_Rider_Chaos"] = math.huge ,["OdinSpeedShrine"] = math.huge ,["TT_SpeedShrine"] = math.huge ,["odin_lifts_buckets"] = math.huge ,["OdinRockSaw"] = math.huge ,["OdinMinionSpawnPortal"] = math.huge ,["SyndraSphere"] = math.huge ,["Red_Minion_MechMelee"] = math.huge ,["SwainRaven"] = math.huge ,["crystal_platform"] = math.huge ,["MaokaiSproutling"] = math.huge ,["Urf"] = math.huge ,["TestCubeRender10Vision"] = math.huge ,["MalzaharVoidling"] = 500.0000 ,["GhostWard"] = 500.0000 ,["MonkeyKingFlying"] = 500.0000 ,["LuluPig"] = 500.0000 ,["AniviaIceBlock"] = 500.0000 ,["TT_OrderInhibitor_D"] = 500.0000 ,["Odin_SoG_Order"] = 500.0000 ,["RammusDBC"] = 500.0000 ,["FizzShark"] = 500.0000 ,["LuluDragon"] = 500.0000 ,["OdinTestCubeRender"] = 500.0000 ,["TT_Tree1"] = 500.0000 ,["ARAMOrderTurretShrine"] = 500.0000 ,["Odin_Windmill_Gears"] = 500.0000 ,["ARAMChaosNexus"] = 500.0000 ,["TT_NWraith"] = 750.0000 ,["TT_OrderTurret4"] = 500.0000 ,["Odin_SOG_Chaos_Crystal"] = 500.0000 ,["OdinQuestIndicator"] = 500.0000 ,["JarvanIVStandard"] = 500.0000 ,["TT_DummyPusher"] = 500.0000 ,["OdinClaw"] = 500.0000 ,["EliseSpiderling"] = 2000.0000 ,["QuinnValor"] = math.huge ,["UdyrTigerUlt"] = math.huge ,["UdyrTurtleUlt"] = math.huge ,["UdyrUlt"] = math.huge ,["UdyrPhoenixUlt"] = math.huge ,["ShacoBox"] = 1500.0000 ,["HA_AP_Poro"] = 1500.0000 ,["AnnieTibbers"] = math.huge ,["UdyrPhoenix"] = math.huge ,["UdyrTurtle"] = math.huge ,["UdyrTiger"] = math.huge ,["HA_AP_OrderShrineTurret"] = 500.0000 ,["HA_AP_Chains_Long"] = 500.0000 ,["HA_AP_BridgeLaneStatue"] = 500.0000 ,["HA_AP_ChaosTurretRubble"] = 500.0000 ,["HA_AP_PoroSpawner"] = 500.0000 ,["HA_AP_Cutaway"] = 500.0000 ,["HA_AP_Chains"] = 500.0000 ,["ChaosInhibitor_D"] = 500.0000 ,["ZacRebirthBloblet"] = 500.0000 ,["OrderInhibitor_D"] = 500.0000 ,["Nidalee_Spear"] = 500.0000 ,["Nidalee_Cougar"] = 500.0000 ,["TT_Buffplat_Chain"] = 500.0000 ,["WriggleLantern"] = 500.0000 ,["TwistedLizardElder"] = 500.0000 ,["RabidWolf"] = math.huge ,["HeimerTGreen"] = 1599.3999 ,["HeimerTRed"] = 1599.3999 ,["ViktorFF"] = 1599.3999 ,["TwistedGolem"] = math.huge ,["TwistedSmallWolf"] = math.huge ,["TwistedGiantWolf"] = math.huge ,["TwistedTinyWraith"] = 750.0000 ,["TwistedBlueWraith"] = 750.0000 ,["TwistedYoungLizard"] = 750.0000 ,["Red_Minion_Melee"] = math.huge ,["Blue_Minion_Melee"] = math.huge ,["Blue_Minion_Healer"] = 1000.0000 ,["Ghast"] = 750.0000 ,["blueDragon"] = 800.0000 ,["Red_Minion_MechRange"] = 3000, ["SRU_OrderMinionRanged"] = 650, ["SRU_ChaosMinionRanged"] = 650, ["SRU_OrderMinionSiege"] = 1200, ["SRU_ChaosMinionSiege"] = 1200, ["SRUAP_Turret_Chaos1"]  = 1200, ["SRUAP_Turret_Chaos2"]  = 1200, ["SRUAP_Turret_Chaos3"] = 1200, ["SRUAP_Turret_Order1"]  = 1200, ["SRUAP_Turret_Order2"]  = 1200, ["SRUAP_Turret_Order3"] = 1200, ["SRUAP_Turret_Chaos4"] = 1200, ["SRUAP_Turret_Chaos5"] = 500, ["SRUAP_Turret_Order4"] = 1200, ["SRUAP_Turret_Order5"] = 500 } 
    self.gapcloserTable = {
      ["Akali"] = _R, ["Elise"] = _Q, ["Elise"] = _E, ["Fiora"] = _Q, ["Fizz"] = _Q, 
      ["Graves"] = _E, ["Irelia"] = _Q, ["JarvanIV"] = _Q, ["Jax"] = _Q, ["Kennen"] = _E, 
      ["KhaZix"] = _E, ["Lucian"] = _E, ["MasterYi"] = _Q, ["MonkeyKing"] = _E, ["Pantheon"] = _W, 
      ["Poppy"] = _E, ["RekSai"] = _E, ["Renekton"] = _E, ["Riven"] = _E, ["Sejuani"] = _Q, 
      ["Shen"] = _E, ["Talon"] = _E, ["Udyr"] = _E, ["Volibear"] = _Q, ["XinZhao"] = _E
    }
    self.myRange = GetRange(myHero)+GetHitBox(myHero)*2
    self:Load(bool)
    
    OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
    return self
  end

  function IAC:Load(bool)
    DelayAction(function() -- my OnLoad
      if not bool then self:OverwriteIACPlugins() end
      if  IWalkConfigUSEIAC.getValue() then 
      self:DoChampionPluginMenu() 
    end
    if myHeroName == "Riven" and IWalkConfigUSEIAC.getValue() == false then
    IWalkConfigW = root.addItem(MenuBool.new("Use W (Stun)",true)) 
    IWalkConfigR = root.addItem(MenuBool.new("Use R if Kill",true))     
    end
      self:MakeMenu()
    --  end
      OnLoop(function() self:OnLoop() end)
   end, 0)
  end

  function IAC:OnLoop()
        if (IWalkConfig.D or IWalkConfigD.getValue()) then self:DmgCalc() end
        if waitTickCount > GetTickCount() then return end
    --    if not inbuiltOverwritten then
       if  IWalkConfigUSEIAC.getValue() then    
        self:DoChampionPlugins2()
      end
        self:IWalk()
        
  end

  function IAC:DmgCalc()
    for _,unit in pairs(GetEnemyHeroes()) do
      if ValidTarget(unit) then
        local hPos = GetHPBarPos(unit)
        DrawText(self:PossibleDmg(unit), 15, hPos.x, hPos.y+20, 0xffffffff)
      end
    end
  end

function IAC:RIVENR()
    if myHeroName == "Riven" then
     IWalkConfigR.getValue()
    end
end

  function IAC:PossibleDmg(unit)    
    local addDamage = GetBonusDmg(myHero)
    local TotalDmg = (GetBonusDmg(myHero)+GetBaseDamage(myHero))*((((IWalkConfig.R or self:RIVENR()) and (GetCastName(myHero, _R) ~= "RivenFengShuiEngine" or CanUseSpell(myHero, _R)))) and 1.2 or 1)
    local dmg = 0
    local cthp = GetCurrentHP(unit)
    local mthp = GetMaxHP(unit)
    if myHeroName == "Riven" then 
      local dmg = 0
      local mlevel = GetLevel(myHero)
      local pdmg = CalcDamage(myHero, unit, 5+math.max(5*math.floor((mlevel+2)/3)+10,10*math.floor((mlevel+2)/3)-15)*TotalDmg/100)
      if CanUseSpell(myHero, _Q) == READY then
        local level = GetCastLevel(myHero, _Q)
        dmg = dmg + CalcDamage(myHero, unit, 20*level+(0.35+0.05*level)*TotalDmg-10)*3+CalcDamage(myHero, unit, TotalDmg)*3+pdmg*3
      end
      if CanUseSpell(myHero, _W) == READY then
        local level = GetCastLevel(myHero, _W)
        dmg = dmg + CalcDamage(myHero, unit, 20+30*level+TotalDmg)+CalcDamage(myHero, unit, TotalDmg)+pdmg
      end
      if (CanUseSpell(myHero, _R) == READY or GetCastName(myHero, _R) ~= "RivenFengShuiEngine") and (IWalkConfig.R or IWalkConfigR.getValue()) and IWalkConfigUSEIAC.getValue() then
        local level = GetCastLevel(myHero, _R)
        local rdmg = CalcDamage(myHero, unit, (40+40*level+0.6*addDamage)*(math.min(3,math.max(1,4*(mthp-cthp)/mthp))))
        if rdmg > cthp and ValidTarget(unit, 800) and GetCastName(myHero, _R) ~= "RivenFengShuiEngine" and IWalkConfig.Combo then 
          local unitPos = GetOrigin(unit)
          CastSkillShot(_R, unitPos.x, unitPos.y, unitPos.z) 
        end
        cthp = cthp - dmg
        rdmg = CalcDamage(myHero, unit, (40+40*level+0.6*addDamage)*(math.min(3,math.max(1,4*(mthp-cthp)/mthp))))
        dmg = dmg + rdmg
      end
      return dmg > cthp and "Killable" or math.floor(100*dmg/cthp).."% Dmg"
    else
      dmg = CalcDamage(myHero, unit, TotalDmg)
      return math.ceil(cthp/dmg).." AA"
    end
  end

  function IAC:IWalk()
    if IWalkConfig.LastHit or IWalkConfig.LaneClear or IWalkConfig.Harass or IWalkConfigLastHit.getValue() or IWalkConfigLaneClear.getValue() or IWalkConfigHarass.getValue() then
      for _,k in pairs(GetAllMinions(MINION_ENEMY)) do
        local targetPos = GetOrigin(k)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        local hp = self:PredictHealth(k, self.orbTable.windUp + GetDistance(k)/self:GetProjectileSpeed(myHero) - 0.07)
        local dmg = CalcDamage(myHero, k, GetBonusDmg(myHero)+GetBaseDamage(myHero))
        if dmg > hp then
          if (IWalkConfig.LastHit or IWalkConfig.LaneClear or IWalkConfig.Harass or IWalkConfigLastHit.getValue() or IWalkConfigLaneClear.getValue() or IWalkConfigHarass.getValue()) and IsInDistance(k, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation then
            AttackUnit(k)
            return
          end
        end
      end
    end
    if IWalkConfig.Combo or IWalkConfig.Harass or IWalkConfig.LastHit or IWalkConfig.LaneClear or IWalkConfigCombo.getValue() or IWalkConfigLastHit.getValue() or IWalkConfigLaneClear.getValue() or IWalkConfigHarass.getValue() then
      self:DoWalk()
    end
  end

function IAC:IWalkConfigS()
    if not inbuiltOverwritten then 
      IWalkConfig.addParam("S", "Skillfarm", SCRIPT_PARAM_ONOFF, false)
      IWalkConfigS = root.addItem(MenuBool.new("Skillfarm",true))
      IWalkConfigS.getValue()
    end 
end      
  function IAC:DoWalk()
    self.myRange = GetRange(myHero)+GetHitBox(myHero)+(IWalkTarget and GetHitBox(IWalkTarget) or GetHitBox(myHero))   
    if (IWalkConfig.C or IWalkConfigC.getValue()) then Circle(myHero,self.myRange):draw() end
    local addRange = ((self.gapcloserTable[myHeroName] and CanUseSpell(myHero, gapcloserTable[myHeroName]) == READY) and 250 or 0) + (GetObjectName(myHero) == "Jinx" and (GetCastLevel(myHero, _Q)*25+50) or 0)
    IWalkTarget = GetTarget(self.myRange + addRange, DAMAGE_PHYSICAL)
    if IWalkConfig.LaneClear or IWalkConfigLaneClear.getValue() then
      IWalkTarget = GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_JUNGLE) or GetHighestMinion(GetOrigin(myHero), self.myRange, MINION_ENEMY)
    end
    local unit = IWalkTarget
    if (IWalkConfig.S or IWalkConfig.Combo or self:IWalkConfigS() or IWalkConfigCombo.getValue()) and ValidTarget(unit) then self:DoChampionPlugins(unit) end
    if not (IWalkConfig.LastHit or IWalkConfigLastHit.getValue()) and ValidTarget(unit, self.myRange) and GetTickCount() > self.orbTable.lastAA + self.orbTable.animation and self.aa then
      AttackUnit(unit)
    elseif GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp and self.move then
      if GetRange(myHero) < 450 and (IWalkConfig.wtt or IWalkConfigwtt.getValue()) and unit and GetObjectType(unit) == GetObjectType(myHero) and ValidTarget(unit, self.myRange) then
        local unitPos = GetOrigin(unit)
        if GetDistance(unit) > self.myRange/2 then
          MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
        end
      else
        if (IWalkConfig.Combo or IWalkConfigCombo.getValue()) and self.gapcloserTable[myHeroName] and ValidTarget(unit, self.myRange + 250) and (IWalkConfig[str[self.gapcloserTable[myHeroName]].."g"] or IWalkConfig2g.getValue()) and CanUseSpell(myHero, gapcloserTable[myHeroName]) == READY then 
          local unitPos = GetOrigin(unit)
          CastSkillShot(self.gapcloserTable[myHeroName], unitPos.x, unitPos.y, unitPos.z)
          if myHeroName == "Riven" and (IWalkConfig["W"] or IWalkConfigW.getValue()) and CanUseSpell(myHero, _W) == READY then
            if self:PossibleDmg(unit):find("Killable") and (IWalkConfig.R or IWalkConfigR.getValue()) then
              DelayAction(function() CastTargetSpell(myHero, _R) end, 137)
            else
              DelayAction(function() CastTargetSpell(myHero, _W) end, 137)
            end
            self.orbTable.lastAA = 0
          end
        else
          self:Move()
        end
      end
    end
  end

  function IAC:Move()
    local movePos = GenerateMovePos()
    if GetDistance(GetMousePos()) > GetHitBox(myHero) then
      MoveToXYZ(movePos.x, GetMyHeroPos().y, movePos.z)
    end
  end

  function IAC:GetIWalkTarget()
    return IWalkTarget
  end

  function IAC:ProcessSpell(unit, spell)
    if unit and spell and spell.name then
      if unit == myHero then
        if (spell.name:lower():find("attack") or (self.isAAaswellTable[myHeroName] and self.isAAaswellTable[myHeroName] == spell.name)) then
          self.orbTable.lastAA = GetTickCount() + GetLatency()
          self.orbTable.windUp = myHeroName == "Kalista" and 0 or spell.windUpTime * 1000
          self.orbTable.animation = GetAttackSpeed(GetMyHero()) < 2.25 and spell.animationTime * 1000 or 1000 / GetAttackSpeed(GetMyHero())
          DelayAction(function() 
                              if (IWalkConfig.S or IWalkConfig.Combo or self:IWalkConfigS() or IWalkConfigCombo.getValue()) and ValidTarget(IWalkTarget, self.myRange) then 
                                self:WindUp(IWalkTarget) 
                              end
                            end, spell.windUpTime * 1000 + GetLatency())
        elseif spell.name:lower():find("katarinar") then
          waitTickCount = GetTickCount() + 2500
        end
      end
      if spell.target and spell.name:lower():find("attack") and GetObjectType(spell.target) == Obj_AI_Minion then
        local timer = 1000*GetDistance(spell.target,unit)/self:GetProjectileSpeed(unit)
        local target = spell.target
        if not self.AATable[GetNetworkID(target)] then self.AATable[GetNetworkID(target)] = {} end
        self.AATable[GetNetworkID(target)][timer] = {source = unit, dmg = CalcDamage(unit, spell.target, GetBonusDmg(unit)+GetBaseDamage(unit)), time = GetTickCount() + timer}
        DelayAction(function() self.AATable[GetNetworkID(target)][timer] = nil end, timer)
      end
    end
  end
  
  function IAC:GetProjectileSpeed(unit)
    return self.projectilespeeds[GetObjectName(unit)] and self.projectilespeeds[GetObjectName(unit)] or math.huge
  end

  function IAC:PredictHealth(unit, time)
    if self.AATable[GetNetworkID(unit)] then
      local preds = self.AATable[GetNetworkID(unit)]
      local health = GetCurrentHP(unit)
      if preds then
        for _, k in pairs(preds) do
          if not IsDead(k.source) and k.time < GetTickCount() + time then
            health = health - k.dmg
          end
        end
      end
      return health
    else
      return GetCurrentHP(unit)
    end
  end

  function IAC:WindUp(unit)
    local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
    if self.aaResetTable4[myHeroName] then
      for _,k in pairs(self.aaResetTable4[myHeroName]) do
        if CanUseSpell(myHero, k) == READY and (IWalkConfig[str[k]] or IWalkConfig4.getValue()) then --IWalkConfig2[str[k]].getValue()
          self.orbTable.lastAA = 0
          local movePos = GenerateMovePos()
          CastSkillShot(k, movePos.x, movePos.y, movePos.z)
          return true
        end
      end
    end
    if self.aaResetTable[myHeroName] then
      for _,k in pairs(self.aaResetTable[myHeroName]) do
        if CanUseSpell(myHero, k) == READY and (IWalkConfig[str[k]] or IWalkConfig1.getValue())  and GetDistanceSqr(GetOrigin(unit)) < self.myRange * self.myRange then
          self.orbTable.lastAA = 0
          CastSpell(k)
          return true
        end
      end
    end
    if self.aaResetTable2[myHeroName] then
      for _,k in pairs(self.aaResetTable2[myHeroName]) do
        if CanUseSpell(myHero, k) == READY and (IWalkConfig[str[k]] or IWalkConfig2.getValue())  and GetDistanceSqr(GetOrigin(unit)) < self.myRange * self.myRange and (not myHeroName == "Quinn" or CanUseSpell(myHero, _E) ~= READY) then
          local unitPos = GetOrigin(unit)
          CastSkillShot(k, unitPos.x, unitPos.y, unitPos.z)
          if myHeroName == "Riven" then
            local unitPos = GetOrigin(unit)
            MoveToXYZ(unitPos.x, unitPos.y, unitPos.z)
          end
          self.orbTable.lastAA = 0
          return true
        end
      end
    end
    if self.aaResetTable3[myHeroName] then
      for _,k in pairs(self.aaResetTable3[myHeroName]) do
        if CanUseSpell(myHero, k) == READY and (IWalkConfig[str[k]] or IWalkConfig3.getValue())  and GetDistanceSqr(GetOrigin(unit)) < self.myRange * self.myRange then
          if myHeroName ~= "Quinn" or GotBuff(unit, "QuinnW") < 1 then
            self.orbTable.lastAA = 0
            CastTargetSpell(unit, k)
          end
          return true
        end
      end
    end
    return (IWalkConfig.I or IWalkConfigI.getValue()) and CastOffensiveItems(unit)
  end

  function IAC:MakeMenu()
    str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
    
    IWalkConfig.addParam("D", "Damage Calc", SCRIPT_PARAM_ONOFF, false)   
    IWalkConfig.addParam("C", "AA Range Circle", SCRIPT_PARAM_ONOFF, false)   
    IWalkConfig.addParam("LastHit", "LastHit", SCRIPT_PARAM_KEYDOWN, string.byte("pp"))
    IWalkConfig.addParam("Harass", "Harass", SCRIPT_PARAM_KEYDOWN, string.byte("pp"))
    IWalkConfig.addParam("LaneClear", "LaneClear", SCRIPT_PARAM_KEYDOWN, string.byte("pp"))     
    IWalkConfig.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte("pp"))
    IWalkConfig.addParam("I", "Cast Items", SCRIPT_PARAM_ONOFF, false)

--    root = menu.addItem(SubMenu.new("Inspired's Auto Carry"))
--    IWalkConfigD = root.addItem(MenuBool.new("Damage Calc",true))     
--    IWalkConfigC = root.addItem(MenuBool.new("AA Range Circle",true)) 
--    IWalkConfigLastHit = root.addItem(MenuKeyBind.new("LastHit", 88))     
--    IWalkConfigHarass = root.addItem(MenuKeyBind.new("Harass", 67))        
--    IWalkConfigLaneClear = root.addItem(MenuKeyBind.new("LaneClear", 86)) 
--    IWalkConfigCombo = root.addItem(MenuKeyBind.new("Combo", 32)) 
--    IWalkConfigI = root.addItem(MenuBool.new("Cast Items",true))    

    if self.aaResetTable3[myHeroName] then
      for _,k in pairs(self.aaResetTable3[myHeroName]) do
        IWalkConfig.addParam(str[k], "AA Reset with "..str[k], SCRIPT_PARAM_ONOFF, not inbuiltOverwritten)
        IWalkConfig3 = root.addItem(MenuBool.new("AA Reset with "..str[k], true))        
      end
    end
    if self.aaResetTable2[myHeroName] then
      for _,k in pairs(self.aaResetTable2[myHeroName]) do
        IWalkConfig.addParam(str[k], "AA Reset with "..str[k], SCRIPT_PARAM_ONOFF, not inbuiltOverwritten)
        IWalkConfig2 = root.addItem(MenuBool.new("AA Reset with "..str[k], true))        
      end
    end
    if self.aaResetTable[myHeroName] then
      for _,k in pairs(self.aaResetTable[myHeroName]) do
        IWalkConfig.addParam(str[k], "AA Reset with "..str[k], SCRIPT_PARAM_ONOFF, not inbuiltOverwritten)
        IWalkConfig1 = root.addItem(MenuBool.new("AA Reset with "..str[k], true))              --not inbuiltOverwritten)  
      end
    end
    if self.aaResetTable4[myHeroName] then
      for _,k in pairs(self.aaResetTable4[myHeroName]) do
        IWalkConfig.addParam(str[k], "AA Reset with "..str[k], SCRIPT_PARAM_ONOFF, not inbuiltOverwritten)
        IWalkConfig4 = root.addItem(MenuBool.new("AA Reset with "..str[k], true))        
      end
    end
    if self.gapcloserTable[myHeroName] then
      k = self.gapcloserTable[myHeroName]
        if type(k)=="number" then
        IWalkConfig.addParam(str[k].."g", "Gapclose with "..str[k], SCRIPT_PARAM_ONOFF, not inbuiltOverwritten)
        IWalkConfig2g = root.addItem(MenuBool.new("Gapclose with "..str[k], true))        
      end
    end
   -- if not inbuiltOverwritten then 
   --   self:DoChampionPluginMenu()
  --    IWalkConfig.addParam("S", "Skillfarm", SCRIPT_PARAM_ONOFF, false)
  --    IWalkConfigS = root.addItem(MenuBool.new("Skillfarm",true))      
   -- end    
    if GetRange(myHero) < 450 or myHeroName == "Rengar" then
      IWalkConfig.addParam("wtt", "Walk To Target", SCRIPT_PARAM_ONOFF, false)
      IWalkConfigwtt = root.addItem(MenuBool.new("Walk To Target",true))       
    end        
  end

  function IAC:DoChampionPluginMenu()  
    local manaPerc = Get
    if myHeroName == "Ashe" then 
      IWalkConfig.addParam("Q", "Use Q (5 stacks)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q (5 stacks)",true))       
      IWalkConfig.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigW = root.addItem(MenuBool.new("Use W",true))       
      IWalkConfig.addParam("R", "Use R (execute)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigR = root.addItem(MenuBool.new("Use R (execute)",true))       
    elseif myHeroName == "Caitlyn" then
      IWalkConfig.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q",true))       
      IWalkConfig.addParam("R", "Use R (execute)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigR = root.addItem(MenuBool.new("Use R (execute)",true))        
    elseif myHeroName == "Corki" then
    elseif myHeroName == "Draven" then
    elseif myHeroName == "Ezreal" then
      IWalkConfig.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q",true))       
      IWalkConfig.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigW = root.addItem(MenuBool.new("Use W",true))       
      IWalkConfig.addParam("R", "Use R (execute)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigR = root.addItem(MenuBool.new("Use R (execute)",true))  
    elseif myHeroName == "Graves" then
      IWalkConfig.addParam("R", "Use R (execute)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigR = root.addItem(MenuBool.new("Use R (execute)",true)) 
    elseif myHeroName == "Jinx" then
      IWalkConfig.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q",true))       
      IWalkConfig.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigW = root.addItem(MenuBool.new("Use W",true)) 
--      IWalkConfig.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, false) 
--      IWalkConfigE = root.addItem(MenuBool.new("Use E",true))        
      IWalkConfig.addParam("R", "Use R (execute)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigR = root.addItem(MenuBool.new("Use R (execute)",true))  
    elseif myHeroName == "Kalista" then
      IWalkConfig.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q",true))
      IWalkConfig.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true) 
      IWalkConfigE = root.addItem(MenuBool.new("Use E",true))    
    elseif myHeroName == "KogMaw" then
    elseif myHeroName == "Lucian" then
    elseif myHeroName == "MissFortune" then
    elseif myHeroName == "Quinn" then
  elseif myHeroName == "Riven" then   
      IWalkConfig.addParam("R", "Use R if Kill", SCRIPT_PARAM_ONOFF, false)
    IWalkConfigR = root.addItem(MenuBool.new("Use R if Kill",true)) 
    elseif myHeroName == "Sivir" then
    elseif myHeroName == "Teemo" then
  elseif myHeroName == "Tristana" then
      IWalkConfig.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigQ = root.addItem(MenuBool.new("Use Q",true))       
      IWalkConfig.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigE = root.addItem(MenuBool.new("Use E",true))  
  elseif myHeroName == "Twitch" then
        elseif myHeroName == "Yasuo" then  
    elseif myHeroName == "Varus" then
  elseif myHeroName == "Vayne" then
      IWalkConfig.addParam("E", "Use E (stun)", SCRIPT_PARAM_ONOFF, false) 
      IWalkConfigE = root.addItem(MenuBool.new("Use E (Stun)",true))        
    end
  end

  function IAC:DoChampionPlugins(unit)
    if myHeroName == "Ashe" then
      if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "asheqcastready") > 0 and (IWalkConfig.Q or IWalkConfigQ.getValue()) then
        CastSpell(_Q)
      end
      if CanUseSpell(myHero, _W) == READY and (IWalkConfig.W or IWalkConfigW.getValue()) then
        local unitPos = GetOrigin(unit)
        CastSkillShot(_W, unitPos.x, unitPos.y, unitPos.z)
      end
    elseif myHeroName == "Corki" then
    elseif myHeroName == "Draven" then
    elseif myHeroName == "Graves" then
    elseif myHeroName == "Jinx" then
      if CanUseSpell(myHero, _Q) == READY and (IWalkConfig.Q or IWalkConfigQ.getValue()) and GetTickCount() > self.orbTable.lastAA + self.orbTable.windUp then
        if GetRange(myHero) == 525 and GetDistance(unit) > 525 then
          CastSpell(_Q)
        elseif GetRange(myHero) > 525 and GetDistance(unit) < 525 + GetHitBox(myHero) + GetHitBox(unit) then
          CastSpell(_Q)
        end
      end
    elseif myHeroName == "KogMaw" then
    elseif myHeroName == "Lucian" then
    elseif myHeroName == "MissFortune" then
    elseif myHeroName == "Quinn" then
    elseif myHeroName == "Sivir" then
    elseif myHeroName == "Teemo" then
    elseif myHeroName == "Tristana" then
      if CanUseSpell(myHero, _Q) == READY and (IWalkConfig.Q or IWalkConfigQ.getValue()) then
        CastSpell(_Q)
      end
      if CanUseSpell(myHero, _E) == READY and (IWalkConfig.E or IWalkConfigE.getValue()) then
        CastSpell(_E)
      end
    elseif myHeroName == "Twitch" then
  elseif myHeroName == "Varus" then
    elseif myHeroName == "Yasuo" then      
    elseif myHeroName == "Vayne" then
      if IWalkConfig.E or IWalkConfigE.getValue() and CanUseSpell(myHero, _E) == READY then
        local Pred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit), 2000, 0.25, 1000, 1, false, true)
        for _=0,450,GetHitBox(unit) do
          local tPos = Vector(Pred.PredPos)+Vector(Vector(Pred.PredPos)-Vector(myHero)):normalized()*_
          if IsWall(tPos) then
            CastTargetSpell(unit, _E)
          end
        end
      end
    end
  end

  function IAC:DoChampionPlugins2()
    if myHeroName == "Ashe" then
      for _, unit in pairs(GetEnemyHeroes()) do
        if ValidTarget(unit, 3500) and CanUseSpell(myHero, _R) == READY and (IWalkConfig.R or IWalkConfigR.getValue()) then
          if CalcDamage(myHero, unit, 0, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero)) >= GetCurrentHP(unit) then
             PredCast(_R, unit, 1600, 250, 20000, 130, false)
          end
        end
      end
    elseif myHeroName == "Caitlyn" then
      for _, unit in pairs(GetEnemyHeroes()) do
        if ValidTarget(unit, GetCastRange(myHero, _R)) and CanUseSpell(myHero, _R) == READY and (IWalkConfig.R or IWalkConfigR.getValue()) then
          if CalcDamage(myHero, unit, 25+225*GetCastLevel(myHero, _R)+GetBonusDmg(myHero)*2) >= GetCurrentHP(unit) then
            CastTargetSpell(unit, _R)
          end
        end
      end
      local unit = GetTarget(1300, DAMAGE_PHYSICAL)
      if unit and CanUseSpell(myHero, _Q) == READY and (IWalkConfig.Q or IWalkConfigQ.getValue()) and (IWalkConfig.Combo or IWalkConfigCombo.getValue()) then
        PredCast(_Q, unit, 2200, 625, 1300, 90, false)
      end
    elseif myHeroName == "Yasuo" then  
    elseif myHeroName == "Ezreal" then
      for _, unit in pairs(GetEnemyHeroes()) do
        if ValidTarget(unit, 3500) and CanUseSpell(myHero, _R) == READY and (IWalkConfig.R or IWalkConfigR.getValue()) then
          if CalcDamage(myHero, unit, 0, 200 + 150*GetCastLevel(myHero,_R) + .9*GetBonusAP(myHero)+GetBonusDmg(myHero)) >= GetCurrentHP(unit) then
            PredCast(_R, unit, 2000, 1000, 20000, 160, false)
          end
        end
      end
      local unit = GetTarget(1200, DAMAGE_PHYSICAL)
      if unit and CanUseSpell(myHero, _Q) == READY and (IWalkConfig.Q or IWalkConfigQ.getValue()) and (IWalkConfig.Combo or IWalkConfigCombo.getValue()) then
        PredCast(_Q, unit, 2000, 250, 1200, 60, false)
      end
      local unit = GetTarget(1050, DAMAGE_PHYSICAL)
      if unit and CanUseSpell(myHero, _W) == READY and (IWalkConfig.W or IWalkConfigW.getValue()) and (IWalkConfig.Combo or IWalkConfigCombo.getValue()) then
        PredCast(_W, unit, 1600, 250, 1050, 80, false)
      end
    elseif myHeroName == "Graves" then
      for _, unit in pairs(GetEnemyHeroes()) do
        if ValidTarget(unit, 1100) and CanUseSpell(myHero, _R) == READY and (IWalkConfig.R or IWalkConfigR.getValue()) then
          if CalcDamage(myHero, unit, 100+150*GetCastLevel(myHero, _R)+GetBonusDmg(myHero)*1.5) >= GetCurrentHP(unit) then
            PredCast(_R, unit, 2100, 250, 1100, 100, false)
          end
        end
      end
    elseif myHeroName == "Jinx" then
      for _, unit in pairs(GetEnemyHeroes()) do
        if ValidTarget(unit, 3500) and CanUseSpell(myHero, _R) == READY and (IWalkConfig.R or IWalkConfigR.getValue()) then
          if CalcDamage(myHero, unit, (GetMaxHP(unit)-GetCurrentHP(unit))*(0.2+0.05*GetCastLevel(myHero, _R))+(150+100*GetCastLevel(myHero, _R)+GetBonusDmg(myHero))*math.max(0.1, math.min(1, GetDistance(unit)/1700))) >= GetCurrentHP(unit) then
            PredCast(_R, unit, 2300, 600, 20000, 140, false)
          end
        end
      end
      local unit = GetTarget(1500, DAMAGE_PHYSICAL)
      if unit and CanUseSpell(myHero, _W) == READY and (IWalkConfig.W or IWalkConfigW.getValue()) and (IWalkConfig.Combo or IWalkConfigCombo.getValue()) then
        PredCast(_W, unit, 3300, 600, 1500, 60, true)
      end
    elseif myHeroName == "Kalista" then
      local function kalE(x) if x <= 1 then return 10 else return kalE(x-1) + 2 + x end end
      local killableCount = 0
      for _,unit in pairs(GetAllMinions(MINION_ENEMY)) do
        local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
        local dmgE = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (TotalDmg * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*TotalDmg) or 0)
        local dmg = CalcDamage(myHero, unit, dmgE)
        local hp = GetCurrentHP(unit)
        if dmg > 0 and hp > 0 and dmg >= hp and ValidTarget(unit, 1000) and (IWalkConfig.E or IWalkConfigE.getValue()) then 
          killableCount = killableCount + (GetObjectName(unit):find("Siege") and 2 or 1)
        end
      end
      if killableCount >= 2 and (IWalkConfig.LastHit or IWalkConfig.LaneClear) or (IWalkConfigLastHit.getValue() or IWalkConfigLaneClear.getValue()) then
        CastSpell(_E)
        return;
      end
      for _,unit in pairs(GetEnemyHeroes()) do
        local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
        local dmgE = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (TotalDmg * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*TotalDmg) or 0)
        local dmg = CalcDamage(myHero, unit, dmgE)
        local hp = GetCurrentHP(unit)
        local targetPos = GetOrigin(unit)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        if dmg > 0 then 
          DrawText(math.floor(dmg/hp*100).."%",20,drawPos.x,drawPos.y,0xffffffff)
          if hp > 0 and (dmg >= hp or killableCount > 0) and ValidTarget(unit, 1000) and (IWalkConfig.E or IWalkConfigE.getValue()) then 
            CastSpell(_E) 
          end
        end
      end
      if IWalkTarget then
        local TotalDmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)
        local dmgE = (GotBuff(IWalkTarget,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (TotalDmg * 0.6)) + (GotBuff(IWalkTarget,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*TotalDmg) or 0)
        local dmg = CalcDamage(myHero, IWalkTarget, dmgE)
        local hp = GetCurrentHP(IWalkTarget)
        if dmg > 0 then 
          if hp > 0 and dmg >= hp and ValidTarget(IWalkTarget, 1000) and (IWalkConfig.E or IWalkConfigE.getValue()) then 
            CastSpell(_E) 
          end
        end
      end
      local unit = GetTarget(1150, DAMAGE_PHYSICAL)
      if unit and CanUseSpell(myHero, _Q) == READY and (IWalkConfig.Q or IWalkConfigQ.getValue()) and (IWalkConfig.Combo or IWalkConfigCombo.getValue()) then 
        PredCast(_Q, unit, 1750, 250, 1150, 70, true)
      end
    end
  end

  function IAC:OverwriteIACPlugins()
    inbuiltOverwritten = true
  end

  function IAC:IsWindingUp()
    return GetTickCount() <= self.orbTable.lastAA + self.orbTable.windUp
  end

  function IAC:SetMove(bool)
    self.move = bool
  end

  function IAC:SetAA(bool)
    self.aa = bool
  end

  function IAC:SetOrb(bool)
    self.aa = bool
    self.move = bool
  end

-- }
