local Gluth = {}
local PoisonGas = {}
--Gluth (cachorro otário) boss_gluth.cpp
--20% da vida do boss
--< 20% da vida, a cada 5s bufa os bichin dele
--Gás tóxico movendo pela sala
--Gás tóxico faz nascer os zombiezinhos com 50% da vida
--Spawna mais gas conforme o tempo passasse (no despawn)
--50% da vida causa mortal wound e outro efeito (aumentar dano que vai tomar ou diminuir o dano que ele dá)


--new
--PoisonGas spawn zombiezinhos a cada X sec
--Zombie target player
--MAS, se Gluth tiver 50% < vai em direção ao Gluth, mais rápido

--1s ele come bichos zombiezinhos perto dele


local Gluth_Spells =
{
    MORTAL_WOUNDS               = 54378,
    MORTAL_WOUNDS_SPECIAL       = 20000, -- Pestilence, go for another group, plague
    ENRAGE                      = 54427,
    MOVING_GAS_CREATURE         = 12000,
    DECIMATE                    = 28375,
    ZOMBIE_CHOW_CREATURE        = 16360,
    --SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,
};

local Gluth_Spells_Times = 
{
    MORTAL_WOUNDS               = 10000,
    ENRAGE                      = 22000,
    MOVING_GAS_SPAWN            = 12000,
    DECIMATE                    = 500,
}

--DEFINE "BLOCKS" FOR POISON SPAWN

--
local availableBlockPositions;

function Gluth.MovingPoisonGas(eventId, delay, calls, creature)
    --Summon at a random non occupied in the map 
    --creature:SpawnCreature(Gluth_Spells.MOVING_GAS_CREATURE, )
end

function PoisonGas.SpawnZombie()
    
end

function Gluth.MortalWounds(eventId, delay, calls, creature)
    -- Casts spell 54378 on its current target
    creature:CastSpell(creature:GetVictim(), Gluth_Spells.MORTAL_WOUNDS, true)

    if creature:HealthBelowPct(50) then
        -- Casts debuff -- on its current target
        creature:CastSpell(creature:GetVictim(), Gluth_Spells.MORTAL_WOUNDS_SPECIAL, true)
    end
end


function Gluth.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Gluth.MovingPoisonGas, Gluth_Spells_Times.MOVING_GAS_SPAWN, 0)
    creature:RegisterEvent(Gluth.MortalWounds, Gluth_Spells_Times.MORTAL_WOUNDS, 0)
    creature:RegisterEvent(Gluth.EnrageEmpower, Gluth_Spells_Times.ENRAGE, 0)
    creature:RegisterEvent(Gluth.CheckDecimate, Gluth_Spells_Times.DECIMATE, 0)
end

function Gluth.EnrageEmpower(eventId, delay, calls, creature)
    creature:SendUnitYell("Gluth is Wung!", 0)
    --Cast empowering in himself
    creature:CastSpell(creature, Gluth_Spells.ENRAGE, true)
end

function Gluth.CheckDecimate(eventId,removeId, delay, calls, creature )
    if (creature:HealthBelowPct(20)) then
        creature:SendUnitYell("Gluth is Mad!", 0)

        creature:CastSpell(creature, Gluth_Spells.DECIMATE, true)

        creature:RemoveEventById(eventId)
    end
end

RegisterCreatureEvent(16028, 1, Gluth.OnEnterCombat)