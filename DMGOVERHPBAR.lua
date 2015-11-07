--MarCiii on Tour´s Damage Over Hp Bar LIB one function all Spells 
--V1.0.0.2

--require('IAC')  
require('Inspired')
myHero = GetMyHero()
--myIAC = IAC()

--unit = GetCurrentTarget()
--Qcheck = nil
--Wcheck = nil
--EWcheck = nil
--Rcheck = nil

function DrawDmgOverHpBar2(Q_AD_DMG, W_AD_DMG, E_AD_DMG, R_AD_DMG, Q_AP_DMG, W_AP_DMG, E_AP_DMG, R_AP_DMG, _Q_, _W_, _E_, _R_, Qcheck, Wcheck, Echeck, Rcheck, RangeOfDraws, HPCOLOR)
rangeofdraws = RangeOfDraws
targetDMG = GetTarget(rangeofdraws, DAMAGE_MAGIC) -- DAMAGE_MAGIC or DAMAGE_PHYSICAL
--QREADYcheck = Qcheck
--WREADYcheck = Wcheck
--EREADYcheck = Echeck
--RREADYcheck = Rcheck
--QDMGAD = Q_AD_DMG
--WDMGAD = W_AD_DMG
--EDMGAD = E_AD_DMG
--RDMGAD = R_AD_DMG
--QDMGMAGIC = Q_MAGIC_DMG
--WDMGMAGIC = W_MAGIC_DMG
--EDMGMAGIC = E_MAGIC_DMG
--RDMGMAGIC = R_MAGIC_DMG
--QWER_AD = QDMGAD + WDMGAD + EDMGAD + RDMGAD
--QWER_MAGIC = QDMGMAGIC + WDMGMAGIC + EDMGMAGIC + RDMGMAGIC
--HPCOLOR = percentToRGBDRAW(percent)

for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == true then --QWER
	--Ready Q + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + W + (E) + R
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)		
	--Ready Q + (W) + E + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + W + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == false then --QWE
	--Ready Q + W + E + (R)
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == true then --QWR
	--Ready Q + W + (E) + R
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == true and _R_ == true then --QER
	--Ready Q + (W) + E + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == true then --WER
	--Ready (Q) + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == false then	--QW
	--Ready Q + W + (E) + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)					
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	end
end
if _Q_ == true and _W_ == false and _E_ == true and _R_ == false then	--QE
	--Ready Q + (W) + E + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == false and _R_ == true then	--QR		
	--Ready Q + (W) + (E) + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)				
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == false then	--WE	
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == false and _R_ == true then --WR
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == true and _R_ == true then --ER
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == true and _W_ == false and _E_ == false and _R_ == false then --Q	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == true and _E_ == false and _R_ == false then --W
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == false and _E_ == true and _R_ == false then --E	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == false and _R_ == true then --R	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
end

function DrawDmgOverHpBar3(Q_AD_DMG, W_AD_DMG, E_AD_DMG, R_AD_DMG, Q_AP_DMG, W_AP_DMG, E_AP_DMG, R_AP_DMG, _Q_, _W_, _E_, _R_, Qcheck, Wcheck, Echeck, Rcheck, RangeOfDraws, HPCOLOR, DMGTyp)
rangeofdraws = RangeOfDraws
targetDMG = GetTarget(rangeofdraws, DMGTyp) -- DAMAGE_MAGIC or DAMAGE_PHYSICAL
--QREADYcheck = Qcheck
--WREADYcheck = Wcheck
--EREADYcheck = Echeck
--RREADYcheck = Rcheck
--QDMGAD = Q_AD_DMG
--WDMGAD = W_AD_DMG
--EDMGAD = E_AD_DMG
--RDMGAD = R_AD_DMG
--QDMGMAGIC = Q_MAGIC_DMG
--WDMGMAGIC = W_MAGIC_DMG
--EDMGMAGIC = E_MAGIC_DMG
--RDMGMAGIC = R_MAGIC_DMG
--QWER_AD = QDMGAD + WDMGAD + EDMGAD + RDMGAD
--QWER_MAGIC = QDMGMAGIC + WDMGMAGIC + EDMGMAGIC + RDMGMAGIC
--HPCOLOR = percentToRGBDRAW(percent)

for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == true then --QWER
	--Ready Q + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + W + (E) + R
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)		
	--Ready Q + (W) + E + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + W + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == false then --QWE
	--Ready Q + W + E + (R)
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == true then --QWR
	--Ready Q + W + (E) + R
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == true and _R_ == true then --QER
	--Ready Q + (W) + E + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == true then --WER
	--Ready (Q) + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == false then	--QW
	--Ready Q + W + (E) + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)					
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	end
end
if _Q_ == true and _W_ == false and _E_ == true and _R_ == false then	--QE
	--Ready Q + (W) + E + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == false and _R_ == true then	--QR		
	--Ready Q + (W) + (E) + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)				
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == false then	--WE	
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == false and _R_ == true then --WR
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == true and _R_ == true then --ER
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == true and _W_ == false and _E_ == false and _R_ == false then --Q	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == true and _E_ == false and _R_ == false then --W
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == false and _E_ == true and _R_ == false then --E	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == false and _R_ == true then --R	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
end

function DrawDmgOverHpBarNC(Q_AD_DMG, W_AD_DMG, E_AD_DMG, R_AD_DMG, Q_AP_DMG, W_AP_DMG, E_AP_DMG, R_AP_DMG, _Q_, _W_, _E_, _R_, RangeOfDraws, HPCOLOR, DMGTyp)
rangeofdraws = RangeOfDraws
targetDMG = GetTarget(rangeofdraws, DMGTyp)
Qcheck = CanUseSpell(myHero,_Q) == READY
Wcheck = CanUseSpell(myHero,_W) == READY
Echeck = CanUseSpell(myHero,_E) == READY
Rcheck = CanUseSpell(myHero,_R) == READY
--QDMGAD = Q_AD_DMG
--WDMGAD = W_AD_DMG
--EDMGAD = E_AD_DMG
--RDMGAD = R_AD_DMG
--QDMGMAGIC = Q_MAGIC_DMG
--WDMGMAGIC = W_MAGIC_DMG
--EDMGMAGIC = E_MAGIC_DMG
--RDMGMAGIC = R_MAGIC_DMG
--QWER_AD = QDMGAD + WDMGAD + EDMGAD + RDMGAD
--QWER_MAGIC = QDMGMAGIC + WDMGMAGIC + EDMGMAGIC + RDMGMAGIC
--HPCOLOR = percentToRGBDRAW(percent)

for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == true then --QWER
	--Ready Q + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready Q + W + E + (R)
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + W + (E) + R
	elseif ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)		
	--Ready Q + (W) + E + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + W + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == true and _R_ == false then --QWE
	--Ready Q + W + E + (R)
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + E_AD_DMG, Q_AP_DMG + W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == true then --QWR
	--Ready Q + W + (E) + R
	if ValidTarget(targetDRAW,rangeofdraws) and Qcheck and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG + R_AD_DMG, Q_AP_DMG + W_AP_DMG + R_AP_DMG),HPCOLOR)				
	--Ready Q + W + (E) + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)				
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == true and _R_ == true then --QER
	--Ready Q + (W) + E + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + E_AD_DMG + R_AD_DMG, Q_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)
	--Ready Q + (W) + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == true then --WER
	--Ready (Q) + W + E + R
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG + R_AD_DMG, W_AP_DMG + E_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + E + (R)
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)	
	--Ready (Q) + W + (E) + R			
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and Rcheck then		
	DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + R
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, 0, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)	
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == true and _E_ == false and _R_ == false then	--QW
	--Ready Q + W + (E) + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + W_AD_DMG, Q_AP_DMG + W_AP_DMG),HPCOLOR)					
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)			
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	end
end
if _Q_ == true and _W_ == false and _E_ == true and _R_ == false then	--QE
	--Ready Q + (W) + E + (R)			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG,  Q_AD_DMG + E_AD_DMG, Q_AP_DMG + E_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == true and _W_ == false and _E_ == false and _R_ == true then	--QR		
	--Ready Q + (W) + (E) + R			
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG + R_AD_DMG, Q_AP_DMG + R_AP_DMG),HPCOLOR)			
	--Ready Q + (W) + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Qcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)				
	--Ready (Q) + (W) + (E) + R		
	elseif ValidTarget(targetDMG,rangeofdraws) and not Qcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == true and _R_ == false then	--WE	
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + E_AD_DMG, W_AP_DMG + E_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == true and _E_ == false and _R_ == true then --WR
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG + R_AD_DMG, W_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Wcheck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Wcheck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == true and _R_ == true then --ER
	--Ready (Q) + W + E + (R)
	if ValidTarget(targetDMG,rangeofdraws) and Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG + R_AD_DMG, E_AP_DMG + R_AP_DMG),HPCOLOR)		
	--Ready (Q) + W + (E) + (R)		
	elseif ValidTarget(targetDMG,rangeofdraws) and Echeck and not Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)
	--Ready (Q) + (W) + E + (R)			
	elseif ValidTarget(targetDMG,rangeofdraws) and not Echeck and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == true and _W_ == false and _E_ == false and _R_ == false then --Q	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Qcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, Q_AD_DMG, Q_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == true and _E_ == false and _R_ == false then --W
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Wcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, W_AD_DMG, W_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
  if _Q_ == false and _W_ == false and _E_ == true and _R_ == false then --E	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Echeck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, E_AD_DMG, E_AP_DMG),HPCOLOR)		
	end
end
end
for _,unit in pairs(GetEnemyHeroes()) do
if _Q_ == false and _W_ == false and _E_ == false and _R_ == true then --R	
	--Ready Q + (W) + (E) + (R)		
	if ValidTarget(targetDMG,rangeofdraws) and Rcheck then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),0,CalcDamage(myHero, targetDMG, R_AD_DMG, R_AP_DMG),HPCOLOR)		
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





