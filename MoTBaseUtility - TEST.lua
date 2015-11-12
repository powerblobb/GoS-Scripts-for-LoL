local MoTBaseUVersion = "MoTBaseUtility: v1.0 by MarCiii"

class "MoT"
function MoT:__init()
self.recalling = {}
print(MoTBaseUVersion) 
self.MonTourMenu = MenuConfig("MoTHeroTracker", "MoTHeroTracker")
self.MonTourMenu:Boolean("MGUNUSE","Using without Script?", false)
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
self.MonTourMenu:Info("MoTHeroTracker323", "")
self.MonTourMenu:Info("MoTHeroTracker22323", ""..MoTBaseUVersion)
OnTick(function(myHero) self:Tick(myHero) end)
OnDraw(function(myHero) self:Draw(myHero) end)
--OnProcessRecall(function(Object,recallProc) self:ProcessRecall(Object,recallProc) end)
end
 
function MoT:Draw(myHero)
if self.MonTourMenu.MGUNUSE:Value() then  
self:NoteEnemys(0,0,0,0,0,0,0,0,0,0)
self:NoteAllys()
end
--self:OnTick2()
end

function MoT:Tick(myHero)
--self:Missing() 
end

function MoT:OnTick2()
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


--for _,i in pairs(GetEnemyHeroes()) do
-- dmg=0
-- dmg=dmg(q)+dmg(w)+dmg(e)+dmg(rainbow)
-- Heroes[i].dmg=dmg
--end

function MoT:Missing()
local Heroes = {}
local visible = ""
for i,unit in pairs(GetEnemyHeroes()) do
--local hpPercent = math.floor((GetBonusDmg(myHero)+GetBaseDamage(myHero))/GetCurrentHP(unit)*100)
Heroes[i] ={name=GetObjectName(unit),visible=false,object=unit}
end
for i=1,5 do 
 if IsVisible(Heroes[i].object) then
  Heroes[i].visible=true
  return true
 else
  Heroes[i].visible=false
  return false
end
end
--if not IsVisible(unit) and IsObjectAlive(unit)  then
--  Heroes[i].visible = true 
--  visible = "true"
----  print("not IsVisible(unit) and IsObjectAlive(unit) = true")
--  return true
--elseif IsVisible(unit) and IsObjectAlive(unit) then  
--  Heroes[i].visible = false
--  visible = "false"
----  print("IsVisible(unit) and IsObjectAlive(unit) = false")
--  return false
--elseif IsDead(unit) then  
--  Heroes[i].visible = false
--  visible = "false"
----  print("test")
--  return false 
----elseif not IsObjectAlive(unit) and IsObjectAlive(unit) then
----  Heroes.visible = false
----  visible = "false"  
----  hpPercent = 0
----  return false
--end
--return Heroes[i].visible
--print("test")
--print(Heroes.name.." = "..GetObjectName(unit).." - Missing? = "..visible.." - Life: = "..hpPercent.."%")
--end
end

function MoT:Tick(myHero)
self.cpos = GetCursorPos()
end

function MoT:NoteEnemys(check,overall,adQ,apQ,adW,apW,adE,apE,adR,apR) 
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
if overalldmg >= hp and IsObjectAlive(unit) and IsObjectAlive(myHero) and percent > 10 then
  killable = "is 100% killable!"
  killsize = killsize + 4
  if not IsVisible(unit) and self:Missing() == false then
    killable = "is 100% killable(mis?)"
    killsize = killsize - 4
  elseif not IsVisible(unit) and self:Missing() then
    killable = "is Missing!"
    killsize = killsize - 4   
  end
elseif overalldmg < hp and IsObjectAlive(unit) and IsObjectAlive(myHero) and percent > 10 then
  killable = "is "..DMGpercent.."% killable!"
  killsize = killsize + 0
  if not IsVisible(unit) and self:Missing() == false then
    killable = "is "..DMGpercent.."% killable(mis?)"
    killsize = killsize -1
  elseif not IsVisible(unit) and self:Missing() then
    killable = "is Missing!"
    killsize = killsize -1      
  end
elseif overalldmg >= hp and IsObjectAlive(unit) and IsObjectAlive(myHero) and percent <= 10 then
  killable = "is 100% killable!"
  killsize = killsize + 4
  RGB = ARGB(255,255,0,0)
  if not IsVisible(unit) and self:Missing() == false then
    killable = "is 100% killable(mis?)"
    killsize = killsize - 4
    RGB = ARGB(255,255,0,0)
  elseif not IsVisible(unit) and self:Missing() then
    killable = "is Missing!"
    killsize = killsize - 4 
    RGB = ARGB(255,255,0,0)
  end
elseif overalldmg < hp and IsObjectAlive(unit) and IsObjectAlive(myHero) and percent <= 10 then
  killable = "is "..DMGpercent.."% killable!"
  killsize = killsize + 0
  RGB = ARGB(255,255,0,0)
  if not IsVisible(unit) and self:Missing() == false then
    killable = "is "..DMGpercent.."% killable(mis?)"
    killsize = killsize -1
    RGB = ARGB(255,255,0,0)
  elseif not IsVisible(unit) and self:Missing() then
    killable = "is Missing!"
    killsize = killsize -1 
    RGB = ARGB(255,255,0,0)
  end  
elseif not IsObjectAlive(unit) then
killable = "is dead!"
percent = 0
RGB = ARGB(255,139,139,139)
y = 1
killsize = killsize + 3
elseif not IsObjectAlive(myHero) then
killable = "..."
killsize = killsize + 0
end 
end
if check == 0 then
if percent < 4 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "ByeBye!!!"
  killsize = killsize + 6
  RGB = ARGB(255,255,0,0)
elseif percent <= 10 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Health CITICAL!"
  killsize = killsize + 5
  RGB = ARGB(255,255,0,0)
elseif percent >= 10 and percent < 35 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Low Life++!"
  killsize = killsize + 4
elseif percent >= 35 and percent < 50 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Low Life+!"
  killsize = killsize + 4  
elseif percent >= 50 and percent < 70 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Good Life!"
  killsize = killsize + 2
elseif percent >= 70 and percent < 98 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Ready to fight+!"
  killsize = killsize + 1 
elseif percent >= 99 and IsObjectAlive(unit) and IsVisible(unit) then
  killable = "Ready to fight++!"
  killsize = killsize + 0    
elseif not IsObjectAlive(unit) then
killable = "is Dead!"
percent = 0
RGB = ARGB(255,139,139,139)
y = 3
killsize = killsize - 4
elseif not IsVisible(unit) and IsObjectAlive(unit) then
killable = "is Missing!"
killsize = killsize -1 
RGB = ARGB(255,255,255,255)
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

function MoT:NoteAllys()
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
  RGB = ARGB(255,255,0,0)
elseif percent <= 10 and percent >= 4 and IsObjectAlive(unit) then
  killable = "Health CITICAL!"
  killsize = killsize + 5
  RGB = ARGB(255,255,0,0)
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
RGB = ARGB(255,139,139,139)
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
function MoT:percentToRGB(percent) 
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

_G.MoT = MoT()
_G.mot = _G.MoT
_G.Mot = _G.MoT
_G.MOt = _G.MoT

--function MoT:ProcessRecall(Object,recallProc)
--	if GetTeam(GetMyHero())==GetTeam(Object) then return end
----	if self.recalling[GetObjectName(Object)] == nil  and IsVisible(Object) then return end
--	rec = {}
--	rec.hero = Object
--	rec.info = recallProc
--	rec.starttime = GetTickCount()
--	rec.killtime = nil
--	rec.result = nil
--	recalling[GetObjectName(Object)] = rec
--end
--local recalling = {}
--for hero, recallObj in pairs(recalling) do
--local leftTime = recallObj.starttime - GetTickCount() + recallObj.info.totalTime 
--local secondtimer = leftTime/1000
--if leftTime<0 then leftTime = 0 end
--			if recallObj.killtime == nil then
--				if recallObj.info.isFinish and not recallObj.info.isStart then
--					recallObj.result = "finished"
--					recallObj.killtime =  GetTickCount()+2000
--				elseif not recallObj.info.isFinish then
--					recallObj.result = "cancelled"
--					recallObj.killtime =  GetTickCount()+2000
--				end
				
--			end
--end   
--		if recallObj.killtime~=nil and GetTickCount() > recallObj.killtime then
--			recalling[hero] = nil
--		end

--elseif textkiller > GetGameTimer()+2 then
--killable = "is missing!!"
--killsize = killsize + 0
--elseif recallObj.info.isStart then
--killable = secondtimer.." RECALLING"
--killsize = killsize - 2
--elseif recallObj.info.isFinish and not recallObj.info.isStart then
--killable = ""..secondtimer..""..recallObj.result..""
--killsize = killsize - 2
--elseif not recallObj.info.isFinish then
--killable = ""..secondtimer..""..recallObj.result..""
--killsize = killsize - 2

---GetTextArea(""..unitname.." ("..percent..") "..killable.."",self.MonTourMenu.MGUNSIZE:Value())/2
--GetTextArea("No Target found",14)/2