local Gluth = {id = 15932}
local PoisonGas = {id = 37690}
local ZombieChowCreature = {id = 16360}

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

--Sumona as posion cloud / poças baseado em porcentagem de vida, deixa de ser randomico.
local PoisonGas_Times = 
{
    ZOMBIE_CHOW_CREATURE = 15000
}

local Gluth_Spells =
{
    MORTAL_WOUNDS               = 54378,
    MORTAL_WOUNDS_SPECIAL       = 20000, -- Pestilence, go for another group, plague
    ENRAGE                      = 54427,
    DECIMATE                    = 28375,
};

local Gluth_Spells_Times = 
{
    MORTAL_WOUNDS               = 10000,
    POISON_GAS_CHECK_LIFE       = 500,
    ENRAGE                      = 22000,
    DECIMATE                    = 500,
}

local poisonGasPosition = {
    {x = 3308.393066, y = -3184.520996, z = 350.969086, spawned = false, creature_ref = nil},
    {x = 3267.750977, y = -3171.457520, z = 350.969482, spawned = false, creature_ref = nil},
    {x = 3256.010742, y = -3130.549072, z = 350.969482, spawned = false, creature_ref = nil},
    {x = 3308.294678, y = -3131.699463, z = 350.969086, spawned = false, creature_ref = nil}
}

local poisonGasSpawned = 0;

--if < health (40% 3 poisonGas) 
--poisonGasSpawned qtd - poisonGasSpawned.QTD Spawna

--80, 60, 40, 20
--1 , 2 , 3 , 4 (qtd spawn)
--poisonGasSpawned.QTD < qtd spawn (SPAWNO)
--caso contrário faz nada

--PoisonGas
function PoisonGas.SpawnZombie(eventId, delay, calls, creature)
    local x, y, z, o = creature:GetLocation()
    creature:SpawnCreature(ZombieChowCreature.id,         
    x,
    y,
    z, 0, 5);
end

function PoisonGas.OnSpawn(event, creature)
    creature:RegisterEvent(PoisonGas.SpawnZombie, PoisonGas_Times.ZOMBIE_CHOW_CREATURE, 0)
end

function PoisonGas.OnRemove(event, creature)
    creature:RemoveEvents()
end

function PoisonGas.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

--ZombieChowCreature
function ZombieChowCreature.OnRemove(event, creature)
    creature:RemoveEvents()
end

function ZombieChowCreature.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

--Gluth
function Gluth.SpawnPoisonGas(eventId, delay, calls, creature)
    --Summon at a random non occupied in the map 
    local qtd = math.floor((100 - creature:GetHealthPct()) / 20)

    if(qtd <= poisonGasSpawned) then
        return
    end

    for i=1, qtd - poisonGasSpawned do
        local poisonGas = FindNotSpawnedPosition(poisonGasPosition)

        if  poisonGas == nil then
            return
        end
        
        poisonGas.creatureRef = creature:SpawnCreature(PoisonGas.id,         
            poisonGas.x,
            poisonGas.y,
            poisonGas.z, 0, 5);

        poisonGas.spawned = true;
    end

    poisonGasSpawned = qtd;
end

function FindNotSpawnedPosition(positions)
    local notSpawnedPositions = {} -- Table to store not spawned positions

    -- Iterate through positions
    for i, pos in ipairs(positions) do
        if not pos.spawned then
            table.insert(notSpawnedPositions, i) -- Store the index of not spawned position
        end
    end

    -- If there are not spawned positions, return a random one
    if #notSpawnedPositions > 0 then
        local randomIndex = notSpawnedPositions[math.random(1, #notSpawnedPositions)]
        return positions[randomIndex], randomIndex
    else
        return nil -- No not spawned positions found
    end
end

function CleanAll()
    for i, pos in ipairs(poisonGasPosition) do
        pos.spawned = false
        pos.creature_ref:Kill(pos.creature_ref)
    end

    poisonGasSpawned = 0;
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
    creature:RegisterEvent(Gluth.SpawnPoisonGas, Gluth_Spells_Times.POISON_GAS_CHECK_LIFE, 0)
    creature:RegisterEvent(Gluth.MortalWounds, Gluth_Spells_Times.MORTAL_WOUNDS, 0)
    creature:RegisterEvent(Gluth.EnrageEmpower, Gluth_Spells_Times.ENRAGE, 0)
    creature:RegisterEvent(Gluth.CheckDecimate, Gluth_Spells_Times.DECIMATE, 0)
end
function Gluth.EnrageEmpower(eventId, delay, calls, creature)
    creature:SendUnitYell("Gluth is Wung!", 0)
    --Cast empowering in himself
    creature:CastSpell(creature, Gluth_Spells.ENRAGE, true)
end

function Gluth.CheckDecimate(eventId, delay, calls, creature )
    if (creature:HealthBelowPct(20)) then
        creature:SendUnitYell("Gluth is Mad!", 0)

        creature:CastSpell(creature, Gluth_Spells.DECIMATE, true)

        creature:RemoveEventById(eventId)
    end
end

function Gluth.OnLeaveCombat(event, creature)
    CleanAll()
    creature:RemoveEvents()
end

function Gluth.OnDied(event, creature, killer)
    CleanAll()
    creature:RemoveEvents()
end

RegisterCreatureEvent(Gluth.id, 1, Gluth.OnEnterCombat)
RegisterCreatureEvent(Gluth.id, 2, Gluth.OnLeaveCombat)
RegisterCreatureEvent(Gluth.id, 4, Gluth.OnDied)

RegisterCreatureEvent(PoisonGas.id, 5, PoisonGas.OnSpawn)
RegisterCreatureEvent(PoisonGas.id, 37, PoisonGas.OnRemove)
RegisterCreatureEvent(PoisonGas.id, 4, PoisonGas.OnDied)

RegisterCreatureEvent(ZombieChowCreature.id, 37, ZombieChowCreature.OnRemove)
RegisterCreatureEvent(ZombieChowCreature.id, 4, ZombieChowCreature.OnDied)