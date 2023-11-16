
local NpcId = 9000000
local MenuId = 99999 -- Unique ID to recognice player gossip menu among others

local function OnGossipHello(event, player, object)
    player:GossipClearMenu() -- required for player gossip
    player:GossipMenuAddItem(0, "MC 10HC", 1, 1)
    player:GossipMenuAddItem(0, "AQ40", 1, 2)
    player:GossipSendMenu(1, object, MenuId) -- MenuId required for player gossip
end

local function OnGossipSelect(event, player, object, sender, intid, code, menuid)
    if (intid == 1) then
        player:Teleport( 409, 1082.040039, -474.596008, -107.762001, 5.02623)
    elseif (intid == 2) then
        player:Teleport( 531, -8210.090820, 2041.079712, 129.519592, 1.290410)
    end
end

RegisterCreatureGossipEvent(NpcId, 1, OnGossipHello)
RegisterCreatureGossipEvent(NpcId, 2, OnGossipSelect)
RegisterPlayerGossipEvent(MenuId, 2, OnGossipSelect)