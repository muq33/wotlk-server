local Magmadar = {}

local Spells = {
    FRENZY = 19451,
    PANIC = 19408,
    MAGMA_BOMB = 19411, --Precisa ser refeita
    MAGMA_BOMB_RANGED = 20474--Precisa ser refeita
}

function Magmadar.Frenzy(eventId,delay,calls, creature)
    creature:CastSpell(nil, Spells['FRENZY'], true)
end

function Magmadar.Panic(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Spells['PANIC'], true)
end

function Magmadar.MagmaBomb(eventId, delay, calls, creature)

    local targets = {
        creature:GetAITarget(1, true, math.random(2,5)),
        creature:GetAITarget(4, true, math.random(1,5), 50)
}
    creature:CastSpell(targets[1], Spells['MAGMA_BOMB_RANGED'], true)
    creature:CastSpell(targets[2], Spells['MAGMA_BOMB_RANGED'], true)
end
function Magmadar.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Magmadar.Frenzy, 8500, 0)
    creature:RegisterEvent(Magmadar.Panic, 9500, 0)
    creature:RegisterEvent(Magmadar.MagmaBomb, 12000, 0)
end

function Magmadar.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Magmadar.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

-- function Magmadar.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Magmadar want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(9000001, 1, Magmadar.OnEnterCombat)
RegisterCreatureEvent(9000001, 2, Magmadar.OnLeaveCombat)
RegisterCreatureEvent(9000001, 4, Magmadar.OnDied)
-- RegisterCreatureEvent(16028, 5, Magmadar.CheckHealth)
