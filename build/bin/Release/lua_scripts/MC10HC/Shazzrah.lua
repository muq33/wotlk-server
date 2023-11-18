local Shazzrah = {
    id = 9000009
}

local Spells_Shazzrah = {
    ARCANE_EXPLOSION              = 19712,
    SHAZZRAH_CURSE                = 19713,
    MAGIC_GROUNDING               = 19714,
    COUNTERSPELL                  = 19715,
    SHAZZRAH_GATE                 = 23138
}

-----------------------------------------------------------------------------------
function Shazzrah.ArcaneExplosion(eventId,delay,calls, creature)
    creature:CastCustomSpell(creature, Spells_Shazzrah.ARCANE_EXPLOSION, false, 1800)
end
function Shazzrah.ShazzrahCurse(eventId,delay,calls, creature)
    creature:CastSpell(creature:GetVictim(), Spells_Shazzrah.SHAZZRAH_CURSE, true)
end
function Shazzrah.MagicGrounding(eventId,delay,calls, creature)
    creature:CastSpell(creature, Spells_Shazzrah.MAGIC_GROUNDING,true)
end

function Shazzrah.CounterSpell(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Spells_Shazzrah.COUNTERSPELL, true)
end

function Shazzrah.ShazzrahGate(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(creature, Spells_Shazzrah.ARCANE_EXPLOSION, false, 2500)
        creature:CastSpell(creature:GetVictim(), Spells_Shazzrah.SHAZZRAH_GATE, true)
    else
        local all_targets = creature:GetAITarget(1, true)
        local sample_target = all_targets[math.random(2,#all_targets)]
        creature:CastCustomSpell(creature, Spells_Shazzrah.ARCANE_EXPLOSION, false, 2500)
        creature:CastSpell(sample_target, Spells_Shazzrah.SHAZZRAH_GATE, true)
    end
end
function Shazzrah.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Shazzrah.ArcaneExplosion, {4000, 5000}, 0)
    creature:RegisterEvent(Shazzrah.ShazzrahCurse, {23000, 26000}, 0)
    creature:RegisterEvent(Shazzrah.MagicGrounding, {7000, 9000}, 0)
    creature:RegisterEvent(Shazzrah.ShazzrahGate, 30000, 0)
end

function Shazzrah.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Shazzrah.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

-- function Shazzrah.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Shazzrah want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(Shazzrah.id, 1, Shazzrah.OnEnterCombat)
RegisterCreatureEvent(Shazzrah.id, 2, Shazzrah.OnLeaveCombat)
RegisterCreatureEvent(Shazzrah.id, 4, Shazzrah.OnDied)
-- RegisterCreatureEvent(16028, 5, Shazzrah.CheckHealth)
