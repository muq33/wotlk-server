--- Imports ---
loadfile("Utils.lua")

--- Main boss ---
local Majordomo = {
    id = 9000014
}

local Spells = {
    MAGIC_REFLECTION                  = 20619,
    DAMAGE_REFLECTION                 = 21075,
    BLAST_WAVE                        = 20229,
    LIVING_BOMB                       = 20475,
    AEGIS_OF_RAGNAROS                 = 20620,
    TELEPORT_RANDOM                   = 20618,    -- Teleport random target
    TELEPORT_TARGET                   = 20534,    -- Teleport Victim
    ENCOURAGEMENT                     = 21086,
    SEPARATION_ANXIETY                = 21094,    -- Aura cast on himself by Majordomo Executus, if adds move out of range, they will cast spell 21095 on themselves
    SEPARATION_ANXIETY_MINION         = 21095,
}
local Phase_Indicators = {0,0}
-----------------------------------------------------------------------------------
function Majordomo.Reflection(eventId,delay,calls, creature)
    local which_to_cast = math.random(1,2)
    if which_to_cast == 1 then
        creature:CastSpell(creature, Spells.DAMAGE_REFLECTION, true)
    else
        creature:CastSpell(creature, Spells.MAGIC_REFLECTION, true)
    end
    
    
end

function Majordomo.BlastWave(eventId,delay,calls, creature)
    creature:CastCustomSpell(creature, Spells.BLAST_WAVE, true, 4100)
end

function Majordomo.Teleport(eventId,delay,calls, creature)
    creature:CastSpell(creature, Spells.AEGIS_OF_RAGNAROS, true)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastSpell(all_targets[1], Spells.TELEPORT_RANDOM, true)
        creature:ClearThreatList()
    else
        local sample_targets = sample(1,#all_targets, math.min(3, #all_targets-1))

        for i=1,#sample_targets do
            creature:CastSpell(all_targets[i], Spells.TELEPORT_RANDOM, true)
        end
        creature:ClearThreatList()
    end
end
function Majordomo.LivingBomb(eventId,delay,calls, creature)
    local all_targets = creature:GetAITargets()
    if(#all_targets < 2)then
        creature:CastSpell(all_targets[1], Spells.LIVING_BOMB, true)
    else
        local sample_targets = sample(1,#all_targets, math.min(2, #all_targets-1))

        for i=1,#sample_targets do
            creature:CastSpell(all_targets[sample_targets[i]], Spells.LIVING_BOMB, true)
        end
    end
end
function Majordomo.PhaseSelector(event, creature, attacker, damage)
    if creature:HealthBelowPct(101) and creature:HealthAbovePct(51) and Phase_Indicators[1] == 0 then
        creature:CastSpell(creature, Spells.AEGIS_OF_RAGNAROS, true)
        creature:RegisterEvent(Majordomo.Reflection, 30000, 0)
        creature:RegisterEvent(Majordomo.Teleport, 30000, 0)
        Phase_Indicators[1] = 1
    elseif creature:HealthBelowPct(51) and Phase_Indicators[2] == 0 then
        creature:RemoveEvents()
        creature:RegisterEvent(Majordomo.LivingBomb, {11000, 16000}, 0)
        creature:RegisterEvent(Majordomo.Teleport, 30000, 0)
        creature:RegisterEvent(Majordomo.BlastWave, {21000, 23000}, 0)
        Phase_Indicators[2] = 1
    end
end

function Majordomo.OnEnterCombat(event, creature, target)
    creature:CastCustomSpell(creature, Spells.AEGIS_OF_RAGNAROS, true, creature:GetMaxHealth()/20, 350)
end

function Majordomo.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Phase_Indicators = {0,0}
end

function Majordomo.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Phase_Indicators = {0,0}
end


RegisterCreatureEvent(Majordomo.id, 1, Majordomo.OnEnterCombat)
RegisterCreatureEvent(Majordomo.id, 2, Majordomo.OnLeaveCombat)
RegisterCreatureEvent(Majordomo.id, 9, Majordomo.PhaseSelector)
RegisterCreatureEvent(Majordomo.id, 4, Majordomo.OnDied)

-----------------------------------------------------------------------------------

---Adds---
local Flamewaker_Elite = {
    id = 9000015
}


local Flamewaker_Elite_Spells = {
    SHADOW_SHOCK              = 20603,
    FIRE_BLAST                = 20623,
    FIREBALL                  = 20420,
    SEPARATION_ANXIETY_MINION = 23492,
    SHADOW_BOLT               = 21077
}


function Flamewaker_Elite.ShadowShock(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature:GetVictim(), Flamewaker_Elite_Spells.SHADOW_SHOCK, true, 2500)
end
function Flamewaker_Elite.FireBlast(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature:GetVictim(), Flamewaker_Elite_Spells.FIRE_BLAST, true, 2850)
end
function Flamewaker_Elite.FireShadow(eventId, delay, calls, creature)
    local which_to_cast = math.random(1,2)
    local target = creature:GetAITarget(1,true,0,45)
    if(which_to_cast == 1) then
        creature:CastCustomSpell(target, Flamewaker_Elite_Spells.SHADOW_BOLT, true, 2650)
    else
        creature:CastCustomSpell(target, Flamewaker_Elite_Spells.FIREBALL, true, 2650)
    end
    
end

function Flamewaker_Elite.SeparationAnxiety(event, creature, attacker, damage)
    local InRange = creature:GetCreaturesInRange(20, 9000014)
    local index, Majordomo = pairs(InRange)
    if Majordomo == nil then
        creature:CastSpell(creature, Flamewaker_Elite_Spells.SEPARATION_ANXIETY_MINION, true)
    
    else
        creature:RemoveAura(Flamewaker_Elite_Spells.SEPARATION_ANXIETY_MINION)
    end
end
function Flamewaker_Elite.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Flamewaker_Elite.ShadowShock, {10000, 12000}, 0)
    creature:RegisterEvent(Flamewaker_Elite.FireBlast, 14000, 0)
    creature:RegisterEvent(Flamewaker_Elite.FireShadow, {18000, 21000}, 0)
end

function Flamewaker_Elite.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Flamewaker_Elite.OnDied(event, creature, killer)
    creature:RemoveEvents()
end




RegisterCreatureEvent(Flamewaker_Elite.id, 1, Flamewaker_Elite.OnEnterCombat)
RegisterCreatureEvent(Flamewaker_Elite.id, 2, Flamewaker_Elite.OnLeaveCombat)
RegisterCreatureEvent(Flamewaker_Elite.id, 4, Flamewaker_Elite.OnDied)
RegisterCreatureEvent(Flamewaker_Elite.id, 7, Flamewaker_Elite.SeparationAnxiety)