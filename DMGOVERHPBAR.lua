--MarCiii on Tour´s Damage Over Hp Bar LIB one function all Spells 
--V1.0.0.1

--require('IAC')  
require('Inspired')
myHero = GetMyHero()
--myIAC = IAC()

unit = GetCurrentTarget()
Qcheck = nil
Wcheck = nil
EWcheck = nil
Rcheck = nil

function DMGOVERHPDRAW(Q_AD_DMG, W_AD_DMG, E_AD_DMG, R_AD_DMG, Q_MAGIC_DMG, W_MAGIC_DMG, E_MAGIC_DMG, R_MAGIC_DMG, _Q_, _W_, _E_, _R_, Qcheck, Wcheck, Echeck, Rcheck, RangeOfDraws, HPCOLOR)
rangeofdraws = RangeOfDraws
targetDMG = GetTarget(rangeofdraws, DAMAGE_MAGIC)
QREADY = Qcheck
WREADY = Wcheck
EREADY = Echeck
RREADY = Rcheck
QDMGAD = Q_AD_DMG
WDMGAD = W_AD_DMG
EDMGAD = E_AD_DMG
RDMGAD = R_AD_DMG
QDMGMAGIC = Q_MAGIC_DMG
WDMGMAGIC = W_MAGIC_DMG
EDMGMAGIC = E_MAGIC_DMG
RDMGMAGIC = R_MAGIC_DMG
--HPCOLOR = percentToRGBDRAW(percent)

for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == true then --QWER
	--Ready Q + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and QREADY and WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD + EDMGAD + RDMGAD, QDMGMAGIC + WDMGMAGIC + EDMGMAGIC + RDMGMAGIC),HPCOLOR)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(targetDRAW,rangeofdraws) and QREADY and WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD + EDMGAD, QDMGMAGIC + WDMGMAGIC + EDMGMAGIC),HPCOLOR)
	--Ready Q + W + (E) + R
	elseif ValidTarget(targetDRAW,rangeofdraws) and QREADY and WREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD + RDMGAD, QDMGMAGIC + WDMGMAGIC + RDMGMAGIC),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and WREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD, QDMGMAGIC + WDMGMAGIC),HPCOLOR)		
	--Ready Q + (W) + E + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + EDMGAD + RDMGAD, QDMGMAGIC + EDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  QDMGAD + EDMGAD, QDMGMAGIC + EDMGMAGIC),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + RDMGAD, QDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)
	--Ready (Q) + W + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD + RDMGAD, WDMGMAGIC + EDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD, WDMGMAGIC + EDMGMAGIC),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and not EREADY and RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + RDMGAD, WDMGMAGIC + RDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, EDMGAD + RDMGAD, EDMGMAGIC + RDMGMAGIC),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not WREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == true and _W_ == true and _E_ == true and _R_ == false then --QWE
	--Ready Q + W + E + (R)
	if ValidTarget(targetDRAW,rangeofdraws) and QREADY and WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD + EDMGAD, QDMGMAGIC + WDMGMAGIC + EDMGMAGIC),HPCOLOR)		
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and WREADY and not EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD, QDMGMAGIC + WDMGMAGIC),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + EDMGAD, QDMGMAGIC + EDMGMAGIC),HPCOLOR)
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and not EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)	
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD, WDMGMAGIC + EDMGMAGIC),HPCOLOR)	
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and not EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	end
end
if _Q_ == true and _W_ == true and _E_ == false and _R_ == true then --QWR
	--Ready Q + W + (E) + R
	if ValidTarget(targetDRAW,rangeofdraws) and QREADY and WREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD + RDMGAD, QDMGMAGIC + WDMGMAGIC + RDMGMAGIC),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and WREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD, QDMGMAGIC + WDMGMAGIC),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + RDMGAD, QDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + RDMGAD, WDMGMAGIC + RDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)	
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not WREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == true and _W_ == false and _E_ == true and _R_ == true then --QER
	--Ready Q + (W) + E + R			
	if ValidTarget(targetDMG,rangeofdraws) and QREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + EDMGAD + RDMGAD, QDMGMAGIC + EDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  QDMGAD + EDMGAD, QDMGMAGIC + EDMGMAGIC),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + RDMGAD, QDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, EDMGAD + RDMGAD, EDMGMAGIC + RDMGMAGIC),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == false and _W_ == true and _E_ == true and _R_ == true then --WER
	--Ready (Q) + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD + RDMGAD, WDMGMAGIC + EDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD, WDMGMAGIC + EDMGMAGIC),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and WREADY and not EREADY and RREADY then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + RDMGAD, WDMGMAGIC + RDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and WREADY and not EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not WREADY and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, EDMGAD + RDMGAD, EDMGMAGIC + RDMGMAGIC),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not WREADY and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not WREADY and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == true and _W_ == true and _E_ == false and _R_ == false then	--QW
	--Ready Q + W + (E) + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and QREADY and WREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + WDMGAD, QDMGMAGIC + WDMGMAGIC),HPCOLOR)					
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not WREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)			
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and WREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == true and _W_ == false and _E_ == true and _R_ == false then	--QE
	--Ready Q + (W) + E + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and QREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  QDMGAD + EDMGAD, QDMGMAGIC + EDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	end
end
if _Q_ == true and _W_ == false and _E_ == false and _R_ == true then	--QR		
	--Ready Q + (W) + (E) + R			
	if ValidTarget(targetDMG,rangeofdraws) and QREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD + RDMGAD, QDMGMAGIC + RDMGMAGIC),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and QREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)				
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not QREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)
	end
end
if _Q_ == false and _W_ == true and _E_ == true and _R_ == false then	--WE	
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + EDMGAD, WDMGMAGIC + EDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and WREADY and not EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not WREADY and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	end
end
if _Q_ == false and _W_ == true and _E_ == false and _R_ == true then --WR
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and WREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD + RDMGAD, WDMGMAGIC + RDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and WREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not WREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)		
	end
end
if _Q_ == false and _W_ == false and _E_ == true and _R_ == true then --ER
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD + RDMGAD, EDMGMAGIC + RDMGMAGIC),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and EREADY and not RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not EREADY and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)		
	end
end
  if _Q_ == true and _W_ == false and _E_ == false and _R_ == false then --Q	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and QREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, QDMGAD, QDMGMAGIC),HPCOLOR)		
	end
end
  if _Q_ == false and _W_ == true and _E_ == false and _R_ == false then --W
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and WREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, WDMGAD, WDMGMAGIC),HPCOLOR)		
	end
end
  if _Q_ == false and _W_ == false and _E_ == true and _R_ == false then --E	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and EREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, EDMGAD, EDMGMAGIC),HPCOLOR)		
	end
end
if _Q_ == false and _W_ == false and _E_ == false and _R_ == true then --R	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and RREADY then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, RDMGAD, RDMGMAGIC),HPCOLOR)		
	end
end
end
end

--white = 0xFFFFFF
--yellow = 0xFFFF00
--orange = 0xFFCC00
--pink = 0xFFCCFF

--COLOR_TABLE1 = {
--    ["White"]                       = 0xFFFFFF,
--    ["Yellow1"]                     = 0xFFFFCC,
--    ["Yellow2"]                     = 0xFFFF99,
--    ["Yellow3"]                     = 0xFFFF66,
--    ["Yellow4"]                     = 0xFFFF33,
--    ["Yellow5"]                     = 0xFFFF00,
--    ["Pink1"]                       = 0xFFCCFF,
--    ["Pink2"]                       = 0xFF99FF, 
--    ["Pink3"]                       = 0xFF99CC,    
--    ["Orange1"]                       = 0xFFCCCC,    
--    ["Orange2"]                       = 0xFFCC99,
--    ["Orange3"]                       = 0xFFCC66,    
--    ["Orange4"]                       = 0xFFCC33,
--    ["Orange5"]                       = 0xFFCC00,
--    ["Orange5"]                       = 0xFFCC00,    
--}
--OnLoop(function()
--	percentToRGBDRAW(percent)
--end)
 

--function percentToRGBDRAW(percent) 
--  for _,unit in pairs(GetEnemyHeroes()) do
--		local percent=math.floor(GetCurrentHP(unit)/GetMaxHP(unit)*100)
--	--	local color=percentToRGB(percent)
--  local r, g
--    if percent == 100 then
--        percent = 99 end
		
--    if percent < 50 then
--        r = math.floor(255 * (percent / 50))
--        g = 255
        
----    elseif percent < 10 then
----    r = math.floor(255 * (percent / 10))
----    g = 155    
--    else
--        r = 255
--        g = math.floor(255 * ((50 - percent % 50) / 50))
--    end
	
--    return 0xFF000000+g*0xFFFF+r*0xFF
--  end  
--end





