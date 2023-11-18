
---Boss---
local Garr = {
    id = 9000006
}

local Garr_Spells =
{
    -- Garr
    ANTIMAGIC_PULSE               = 19492,    -- Dispels magic on nearby enemies, removing 1 beneficial spell
    MAGMA_SHACKLES                = 19496,    -- Reduces the movement speed of nearby enemies by 60%
    SEPARATION_ANXIETY            = 23487,    -- Aura cast on himself by Garr, if adds move out of range, they will cast spell 23492 on themselves (server side)
    FRENZY                        = 19516,    -- Increases the caster's attack speed by 9 + scale. Stacks up to 10 times
};

function Garr.AntiMagicPulse(eventId,delay,calls, creature)
    creature:CastSpell(creature:GetVictim(), Garr_Spells.ANTIMAGIC_PULSE, true)
end

function Garr.MagmaShackles(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(),Garr_Spells.MAGMA_SHACKLES, true)
end


function Garr.Frenzy(eventId, delay, calls, creature)
    creature:CastSpell(nil, Garr_Spells.FRENZY, true)
end


function Garr.OnEnterCombat(event, creature, target)
    creature:CastSpell(nil, Garr_Spells.SEPARATION_ANXIETY, true) --talvez precise ser refeito
    creature:RegisterEvent(Garr.Frenzy, 30000, 0)
    creature:RegisterEvent(Garr.AntiMagicPulse, 15000, 0)
    creature:RegisterEvent(Garr.MagmaShackles, 10000, 0)
end

function Garr.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Garr.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

-- function Garr.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Garr want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(Garr.id, 1, Garr.OnEnterCombat)
RegisterCreatureEvent(Garr.id, 2, Garr.OnLeaveCombat)
RegisterCreatureEvent(Garr.id, 4, Garr.OnDied)
-- RegisterCreatureEvent(16028, 5, Garr.CheckHealth)

---Adds---

local Firesworn = {
    id = 9000008
}
local Firesworn_Spells={

    SEPARATION_ANXIETY_MINION     = 23492,    -- Increases damage done by 300% and applied banish immunity
    ERUPTION                      = 19497,    -- Deals fire aoe damage and knockbacks nearby enemies
    MASSIVE_ERUPTION              = 20483    -- Deals fire aoe damage, knockbacks nearby enemies and kills caster
}

function Firesworn.Eruption(eventId,delay,calls, creature)
    creature:CastSpell(creature:GetVictim(), Firesworn_Spells.ANTIMAGIC_PULSE, true)
end

function Firesworn.SeparationAnxiety(event, creature, attacker, damage)
    local InRange = creature:GetCreaturesInRange(20, 9000006)
    local index, Garr = pairs(InRange)
    if Garr == nil then
        creature:CastSpell(creature, Firesworn_Spells.SEPARATION_ANXIETY_MINION, true)
    
    else
        creature:RemoveAura(Firesworn_Spells.SEPARATION_ANXIETY_MINION)
    end
end
function Firesworn.OnEnterCombat(event, creature, target)
    creature:CastSpell(creature, Firesworn_Spells.SEPARATION_ANXIETY_MINION, true)
    -- creature:RegisterEvent(Firesworn.SeparationAnxiety, 12000, 0)
end

function Firesworn.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end


function Firesworn.OnDied(event, creature, killer)
    creature:CastCustomSpell(nil, Firesworn_Spells.MASSIVE_ERUPTION, true, 7324)
    creature:RemoveEvents()
end

-- function Firesworn.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Firesworn want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(Firesworn.id, 1, Firesworn.OnEnterCombat)
RegisterCreatureEvent(Firesworn.id, 2, Firesworn.OnLeaveCombat)
RegisterCreatureEvent(Firesworn.id, 4, Firesworn.OnDied)
RegisterCreatureEvent(Firesworn.id, 9, Firesworn.SeparationAnxiety)