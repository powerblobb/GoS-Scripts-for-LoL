--[[

	Name:		Warding Assistant
	Version:	1.1 Final
	Author:		Tiritto

	Changes:
	- New display system for Safe Warding spots.
	- Increased performance while drawing Safe Spots.
  - Added Menu for KeyChanging

	Thread link:	http://gamingonsteroids.com/topic/4136-topic
	GitHub link:	https://github.com/tiritto/GamingOnSteroids/blob/master/wardingAssistant.lua
	
--]]

-- Don't load this script on maps other than Summoners Rift (since it's the only map with wards in the shop)
if GetMapID() == SUMMONERS_RIFT then
  WardingAssistantTritto = Menu("WardingAssistant", "WardingAssistant")
  WardingAssistantTritto:Key("PlaceWard", "Place Ward", string.byte("Z"))
  WardingAssistantTritto:Key("WardModifier", "Ward Modifier", 17)
--  WardingAssistantTritto:Slider("CicleRange", "Ward Cast Range(2xF6)", 2500, 1000, 20000, 1)
  WardingAssistantTritto:Slider("CicleRange", "Ward Circle Range(2xF6)", 2500, 1000, 20000, 1)
	------------------------------------[ SCRIPT DATA ]------------------------------------
	
	--# Global Variables #--
	local myHeroDestination = nil;	-- waypointProc.position;
	local playerPosition = nil;		-- GetOrigin(myHero);
	local cursorPosition = nil;		-- Point(GetMousePos());
	local wardSlot = 0;				-- getWardSlot();

	local lastTick = GetTickCount();-- Script global cooldown. Used to prevent from double-warding from one command.
	local closestToCursor = nil;	-- Used to determine the closest warding stop from the player cursor.
	local closestToCursorRange=nil;	-- Like above.
	local hoveredCircle = nil;		-- Used to determine if player selected any predefinied spots by himself.
	
	
	local queue = {};	-- SafeWard Queue
	local retry = nil;	-- SafeWard Retry Count

	--# Settings #--
	local actionKey = WardingAssistantTritto.PlaceWard:Value()		-- Z
	local modifierKey = WardingAssistantTritto.WardModifier:Value()	-- CTRLWardModifier
	local drawingRange = WardingAssistantTritto.CicleRange:Value()--2500;
	local classicSpotSize = 30;
	local showEnemyTeamSpots = false;
	local spotCircleSize = 30;
	local wardCastRange = 600;
	
	--# Constants #--
	local playerTeam = GetTeam(GetMyHero())/100;
	
	-- Items able to create Green Wards
	local greenWards = {
		3340,	-- Warding Totem (Trinket)
		3361,	-- Greater Warding Totem (Trinket Upgrade)
		2049,	-- Sightstone (Blue Stone)
		2045,	-- Ruby Sightstone (Red Stone)
		2044	-- Stealth Ward (Green Ward)
	}
	
	-- Items able to create Pink Wards
	local pinkWards = {
		2043,	-- Vision Ward
		3362	-- Greater Vision Totem (Trinket)
	}

	-- Warding spots coordinates [Classic]
	local wardingSpots = {
	
		---------------------------
		--# Team-Specific Wards #--
		---------------------------
		
		-- Blue Team (100) --
		{4956,51,2834,1},  -- Base sideEntrance from Red Jungle
		{2697,52,5280,1},  -- Base sideEntrance from Blue Jungle
		{10046,48,6575,1}, -- Middle Lane River Entrance Bush
		
		-- Purple Team (200) --
		
		{3041,95,3068,2},  -- Middle Lane Blue Inhibitor Ward
		
		{9753,52,12071,2}, -- Base sideEntrance from Red Jungle
		{12083,52,9407,2}, -- Base sideEntrance from Blue Jungle
		{9752,-37,6288,2}, -- Middle Lane River Entrance Bush
		
		--------------------------------
		--# PurpleTeam - Blue Jungle #--
		--------------------------------
		
		{11645,51,7035}, -- Blue Entrance Bush
		{11939,52,7434}, -- Blue Entrance Crossroad
		{11890,51,6964}, -- Blue/Frog Base Entrance
		{11703,50,6054}, -- Blue/Frog River Entrance
		{12684,51,5202}, -- Bottom Lane Jungle Bush Entrance
		--{10701,63,8975}, -- Middle Lane Wolves Entrance * This spot needs rework...
		{10140,51,7703}, -- Middle Lane Bush Crossroad
		
		-------------------------------
		--# PurpleTeam - Red Jungle #--
		-------------------------------
		
		-- Universal Spots --
		{7097,54,11353}, -- Red Bush (Right Edge)
		{6343,54,10054}, -- River Crossroad Bush
		{6742,54,9621},  -- River Crossroad
		{4269,51,11752}, -- Tribush
		{5808,52,12640}, -- Krug Bush (Jungle Vision)
		{8976,55,11344}, -- Base Entrance Bush (Left Edge)
		{9445,52,11436}, -- Base Entrance Bush (Right Edge)
		
		-- Unrecommended Spots --
		
		-- Purple Team Recommendations --
		
		-- Blue Team Recommendations --

		-----------------------------
		--# BlueTeam - Red Jungle #--
		-----------------------------
		
		-- Universal Spots --
		{7802,52,3541}, -- Red Bush (Left Edge)
		{6861,52,2985}, -- Red Crosroad Bush (Center)
		{5835,51,3578}, -- Base Entrance Bush (Right Edge)
		{5404,51,3469}, -- Base Entrance Bush (Left Edge)
		{10610,48,3105},-- Tribush
		{9211,50,2281}, -- Krug Camp Brush
		{6689,48,4718}, -- Raptors Bush
		{8490,52,4926}, -- River Crossroad
		{8117,53,5314}, -- River Crossroad Bush
		
		-- Purple Team Recommendations --
		{6550,50,3088,2}, -- Red Crossroad Bush (Left Edge)
		
		-- Blue Team Recommendations --
		{7143,52,3076,1}, -- Red Crossroad Bush (Right Edge)
		
		-- Unrecommended Spots --
		
		-----------------------------
		--# BlueTeam - Blue Jungle #--
		-----------------------------
		
		{3222,51,7879}, -- Blue Bush
		{3443,50,8656}, -- Blue River Entrance
		{2822,51,7443}, -- Blue Crossroad
		{5211,-59,8583},-- Jungle River Entrance (Middle Lane Side)
		{4649,50,7247}, -- Jungle River Entrance Crossroad
		{2281,54,10124},-- Tribush (Defensive Ward)
		{2153,59,9703}, -- Tribush (Agressive Ward)
		
		--# River and Lanes #--
		
		-- Universal Spots --
		{13453,51,2820}, -- Bottom Lane Purple-side Bush (Top Edge)
		{13004,51,2216}, -- Bottom Lane Purple-side Bush (Bot Edge)
		{12773,52,1876}, -- Bottom Lane Blue-side Bush (Top Edge)
		{12103,51,1328}, -- Bottom Lane Blue-side Bush (Bot Edge)
		{11127,-71,3810},-- Bottom Lane River Entrance Bush
		{11701,-71,4050}, -- Bottom Lane River Entrance
		{6457,-72,8430}, -- Middle Lane Bush - Top/Left Side
		{8483,-72,6384}, -- Middle Lane Bush - Bot/Right Side
		{2694,52,13546}, -- Top Lane 3rd Bush - Right
		{2252,52,13254}, -- Top Lane 3rd Bush - Left
		{1893,52,13003}, -- Top Lane 2nd Bush - Right
		{1602,52,12790}, -- Top Lane 2nd Bush - Left
		{1392,52,12464}, -- Top Lane 1st Bush - Right
		{1216,52,12044}, -- Top Lane 1st Bush - Left
		{3193,-66,10760},-- Top Lane River Bush
		{9339,-72,5727},  -- Dragon Bush
		{10188,-63,5269}, -- Dragon Entrance from Purple Middle Lane Jungle
		{5104,-72,9152}, -- Baron Bush
		{4102,-72,9857}, -- Baron Entrance
		{4684,-72,10050},-- Baron Den
		
		-- Blue Team Recommendations --
		{14001,52,7127,1}, -- Purple Tier 2 Bottom Tower Bush
		{732,52,14037,1},  -- Purple Tier 2 Top Tower Bush
		{7996,49,842,1},   -- Blue Tier 2 Bottom Tower Bush
		{887,52,8341,1},   -- Blue Tier 2 Top Tower Bush
		{10546,-60,5019,1}, -- Dragon Entrance from Blue
		
		-- Purple Team Recommendations --
		{14005,52,6786,2}, -- Purple Tier 2 Bottom Tower Bush
		{9030,52,14039,2}, -- Purple Tier 2 Top Tower Bush
		{7629,49,830,2},   -- Blue Tier 2 Bottom Tower Bush
		{896,52,7930,2}    -- Blue Tier 2 Top Tower Bush
	};
	
	-- Warding spots coordinates [Safe]
	local safeWardingSpots = {

		--[[{	-- Tribush from Dragon * Not working without mastery atm...
			["scoutRequired"]	= false,
			[3]	= {10072,-71.24,3908},
			[1]	= {10297.93,49.03,3358.59},
			[2]	= {10273.9,49.03,3257.76}
		} --]]
		
		{	-- Trisbush from Nashor
			[1]	= {4627,-71,11311},
			[2]	= {4473,51,11457},
			[3]	= {4724,-71,10856}
		},
		
		{	-- Blue Top -> Solo Bush
			[1]	= {3078,54,10868},
			[2]	= {3078,-67,10868},
			[3]	= {2824,54,10356}
		},
		
		{	-- Blue Mid -> round Bush
			[1]	= {5132,51,8373},
			[2]	= {5123,-21,8457},
			[3]	= {5474,51,7906}
		},
		
		{	-- Blue Mid -> River Lane Bush
			[1]	= {6202,51,8132},
			[2]	= {6202,-67,8132},
			[3]	= {5874,51,7656}
		},
		
		{	-- Blue Lizard -> Dragon Pass Bush
			[1]	= {8400,53,4657},
			[2]	= {8523,51,4707},
			[3]	= {8022,53,4258}
		},
		
		{	-- Purple Mid -> Round Bush
			[1]	= {9703,52,6589},
			[2]	= {9823,23,6507},
			[3]	= {9372,52,7008}
		},
		
		{	-- Purple Mid -> River Round Bush
			[1]	= {8705,53,6819},
			[2]	= {8718,95,6764},
			[3]	= {9072,53,7158}
		},
		
		{	-- Purple Bottom -> Solo Bush
			[1]	= {12353,51,4031},
			[2]	= {12023,-66,3757},
			[3]	= {12422,51,4508}
		},
		
		{	-- PPurple Lizard -> Nashor Pass Bush
			[1]	= {6370,56,10359},
			[2]	= {6273,53,10307},
			[3]	= {6824,56,10656}
		},
		
		{	-- Blue Golem -> Blue Lizard
			[1]	= {8163,51,3436},
			[2]	= {8163,51,3436},
			[3]	= {8272,51,2908}
		},
		
		{	-- Red Golem -> Red Lizard
			[1]	= {6678,56,11477},
			[2]	= {6678,53,11477},
			[3]	= {6574,56,12006}
		},
		
		{	-- Blue Top Side Brush
			[1]	= {2302,52,10874},
			[2]	= {2773,-71,11307},
			[3]	= {1774,52,10756}
		},
		
		{	-- Mid Lane Death Brush
			[1]	= {5332,-70,8275},
			[2]	= {5123,-21,8457},
			[3]	= {5874,-70,8306}
		},
		
		{	-- Mid Lane Death Brush Right Side
			[1]	= {9540,71,6657},
			[2]	= {9773,10,6457},
			[3]	= {9022,-71,6558}
		},
		
		{	-- Blue Inner Turret Jungle
			[1]	= {6849,50,2252},
			[2]	= {6723,52,2507},
			[3]	= {6874,50,1708}
		},
		
		{	-- Purple Inner Turret Jungle
			[1]	= {8128,52,12658},
			[2]	= {8323,56,12457},
			[3]	= {8122,52,13206}
		}
		
	};
	
	-------------------------------------[ FUNCTIONS ]-------------------------------------
	
	-- Distance calculator
	local function GetDistance(p1,p2)
		p1 = GetOrigin(p1) or p1;
		p2 = GetOrigin(p2) or p2;
		local dx = p1.x - p2.x;
		local dz = p1.z - p2.z;
		return math.sqrt(dx*dx + dz*dz);
	end;
	
	-- Coordinates container
	class "Point"
		function Point:__init(x, y, z)
			local pos = GetOrigin(x) or type(x) ~= "number" and x or nil;
			self.x = pos and pos.x or x;
			self.y = pos and pos.y or y;
			self.z = pos and pos.z or z;
		end;
	
	-- Circle object
	class "Circle"
		function Circle:__init(x, y, z, r, c)
			self.x = x;
			self.y = y;
			self.z = z;
			self.c = c or 0xffffffff;
			self.r = r or 30;
		end;
		
		function Circle:setColor(c) self.c = c or 0xffffffff; end;
		function Circle:setRange(r) self.r = r or 30; end;
		function Circle:getDistance(pos) return GetDistance(Point(self.x,self.y,self.z),pos); end;
		function Circle:mouseOver(range) return range < self.r;	end; 
		function Circle:draw() DrawCircle(self.x,self.y,self.z,self.r,0,0,self.c); end;
	
	-- Warding mechanics
	local function putWard(wardSlot,clickPos,heroPos)
	
		-- Just CastSkillShot for classic wards
		if not(heroPos) then CastSkillShot(wardSlot,clickPos);
		
		-- If you're in range to CastSkillShot for safe spot - Do it.
		elseif GetDistance(clickPos,playerPosition) < 600 then -- Ward casting range is 600.
			CastSkillShot(wardSlot,clickPos);
	
		-- If you're of out range for safeSpot - Move to this spot.
		elseif myHeroDestination ~= heroPos then
			MoveToXYZ(heroPos);		-- Move to the destination point and start queue
			myHeroDestination = heroPos;
			queue[1] = clickPos;	-- Remember where you need to click
			queue[2] = heroPos.x;	-- and where you have to be
			queue[3] = wardSlot;	-- and what kind of ward it is.
		end;
	end;
	
	-- Safeward queue
	local function checkQueue(wardSlot)
		if next(queue) then
		
			-- Destination point doesn't match - Operation cancelled
			if myHeroDestination.x ~= queue[2] then
				queue={};
			
			-- You have reach the distance for CastSkillShot
			elseif GetDistance(queue[1],playerPosition) < 600 then
				putWard(queue[3],queue[1]);
				MoveToXYZ(playerPosition);
				queue={};
			end;
		end;
	end;
	
	-----------------------------------[ INITALIZATION ]-----------------------------------
	
	-- Initialize classic warding spot circles
	local classicWardSpot = {};
	for i=1, #wardingSpots, 1 do
		if not(wardingSpots[i][4])
		or playerTeam == wardingSpots[i][4]
		or showEnemyTeamSpots then
			table.insert(classicWardSpot, Circle(wardingSpots[i][1],wardingSpots[i][2],wardingSpots[i][3]));
		end;
	end;

	-- Initialize safe warding spot circles
	local safeWardClick = {};
	local safeWardHero = {};
	local safeWardSpot = {};
	for i=1, #safeWardingSpots, 1 do
		--safeWardClick[i] = Circle(safeWardingSpots[i][1][1],safeWardingSpots[i][1][2],safeWardingSpots[i][1][3],5,0xff000000);	-- Circle object [Click Position]	-- No longer required
		--safeWardSpot[i] = Circle(safeWardingSpots[i][2][1],safeWardingSpots[i][2][2],safeWardingSpots[i][2][3],15,0xffff0000);	-- Circle object [Spot Position]	-- No longer required
		safeWardHero[i] = Circle(safeWardingSpots[i][3][1],safeWardingSpots[i][3][2],safeWardingSpots[i][3][3],50,0xffffff00);		-- Circle object [Hero Position]
		safeWardClick[i] = Point(safeWardingSpots[i][1][1],safeWardingSpots[i][1][2],safeWardingSpots[i][1][3]);					-- Point object [Click Position]
		safeWardSpot[i] = Point(safeWardingSpots[i][2][1],safeWardingSpots[i][2][2],safeWardingSpots[i][2][3]);						-- Point object [Spot Position]
	end;

	-- Since all circles are already initialized we dont need those coordinates anymore...
	wardingSpots = nil;
	safeWardingSpots = nil
	
	------------------------------------[ MAIN SCRIPT ]------------------------------------
	OnProcessWaypoint(function(Object,waypointProc)
		if Object == GetMyHero() then
			if waypointProc.index == 1 then
				myHeroDestination = waypointProc.position;
			end;
		end;
	end)

	OnDraw(function(myHero)
		local wardSlot = 0;
		
		-- Serach inventory for warding items [Green Wards]
		if WardingAssistantTritto.WardModifier:Value() == false then
			for i=1, #greenWards, 1 do
				wardSlot = GetItemSlot(myHero,greenWards[i]);
				if wardSlot > 0 and CanUseSpell(myHero, wardSlot) == READY
				then break; end;
			end;
			
		-- Search inventory for warding items [Pink Wards]
		else
			for i=1, #pinkWards, 1 do
				wardSlot = GetItemSlot(myHero,pinkWards[i]);
				if wardSlot > 0 and CanUseSpell(myHero, wardSlot) == READY
				then break; end;
			end;
		end;
	
		-- Disable Warding Assistant when player is not able to put any wards (Performance)
		if wardSlot > 0 then
		
			-- Update crucial variables
			playerPosition = GetOrigin(myHero);
			cursorPosition = GetMousePos();

			
			-- Reset outdated variables
			closestToCursorDistance = 9999999;
			closestToCursor = nil;
			hoveredCircle = nil;
			
			-- Check the queue and complete the tasks in it
			checkQueue(wardSlot);
			
			-- Classic Warding Spots
			for i=1, #classicWardSpot, 1 do
				
				-- Show only nearby spots
				if classicWardSpot[i]:getDistance(playerPosition) < drawingRange then
			
					-- Calculate distance between player cursor and warding spot.
					local cursorDistance = classicWardSpot[i]:getDistance(cursorPosition);
				
					-- Is cursor pointed at this warding spot?
					-- Don't calculate the distance if there's already active circle. [Performance]
					if not(hoveredCircle) and classicWardSpot[i]:mouseOver(cursorDistance) then
						classicWardSpot[i]:setColor(ARGB(255,255,0,0));
						hoveredCircle = i;
					else
						classicWardSpot[i]:setColor(ARGB(255,255,255,255));
					end;
					
					-- Now you can display this spot.
					classicWardSpot[i]:draw();
					
					-- Don't do anything else if some spot is already active. Otherwise check if it was the closest spot from the cursor.
					if not(hoveredCircle) and closestToCursorDistance > cursorDistance then
						closestToCursor = i; -- Don't get full coordinates just yet [Performance]
						closestToCursorDistance = cursorDistance;
					end;
				
				end;
			end;
			
			
			-- Safe Warding Spots
			for i=1, #safeWardSpot, 1 do
				
				-- Show only nearby spots
				if safeWardHero[i]:getDistance(playerPosition) < drawingRange then
				
					-- Is cursor pointed at this warding spot?
					-- Don't calculate the distance if there's already active circle. [Performance]
					if not(hoveredCircle) and safeWardHero[i]:mouseOver(safeWardHero[i]:getDistance(cursorPosition)) then
						safeWardHero[i]:setColor(ARGB(200,255,0,0));
						hoveredCircle = i+100;
						--safeWardSpot[i]:draw();	-- DEBUG
						--safeWardClick[i]:draw();	-- DEBUG
					else
						safeWardHero[i]:setColor(ARGB(100,255,255,0));
					end;
					
					-- Now you can display this spot.
					safeWardHero[i]:draw();
					
					-- Line
					local lineA = WorldToScreen(1,safeWardSpot[i]);
					local lineB = WorldToScreen(1,safeWardHero[i]);
					if lineA.flag and lineB.flag then
						DrawLine(lineA.x,lineA.y,lineB.x,lineB.y,1,ARGB(50,255,255,255));
					end;
				end;
			end;
		
			-- Is actionKey pressed?
			if WardingAssistantTritto.PlaceWard:Value() then--actionKey then
				local currentTick = GetTickCount();
				if currentTick > (lastTick + 1000)	-- Great, but first check if it's not on cooldown (1 second)
				and wardSlot then				-- and check if certain ward type is available?
					if hoveredCircle then
						if hoveredCircle < 100 then
							putWard(wardSlot,classicWardSpot[hoveredCircle]);
						else
							putWard(wardSlot,safeWardClick[hoveredCircle-100],safeWardHero[hoveredCircle-100]);
						end;
					else
						putWard(wardSlot,classicWardSpot[closestToCursor]);
					end;
					lastTick = currentTick;
				end;
			end;
		end;
	end)
end; --Skip this script for all maps except Summoner's Rift
