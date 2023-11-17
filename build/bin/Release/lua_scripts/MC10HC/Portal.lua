-- The ID's of the two invisible npc's (use  displayid 11686 for invisible, scale 0.01 (optional) and in game target  him and do .mod flags -10 to make him untargetable)
local portal_mc = {
    id = 9000005
}
-- Entrance

function portal_mc.InvisPortal_OnSpawn(event, creature, diff)
    creature:RegisterEvent(portal_mc.Check_for_players_invis_portal, 2000, 0) --  1000 (1 second) is more effective but uses up more server resources
end

function portal_mc.Check_for_players_invis_portal(event, creature, diff)
    for a, plrs in pairs(creature:GetPlayersInRange(5)) do
        if plrs ~= nil then
            local difficulty = plrs:GetDifficulty()
            if creature:GetDistance(plrs) < 5 and difficulty == 2 then
                if plrs:IsInGroup() then
                    plrs:Teleport( 409, 1082.040039, -474.596008, -107.762001, 5.02623)
                else
                    plrs:SendAreaTriggerMessage("|CFFff0000You must be in a raid group!|R")
                end
            end
        end
    end
end

RegisterCreatureEvent(portal_mc.id, 7, portal_mc.Check_for_players_invis_portal)