
---Boss---
local SulfuronHarbinger = {
    id = 9000012
}


local SulfuronHarbinger_Spells =
{
    -- Sulfuron Harbringer
    DEMORALIZING_SHOUT    = 19778,
    INSPIRE               = 19779,
    KNOCKDOWN             = 19780,
    FLAMESPEAR            = 19781
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

function SulfuronHarbinger.Knockdown(eventId,delay,calls, creature)
    creature:CastCustomSpell(creature, SulfuronHarbinger_Spells.KNOCKDOWN, true, nil, nil, 6800)
end

function SulfuronHarbinger.DemoralizingShout(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature,SulfuronHarbinger_Spells.DEMORALIZING_SHOUT, true, -1001,-1001)

end
function SulfuronHarbinger.Flamespear(eventId, delay, calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1],SulfuronHarbinger_Spells.FLAMESPEAR, true, 8100)
    else
        local all_targets = creature:GetAITarget(1, true)
        local sample_targets = sample(2,#all_targets, 2)

        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[1],SulfuronHarbinger_Spells.FLAMESPEAR, true, 8100)
        end
    end
        creature:CastCustomSpell(creature,SulfuronHarbinger_Spells.FLAMESPEAR, true, 8100)
    
end

function SulfuronHarbinger.Inspire(eventId, delay, calls, creature)
    creature:CastSpell(creature,SulfuronHarbinger_Spells.INSPIRE, true)
end

function SulfuronHarbinger.OnEnterCombat(event, creature, target)

    creature:RegisterEvent(SulfuronHarbinger.Knockdown, {10000, 20000}, 0)
    creature:RegisterEvent(SulfuronHarbinger.DemoralizingShout, {12000, 18000}, 0)
    creature:RegisterEvent(SulfuronHarbinger.Flamespear, {12000, 16000}, 0)
    creature:RegisterEvent(SulfuronHarbinger.Inspire, {13000, 20000}, 0)
end

function SulfuronHarbinger.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end
function SulfuronHarbinger.OnDied(event, creature, killer)
    creature:RemoveEvents()
end


RegisterCreatureEvent(SulfuronHarbinger.id, 1, SulfuronHarbinger.OnEnterCombat)
RegisterCreatureEvent(SulfuronHarbinger.id, 2, SulfuronHarbinger.OnLeaveCombat)
RegisterCreatureEvent(SulfuronHarbinger.id, 4, SulfuronHarbinger.OnDied)

---Adds---

local FlamewakerPriest = {
    id = 9000013
}

local FlamewakerPriest_Spells={
    DARK_MENDING          = 19775,
    SHADOW_WORD_PAIN      = 19776,
    DARK_STRIKE           = 19777,
    IMMOLATE              = 20294,
}

function FlamewakerPriest.DarkMending(eventId,delay,calls, creature)
    local which_to_cast = math.random(1,2)
    if(which_to_cast == 1) then
        local InRange = creature:GetCreaturesInRange(45, 9000012)
        for index, SulfuronH in pairs(InRange) do
            creature:CastCustomSpell(SulfuronH, FlamewakerPriest_Spells.DARK_MENDING, false, SulfuronH:GetMaxHealth()/10)
        end
        
       
    
    elseif which_to_cast == 2 then
        local InRange = creature:GetCreaturesInRange(45, 9000013)
        for index, Priest in pairs(InRange) do
            creature:CastCustomSpell(Priest, FlamewakerPriest_Spells.DARK_MENDING, false, Priest:GetMaxHealth()/10)
        end
       

    end

end
function FlamewakerPriest.ShadowWordPain(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1], FlamewakerPriest_Spells.SHADOW_WORD_PAIN, true, 110)
    else
        local sample_targets = sample(1,#all_targets, 3)

        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[sample_targets[i]], FlamewakerPriest_Spells.SHADOW_WORD_PAIN, true, 110)
        end
    end
end

function FlamewakerPriest.DarkStrike(eventId,delay,calls, creature)
    creature:CastCustomSpell(creature:GetVictim(), FlamewakerPriest_Spells.DARK_STRIKE, true, 2100)
end
function FlamewakerPriest.Immolate(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastCustomSpell(all_targets[1], FlamewakerPriest_Spells.IMMOLATE, true, 900, 1200)
    else
        local sample_targets = sample(1,#all_targets, 2)

        for i=1,#sample_targets do
            creature:CastCustomSpell(all_targets[sample_targets[i]], FlamewakerPriest_Spells.IMMOLATE, true, 900, 1200)
        end
    end
end


function FlamewakerPriest.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(FlamewakerPriest.Immolate, {5500,6500}, 0)
    creature:RegisterEvent(FlamewakerPriest.DarkMending, {15000, 30000}, 0)
    creature:RegisterEvent(FlamewakerPriest.ShadowWordPain, {5000, 7000}, 0)
    creature:RegisterEvent(FlamewakerPriest.DarkStrike, {4000, 7000}, 0)
    -- creature:RegisterEvent(FlamewakerPriest.SeparationAnxiety, 12000, 0)
end

function FlamewakerPriest.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end


function FlamewakerPriest.OnDied(event, creature, killer)
    creature:RemoveEvents()
end


RegisterCreatureEvent(FlamewakerPriest.id, 1, FlamewakerPriest.OnEnterCombat)
RegisterCreatureEvent(FlamewakerPriest.id, 2, FlamewakerPriest.OnLeaveCombat)
RegisterCreatureEvent(FlamewakerPriest.id, 4, FlamewakerPriest.OnDied)