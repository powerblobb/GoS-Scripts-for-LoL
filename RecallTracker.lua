local version = 2

local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = true

  local RecallTracker = Menu("RecallTracker", "RecallTracker")
  RecallTracker:Boolean("RT","RecallTracker ON/OFF",true)
  RecallTracker:Boolean("RTE","Show only Enemys?",true)
  RecallTracker:Boolean("RTFOW","Show only in FOW?",true)
  
OnDraw(function()
	if RecallTracker.RT:Value() then
	local i = 0
	for hero, recallObj in pairs(recalling) do
		local percent=math.floor(GetCurrentHP(recallObj.hero)/GetMaxHP(recallObj.hero)*100)
		local color=percentToRGB(percent)
		local leftTime = recallObj.starttime - GetTickCount() + recallObj.info.totalTime
		
		if leftTime<0 then leftTime = 0 end
		FillRect(x,y+rowHeight*i-2,168,rowHeight,0x50000000)
		if i>0 then FillRect(x,y+rowHeight*i-2,168,1,0xC0000000) end
		
		DrawText(string.format("%s (%d%%)", hero, percent), 14, x+2, y+rowHeight*i, color)
		
		if recallObj.info.isStart then
			DrawText(string.format("%.1fs", leftTime/1000), 14, x+115, y+rowHeight*i, color)
			FillRect(x+169,y+rowHeight*i, barWidth*leftTime/recallObj.info.totalTime,14,0x80000000)
		else
			if recallObj.killtime == nil then
				if recallObj.info.isFinish and not recallObj.info.isStart then
					recallObj.result = "finished"
					recallObj.killtime =  GetTickCount()+2000
				elseif not recallObj.info.isFinish then
					recallObj.result = "cancelled"
					recallObj.killtime =  GetTickCount()+2000
				end
				
			end
			DrawText(recallObj.result, 14, x+115, y+rowHeight*i, color)
		end
		
		if recallObj.killtime~=nil and GetTickCount() > recallObj.killtime then
			recalling[hero] = nil
		end
		
		i=i+1
	end
end  
end)

function percentToRGB(percent) 
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


OnProcessRecall(function(Object,recallProc)
	if RecallTracker.RTE:Value() and GetTeam(GetMyHero())==GetTeam(Object) then return end
	if RecallTracker.RTFOW:Value() and recalling[GetObjectName(Object)] == nil and IsVisible(Object) then return end
	
	rec = {}
	rec.hero = Object
	rec.info = recallProc
	rec.starttime = GetTickCount()
	rec.killtime = nil
	rec.result = nil
	recalling[GetObjectName(Object)] = rec

end)
PrintChat("Recall tracker by Krystian loaded.")
