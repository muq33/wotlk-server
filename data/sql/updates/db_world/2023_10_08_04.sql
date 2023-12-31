-- DB update 2023_10_08_03 -> 2023_10_08_04
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1561,3643) AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Sealed Crate
(1561, 1, 0, 0, 19, 0, 100, 0, 74, 0, 0, 0, 0, 0, 12, 2044, 1, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -8841.93, 985.171, 98.6999, 6.00926, 'Sealed Crate - On Quest \'The Legend of Stalvan\' Taken - Summon Creature \'Forlorn Spirit\''),
-- Old Footlocker
(3643, 1, 0, 0, 20, 0, 100, 0, 67, 0, 0, 0, 0, 0, 12, 2044, 2, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -10951.4, 1568.86, 46.9779, 3.75142, 'Old Footlocker - On Quest \'The Legend of Stalvan\' Finished - Summon Creature \'Forlorn Spirit\'');

-- Forlorn Spirit
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2044 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 204400 AND `source_type` = 9;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2044, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 204400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - On Respawn - Run Script'),
(2044, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 0, 11, 3105, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - In Combat - Cast \'Curse of Stalvan\''),
(2044, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 18500, 27000, 0, 0, 11, 118, 32, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - In Combat - Cast \'Polymorph\' (Skip Tank)'),
(204400, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - Actionlist - Say Line 0'),
(204400, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - Actionlist - Start Attacking');
