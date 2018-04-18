if GetObjectName(GetMyHero()) ~= "MissFortune" then return end

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

PrintChat("MissFortune loaded.")
PrintChat("ßy miragessee")