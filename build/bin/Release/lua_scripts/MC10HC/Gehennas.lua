--- Imports ---
loadfile("Utils.lua")

--- Main boss ---
local Gehennas = {
    id = 9000003
}

local Spells = {
    GEHENNAS_CURSE        = 19716,
    RAIN_OF_FIRE          = 19717,
    SHADOW_BOLT           = 19729 --Precisa ser refeita
}

-----------------------------------------------------------------------------------
function Gehennas.GehennasCurse(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastSpell(all_targets[1], Spells.GEHENNAS_CURSE, true)
    else
        local sample_targets = sample(1,#all_targets, math.min(2, #all_targets-1))

        for i=1,#sample_targets do
            creature:CastSpell(all_targets[sample_targets[i]], Spells.GEHENNAS_CURSE, true)
        end
    end
end

function Gehennas.RainfOfFire(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1], Spells.RAIN_OF_FIRE, true, 4000)
    else
        local sample_targets = sample(1,#all_targets, math.min(2, #all_targets-1))

        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[sample_targets[i]], Spells.RAIN_OF_FIRE, true, 4000 + math.random(-250, 250))
        end
    end
    
end

function Gehennas.ShadowBolt(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature:GetVictim(), Spells.SHADOW_BOLT, true, 4500 + math.random(-250, 250))
end

function Gehennas.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Gehennas.GehennasCurse, {15000, 18000}, 0)
    creature:RegisterEvent(Gehennas.RainfOfFire, 15000, 0)
    creature:RegisterEvent(Gehennas.ShadowBolt, {3000, 5000}, 0)
end

function Gehennas.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Gehennas.OnDied(event, creature, killer)
    creature:RemoveEvents()
end


RegisterCreatureEvent(Gehennas.id, 1, Gehennas.OnEnterCombat)
RegisterCreatureEvent(Gehennas.id, 2, Gehennas.OnLeaveCombat)
RegisterCreatureEvent(Gehennas.id, 4, Gehennas.OnDied)

-----------------------------------------------------------------------------------

---Adds---
local Flamewalker = {
    id = 9000004
}


local Flamewalker_Spells = {
    FIST_OF_RAGNAROS        = 20277
}


function Flamewalker.FistOfRagnaros(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Flamewalker_Spells.FIST_OF_RAGNAROS, true)
end
function Flamewalker.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Flamewalker.FistOfRagnaros, 10000, 0)
end

function Flamewalker.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Flamewalker.OnDied(event, creature, killer)
    creature:RemoveEvents()
end



RegisterCreatureEvent(Flamewalker.id, 1, Flamewalker.OnEnterCombat)
RegisterCreatureEvent(Flamewalker.id, 2, Flamewalker.OnLeaveCombat)
RegisterCreatureEvent(Flamewalker.id, 4, Flamewalker.OnDied)