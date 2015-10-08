local MoTver = "0.10"
local MoTverST = "Beta"
local myHeroNAME = GetObjectName(myHero)
class "MarCiiiOnTour"
function MarCiiiOnTour:__init()
--OnLoop(function() self:Checks() end) 
self:Checks()
self.LOOPON = false
self.MENUON = true
self.lang = de
--self.DEBUG = false
self.MonTourItem = Menu("MonTour ItemCaster", "ItemDataBase") 
GoS:DelayAction(function() 
MarCiiiOnTour:English()
end, 900)
GoS:DelayAction(function() 
if self.MENUON == true then 
self:MakeMenu()
end
if self.MENUON == false then
self.MonTourItem:Info("MonTourItem", "MENU IS OFF")
PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Version: "..MoTver.." "..MoTverST.."</font>"))
PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loaded!</font>"))
end
end, 1000)
--GoS:DelayAction(function() 
--if self.DEBUG == true then
--self.MonTourItem:SubMenu("DEB", "DEBUG")
--self.MonTourItem.DEB:Boolean("D", "ON/OFF", true)
--OnLoop(function() self:Loop2() end)
--end
--end, 500)
OnLoop(function() self:Loop() end)
end

function MarCiiiOnTour:Language(lang)
if lang == de then
  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Deutsch loaded!</font>"))
  self:German()
  self.lang = de
elseif lang == eng then
  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>English loaded!</font>"))  
  self:German()
  self.lang = eng
end
end

function MarCiiiOnTour:German()
self.SettingsData = {"Einstellungen"}
self.LanguageData = {"Items Gegner","Tiamat & Hydra","Bilgewasser-Entermesser","Klinge d. g. Koenigs","Youmus Geistklinge","Anrecht d. Frostkoenigin","wenn Gegner in Range = X","Tiamat & (Ti)Hydra Minion","RanduinsOmen","Redliche Pracht"} 
self.LanguageDataAlly = {"Items Ally","Zekes Herold auf Ally","Amulett d. Aufstiegs","Truebwassersphaere(+Upgraded)","Gebirgspanzer","Amulett d. eisernen Solari","Mikaels Schmelztiegel"}
self.LanguageData2 = {"wenn meine HP < x%","wenn Gegner HP < x%","wenn Ally HP < x%","wenn AllyAround me >= x","wenn Gegner in Range <= x","wenn MinionAround me >= X","wenn EnemyAround me <= X"} 
self.LanguageDataDef = {"Items Verteidigung","Quecksilberschaerpe ","Zhonyas Stundenglas","Ohmzerstoerer","Kommandobanner"} 
self.LanguageDataPot = {"Items Pots","Elixire nutzen?"} 
self.LanguageDataMinion = {"SuperMinion als Ziel","SiegeMinion als Ziel","MeleeMinion als Ziel","CasterMinion als Ziel"}
end

function MarCiiiOnTour:English()
self.SettingsData = {"Settings"}
self.LanguageData = {"Use Items Enemy","Tiamat & (Ti)Hydra Enemy","Bilgewater Cutlass","Blade of the Ruined King","Youmuu's Ghostblade","Frost Queen's Claim","If Enemy in Range = X","Tiamat & (Ti)Hydra Minion","Randuins Omen","Righteous Glory"} 
self.LanguageDataAlly = {"Use Items Ally","Zeke's Harbinger Ally","Talisman of Ascension","Murksphere->GlobeofTrust","Face of the Mountain","Locket of the Iron Solari","Mikaels Crucible"}
self.LanguageData2 = {"if My HP < x%","if Enemy HP < x%","if Ally HP < x%","if AllyAround >= x","if Enemy in Range <= x","if MinionAround me >= X","if EnemyAround me <= X"} 
self.LanguageDataDef = {"Use Items Defence","Use QSS","Use Zhonyas","Ohmwrecker","Banner of Command"} 
self.LanguageDataPot = {"Use Potions","Use Elixirs"} 
self.LanguageDataMinion = {"Cast on SuperMinion","Cast on SiegeMinion","Cast on MeleeMinion","Cast on CasterMinion"}
end

function MarCiiiOnTour:MakeMenu()
self.MonTourItem:SubMenu("Settings", self.SettingsData[1])
self.MonTourItem.Settings:Key("Combo", "Combo", string.byte(" "))
self.MonTourItem.Settings:Key("Harass", "Harass", string.byte("C"))
self.MonTourItem.Settings:Key("LastHit", "LastHit", string.byte("X"))
self.MonTourItem.Settings:Key("LaneClear", "LaneClear", string.byte("V"))
self.MonTourItem:SubMenu("Items", ""..self.LanguageData[1])
self.MonTourItem.Items:Boolean("TiHy", ""..self.LanguageData[2], true)
self.MonTourItem.Items:Boolean("TiHyM", ""..self.LanguageData[8], true)
self.MonTourItem.Items:Slider("TiHyMA", self.LanguageData2[6].." (Def.4)", 4, 1, 15, 1)
self.MonTourItem.Items:Info("MonTourItem"," ")
self.MonTourItem.Items:Boolean("useCut", ""..self.LanguageData[3], true)
self.MonTourItem.Items:Slider("CutBlademyhp", ""..self.LanguageData2[1], 50, 5, 100, 1)
self.MonTourItem.Items:Slider("CutBladeehp", ""..self.LanguageData2[2], 20, 5, 100, 1)
self.MonTourItem.Items:Info("MonTourItem", " ")
self.MonTourItem.Items:Boolean("useBork", ""..self.LanguageData[4], true)
self.MonTourItem.Items:Slider("borkmyhp", ""..self.LanguageData2[1], 50, 5, 100, 1)
self.MonTourItem.Items:Slider("borkehp", ""..self.LanguageData2[2], 20, 5, 100, 1)
self.MonTourItem.Items:Info("MonTourItem", " ")
self.MonTourItem.Items:Boolean("ghostblade", ""..self.LanguageData[5], true)
self.MonTourItem.Items:Slider("ghostbladeR", self.LanguageData[7].." (Def.400)", 400, 100, 1500, 1)
self.MonTourItem.Items:Info("MonTourItem"," ")
self.MonTourItem.Items:Boolean("RanduinsOmen", ""..self.LanguageData[9], true)
self.MonTourItem.Items:Slider("RanduinsOmenR", ""..self.LanguageData2[7], 3, 1, 5, 1)
self.MonTourItem.Items:Info("MonTourItem", " ")
self.MonTourItem.Items:Boolean("FrostQueensClaimCombo", ""..self.LanguageData[6].." Combo", true)
self.MonTourItem.Items:Boolean("FrostQueensClaimHarass", ""..self.LanguageData[6].." Harass", true)
self.MonTourItem:SubMenu("Ally", ""..self.LanguageDataAlly[1])
self.MonTourItem.Ally:Boolean("LocketoftheIronSolari", ""..self.LanguageDataAlly[6], true)
self.MonTourItem.Ally:Slider("LocketoftheIronSolariHP", self.LanguageData2[3].." (Def.20)", 20, 5, 90, 1)
self.MonTourItem.Ally:Slider("LocketoftheIronSolariHPME", self.LanguageData2[1].." (Def.15)", 15, 1, 90, 1)
self.MonTourItem.Ally:Slider("LocketoftheIronSolariR", self.LanguageData2[5].." (Def.700)", 700, 100, 1500, 1)
self.MonTourItem.Ally:Info("MonTourItem", " ")
self.MonTourItem.Ally:Boolean("Zekees", ""..self.LanguageDataAlly[2], false)
self.MonTourItem.Ally:Info("MonTourItem", " ")
self.MonTourItem.Ally:Boolean("RighteousGlory", ""..self.LanguageData[9], false)
self.MonTourItem.Ally:Slider("RighteousGloryR", ""..self.LanguageData2[4], 3, 1, 5, 1)
self.MonTourItem.Ally:Info("MonTourItem", " ")
self.MonTourItem.Ally:Boolean("MikaelsCrucible", ""..self.LanguageDataAlly[7], true)
self.MonTourItem.Ally:Slider("MikaelsCrucibleHP", self.LanguageData2[3].." (Def.100)", 100, 5, 100, 1)
self.MonTourItem.Ally:Info("MonTourItem", " ")
self.MonTourItem.Ally:Boolean("TalismanofAscension", ""..self.LanguageDataAlly[3], true)
self.MonTourItem.Ally:Slider("TalismanofAscensionR", self.LanguageData2[4].." (Def.3)", 3, 1, 5, 1)
--self.MonTourItem.Ally:Info("MonTourItem", " ")
--self.MonTourItem.Ally:Boolean("MurksphereSwindlersOrbGlobeofTrust", ""..self.LanguageDataAlly[4], true)
--self.MonTourItem.Ally:Slider("MurksphereSwindlersOrbGlobeofTrustHP", self.LanguageData2[3].." (Def.20)", 20, 5, 90, 1)
--self.MonTourItem.Ally:Slider("MurksphereSwindlersOrbGlobeofTrustHPME", self.LanguageData2[1].." (Def.15)", 15, 1, 90, 1)
self.MonTourItem.Ally:Info("MonTourItem", " ")
self.MonTourItem.Ally:Boolean("FaceoftheMountain", ""..self.LanguageDataAlly[5], true)
self.MonTourItem.Ally:Slider("FaceoftheMountainHP", self.LanguageData2[3].." (Def.20)", 20, 5, 90, 1)
self.MonTourItem.Ally:Slider("FaceoftheMountainR", self.LanguageData2[5].." (Def.700)", 700, 100, 1500, 1)
self.MonTourItem:SubMenu("Def", ""..self.LanguageDataDef[1])
self.MonTourItem.Def:Boolean("QSS", ""..self.LanguageDataDef[2], true)
self.MonTourItem.Def:Slider("QSSHP", self.LanguageData2[1].." (Def.75)", 75, 0, 100, 1)
self.MonTourItem.Def:Info("MonTourItem", " ")
self.MonTourItem.Def:Boolean("Zhonya", ""..self.LanguageDataDef[3], true)
self.MonTourItem.Def:Slider("ZhonyaHP", self.LanguageData2[1].." (Def.30)", 30, 0, 100, 1)
self.MonTourItem.Def:Slider("ZhonyaR", self.LanguageData2[5].." (Def.900)", 900, 100, 1500, 1)
self.MonTourItem.Def:Boolean("Ohmwrecker", ""..self.LanguageDataDef[4], true)
self.MonTourItem.Def:Info("MonTourItem", " ")
self.MonTourItem.Def:Boolean("BannerofCommand", ""..self.LanguageDataDef[5], true)
self.MonTourItem.Def:Boolean("BannerofCommandSu", ""..self.LanguageDataMinion[1], true)
self.MonTourItem.Def:Boolean("BannerofCommandSi", ""..self.LanguageDataMinion[2], true)
self.MonTourItem.Def:Boolean("BannerofCommandMe", ""..self.LanguageDataMinion[3], false)
self.MonTourItem.Def:Boolean("BannerofCommandCa", ""..self.LanguageDataMinion[4], false)
self.MonTourItem:SubMenu("Potions", ""..self.LanguageDataPot[1])
self.MonTourItem.Potions:Boolean("Elixir", ""..self.LanguageDataPot[2], true)
self.MonTourItem.Potions:Slider("ElixirR", self.LanguageData[7].." (Def.600)", 600, 100, 1500, 1)
self.MonTourItem:Info("MonTourItem", " ")
self.MonTourItem:Info("MonTourItem", "Version: v"..MoTver.." "..MoTverST)
PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Version: "..MoTver.." "..MoTverST.."</font>"))
PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loaded!</font>"))
self.LOOPON = true
end

function MarCiiiOnTour:Checks()
self.DamageItemData = {3077,3074,3144,3153,3142,3748}
self.Tiamat =     self.DamageItemData[1] --Tiamt
self.Hydra =      self.DamageItemData[2] --Hydra
self.CutBlade =   self.DamageItemData[3] --Bilgewater Cutlass
self.BotrK =      self.DamageItemData[4] --Blade of the Ruined King
self.GhostBlade = self.DamageItemData[5] --Youmuu's Ghostblade
self.TitanHydra = self.DamageItemData[6] --Titanische Hydra
    
self.AllyPairItemData = {3050,3190}
self.Zekees                = self.AllyPairItemData[1] --Zeke's Harbinger / Zekes Herold 
self.LocketoftheIronSolari = self.AllyPairItemData[2] --Locket of the Iron Solari /

self.GoldItemData = {3069,3092,3844,3841,3840,3401}
self.FrostQueensClaim =      self.GoldItemData[2] -- Frost Queen's Claim / Anrecht der Frostkönigin
--self.Murksphere =          self.GoldItemData[3] -- Murksphere / Trübwassersphäre
--self.SwindlersOrb =        self.GoldItemData[4] -- Swindler's Orb / Schwindlerkugel
--self.GlobeofTrust =        self.GoldItemData[5] -- Globe of Trust / Globus des Vertrauens
self.FaceoftheMountain =     self.GoldItemData[6] -- Face of the Mountain / Gebirgspanzer 

self.DefenceItemData = {3157,3139,3140,3056,3060,3143,3800,3069,3222}
self.Zhonya =               self.DefenceItemData[1] -- Zhonyas
self.QSS =                  self.DefenceItemData[2] -- QSS
self.QSS2 =                 self.DefenceItemData[3] -- QSS Fullbuild
self.Ohmwrecker =           self.DefenceItemData[4] --  Ohmzerstörer / Ohmwrecker -Verhindert 3 Sekunden lang, dass nahe gegnerische Türme angreifen können
self.BannerofCommand =      self.DefenceItemData[5] -- Kommandobanner / Banner of Command
self.RanduinsOmen =         self.DefenceItemData[6] -- Randuins Omen / Raduins Range 500
self.RighteousGlory =       self.DefenceItemData[7] -- Redliche Pracht(engl. Righteous Glory) /  Range 700
self.TalismanofAscension =  self.DefenceItemData[8] -- Amulett des Aufstiegs (engl. Talisman of Ascension) /  Range 700
self.MikaelsCrucible =      self.DefenceItemData[9] -- Mikaels Schmelztiegel (engl. Mikael's Crucible) /  Range 750
    
self.MinionItemData = {3512}
self.ZzRotPortal =   self.MinionItemData[1] -- Zz'Rot-Portal (engl. Zz'Rot Portal) - Skillshot - Range 400 --NOT DID YET
    
self.PotionItemData = {2140,2139,2138,2137,2141,2003,2004}
self.ElixirofWrath =    self.PotionItemData[1] --Elixir of Wrath / Elixier des Zorns / RedPot / AD DMG
self.ElixirofSorcery =  self.PotionItemData[2] --Elixir of Sorcery / Elixier der Zauberrei / PurplePot / AP DMG
self.ElixirofIron =     self.PotionItemData[3] --Elixir of Iron / Elixier des Metalls / 25 % increased size , slowing resistance and toughness 
self.ElixirofRuin =     self.PotionItemData[4] --Elixir of Ruin / Elixier des Ruins / Gives +250 Health , 15 % additional damage to towers
--self.CrystalPot =     self.PotionItemData[5] --CrystalPot
--self.HPPot =          self.PotionItemData[6] --HPPOT
--self.ManaPot =        self.PotionItemData[7] --MANAPOT 
    
--self.WardItemData = {2043,3362,2044,3340,3361,2049,2045}
--self.PinkWard =             self.WardItemData[1] --Pink Ward	
--self.GreaterVisionTotem =   self.WardItemData[2] --GreaterVisionTotem - Pink Ward Trinket	
--self.GreenWard =            self.WardItemData[3] --Green Ward	
--self.WardingTotem =         self.WardItemData[4] --WardingTotem - Yellow Trinket
--self.GreaterWardingTotem =  self.WardItemData[5] --GreaterWardingTotem - Yellow Trinket Upgraded		
--self.Sightstone =           self.WardItemData[6] --Blue Stone	
--self.RubySightstone =       self.WardItemData[7] --Red Stone	
    
--self.Antiself.WardItemData = {3341,3364}
--self.SweepingLens = Antiself.WardItemData[1] -- Sweeping Lens - Red Trinket
--self.OraclesLens =  Antiself.WardItemData[2] -- Oracle's Lens - Red Trinket Upgraded   
    
--self.GetVisionItemData = {3342,3363,2047}
--self.ScryingOrb =     self.GetVisionItemData[1] -- Wahrsagerkugel / Scrying Orb - Blue Trinket	
--self.FarsightOrb =    self.GetVisionItemData[2] -- Weitsicht-Kugel / Farsight Orb - Blue Trinket	Upgraded	
--self.OraclesExtract = self.GetVisionItemData[3] -- Elixir des Orakels / Oracle's Extract 
end

function MarCiiiOnTour:Loop2()
if self.MonTourItem.DEB.D:Value() then
local Slot1R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_1)))
local Slot1ID = GetItemID(myHero,ITEM_1)
DrawText("Slot1 Range: "..Slot1R.." ID: "..Slot1ID,30,30,120,0xffffffff);  

local Slot2R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_2)))
local Slot2ID = GetItemID(myHero,ITEM_2)
DrawText("Slot2 Range: "..Slot2R.." ID: "..Slot2ID,30,30,150,0xffffffff);    
 
local Slot3R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_3)))
local Slot3ID = GetItemID(myHero,ITEM_3)
DrawText("Slot3 Range: "..Slot3R.." ID: "..Slot3ID,30,30,180,0xffffffff);  

local Slot4R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_4)))
local Slot4ID = GetItemID(myHero,ITEM_4)
DrawText("Slot5 Range: "..Slot4R.." ID: "..Slot4ID,30,30,210,0xffffffff);
 
local Slot5R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_5)))
local Slot5ID = GetItemID(myHero,ITEM_5)
DrawText("Slot6 Range: "..Slot5R.." ID: "..Slot5ID,30,30,240,0xffffffff);

local Slot6R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_6)))
local Slot6ID = GetItemID(myHero,ITEM_6)
DrawText("Slot7 Range: "..Slot6R.." ID: "..Slot6ID,30,30,270,0xffffffff);

local Slot7R = GetCastRange(myHero,GetItemSlot(myHero,GetItemID(myHero,ITEM_7)))
local Slot7ID = GetItemID(myHero,ITEM_7)
DrawText("Trinket Range: "..Slot7R.." ID: "..Slot7ID,30,30,300,0xffffffff);
end
--myHeroNAME:lower():find("attack")
end

function MarCiiiOnTour:Loop()
--self:Checks()
self.myHeroAARange = GetRange(myHero)
if self.LOOPON == true then 
self:LocketoftheIronSolariAUTO() 
self:ZhonyaAUTO() 
self:QSSAUTO() 
self:ZekeesAUTO()
self:MikaelsCrucibleAUTO() 
self:BannerofCommandAUTO()
if self.MonTourItem.Settings.Combo:Value() or self.MonTourItem.Settings.Harass:Value() then
self:TiHyEnemyAUTO()
self:TitaHyEnemyAUTO()
self:GhostBladeAUTO()
self:ElixirAUTO()
self:BotrKandCutBladeAUTO()
self:FaceoftheMountainAUTO()
self:FrostQueensClaimAUTO()
self:TalismanofAscensionAUTO()
self:RanduinsOmenAUTO()
self:RighteousGloryAUTO()
end
if self.MonTourItem.Settings.LaneClear:Value() then
self:TiHyMinionAUTO() 
self:TiHyJungleAUTO()
self:TitaHyJungleLCAUTO()
end
if self.MonTourItem.Settings.LastHit:Value() then
self:TitaHyMinionAUTO()
self:TitaHyJungleAUTO()
end
end
end

function MarCiiiOnTour:UseItem(ID, team) -- 1 = Enemy 2 = Ally/Myself 3 = Minion 4 = Jungle
  if self.MENUON == true and self.LOOPON == false then
    if (ID == self.Tiamat or ID == self.Hydra or ID == self.TitanHydra or ID == Tiamat) and  team == 1 then
      self:TiHyEnemyAUTO()
      self:TitaHyEnemyAUTO()
    end
    if (ID == self.Tiamat or ID == self.Hydra or ID == Tiamat) and  team == 3 then
      self:TiHyMinionAUTO()
    end
    if (ID == self.TitanHydra or ID == TiHydra) and  team == 3 then
      self:TitaHyMinionAUTO()
    end  
    if (ID == self.Tiamat or ID == self.Hydra or ID == Tiamat) and  team == 4 then
      self:TiHyJungleAUTO()
    end
    if (ID == self.TitanHydra or ID == TiHydra) and  team == 4 then
      self:TitaHyJungleAUTO() GoS:DelayAction(function() self:TitaHyJungleLCAUTO() end, 250)      
    end   
    
    if (ID == self.CutBlade or ID == self.BotrK or ID == CutNBork) and  team == 1 then
      self:BotrKandCutBladeAUTO()     
    end   
    
    if (ID == self.GhostBlade or ID == Ghost) and  team == 1 then
      self:GhostBladeAUTO()     
    end  
    
    if (ID == self.Zekees or ID == Zeke) and  team == 2 then
      self:ZekeesAUTO()    
    end
    
    if (ID == self.LocketoftheIronSolari or ID == Locket) and  team == 2 then
      self:LocketoftheIronSolariAUTO()    
    end
    
    if (ID == self.FrostQueensClaim or ID == Frost) and  team == 1 then
      self:FrostQueensClaimAUTO()    
    end 
    
    if (ID == self.FaceoftheMountain or ID == Face) and  team == 1 then
      self:FaceoftheMountainAUTO()    
    end
    
    if (ID == self.Zhonya or ID == Zhonya) and  team == 1 then
      self:ZhonyaAUTO()    
    end  
    --local OSS = (self.QSS or ID == self.QSS2)
    if (ID == self.QSS or ID == self.QSS2 or ID == QSS) and  team == 1 then
      self:QSSAUTO()     
    end  
    
    if (ID == self.BannerofCommand or ID == Banner) and  team == 3 then
      self:BannerofCommandAUTO()    
    end  
    
    if (ID == self.RanduinsOmen or ID == Randuins) and  team == 1 then
      self:RanduinsOmenAUTO()    
    end 
    
    if (ID == self.RighteousGlory or ID == Righteous) and  team == 2 then
      self:RighteousGloryAUTO()    
    end  
    
    if (ID == self.TalismanofAscension or ID == Talisman) and  team == 2 then
      self:TalismanofAscensionAUTO()    
    end    
    
    if (ID == self.MikaelsCrucible or ID == Mikaels) and  team == 2 then
      self:MikaelsCrucibleAUTO()    
    end  
    
    if (ID == self.ElixirofWrath or ID == self.ElixirofSorcery or ID == self.ElixirofIron or ID == self.ElixirofRuin or ID == Elixir) and  team == 1 then
      self:ElixirAUTO()    
    end 
  end 
  if self.MENUON == false then
    self:LoopOff2()
    if (ID == self.Tiamat or ID == self.Hydra or ID == self.TitanHydra or ID == Tiamat) and  team == 1 then
      self:TiHyEnemyUse()
      self:TitaHyEnemyUse()
    end
    if (ID == self.Tiamat or ID == self.Hydra or ID == Tiamat) and  team == 3 then
      self:TiHyMinionUse()
    end
    if (ID == self.TitanHydra or ID == TiHydra) and  team == 3 then
      self:TitaHyMinionUse()
    end  
    if (ID == self.Tiamat or ID == self.Hydra or ID == Tiamat) and  team == 4 then
      self:TiHyJungleUse()
    end
    if (ID == self.TitanHydra or ID == TiHydra) and  team == 4 then
      self:TitaHyJungleUse() GoS:DelayAction(function() self:TitaHyJungleLCUse() end, 250)      
    end
    
    if (ID == self.BotrK or ID == BotrK) and  team == 1 then
      self:BotrKUse()     
    end
    if (ID == self.CutBlade or ID == CutBlade) and  team == 1 then
      self:CutBladeUse()     
    end     
    
    if (ID == self.GhostBlade or ID == Ghost) and  team == 1 then
      self:GhostBladeUse()     
    end  
    
    if (ID == self.Zekees or ID == Zeke) and  team == 2 then
      self:ZekeesUse()    
    end
    
    if (ID == self.LocketoftheIronSolari or ID == Locket) and team == 2 then
      self:LocketoftheIronSolariUse()    
    end
    
    if (ID == self.FrostQueensClaim or ID == Frost) and  team == 1 then
      self:FrostQueensClaimUse()    
    end 
    
    if (ID == self.FaceoftheMountain or ID == Face) and  team == 1 then
      self:FaceoftheMountainUse()    
    end
    
    if (ID == self.Zhonya or ID == Zhonya) and  team == 1 then
      self:ZhonyaUse()    
    end  
    --local OSS = (self.QSS or ID == self.QSS2)
    if (ID == self.QSS or ID == self.QSS2 or ID == QSS) and  team == 1 then
      self:QSSUse()     
    end  
    
    if (ID == self.BannerofCommand or ID == Banner) and  team == 3 then
      self:BannerofCommandUse()    
    end  
    
    if (ID == self.RanduinsOmen or ID == Randuins) and  team == 1 then
      self:RanduinsOmenUse()    
    end 
    
    if (ID == self.RighteousGlory or ID == Righteous) and  team == 2 then
      self:RighteousGloryUse()    
    end  
    
    if (ID == self.TalismanofAscension or ID == Talisman) and  team == 2 then
      self:TalismanofAscensionUse()    
    end    
    
    if (ID == self.MikaelsCrucible or ID == Mikaels) and  team == 2 then
      self:MikaelsCrucibleUse()    
    end  
    
    if (ID == self.ElixirofWrath or ID == self.ElixirofSorcery or ID == self.ElixirofIron or ID == self.ElixirofRuin or ID == Elixir) and  team == 1 then
      self:ElixirUse()    
    end 
  end    
end

-------MENU ON
function MarCiiiOnTour:TalismanofAscensionAUTO()
if GetItemSlot(myHero,self.DefenceItemData[8]) >= 1 then 
  if self.MonTourItem.Ally.TalismanofAscension:Value() then
  for _,ally in pairs(Gos:GetAllyHeroes()) do 
    if GoS:ValidTarget(ally, 695) and GoS:AlliesAround(GetOrigin(myHero), 695) <= self.MonTourItem.Ally.TalismanofAscensionR:Value() then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[8]))
      end
    end
  end 
  end
end

function MarCiiiOnTour:RighteousGloryAUTO()
if GetItemSlot(myHero,self.DefenceItemData[7]) >= 1 then
  if self.MonTourItem.Ally.RighteousGlory:Value() then
  for _,ally in pairs(Gos:GetAllyHeroes()) do 
    if GoS:ValidTarget(ally, 695) and GoS:AlliesAround(GetOrigin(myHero), 695) <= self.MonTourItem.Ally.RighteousGloryR:Value() then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[7]))
    end
  end
  end 
end
end

function MarCiiiOnTour:RanduinsOmenAUTO()
if GetItemSlot(myHero, self.DefenceItemData[6]) >= 1 then
  if self.MonTourItem.Items.RanduinsOmen:Value() then
    for i,target in pairs(Gos:GetEnemyHeroes()) do
      if GoS:ValidTarget(target, 495) and GoS:EnemiesAround(GetOrigin(myHero), 500) <= self.MonTourItem.Items.RanduinsOmenR:Value() then 
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DefenceItemData[6]))
      end 
    end
  end
end
end

function MarCiiiOnTour:FrostQueensClaimAUTO()
 if GetItemSlot(myHero, self.GoldItemData[2]) >= 1 then
    if (self.MonTourItem.Items.FrostQueensClaimCombo:Value() and self.MonTourItem.Settings.Combo:Value()) or (self.MonTourItem.Items.FrostQueensClaimHarass:Value() and self.MonTourItem.Settings.Harass:Value()) then
      for i,target in pairs(Gos:GetEnemyHeroes()) do
        if GoS:ValidTarget(target, 800) then
        self.Pre = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 650, 250, 800, 60, false, true)
         CastSkillShot(GetItemSlot(myHero,self.GoldItemData[2]),Pre.PredPos.x,Pre.PredPos.y,Pre.PredPos.z)
        end  
      end
    end
 end   
end

function MarCiiiOnTour:BannerofCommandAUTO()
if GetItemSlot(myHero, self.DefenceItemData[5]) >= 1 then  
    if self.MonTourItem.Def.BannerofCommand:Value() then
  for i,minion in pairs(GoS:GetAllMinions(MINION_ALLY)) do
      if GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Super")) and self.MonTourItem.Def.BannerofCommandSu:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))

      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Siege")) and self.MonTourItem.Def.BannerofCommandSi:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))

      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Ranged")) and self.MonTourItem.Def.BannerofCommandCa:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))
         
      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Melee")) and self.MonTourItem.Def.BannerofCommandMe:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))          
--      if GoS:ValidTarget(minion, 300) then
--           Slot8R = GetObjectName(minion)
--          Slot8ID = GetObjectType(minion)
--          DrawText("MinionName: "..Slot8R.." ID: "..Slot8ID,30,30,350,0xffffffff);
      end
  end
end
end
end 

function MarCiiiOnTour:TiHyEnemyAUTO()
if (GetItemSlot(myHero, self.DamageItemData[1]) >= 1 or GetItemSlot(myHero, self.DamageItemData[2]) >= 1) then 
    if self.MonTourItem.Items.TiHyM:Value() then
 for i,target in pairs(Gos:GetEnemyHeroes()) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 and GoS:ValidTarget(target, 550) then --tiamat
        if GoS:GetDistance(target) < 385 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
      end  
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 and GoS:ValidTarget(target, 550) then --hydra
        if GoS:GetDistance(target) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
        end
      end
  end
 end
end 
end

function MarCiiiOnTour:TiHyMinionAUTO()
if (GetItemSlot(myHero, self.DamageItemData[1]) >= 1 or GetItemSlot(myHero, self.DamageItemData[2]) >= 1) then
    if self.MonTourItem.Items.TiHyM:Value() then
 for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 and GoS:ValidTarget(minion, 550) and MarCiiiOnTour:MinionAround(GetOrigin(myHero), 400) >= self.MonTourItem.Items.TiHyMA:Value()  then --tiamat
        if GoS:GetDistance(minion) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
      end  
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 and GoS:ValidTarget(minion, 550) and MarCiiiOnTour:MinionAround(GetOrigin(myHero), 400) >= self.MonTourItem.Items.TiHyMA:Value() then --hydra
        if GoS:GetDistance(minion) < 400 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
        end
      end
  end   
end
end
end 

function MarCiiiOnTour:TiHyJungleAUTO()
if (GetItemSlot(myHero, self.DamageItemData[1]) >= 1 or GetItemSlot(myHero, self.DamageItemData[2]) >= 1) then   
  if self.MonTourItem.Items.TiHyM:Value() then
     for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 and GoS:ValidTarget(minion, 500) then --tiamat
        if GoS:GetDistance(minion) <= self.myHeroAARange+10 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
      end  
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 and GoS:ValidTarget(minion, 500) then --hydra
        if GoS:GetDistance(minion) <= self.myHeroAARange+10 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
        end
      end
  end   
end
end
end 

function MarCiiiOnTour:TitaHyEnemyAUTO()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then 
if self.MonTourItem.Items.TiHy:Value() then
 for i,target in pairs(Gos:GetEnemyHeroes()) do
    if GoS:ValidTarget(target, self.myHeroAARange+150) then --tihydra
        if GoS:GetDistance(target) <= self.myHeroAARange+100 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(target) end, 100)
        end
    end  
  end   
end
end
end

function MarCiiiOnTour:TitaHyMinionAUTO()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then  
if self.MonTourItem.Items.TiHyM:Value() then
 for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0 
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
    if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end       
    end  
  end
  end
end
end 


function MarCiiiOnTour:TitaHyJungleAUTO()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then
  if self.MonTourItem.Items.TiHyM:Value() then
 for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0  
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
    if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end       
    end  
  end  
  end
end
end 

function MarCiiiOnTour:TitaHyJungleLCAUTO()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then
if self.MonTourItem.Items.TiHyM:Value() then
 for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0 
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
local Jungle = GetObjectName(minion) == "SRU_Baron" or GetObjectName(minion) == "SRU_Dragon" or GetObjectName(minion) == "SRU_Blue" or GetObjectName(minion) == "SRU_Red"
local Jungle2 = GetObjectName(minion) == "SRU_Krug" or GetObjectName(minion) == "SRU_Murkwolf" or GetObjectName(minion) == "SRU_Razorbeak" or GetObjectName(minion) == "SRU_Gromp" or GetObjectName(minion) == "Sru_Crab"
  if (Jungle or Jungle2) then
    if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end       
    end  
  end   
end
end
end
end

function MarCiiiOnTour:ElixirAUTO()
for _,target in pairs(Gos:GetEnemyHeroes()) do    
    if GetItemSlot(myHero, self.PotionItemData[1]) >= 1 then
      if self.MonTourItem.Potions.Elixir:Value() then 
        if GoS:ValidTarget(target,  self.MonTourItem.Potions.ElixirR:Value()) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[1]))
        end 
      end  
    end 
    if GetItemSlot(myHero, self.PotionItemData[2]) >= 1 then
      if self.MonTourItem.Potions.Elixir:Value() then 
        if GoS:ValidTarget(target,  self.MonTourItem.Potions.ElixirR:Value()) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[2]))
        end 
      end  
    end
    if GetItemSlot(myHero, self.PotionItemData[3]) >= 1 then
      if self.MonTourItem.Potions.Elixir:Value() then 
        if GoS:ValidTarget(target,  self.MonTourItem.Potions.ElixirR:Value()) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[3]))
        end 
      end  
    end  
    if GetItemSlot(myHero, self.PotionItemData[4]) >= 1 then
      if self.MonTourItem.Potions.Elixir:Value() then 
        if GoS:ValidTarget(target,  self.MonTourItem.Potions.ElixirR:Value()) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[4]))
        end 
      end  
    end 
end   
end

function MarCiiiOnTour:ZhonyaAUTO()
if GetItemSlot(myHero, self.DefenceItemData[1]) >= 1 then
  if self.MonTourItem.Def.Zhonya:Value() then  
    for _,target in pairs(Gos:GetEnemyHeroes()) do 
      if GoS:ValidTarget(target, self.MonTourItem.Def.ZhonyaR:Value()) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) <= self.MonTourItem.Def.ZhonyaHP:Value() then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DefenceItemData[1]))
      end  
    end 
  end 
end  
end

function MarCiiiOnTour:QSSAUTO()
      local Buff = GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 
      if GetItemSlot(myHero,self.DefenceItemData[2]) >= 1 then
        if self.MonTourItem.Def.QSS:Value() then
        if 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourItem.Def.QSSHP:Value() and Buff then
        CastTargetSpell(myHero, GetItemSlot(myHero,self.DefenceItemData[2]))
      end
      end
      end
      if GetItemSlot(myHero,self.DefenceItemData[3]) >= 1 then
        if self.MonTourItem.Def.QSS:Value() then        
        if 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourItem.Def.QSSHP:Value() and Buff then
        CastTargetSpell(myHero, GetItemSlot(myHero,self.DefenceItemData[3]))
        end
      end
    end
end 

function MarCiiiOnTour:MikaelsCrucibleAUTO()
    if GetItemSlot(myHero,self.DefenceItemData[9]) >= 1 then
    for _,ally in pairs(Gos:GetAllyHeroes()) do 
    if GoS:ValidTarget(ally, 700) then
      local Buff = GotBuff(ally, "rocketgrab2") > 0 or GotBuff(ally, "charm") > 0 or GotBuff(ally, "fear") > 0 or GotBuff(ally, "flee") > 0 or GotBuff(ally, "snare") > 0 or GotBuff(ally, "taunt") > 0 or GotBuff(ally, "suppression") > 0 or GotBuff(ally, "stun") > 0 or GotBuff(ally, "zedultexecute") > 0 or GotBuff(ally, "summonerexhaust") > 0 
      if self.MonTourItem.Ally.MikaelsCrucible:Value() and 100*GetCurrentHP(ally)/GetMaxHP(ally) < self.MonTourItem.Ally.MikaelsCrucibleHP:Value() and Buff then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[9]))
      end
    end
    end
    end  
end

function MarCiiiOnTour:BotrKandCutBladeAUTO()
for _,target in pairs(Gos:GetEnemyHeroes()) do  
if GetItemSlot(myHero, self.DamageItemData[4]) >= 1 then    
    if self.MonTourItem.Items.useBork:Value() then      
      if GoS:ValidTarget(target, 550) then
        if 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourItem.Items.borkmyhp:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) > self.MonTourItem.Items.borkehp:Value() then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[4]))
        end         
      end  
    end
end    
if GetItemSlot(myHero, self.DamageItemData[3]) >= 1 then
    if self.MonTourItem.Items.useCut:Value() then  
      if GoS:ValidTarget(target, 550) then
        if 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourItem.Items.CutBlademyhp:Value() and 100*GetCurrentHP(target)/GetMaxHP(target) > self.MonTourItem.Items.CutBladeehp:Value() then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[3]))
        end        
      end  
    end 
end
end
end

function MarCiiiOnTour:GhostBladeAUTO()
if GetItemSlot(myHero, self.DamageItemData[5]) >= 1 then 
  if self.MonTourItem.Items.ghostblade:Value() then
    for _,target in pairs(Gos:GetEnemyHeroes()) do   
      if GoS:ValidTarget(target, self.MonTourItem.Items.ghostbladeR:Value()) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[5]))
      end  
    end
  end
end
end  

function MarCiiiOnTour:LocketoftheIronSolariAUTO()
  if GetItemSlot(myHero, self.AllyPairItemData[2]) >= 1 then
    if self.MonTourItem.Ally.LocketoftheIronSolari:Value() then
      for _,ally in pairs(Gos:GetAllyHeroes()) do
        if GoS:ValidTarget(target, self.MonTourItem.Ally.LocketoftheIronSolari:ValueR()) and GoS:ValidTarget(ally, 690) and 100*GetCurrentHP(ally)/GetMaxHP(ally) < self.MonTourItem.Ally.LocketoftheIronSolariHP:Value() then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.AllyPairItemData[2]))
        end
      end 
      for _,target in pairs(Gos:GetEnemyHeroes()) do 
        if GoS:ValidTarget(target, self.MonTourItem.Ally.LocketoftheIronSolari:ValueR()) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < self.MonTourItem.Ally.LocketoftheIronSolariHPME:Value() then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.AllyPairItemData[2]))
        end       
      end 
    end
  end
end  

function MarCiiiOnTour:FaceoftheMountainAUTO() 
if GetItemSlot(myHero, self.GoldItemData[6]) >= 1 then  
if self.MonTourItem.Ally.FaceoftheMountain:Value() then
  for _,target in pairs(Gos:GetEnemyHeroes()) do   
  for _,ally in pairs(Gos:GetAllyHeroes()) do 
      if GoS:ValidTarget(target, self.MonTourItem.Ally.FaceoftheMountainR:Value()) and GoS:ValidTarget(ally, 600) and 100*GetCurrentHP(ally)/GetMaxHP(ally) <= self.MonTourItem.Ally.FaceoftheMountainHP:Value() then
         CastTargetSpell(ally, GetItemSlot(myHero, self.GoldItemData[6]))
      end  
    end
  end
end
end
end  

function MarCiiiOnTour:ZekeesAUTO() 
 if GetItemSlot(myHero, self.AllyPairItemData[1]) >= 1 then
  if self.MonTourItem.Ally.Zekees:Value() then
    for _,ally in pairs(Gos:GetAllyHeroes()) do      
      if GoS:ValidTarget(ally, 1000) then
         CastTargetSpell(ally, GetItemSlot(myHero, self.AllyPairItemData[1]))
      end  
    end 
  end
 end
end
   
function MarCiiiOnTour:MinionAround(pos, range)
  self.c = 0
  if pos == nil then return 0 end
  for k,v in pairs(GoS:GetAllMinions(MINION_ENEMY)) do 
    if v and GoS:ValidTarget(v) and GoS:GetDistanceSqr(pos,GetOrigin(v)) < range*range then
      c = c + 1
    end
  end
  return c
end

-------MENU OFF
function MarCiiiOnTour:TalismanofAscensionUse()
if GetItemSlot(myHero,self.DefenceItemData[8]) >= 1 then
  for _,ally in pairs(Gos:GetAllyHeroes()) do 
    if GoS:ValidTarget(ally, 695) then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[8]))
      end
    end
  end  
end

function MarCiiiOnTour:RighteousGloryUse() 
    if GetItemSlot(myHero,self.DefenceItemData[7]) >= 1 then
      for _,ally in pairs(Gos:GetAllyHeroes()) do
      if GoS:ValidTarget(ally, 695) then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[7]))
      end
    end
  end  
end

function MarCiiiOnTour:RanduinsOmenUse()
if GetItemSlot(myHero, self.DefenceItemData[6]) >= 1 then
    for i,target in pairs(Gos:GetEnemyHeroes()) do
    if GoS:ValidTarget(target, 695) then 
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DefenceItemData[6]))
    end 
    end  
 end
end

function MarCiiiOnTour:FrostQueensClaimUse()
if GetItemSlot(myHero, self.GoldItemData[2]) >= 1 then
 for i,target in pairs(Gos:GetEnemyHeroes()) do
      if GoS:ValidTarget(target, 800) then
        self.Pre = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 650, 250, 800, 60, false, true)
         CastSkillShot(GetItemSlot(myHero,self.GoldItemData[2]),Pre.PredPos.x,Pre.PredPos.y,Pre.PredPos.z)
      end  
 end 
 end
end

function MarCiiiOnTour:BannerofCommandUse()
  if GetItemSlot(myHero, self.DefenceItemData[5]) >= 1 then
      for i,minion in pairs(GoS:GetAllMinions(MINION_ALLY)) do
      if GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Super")) and self.MonTourItem.Def.BannerofCommandSu:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))

      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Siege")) and self.MonTourItem.Def.BannerofCommandSi:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))

      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Ranged")) and self.MonTourItem.Def.BannerofCommandCa:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))
         
      elseif GoS:ValidTarget(minion, 1200) and (GetObjectName(minion):find("Melee")) and self.MonTourItem.Def.BannerofCommandMe:Value() then 
         CastTargetSpell(minion, GetItemSlot(myHero, self.DefenceItemData[5]))          
--      if GoS:ValidTarget(minion, 300) then
--           Slot8R = GetObjectName(minion)
--          Slot8ID = GetObjectType(minion)
--          DrawText("MinionName: "..Slot8R.." ID: "..Slot8ID,30,30,350,0xffffffff);
      end
  end
  end
end 

function MarCiiiOnTour:TiHyEnemyUse()
 for i,target in pairs(Gos:GetEnemyHeroes()) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 then
        if GoS:ValidTarget(target, 550) then --tiamat
        if GoS:GetDistance(target) < 385 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
        end
      end  
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 then 
        if GoS:ValidTarget(target, 550) then --hydra
        if GoS:GetDistance(target) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
      end
      end
      end
 end
end

function MarCiiiOnTour:TiHyMinionUse()
 for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 then 
        if GoS:ValidTarget(minion, 550) and MarCiiiOnTour:MinionAround(GetOrigin(myHero), 400) >= self.MonTourItem.Items.TiHyMA:Value()  then --tiamat
        if GoS:GetDistance(minion) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
        end
      end  
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 then 
        if GoS:ValidTarget(minion, 550) and MarCiiiOnTour:MinionAround(GetOrigin(myHero), 400) >= self.MonTourItem.Items.TiHyMA:Value() then --hydra
        if GoS:GetDistance(minion) < 400 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
      end
      end
      end  
end
end 

function MarCiiiOnTour:TiHyJungleUse()
   for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
      if GetItemSlot(myHero, self.DamageItemData[1]) >= 1 then 
        if GoS:ValidTarget(minion, 500) then --tiamat
        if GoS:GetDistance(minion) < 300 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[1]))
        end
        end
      end
      if GetItemSlot(myHero, self.DamageItemData[2]) >= 1 then 
        if GoS:ValidTarget(minion, 500) then --hydra
        if GoS:GetDistance(minion) < 300 then
        CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[2]))
      end
      end
      end  
end
end 

function MarCiiiOnTour:TitaHyEnemyUse()
 if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then 
 for i,target in pairs(Gos:GetEnemyHeroes()) do
    if GoS:ValidTarget(target, self.myHeroAARange+150) then --tihydra
        if GoS:GetDistance(target) <= self.myHeroAARange+100 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(target) end, 100)
        end
    end    
end
end

function MarCiiiOnTour:TitaHyMinionUse()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then
 for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0 
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
    if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end       
    end 
  end
  end
end
end 


function MarCiiiOnTour:TitaHyJungleUse()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then  
 for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0  
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
    if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end       
    end 
    end
end
end 

function MarCiiiOnTour:TitaHyJungleLCUse()
if GetItemSlot(myHero, self.DamageItemData[6]) >= 1 then
  for i,minion in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
local Dmg = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.1) --or 0 
local Dmg2 = GetBonusDmg(myHero)+GetBaseDamage(myHero)+40+(GetMaxHP(myHero)*0.01) --or 0 
local Damage = GoS:CalcDamage(myHero, minion, Dmg, 0)
local Damage2 = GoS:CalcDamage(myHero, minion, Dmg2, 0)
local Jungle = GetObjectName(minion) == "SRU_Baron" or GetObjectName(minion) == "SRU_Dragon" or GetObjectName(minion) == "SRU_Blue" or GetObjectName(minion) == "SRU_Red"
local Jungle2 = GetObjectName(minion) == "SRU_Krug" or GetObjectName(minion) == "SRU_Murkwolf" or GetObjectName(minion) == "SRU_Razorbeak" or GetObjectName(minion) == "SRU_Gromp" or GetObjectName(minion) == "Sru_Crab"
      if (Jungle or Jungle2) then
      if GoS:ValidTarget(minion, self.myHeroAARange+150) then --tihydra
      if GetCurrentHP(minion) < Damage then
        if GoS:GetDistance(minion) <= self.myHeroAARange+50 then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      elseif GetCurrentHP(minion) < Damage2 and CanUseSpell(myHero,GetItemSlot(myHero, self.DamageItemData[6])) ~= READY then
        if GoS:GetDistance(minion) <= self.myHeroAARange then
         CastSpell(GetItemSlot(myHero, self.DamageItemData[6])) GoS:DelayAction(function() AttackUnit(minion) end, 100)
        end
      end
      end
      end  
  end   
end
end 

function MarCiiiOnTour:ElixirUse() 
      if GetItemSlot(myHero, self.PotionItemData[1]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[1]))
      end  
      if GetItemSlot(myHero, self.PotionItemData[2]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[2]))
      end  
      if GetItemSlot(myHero, self.PotionItemData[3]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[3]))
      end   
      if GetItemSlot(myHero, self.PotionItemData[4]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.PotionItemData[4]))
      end    
end

function MarCiiiOnTour:ZhonyaUse()
  --self.target = GetCurrentTarget()
      if GetItemSlot(myHero, self.DefenceItemData[1]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DefenceItemData[1]))
      end   
end

function MarCiiiOnTour:QSSUse()
      local Buff = GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 
      if GetItemSlot(myHero,self.DefenceItemData[2]) >= 1 then 
        if Buff then
        CastTargetSpell(myHero, GetItemSlot(myHero,self.DefenceItemData[2]))
        end
      end
      if GetItemSlot(myHero,self.DefenceItemData[3]) >= 1 then
        if Buff then
        CastTargetSpell(myHero, GetItemSlot(myHero,self.DefenceItemData[3]))
        end
      end
end 

function MarCiiiOnTour:MikaelsCrucibleUse()
  for _,ally in pairs(Gos:GetAllyHeroes()) do 
    if GetItemSlot(myHero,self.DefenceItemData[9]) >= 1 then
      Buff = GotBuff(ally, "rocketgrab2") > 0 or GotBuff(ally, "charm") > 0 or GotBuff(ally, "fear") > 0 or GotBuff(ally, "flee") > 0 or GotBuff(ally, "snare") > 0 or GotBuff(ally, "taunt") > 0 or GotBuff(ally, "suppression") > 0 or GotBuff(ally, "stun") > 0 or GotBuff(ally, "zedultexecute") > 0 or GotBuff(ally, "summonerexhaust") > 0 
      if GoS:ValidTarget(ally, 700) and Buff then
        CastTargetSpell(ally, GetItemSlot(myHero,self.DefenceItemData[9]))
      end
    end
  end  
end

function MarCiiiOnTour:BotrKUse()      
      if GetItemSlot(myHero, self.DamageItemData[4]) >= 1 then 
        for _,target in pairs(Gos:GetEnemyHeroes()) do
        if GoS:ValidTarget(target, 550) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[4]))       
      end 
      end
end
end
function MarCiiiOnTour:CutBladeUse()   
      if GetItemSlot(myHero, self.DamageItemData[3]) >= 1 then 
        for _,target in pairs(Gos:GetEnemyHeroes()) do  
        if GoS:ValidTarget(target, 550) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[3]))
         end
      end  
end
end

function MarCiiiOnTour:GhostBladeUse()   
      if GetItemSlot(myHero, self.DamageItemData[5]) >= 1 then
      for _,target in pairs(Gos:GetEnemyHeroes()) do
      if GoS:ValidTarget(target, 550) then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.DamageItemData[5]))
      end 
      end
end
end  

function MarCiiiOnTour:LocketoftheIronSolariUse()
  --self.target = GetCurrentTarget()
      if GetItemSlot(myHero, self.AllyPairItemData[2]) >= 1 then
         CastTargetSpell(myHero, GetItemSlot(myHero, self.AllyPairItemData[2]))
      end      
end 

function MarCiiiOnTour:FaceoftheMountainUse() 
  --self.target = GetCurrentTarget()   
      if GetItemSlot(myHero, self.GoldItemData[6]) >= 1 then
          for _,ally in pairs(Gos:GetAllyHeroes()) do 
      if GoS:ValidTarget(ally, 600) then
         CastTargetSpell(ally, GetItemSlot(myHero, self.GoldItemData[6]))
      end
      end
  end
end  

function MarCiiiOnTour:ZekeesUse()  
      if GetItemSlot(myHero, self.AllyPairItemData[1]) >= 1 then
        for _,ally in pairs(Gos:GetAllyHeroes()) do
      if GoS:ValidTarget(ally, 1000) then
         CastTargetSpell(ally, GetItemSlot(myHero, self.AllyPairItemData[1]))
      end 
      end
  end
end  

function MarCiiiOnTour:LoopOff()
GoS:DelayAction(function()  
  self.LOOPON = false
end, 1100)  
--  GoS:DelayAction(function() 
--  if self.LOOPON == false then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loop OFF - loading...</font>"))
--  end
--  if self.LOOPON == false and self.MENUON == true then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loop OFF is Invalid with MENU ON - loading...</font>"))    
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loop OFF will return ON now - loading...</font>"))
--  --self.LOOPON = true
--end
--end, 400)
end

function MarCiiiOnTour:LoopOff2()
  self.LOOPON = false
end

function MarCiiiOnTour:LoopOn()
GoS:DelayAction(function()  
  self.LOOPON = true
end, 1100)  
--  if self.LOOPON == true then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Loop On - loading...</font>"))
--  end  
end

function MarCiiiOnTour:MenuOn()
  self.MENUON = true
--  if self.MENUON == true then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Menu On - loading...</font>"))
--  end    
end

function MarCiiiOnTour:MenuOff()
  self.MENUON = false
--  GoS:DelayAction(function() 
--  if self.MENUON == false then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Menu OFF - loading...</font>"))
--  end 
--  if self.MENUON == false and self.LOOPON == true then
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Menu OFF is Invalid with Loop ON - loading...</font>"))
--  PrintChat(string.format("<font color='#80F5F5'>[MonTour ItemCaster:]</font> <font color='#EFF0F0'>Menu OFF will return MENU ON now - loading...</font>"))
--  self.MENUON = true
--end 
--end, 400)
end

_G.MoT = MarCiiiOnTour()
_G.mot = _G.MoT
_G.Mot = _G.MoT
_G.MOt = _G.MoT
_G.mOS = _G.MoT
_G.moS = _G.MoT
_G.mOt = _G.MoT
_G.MOt = _G.MoT