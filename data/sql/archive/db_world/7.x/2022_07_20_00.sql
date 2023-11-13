-- DB update 2022_07_19_04 -> 2022_07_20_00
--
SET @NPC := 42880;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x`=-10661, `position_y`=-3924.57, `position_z`=18.8015, `orientation`=5.83672, `MovementType`='2' WHERE  `guid`=@NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES 
(@PATH, 1, -10641.5, -3982.49, 19.943),
(@PATH, 2, -10591, -3982.21, 21.4646),
(@PATH, 3, -10574.5, -3995.66, 18.5265),
(@PATH, 4, -10556.4, -4008.31, 19.5063),
(@PATH, 5, -10541.2, -4012.2, 22.3642),
(@PATH, 6, -10510.2, -4016.9, 18.3724),
(@PATH, 7, -10482.4, -4010.78, 18.9192),
(@PATH, 8, -10475.6, -4003.55, 19.5199),
(@PATH, 9, -10460.1, -3998.53, 18.5604),
(@PATH, 10, -10434, -4005, 18.5093),
(@PATH, 11, -10408.6, -4010.32, 18.2372),
(@PATH, 12, -10387.1, -3999.93, 19.7943),
(@PATH, 13, -10363.4, -3997.07, 19.3136),
(@PATH, 14, -10343.3, -4003.71, 20.5207),
(@PATH, 15, -10328.6, -4013.14, 18.4205),
(@PATH, 16, -10335.8, -4029.01, 19.4894),
(@PATH, 17, -10325.5, -4054.12, 19.7849),
(@PATH, 18, -10315.2, -4078.22, 22.4922),
(@PATH, 19, -10296, -4123.39, 23.2141),
(@PATH, 20, -10301, -4143.57, 19.8863),
(@PATH, 21, -10322.1, -4159.15, 18.3385),
(@PATH, 22, -10357.8, -4178.26, 20.1807),
(@PATH, 23, -10379.9, -4192.31, 22.7909),
(@PATH, 24, -10419, -4192.8, 19.1422),
(@PATH, 25, -10441.2, -4184.96, 18.6967),
(@PATH, 26, -10480, -4193.1, 18.9901),
(@PATH, 27, -10495, -4205.67, 19.6285),
(@PATH, 28, -10511.9, -4209.93, 19.0212),
(@PATH, 29, -10547.4, -4199.08, 18.7961),
(@PATH, 30, -10564.6, -4187.57, 19.3169),
(@PATH, 31, -10581, -4203.9, 20.3609),
(@PATH, 32, -10594, -4205.64, 21.6639),
(@PATH, 33, -10620.6, -4211.36, 23.3686),
(@PATH, 34, -10673.5, -4191.09, 22.867),
(@PATH, 35, -10710.4, -4172.44, 21.8668),
(@PATH, 36, -10723.1, -4139.99, 18.6405),
(@PATH, 37, -10745.3, -4114.88, 19.7025),
(@PATH, 38, -10749.3, -4070.5, 20.6484),
(@PATH, 39, -10756.1, -4048.57, 22.868),
(@PATH, 40, -10742.5, -4002.81, 20.3069),
(@PATH, 41, -10701.2, -3956.85, 23.3119),
(@PATH, 42, -10662.1, -3926.38, 19.4344);
