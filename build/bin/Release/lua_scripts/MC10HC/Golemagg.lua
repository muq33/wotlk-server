--- Imports ---
loadfile("Utils.lua")

---Boss---
local Golemagg = {
    id = 9000010
}
local first_health_heck = false

local Golemagg_Spells =
{
    PYROBLAST             = 20228,
    EARTHQUAKE            = 19798,
    MAGMASPLASH           = 13879,
    DOUBLE_ATTACK         = 18943,
};
local CoreRager_Spells={
    -- Core Rager
    MANGLE                = 19820,
    FULL_HEAL             = 17683,
    SUICIDE               = 13520,
    TRUST_AURA            = 28131
}

function Golemagg.Pyroblast(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1], Golemagg_Spells.PYROBLAST, true, 5900, 1000)
    else
        local sample_targets = sample(1,#all_targets, math.min(2, #all_targets-1))
        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[1], Golemagg_Spells.PYROBLAST, true, 5900, 1000)
        end
    end
end

function Golemagg.Earthquake(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature:GetVictim(),Golemagg_Spells.EARTHQUAKE, true, 8100)

end

function Golemagg.OnDamageTaken(event, creature, attacker, damage)
    creature:CastCustomSpell(attacker, Golemagg_Spells.MAGMASPLASH, true)
    
    if(creature:HealthBelowPct(10) and first_health_heck == false) then
        creature:RegisterEvent(Golemagg.Earthquake, 5000, 0)
        first_health_heck = true
    end
end

function Golemagg.OnEnterCombat(event, creature, target)

    creature:RegisterEvent(Golemagg.Pyroblast, 7000, 0)
end

function Golemagg.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end
function Golemagg.OnDied(event, creature, killer)
    creature:RemoveEvents()
    local InRange = creature:GetCreaturesInRange(100, 9000011)
    for index, CoreRager in pairs(InRange) do
        CoreRager:CastSpell(CoreRager, CoreRager_Spells.SUICIDE, true)
    end
   
end


RegisterCreatureEvent(Golemagg.id, 1, Golemagg.OnEnterCombat)
RegisterCreatureEvent(Golemagg.id, 2, Golemagg.OnLeaveCombat)
RegisterCreatureEvent(Golemagg.id, 4, Golemagg.OnDied)
RegisterCreatureEvent(Golemagg.id, 9, Golemagg.OnDamageTaken)

---Adds---

local CoreRager = {
    id = 9000011
}


function CoreRager.Mangle(eventId,delay,calls, creature)
    creature:CastCustomSpell(creature:GetVictim(), CoreRager_Spells.MANGLE, true, 1700)
end

function CoreRager.OnDamageTaken(event, creature, attacker, damage)
    if(creature:HealthBelowPct(50)) then
        creature:SendUnitEmote("Core Rager refuses to die while its master is in trouble.", 3)
        creature:CastSpell(creature, CoreRager_Spells.FULL_HEAL, true)
    end
end

function CoreRager.TrustAura(eventId,delay,calls, creature)

    local InRange = creature:GetCreaturesInRange(100, 9000010)
    local index, Golemagg = pairs(InRange)
    if Golemagg ~= nil then
        creature:CastSpell(creature, CoreRager_Spells.TRUST_AURA, true)
    else
        creature:RemoveAura(CoreRager_Spells.TRUST_AURA)
    end
end
function CoreRager.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CoreRager.Mangle, 10000, 0)
    creature:RegisterEvent(CoreRager.TrustAura, 1000, 0)
    -- creature:RegisterEvent(CoreRager.SeparationAnxiety, 12000, 0)
end

function CoreRager.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end


function CoreRager.OnDied(event, creature, killer)
    creature:RemoveEvents()
end


RegisterCreatureEvent(CoreRager.id, 1, CoreRager.OnEnterCombat)
RegisterCreatureEvent(CoreRager.id, 2, CoreRager.OnLeaveCombat)
RegisterCreatureEvent(CoreRager.id, 4, CoreRager.OnDied)
RegisterCreatureEvent(CoreRager.id, 9, CoreRager.OnDamageTaken)