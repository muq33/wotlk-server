--- Imports ---
loadfile("Utils.lua")


---Boss---
local Ragnaros = {
    id = 9000028,
    iterator_soft_enrage = 1,
    iterator_fill_outer_room = { 0, 0, 0, 0, 0 }
}

local Ragnaros_Spells =
{
    MOLTEN_ARMOR                = 90004,
    SPELL_RAGSUBMERGE           = 21107, -- Stealth aura
    SPELL_RAGNA_SUBMERGE_VISUAL = 20567, -- Visual for submerging into lava
    SPELL_RAGEMERGE             = 20568,
    PACIFY                      = 6462,
    PYROBLAST                   = 42891,
    LIVING_BOMB                 = 90007
    --SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,
};

local Room_Positions = {
    { --outer peninsula
        { x = 888.5654,  y = -822.6207,  z = -227.25616 },
        { x = 885.01117, y = -812.58484, z = -227.37985 },
        { x = 881.2909,  y = -802.08014, z = -227.0577 },
        { x = 874.6447,  y = -790.73395, z = -228.1221 },
        { x = 867.4266,  y = -783.3646,  z = -225.5519 }
    },
    { -- main region for casters
        { x = 849.56854, y = -782.8838,  z = -226.26355 },
        { x = 848.34076, y = -772.5193,  z = -226.01945 },
        { x = 846.74133, y = -760.4427,  z = -224.65933 },
        { x = 838.2128,  y = -782.8808,  z = -226.47266 },
        { x = 835.93823, y = -771.5737,  z = -225.31023 },
        { x = 825.72455, y = -784.6865,  z = -226.43077 },
        { x = 821.8541,  y = -772.5161,  z = -225.24982 },
        { x = 817.30756, y = -788.9423,  z = -225.9666 },
        { x = 811.48846, y = -778.94696, z = -225.50755 }
    },
    { --outer ring pt 1
        { x = 808.4837,  y = -792.2695,  z = -225.91455 },
        { x = 802.46094, y = -800.231,   z = -226.09541 },
        { x = 796.67847, y = -794.9483,  z = -225.78217 },
        { x = 796.1789,  y = -808.9653,  z = -226.18301 },
        { x = 788.60144, y = -804.5304,  z = -225.4195 },
        { x = 794.1029,  y = -815.956,   z = -226.4164 },
        { x = 784.5382,  y = -813.06177, z = -225.25691 }
    },
    { --outer peninsula (closer to boss)
        { x = 841.21216, y = -889.92694, z = -220.05331 },
        { x = 826.49664, y = -886.91376, z = -225.86658 },
        { x = 814.48975, y = -882.2229,  z = -225.56216 },
        { x = 803.0041,  y = -874.5759,  z = -226.30994 },
    },
    {
        { x = 794.7161, y = -822.6237,  z = -226.8463 },
        { x = 780.4607, y = -825.4778,  z = -225.95474 },
        { x = 795.6017, y = -837.37756, z = -228.48352 },
        { x = 799.9522, y = -849.23364, z = -227.61377 },
        { x = 800.9506, y = -860.29065, z = -226.83542 },

    }
}
local Room_Positions_back = Room_Positions

local Intermission_Positions = {
    { x = 873.106567, y = -834.991638, z = -230.355591, o = 2.522876 },
    { x = 868.095764, y = -817.550171, z = -230.991623, o = 3.606388 },
    { x = 867.205078, y = -853.536560, z = -230.354477, o = 2.694532 },
    { x = 860.316101, y = -870.889771, z = -230.361588, o = 2.008879 }
}

local FireRain_Progression = {
    { x = 796.589111, y = -840.385925, z = -228.485519 },
    { x = 799.344116, y = -853.100525, z = -227.169022 },
    { x = 815.835449, y = -843.561462, z = -229.817688 },
    { x = 822.617065, y = -853.745911, z = -229.082672 },
    { x = 833.129639, y = -858.807617, z = -229.334229 },
    { x = 836.434998, y = -848.706055, z = -229.333862 },
    { x = 847.923157, y = -855.005310, z = -229.033981 },
    { x = 856.764893, y = -843.758911, z = -228.546402 },
    { x = 856.009968, y = -830.026245, z = -228.592636 },
    { x = 852.974609, y = -821.351746, z = -229.225586 },
    { x = 845.246826, y = -812.890869, z = -229.987350 },
    { x = 835.387146, y = -811.302185, z = -229.068771 }
}
local Trap_Pos = {
    { x = 849.682190, y = -855.827515, z = -228.829956 }
}



function Ragnaros.LivingBomb(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    creature:SendUnitYell(targets[1]:GetClass(), 0)
    if (#targets < 2) then
        creature:CastSpell(targets[1], Ragnaros_Spells.LIVING_BOMB, true)
    else
        local classes = { 3, 5, 7, 8, 9, 11 }
        local final_targets = {}
        for i = 1, #targets do
            for j = 1, #classes do
                if targets[i]:GetClass() == classes[j] then
                    final_targets[i] = targets[i]
                    break
                end
            end
        end
        if #final_targets == 0 then
            local sample_targets = sample(2,#targets, 2)

            for i=1,#sample_targets do
                creature:CastSpell(targets[sample_targets[i]], Ragnaros_Spells.LIVING_BOMB, true)
            end

        else 
            local sample_targets = sample(2,#final_targets, math.min(#final_targets, 3))
            for i=1,#sample_targets do
                creature:CastSpell(targets[sample_targets[i]], Ragnaros_Spells.LIVING_BOMB, true)
            end
        end
    end
end

function Ragnaros.MoltenArmor(eventId, delay, calls, creature)
    if (not creature:HasAura(Ragnaros_Spells.PACIFY)) then
        creature:CastSpell(creature:GetVictim(), Ragnaros_Spells.MOLTEN_ARMOR,
            true)
    end
end

function Ragnaros.NoTank(eventId, delay, calls, creature)
    if (creature:IsInCombat() and creature:GetExactDistance(creature:GetVictim()) > 22 and not creature:HasAura(Ragnaros_Spells.PACIFY)) then
        local yell = "BY FIRE, BE PURGED!"
        creature:SendUnitYell(yell, 0)
        creature:PlayDirectSound(8046)
        creature:CastCustomSpell(creature:GetVictim(), Ragnaros_Spells.PYROBLAST,
            true, damage_calc(6000), 3000)
    end
end

function Ragnaros.FillRoom(eventId, delay, calls, creature)
    creature:SpawnCreature(9000029,
        FireRain_Progression[Ragnaros.iterator_soft_enrage].x,
        FireRain_Progression[Ragnaros.iterator_soft_enrage].y,
        FireRain_Progression[Ragnaros.iterator_soft_enrage].z, 0, 5)
    if (Ragnaros.iterator_soft_enrage ~= #FireRain_Progression) then
        Ragnaros.iterator_soft_enrage = Ragnaros.iterator_soft_enrage + 1
    else
        creature:RemoveEventById(eventId)
    end
end

function Ragnaros.OuterRain(eventId, delay, calls, creature)
    local pos_tbl = slice(Room_Positions, Ragnaros.iterator_fill_outer_room, 1)
    if pos_tbl == nil then
        creature:RemoveEventById(eventId)
    else
        local random_spawn = math.random(1, #pos_tbl)
        for i = 1, #pos_tbl[random_spawn] do
            creature:SpawnCreature(9000029, pos_tbl[random_spawn][i].x,
                pos_tbl[random_spawn][i].y, pos_tbl[random_spawn][i].z, 0, 5)
        end
        Ragnaros.iterator_fill_outer_room[random_spawn] = 1
    end
end

function Ragnaros.FireTrap(eventId, delay, calls, creature)
    local x = Trap_Pos[1].x
    local y = Trap_Pos[1].y
    local z = Trap_Pos[1].z
    local Yell = "WATCH WHERE YOU STAND!"
    creature:SendUnitYell(Yell, 0)
    creature:SpawnCreature(9000031, x, y, z, 0, 5)
end

function Ragnaros.AddsIntermission(eventId, delay, calls, creature)
    local n = 6
    local sample_targets = sample_r(1, #Intermission_Positions, n)
    for i = 1, #sample_targets do
        creature:SpawnCreature(9000032,
            Intermission_Positions[sample_targets[i]].x,
            Intermission_Positions[sample_targets[i]].y,
            Intermission_Positions[sample_targets[i]].z,
            Intermission_Positions[sample_targets[i]].o, 6, 3000)
    end
end

function Ragnaros.BigAdd(eventId, delay, calls, creature)
    local Yell = "COME FORTH MY SERVANTS! DEFEND YOUR MASTER!"
    creature:SendUnitYell(Yell, 0)
    creature:PlayDirectSound(8049)
    creature:SpawnCreature(9000033, 842.627747, -848.687866, -229.252960,
        6.174773, 5)
end
function Ragnaros.SpellSubmerge(eventId, delay, calls, creature)
    creature:CastSpell(creature, Ragnaros_Spells.SPELL_RAGSUBMERGE, 0)
    creature:CastSpell(creature, Ragnaros_Spells.SPELL_RAGNA_SUBMERGE_VISUAL, 0)
end

function Ragnaros.Phase1(eventId, delay, calls, creature)
    creature:RegisterEvent(Ragnaros.MoltenArmor, { 5000, 6500 }, 0)
    creature:RegisterEvent(Ragnaros.NoTank, 3500, 0)
    creature:RegisterEvent(Ragnaros.Submerge, 1000, 0)
    creature:RegisterEvent(Ragnaros.OuterRain, 25000, 0)
    creature:RegisterEvent(Ragnaros.LivingBomb, 25000, 0)
end



function Ragnaros.Submerge(eventId, delay, calls, creature)
    if (creature:HealthBelowPct(50)) then
        local yellOption = "MY PATIENCE IS DWINDLING! COME RATS, TO YOUR DEATH!"
        creature:SendUnitYell(yellOption, 0)
        creature:PlayDirectSound(8048)
        creature:CastSpell(creature, Ragnaros_Spells.PACIFY, 0)
        creature:AttackStop()
        creature:PerformEmote(374)
        --[[for i = 1, #Room_Positions, 1 do
            local x = Room_Positions[i].x
            local y = Room_Positions[i].y
            local z = Room_Positions[i].z
            creature:SpawnCreature(9000029, x, y, z, 0, 5)
        end--]]
        creature:RegisterEvent(Ragnaros.OuterRain, 200, 5)
        creature:RegisterEvent(Ragnaros.SpellSubmerge, 4500, 1)
        creature:RegisterEvent(Ragnaros.AddsIntermission, 10000, 2)
        creature:RegisterEvent(Ragnaros.Emerge, 35000, 1)
        creature:RemoveEventById(eventId)
    end
end

function Ragnaros.Emerge(eventId, delay, calls, creature)
    creature:RemoveAura(Ragnaros_Spells.SPELL_RAGSUBMERGE, 0)
    creature:RemoveAura(Ragnaros_Spells.PACIFY, 0)
    creature:AttackStop()
    local yellOption =
    "NOW, FOR YOU INSECTS, BOLDLY YOU SOUGHT THE POWER OF RAGNAROS! NOW YOU SHALL SEE IT FIRST HANDLY!"
    creature:SendUnitYell(yellOption, 0)
    creature:PerformEmote(374)
    creature:RemoveAura(Ragnaros_Spells.SPELL_RAGNA_SUBMERGE_VISUAL, 0)
    creature:PlayDirectSound(8045)
    creature:RegisterEvent(Ragnaros.Phase2, 1000, 1)
end

function Ragnaros.Phase2(eventId, delay, calls, creature)
    creature:RegisterEvent(Ragnaros.BigAdd, 35000, 0)
    creature:RegisterEvent(Ragnaros.FillRoom, 12000, 0)
    creature:RegisterEvent(Ragnaros.Phase3, 1000, 0)
end

function Ragnaros.Phase3(eventId, delay, calls, creature)
    if (creature:HealthBelowPct(25)) then
        creature:RegisterEvent(Ragnaros.FireTrap, { 5000, 5000 }, 0)
        creature:RemoveEventById(eventId)
    end
end

function Ragnaros.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Ragnaros.Phase1, 1000, 1)
    creature:SetInCombatWithZone()
end

function Ragnaros.OnLeaveCombat(event, creature)
    delete_creatures(9000029, creature)
    delete_creatures(9000030, creature)
    delete_creatures(9000031, creature)
    delete_creatures(9000032, creature)
    delete_creatures(9000033, creature)
    Ragnaros.iterator_soft_enrage = 1
    Ragnaros.iterator_fill_outer_room = { 0, 0, 0, 0, 0 }
    Room_Positions = Room_Positions_back
    creature:RemoveEvents()
end

function Ragnaros.OnDied(event, creature, killer)
    delete_creatures(9000029, creature)
    delete_creatures(9000030, creature)
    delete_creatures(9000031, creature)
    delete_creatures(9000032, creature)
    delete_creatures(9000033, creature)
    Ragnaros.iterator_soft_enrage = 1
    Ragnaros.iterator_fill_outer_room = { 0, 0, 0, 0, 0 }
    creature:PlayDirectSound(7555)
    Room_Positions = Room_Positions_back
    creature:RemoveEvents()
end

function Ragnaros.PreCombat(event, creature, target)
    creature:SetRooted(true)
end

function Ragnaros.OnKill(event, creature, victim)
    creature:PlayDirectSound(8051)
end

RegisterCreatureEvent(Ragnaros.id, 1, Ragnaros.OnEnterCombat)
RegisterCreatureEvent(Ragnaros.id, 2, Ragnaros.OnLeaveCombat)
RegisterCreatureEvent(Ragnaros.id, 4, Ragnaros.OnDied)
RegisterCreatureEvent(Ragnaros.id, 10, Ragnaros.PreCombat)


---Adds---

local RainFire = {
    id = 9000029
}
local RainFire_Spells = {

    RAIN_OF_FIRE = 19717
}

function RainFire.Rain(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature, RainFire_Spells.RAIN_OF_FIRE, true, 4000)
end

function RainFire.OnSpawn(event, creature, target)
    creature:RegisterEvent(RainFire.Rain, 5900, 0)
end

function RainFire.OnRemove(event, creature)
    creature:RemoveEvents()
end

function RainFire.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(RainFire.id, 5, RainFire.OnSpawn)
RegisterCreatureEvent(RainFire.id, 37, RainFire.OnRemove)
RegisterCreatureEvent(RainFire.id, 4, RainFire.OnDied)



local FireWall = {
    id = 9000030
}
local FireWall_Spells = {

    WALL = 43113

}


function FireWall.OnSpawn(event, creature, target)
    creature:CastCustomSpell(creature, FireWall_Spells.WALL, true)
    --creature:SendUnitYell(string.format("meu pai é %s", creature:GetCreatorGUID()), 0) Debug
    creature:SetScale(0.60)
    creature:SetDisableGravity()
    -- creature:SetHover(true)
    creature:SetSpeed(0, 10, true)
    local x, y, z, o = creature:GetLocation()
    local delta      = 50
    if (o == 0) then
        creature:MoveTo(1, x + delta, y, z, o, false)
    elseif (o > 1 and o < 2) then
        creature:MoveTo(2, x, y + delta, z, o, false)
    elseif (o > 3 and o < 4) then
        creature:MoveTo(3, x - delta, y, z, o, false)
    elseif (o > 4 and o < 5) then
        creature:MoveTo(4, x, y - delta, z, o, false)
    end
end

function FireWall.OnRemove(event, creature)
    creature:RemoveEvents()
end

function FireWall.OnReach(event, creature, type, id)
    delete_creatures(FireWall.id, creature)
end

function FireWall.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(FireWall.id, 5, FireWall.OnSpawn)
RegisterCreatureEvent(FireWall.id, 6, FireWall.OnReach)
RegisterCreatureEvent(FireWall.id, 2, FireWall.OnRemove)
RegisterCreatureEvent(FireWall.id, 4, FireWall.OnDied)

------------------------------------- FireTrap -------------------------------------
local FireTrap = {
    id = 9000031
}

local Visual_Trap = {
    id = 177704
}

function FireTrap.OnSpawn(event, creature, target)
    local x, y, z, o = creature:GetLocation()

    creature:SummonGameObject(Visual_Trap.id, x, y, z, o)
    creature:RegisterEvent(FireTrap.Explosion, 5900, 0)
    creature:RegisterEvent(FireTrap.CastMagmaWave, 6000, 0)
end

function FireTrap.Explosion(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature, 71151, true)
    delete_creatures(FireTrap.id, creature)
    creature:RemoveEventById(eventId)
end

function FireTrap.CastMagmaWave(eventId, delay, calls, creature)
    local delta = 0.8
    local coef_x = { 1, 0, -1, 0 }
    local coef_y = { 0, 1, 0, -1 }
    local x, y, z, o = creature:GetLocation()
    for i = 1, 4, 1 do
        local Wave_Creature = creature:SpawnCreature(FireWall.id,
            x + delta * coef_x[i], y + delta * coef_y[i], z, (math.pi / 2) *
            (i - 1), 5)
        Wave_Creature:SetCreatorGUID(creature:GetGUID())
    end
    creature:RemoveEventById(eventId)
end

function FireTrap.OnRemove(event, creature)
    creature:RemoveEvents()
end

function FireTrap.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(FireTrap.id, 5, FireTrap.OnSpawn)
RegisterCreatureEvent(FireTrap.id, 2, FireTrap.OnRemove)
RegisterCreatureEvent(FireTrap.id, 4, FireTrap.OnDied)

------------------------------------- Intermission Add -------------------------------------

local SonOfFlame = {
    id = 9000032
}

local SonOfFlame_Spells = {
    FIREBALL = 68926
}

function SonOfFlame.OnSpawn(event, creature, target)
    local players = creature:GetPlayersInRange()
    creature:Attack(players[math.random(1, #players)])
end

function SonOfFlame.Fireball(eventId, delay, calls, creature)
    local players = creature:GetPlayersInRange()
    creature:CastCustomSpell(players[math.random(1, #players)],
        SonOfFlame_Spells.FIREBALL, false, damage_calc(1200))
end

function SonOfFlame.OnCombat(event, creature, target)
    creature:RegisterEvent(SonOfFlame.Fireball, { 5500, 6900 }, 0)
end

function SonOfFlame.OnRemove(event, creature)
    creature:RemoveEvents()
end

function SonOfFlame.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(SonOfFlame.id, 1, SonOfFlame.OnCombat)
RegisterCreatureEvent(SonOfFlame.id, 5, SonOfFlame.OnSpawn)
RegisterCreatureEvent(SonOfFlame.id, 2, SonOfFlame.OnRemove)
RegisterCreatureEvent(SonOfFlame.id, 4, SonOfFlame.OnDied)


------------------------------------- Big Add -------------------------------------
local LivingFlame = {
    id = 9000033
}
local LivingFlame_Spells = {
    HEAT_WAVE = 90005
}

function LivingFlame.HeatWave(eventId, delay, calls, creature)
    creature:CastCustomSpell(creature, LivingFlame_Spells.HEAT_WAVE, false, 2500)
end

function LivingFlame.OnSpawn(event, creature, target)
    local players = creature:GetPlayersInRange()
    creature:Attack(players[math.random(1, #players)])
end

function LivingFlame.OnCombat(event, creature, target)
    creature:RegisterEvent(LivingFlame.HeatWave, 6000, 0)
end

function LivingFlame.OnRemove(event, creature)
    creature:RemoveEvents()
end

function LivingFlame.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(LivingFlame.id, 1, LivingFlame.OnCombat)
RegisterCreatureEvent(LivingFlame.id, 5, LivingFlame.OnSpawn)
RegisterCreatureEvent(LivingFlame.id, 2, LivingFlame.OnRemove)
RegisterCreatureEvent(LivingFlame.id, 4, LivingFlame.OnDied)
------------------------------------- FireTrap Visual Indicator -------------------------------------

function Visual_Trap.despawn(eventId, delay, repeats, go)
    go:Despawn()
end

function Visual_Trap.OnSpawn(event, go)
    go:RegisterEvent(Visual_Trap.despawn, 6000, 0)
end

RegisterGameObjectEvent(Visual_Trap.id, 2, Visual_Trap.OnSpawn)
