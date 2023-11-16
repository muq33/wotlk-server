local Gehennas = {}

local Spells = {
    SPELL_GEHENNAS_CURSE        = 19716,
    SPELL_RAIN_OF_FIRE          = 19717,
    SPELL_SHADOW_BOLT_VICTIM    = 19729 --Precisa ser refeita
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
function Gehennas.ImpendingDoom(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    local sample_targets = sample(1,#all_targets, 4)

    for i=1,#sample_targets do
        creature:CastSpell(all_targets[sample_targets[i]], Spells.IMPENDING_DOOM, true)
    end
    creature:RegisterEvent(Gehennas.ImpendingDoom, math.random(6000, 11000), 0)
end

function Gehennas.LucrifronCurse(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    local sample_targets = sample(1,#all_targets, 2)

    for i=1,#sample_targets do
        creature:CastSpell(all_targets[sample_targets[i]], Spells.Gehennas_CURSE, true)
    end
    creature:RegisterEvent(Gehennas.LucrifronCurse, math.random(11000, 14000), 0)
end

function Gehennas.ShadowShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Spells.SHADOW_SHOCK, true)
end

function Gehennas.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Gehennas.ImpendingDoom, math.random(6000, 11000), 0)
    creature:RegisterEvent(Gehennas.LucrifronCurse, math.random(11000, 14000), 0)
    creature:RegisterEvent(Gehennas.ShadowShock, 5000, 0)
end

function Gehennas.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Gehennas.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

-- function Gehennas.CheckHealth(event, creature)
--    if (creature:HealthBelowPct(20)) then
--        creature:SendUnitYell("Gehennas want to play!", 0)
--       creature:CastSpell(creature, 41305, true)
--    end
--end

RegisterCreatureEvent(9000001, 1, Gehennas.OnEnterCombat)
RegisterCreatureEvent(9000001, 2, Gehennas.OnLeaveCombat)
RegisterCreatureEvent(9000001, 4, Gehennas.OnDied)
-- RegisterCreatureEvent(16028, 5, Gehennas.CheckHealth)
