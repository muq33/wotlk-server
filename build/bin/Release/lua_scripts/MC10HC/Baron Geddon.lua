
---Boss---
local BaronGeddon = {
    id = 9000007
}

local BaronGeddon_Spells =
{
    INFERNO                   = 19695,
    --SPELL_INFERNO_DUMMY_EFFECT      = 19698, --Server side spell which inflicts damage
    IGNITE_MANA               = 19659,
    LIVING_BOMB               = 20475,
    ARMAGEDDON                = 20478,
    RAIN_OF_FIRE              = 19717
};

local first_health_heck = false
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

function BaronGeddon.LivingBomb(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastSpell(all_targets[1], BaronGeddon_Spells.LIVING_BOMB, true)
    else
        local all_targets = creature:GetAITarget(1, true)
        local sample_targets = sample(2,#all_targets, 2)

        for i=1,#sample_targets do
            creature:CastSpell(all_targets[sample_targets[i]], BaronGeddon_Spells.LIVING_BOMB, true)
        end
    end
end

function BaronGeddon.Inferno(eventId,delay,calls, creature)
    creature:CastSpell(creature, BaronGeddon_Spells.INFERNO, false)
end

function BaronGeddon.IgniteMana(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastSpell(all_targets[1], BaronGeddon_Spells.IGNITE_MANA, true)
    else
        local all_targets = creature:GetAITarget(1, true)
        local sample_targets = sample(2,#all_targets, 2)

        for i=1,#sample_targets do
            creature:CastSpell(all_targets[sample_targets[i]], BaronGeddon_Spells.IGNITE_MANA, true)
        end
    end
end

function BaronGeddon.RainOfFire(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1], BaronGeddon_Spells.RAIN_OF_FIRE, true, 4000)
    else
        local sample_targets = sample(2,#all_targets, 3)

        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[sample_targets[i]], BaronGeddon_Spells.RAIN_OF_FIRE, true, 4000)
        end
    end
end

function BaronGeddon.OnEnterCombat(event, creature, target)

    creature:RegisterEvent(BaronGeddon.LivingBomb, {11000,16000}, 0)
    creature:RegisterEvent(BaronGeddon.IgniteMana, {7000,19000}, 0)
    creature:RegisterEvent(BaronGeddon.Inferno, {13000,15000}, 0)
end

function BaronGeddon.CheckHealth(event, creature, attacker, damage)

    --if (creature:GetHealthPct() % 25 == 0 and creature:HealthBelowPct(99) and creature:HealthAbovePct(20)) then
    --    creature:CastSpell(creature, BaronGeddon_Spells.INFERNO, false)
    --end
    if(creature:HealthBelowPct(10) and first_health_heck == false) then
        creature:RemoveEvents()
        local all_targets = creature:GetAITargets()
        if(#all_targets < 2)then
            creature:CastCustomSpell(all_targets[1], BaronGeddon_Spells.RAIN_OF_FIRE, true, 4000)
        else
            local sample_targets = sample(2,#all_targets, 3)

            for i=1,#sample_targets do
                creature:CastCustomSpell(all_targets[sample_targets[i]], BaronGeddon_Spells.RAIN_OF_FIRE, true, 4000)
            end
        end
        creature:RegisterEvent(BaronGeddon.RainOfFire, 5000, 0)
        creature:CastSpell(nil, BaronGeddon_Spells.ARMAGEDDON, false)
        first_health_heck = true
    end
end

function BaronGeddon.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    first_health_heck = false
end

function BaronGeddon.OnDied(event, creature, killer)
    creature:RemoveEvents()
    first_health_heck = false
end

RegisterCreatureEvent(BaronGeddon.id, 1, BaronGeddon.OnEnterCombat)
RegisterCreatureEvent(BaronGeddon.id, 2, BaronGeddon.OnLeaveCombat)
RegisterCreatureEvent(BaronGeddon.id, 4, BaronGeddon.OnDied)
RegisterCreatureEvent(BaronGeddon.id, 9, BaronGeddon.CheckHealth)
