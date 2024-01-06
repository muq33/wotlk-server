---Boss---
local Ragnaros = {
    id = 9000028,
    iterator = 1
}

local Ragnaros_Spells =
{
    -- Ragnaros
    MOLTEN_ARMOR                = 90004,
    SPELL_RAGSUBMERGE           = 21107,             -- Stealth aura
    SPELL_RAGNA_SUBMERGE_VISUAL = 20567,             -- Visual for submerging into lava
    SPELL_RAGEMERGE             = 20568,
    PACIFY                      = 6462
    --SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,
};

local Room_Positions = {
    { x = 889.576843, y = -826.231812, z = -227.440445 },
    { x = 883.434021, y = -806.195496, z = -227.241013 },
    { x = 878.229614, y = -795.493896, z = -228.112762 },
    { x = 868.630371, y = -783.562622, z = -225.409958 },
    { x = 850.302429, y = -779.591980, z = -226.223862 },
    { x = 832.326782, y = -782.567261, z = -226.202072 },
    { x = 817.800171, y = -787.241028, z = -225.957047 },
    { x = 859.894714, y = -783.109436, z = -226.938370 },
    { x = 858.796265, y = -781.267822, z = -226.297119 },
    { x = 851.744263, y = -777.414917, z = -226.276627 },
    { x = 839.871948, y = -774.623535, z = -225.755722 },
    { x = 846.228394, y = -760.636353, z = -224.670654 },
    { x = 833.640259, y = -764.077576, z = -224.358215 },
    { x = 818.647339, y = -771.262329, z = -225.070818 },
    { x = 807.515564, y = -793.069031, z = -225.863861 },
    { x = 799.818665, y = -799.396057, z = -226.061050 },
    { x = 792.085388, y = -809.329773, z = -226.109985 },
    { x = 788.922058, y = -821.969482, z = -226.393250 },
    { x = 778.785645, y = -826.071960, z = -225.827469 },
    { x = 839.974670, y = -890.132507, z = -220.875610 },
    { x = 824.385803, y = -886.506165, z = -226.143219 },
    { x = 811.696106, y = -881.236572, z = -225.270004 },
    { x = 798.718079, y = -870.745972, z = -226.221756 }
}

local Intermission_Positions = {
    { x = 873.106567, y = -834.991638, z = -230.355591, o = 2.522876 },
    { x = 868.095764, y = -817.550171, z = -230.991623, o = 3.606388 },
    { x = 867.205078, y = -853.536560, z = -230.354477, o = 2.694532 },
    { x = 860.316101, y = -870.889771, z = -230.361588, o = 2.008879 }
}

local FireRain_Progression = {
    { x = 796.589111, y = -840.385925, z = -228.485519},
    { x = 799.344116, y = -853.100525, z = -227.169022},
    { x = 815.835449, y = -843.561462, z = -229.817688},
    { x = 822.617065, y = -853.745911, z = -229.082672},
    { x = 833.129639, y = -858.807617, z = -229.334229},
    { x = 836.434998, y = -848.706055, z = -229.333862},
    { x = 847.923157, y = -855.005310, z = -229.033981},
    { x = 856.764893, y = -843.758911, z = -228.546402},
    { x = 856.009968, y = -830.026245, z = -228.592636},
    { x = 852.974609, y = -821.351746, z = -229.225586},
    { x = 845.246826, y = -812.890869, z = -229.987350},
    { x = 835.387146, y = -811.302185, z = -229.068771}
}
local Trap_Pos = {
    { x = 849.682190, y = -855.827515, z = -228.829956 }
}

local function sample_r(star, en, n)
    local random_numbers = {}
    for i = 1, n, 1 do
        random_numbers[i] = math.random(star, en)
    end
    return random_numbers
end
local function delete_creatures(id, creature)
    local InRange = creature:GetCreaturesInRange(100, id)
    for index, Mob in pairs(InRange) do
        Mob:Kill(Mob)
    end
end

function Ragnaros.MoltenArmor(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Ragnaros_Spells.MOLTEN_ARMOR, true)
end

function Ragnaros.FillRoom(eventId, delay, calls, creature)
    creature:SpawnCreature(9000029, FireRain_Progression[Ragnaros.iterator].x,
    FireRain_Progression[Ragnaros.iterator].y,  FireRain_Progression[Ragnaros.iterator].z, 0, 5)
    if (Ragnaros.iterator ~= #FireRain_Progression) then
        Ragnaros.iterator = Ragnaros.iterator + 1
    else
        creature:RemoveEventById(eventId)
    end
    
end

function Ragnaros.FireTrap(eventId, delay, calls, creature)
    local x = Trap_Pos[1].x
    local y = Trap_Pos[1].y
    local z = Trap_Pos[1].z
    creature:SpawnCreature(9000031, x, y, z, 0, 5)
end

function Ragnaros.AddsIntermission(eventId, delay, calls, creature)
    local n = 6
    local sample_targets = sample_r(1, #Intermission_Positions, n)
    for i = 1, #sample_targets do
        creature:SpawnCreature(9000032, Intermission_Positions[sample_targets[i]].x,
            Intermission_Positions[sample_targets[i]].y, Intermission_Positions[sample_targets[i]].z,
            Intermission_Positions[sample_targets[i]].o, 6, 3000)
    end
end

function Ragnaros.BigAdd(eventId, delay, calls, creature)
    local Yell = "Rise my servant! Slay these intruders!"
    creature:SendUnitYell(Yell, 0)
    creature:SpawnCreature(9000033, 842.627747, -848.687866, -229.252960, 6.174773, 5)
end
function Ragnaros.Phase1(eventId, delay, calls, creature)
    creature:RegisterEvent(Ragnaros.MoltenArmor, {5000, 6500}, 0)
    creature:RegisterEvent(Ragnaros.Submerge, 1000, 0)
end
function Ragnaros.SpellSubmerge(eventId, delay, calls, creature)
    creature:CastSpell(creature, Ragnaros_Spells.SPELL_RAGSUBMERGE, 0)
    creature:CastSpell(creature, Ragnaros_Spells.SPELL_RAGNA_SUBMERGE_VISUAL, 0)
end
function Ragnaros.Submerge(eventId, delay, calls, creature)
    if (creature:HealthBelowPct(50)) then
        local yellOption = "MORTALS! YOU SHALL PERISH!"
        creature:SendUnitYell(yellOption, 0)
        creature:CastSpell(creature, Ragnaros_Spells.PACIFY, 0)
        creature:AttackStop()
        creature:PerformEmote(374)
        for i = 1, #Room_Positions, 1 do
            local x = Room_Positions[i].x
            local y = Room_Positions[i].y
            local z = Room_Positions[i].z
            creature:SpawnCreature(9000029, x, y, z, 0, 5)
        end
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
    creature:PerformEmote(374)
    creature:RemoveAura(Ragnaros_Spells.SPELL_RAGNA_SUBMERGE_VISUAL, 0)
    creature:RegisterEvent(Ragnaros.Phase2, 1000, 1)
end

function Ragnaros.Phase2(eventId, delay, calls, creature)
    creature:RegisterEvent(Ragnaros.BigAdd, 35000, 0)
    creature:RegisterEvent(Ragnaros.FillRoom, 10000 , 0)
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
    Ragnaros.iterator = 1
    creature:RemoveEvents()
end

function Ragnaros.OnDied(event, creature, killer)
    delete_creatures(9000029, creature)
    delete_creatures(9000030, creature)
    delete_creatures(9000031, creature)
    delete_creatures(9000032, creature)
    delete_creatures(9000033, creature)
    Ragnaros.iterator = 1
    creature:RemoveEvents()
end

function Ragnaros.PreCombat(event, creature, target)
    creature:SetRooted(true)
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


local SonOfFlame = {
    id = 9000032
}

local SonOfFlame_Spells = {
    FIREBALL            = 68926
}

function SonOfFlame.OnSpawn(event, creature, target)
    local players = creature:GetPlayersInRange()
    creature:Attack(players[math.random(1,#players)])
end

function SonOfFlame.Fireball(eventId, delay, calls, creature)
    local players = creature:GetPlayersInRange()
    creature:CastCustomSpell(players[math.random(1,#players)], SonOfFlame_Spells.FIREBALL, false, 1500)
end

function SonOfFlame.OnCombat(event, creature, target)
    creature:RegisterEvent(SonOfFlame.Fireball, {5500,6900}, 0)
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
    creature:Attack(players[math.random(1,#players)])
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
-- Props

function Visual_Trap.despawn(eventId, delay, repeats, go)
    go:Despawn()
end

function Visual_Trap.OnSpawn(event, go)
    go:RegisterEvent(Visual_Trap.despawn, 6000, 0)
end

RegisterGameObjectEvent(Visual_Trap.id, 2, Visual_Trap.OnSpawn)
