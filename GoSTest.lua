if GetObjectName(GetMyHero()) ~= "Kayn" then return end

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

PrintChat("Kayn loaded.")
PrintChat("ßy Ali GÖÇMEN")

local mainMenu = Menu("Kayn", "Kayn")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Boolean("useW", "Use W", true)
mainMenu.Combo:Boolean("useE", "Use R", false)
mainMenu.Combo:Boolean("useR", "Use R Only Kill", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
------------------------------------------------------------------


function GetRdmg()

	local totalDmg = 0

	local rLvl = myHero:GetSpellData(_R).level
	if rLvl > 0 then
		local baseDmg = ({ 150, 250, 350 })[rLvl]
		local bonusAd = 1.75
		totalDmg = baseDmg + (bonusAd * GetBonusDmg(myHero))
	end

	return totalDmg
end

-- CalcDamage(myHero, enemy, 0,  (math.max(90*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero),(90*GetCastLevel(myHero,_R)+70+.75*GetBonusDmg(myHero))*2)))

OnTick(function(myHero)
			local enemy = GetCurrentTarget()
	--for i,enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.Combo.Combo1:Value() then
			-- PrintChat(string.format("%f", GetRdmg()))
			if CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, myHero:GetSpellData(_Q).range) then
				-- PrintChat(enemy.name)
				PrintChat(string.format("Q Hazır, Düşman Yakın, Combo Açık Q %f", myHero:GetSpellData(_Q).range))
				CastTargetSpell(enemy,_Q)
			elseif CanUseSpell(myHero,_W) == READY and ValidTarget(enemy, myHero:GetSpellData(_W).range) then
				-- PrintChat(enemy.name)
				PrintChat(string.format("W Hazır, Düşman Yakın, Combo Açık W %f", myHero:GetSpellData(_W).range))
				CastTargetSpell(enemy,_W)
			elseif CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, myHero:GetSpellData(_R).range) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, GetRdmg()) then
				-- PrintChat(enemy.name)
				PrintChat("R Hazır, Düşman Yakın, Combo Açık R")
				CastTargetSpell(enemy,_R)
			end
		end
	--end
end)