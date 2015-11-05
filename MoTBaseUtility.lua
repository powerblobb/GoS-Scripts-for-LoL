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