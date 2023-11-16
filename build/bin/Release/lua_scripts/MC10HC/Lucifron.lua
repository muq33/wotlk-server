local Lucifron = {}

local Spells = {
    IMPENDING_DOOM    = 19702,
    LUCIFRON_CURSE    = 19703,
    SHADOW_SHOCK      = 20603, --Precisa ser refeita
}

local  function sample (i, j, n)
    local result = {}
    local temp = setmetatable( {}, meta )
    for k = 1, n do
      local idx = math.random( i, j )
      local v = temp[ idx ]
      temp[ idx ] = temp[ i ]
      result[ k ] = v
      i = i + 1
    end
    return result
 end

-----------------------------------------------------------------------------------
function Lucifron.ImpendingDoom(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    local sample_targets = sample(1,#all_targets, 4)

    for i=1,#sample_targets do
        creature:CastSpell(all_targets[sample_targets[i]], Spells.IMPENDING_DOOM, true)
    end
    creature:RegisterEvent(Lucifron.ImpendingDoom, math.random(6000, 11000), 0)
end

function Lucifron.LucrifronCurse(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    local sample_targets = sample(1,#all_targets, 2)

    for i=1,#sample_targets do
        creature:CastSpell(all_targets[sample_targets[i]], Spells.LUCIFRON_CURSE, true)
    end
    creature:RegisterEvent(Lucifron.LucrifronCurse, math.random(11000, 14000), 0)
end

function Lucifron.ShadowShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Spells.SHADOW_SHOCK, true)
end

function Lucifron.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Lucifron.ImpendingDoom, math.random(6000, 11000), 0)
    creature:RegisterEvent(Lucifron.LucrifronCurse, math.random(11000, 14000), 0)
    creature:RegisterEvent(Lucifron.ShadowShock, 5000, 0)
end

function Lucifron.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Lucifron.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

-- function Lucifron.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Lucifron want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(9000001, 1, Lucifron.OnEnterCombat)
RegisterCreatureEvent(9000001, 2, Lucifron.OnLeaveCombat)
RegisterCreatureEvent(9000001, 4, Lucifron.OnDied)
-- RegisterCreatureEvent(16028, 5, Lucifron.CheckHealth)
