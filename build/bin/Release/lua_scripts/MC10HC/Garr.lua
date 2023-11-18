
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
    creature:CastSpell(nil, Garr_Spells.SEPARATION_ANXIETY, true)
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

local Fireworn = {
    id = 9000008
}
local Fireworn_Spells={

    SEPARATION_ANXIETY_MINION     = 23492,    -- Increases damage done by 300% and applied banish immunity
    ERUPTION                      = 19497,    -- Deals fire aoe damage and knockbacks nearby enemies
    MASSIVE_ERUPTION              = 20483    -- Deals fire aoe damage, knockbacks nearby enemies and kills caster
}

function Fireworn.Eruption(eventId,delay,calls, creature)
    creature:CastSpell(creature:GetVictim(), Fireworn_Spells.ANTIMAGIC_PULSE, true)
end


function Fireworn.OnEnterCombat(event, creature, target)
    creature:CastSpell(creature, Fireworn_Spells.SEPARATION_ANXIETY_MINION, true)
    -- creature:RegisterEvent(Fireworn.SeparationAnxiety, 12000, 0)
end

function Fireworn.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Fireworn.OnDied(event, creature, killer)
    creature:CastCustomSpell(nil, Fireworn_Spells.MASSIVE_ERUPTION, true, 7324)
    creature:RemoveEvents()
end

-- function Fireworn.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Fireworn want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(Fireworn.id, 1, Fireworn.OnEnterCombat)
RegisterCreatureEvent(Fireworn.id, 2, Fireworn.OnLeaveCombat)
RegisterCreatureEvent(Fireworn.id, 4, Fireworn.OnDied)