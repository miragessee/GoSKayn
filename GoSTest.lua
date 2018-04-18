if GetObjectName(GetMyHero()) ~= "Kayn" then return end

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

PrintChat("Kayn loaded.")
PrintChat("ßy miragessee")

local mainMenu = Menu("Kayn", "Kayn")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Boolean("useW", "Use W", true)
mainMenu.Combo:Boolean("useE", "Use R", false)
mainMenu.Combo:Boolean("useR", "Use R Only Kill", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
------------------------------------------------------------------

function Combo()

	local qReady = Menu.Combo.useQ:Value() and Utils:IsReady(_Q)
	local wReady = Menu.Combo.useW:Value() and Utils:IsReady(_W)
	local rReady = Menu.Combo.useR:Value() and Utils:IsReady(_R)

	if qReady and self.qTarget then
		self:CastQcombo(self.qTarget)
	end

	if wReady and self.wTarget then
		self:CastWcombo(self.wTarget)
	end
	if #Utils:GetEnemyHeroesInRange(myHero.pos, R.range) > 0 then
		for i=1, #Utils:GetEnemyHeroesInRange(myHero.pos, R.range) do
			local enemy = Utils:GetEnemyHeroesInRange(myHero.pos, R.range)[i]

			if enemy then
				if rReady and enemy then
					if Utils:HasParticle(enemy, "kayn_base_primary_r_mark") then
						self:CastRcombo(enemy)
					end
				end
			end
		end
	end
end

function CastQcombo(unit)

	if not unit then return end
	if myHero.attackData.state == STATE_WINDUP then return end

	local qWrange = Q.range + W.range
	local qRange = Q.range + Q.range

	if Utils:IsValid(unit, myHero.pos, qRange) or (Utils:IsValid(unit, myHero.pos, qWrange) and unit.health < self:GetComboDmg(unit)) then
		if myHero.attackData.state ~= STATE_WINDUP then
			local pred = Utils:GetPred(unit, Q.speed, Q.delay)
			if pred then
				Utils:CastSpell(HK_Q, pred, Q.range + W.range)
			end
		end
	end
end

OnProcessSpell(function(unit,spell)
    PrintChat(string.format("'%s' casts '%s'; Windup: %.3f Animation: %.3f", GetObjectName(unit), spell.name, spell.windUpTime, spell.animationTime))
end)

PrintChat(GetDistance(myHero,enemy))