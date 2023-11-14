local Patchwerk = {}
-- This function is called when Patchwerk is spawned.

function Patchwerk.SummonOoze(event, creature)
    local yellOption = "Patchwerk brings friends to play!"
    -- Sends the selected yell message
    creature:SendUnitYell(yellOption, 0)
    local boss_pos = creature:GetLocation()
    for i = 1, 4, 1 do
        local rand_pos_list = {math.random(-15,15), math.random(-15,15)}
        creature:SpawnCreature(16375, boss_pos.x+rand_pos_list[0],boss_pos.y+rand_pos_list[1],boss_pos.z, boss_pos.o)
    end
end
-- This function is called repeatedly every 10 seconds when Patchwerk is in combat.
function Patchwerk.PoisonBoltVolley(eventId, delay, calls, creature)
    -- Casts spell 40095 on its current target
    creature:CastSpell(creature:GetVictim(), 40095, true)
end

-- This function is called repeatedly every 15 seconds when Patchwerk is in combat.
function Patchwerk.CastHatefulStrike(eventId, delay, calls, creature)
    -- Casts spell 28308 on its current target
    creature:CastSpell(creature:GetVictim(), 28308, true)
end

-- This function is called repeatedly every 20 seconds when Patchwerk is in combat.
function Patchwerk.CastGore(eventId, delay, calls, creature)
    -- Casts spell 48130 on its current target
    creature:CastSpell(creature:GetVictim(), 48130, true)
end

-- This function is called when Patchwerk enters combat.
function Patchwerk.OnEnterCombat(event, creature, target)
    local yellOption = "Kel'thuzad make Patchwerk his avatar of war!"
    -- Sends the selected yell message
    creature:SendUnitYell(yellOption, 0)
    -- Registers the PoisonBoltVolley, CastHatefulStrike, and CastGore functions to be called repeatedly
    creature:RegisterEvent(Patchwerk.PoisonBoltVolley, 20000, 0)
    creature:RegisterEvent(Patchwerk.CastHatefulStrike, 15000, 0)
    creature:RegisterEvent(Patchwerk.CastGore, 20000, 0)
    creature:RegisterEvent(Patchwerk.SummonOoze, 60000, 0)
end

-- This function is called when Patchwerk leaves combat.
function Patchwerk.OnLeaveCombat(event, creature)
    -- Array of yell options
    local yellOption = "No more play?"
    -- Sends the selected yell message
    creature:SendUnitYell(yellOption, 0)
    -- Removes any registered events
    creature:RemoveEvents()
end

-- This function is called when Patchwerk dies.
function Patchwerk.OnDied(event, creature, killer)
    -- Sends a yell message ("What... happen to-")
    creature:SendUnitYell("What... happen to-", 0)
    -- Sends a broadcast message to the player who killed Patchwerk
    if (killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " .. creature:GetName() .. "!")
    end
    -- Removes any registered events
    creature:RemoveEvents()
end

-- This function is called repeatedly when Patchwerk's health changes.
function Patchwerk.CheckHealth(event, creature)
    -- If its health drops below 20%,
    if (creature:HealthBelowPct(20)) then
        -- Sends a yell message ( "Patchwerk want to play!")
        creature:SendUnitYell("Patchwerk want to play!", 0)
        -- Casts spell 41305
        creature:CastSpell(creature, 41305, true)
    end
end

-- Registers the functions to be called for various events
RegisterCreatureEvent(400012, 1, Patchwerk.OnEnterCombat)
RegisterCreatureEvent(400012, 2, Patchwerk.OnLeaveCombat)
RegisterCreatureEvent(400012, 4, Patchwerk.OnDied)
RegisterCreatureEvent(400012, 5, Patchwerk.CheckHealth)
