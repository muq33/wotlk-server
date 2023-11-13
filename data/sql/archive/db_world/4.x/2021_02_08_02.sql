-- DB update 2021_02_08_01 -> 2021_02_08_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_02_08_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_02_08_01 2021_02_08_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1612120176958459300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612120176958459300');

UPDATE `creature_template` SET `AIName` = "" WHERE `entry` IN (15549,15556,15557,15558,15559,15560,15561,15562,15563,15564,15565,15566,15567,15568,15569,15570,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15585,15586,15587,15588,15592,15593,15594,15595,15596,15597,15598,15599,15600,15601,15602,15603,15604,15605,15606,15607,15871,30348,30357,30358,30359,30360,30362,30363,30364,30365,30367,30368,30369,30370,30371,30372,30373,30374,30375,30531,30533,30534,30535,30536,30537,30538);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (15549,15556,15557,15558,15559,15560,15561,15562,15563,15564,15565,15566,15567,15568,15569,15570,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15585,15586,15587,15588,15592,15593,15594,15595,15596,15597,15598,15599,15600,15601,15602,15603,15604,15605,15606,15607,15871,30348,30357,30358,30359,30360,30362,30363,30364,30365,30367,30368,30369,30370,30371,30372,30373,30374,30375,30531,30533,30534,30535,30536,30537,30538) AND `source_type` = 0;
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (15549,15556,15557,15558,15559,15560,15561,15562,15563,15564,15565,15566,15567,15568,15569,15570,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15585,15586,15587,15588,15592,15593,15594,15595,15596,15597,15598,15599,15600,15601,15602,15603,15604,15605,15606,15607,15871,30348,30357,30358,30359,30360,30362,30363,30364,30365,30367,30368,30369,30370,30371,30372,30373,30374,30375,30531,30533,30534,30535,30536,30537,30538);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (15549,15556,15557,15558,15559,15560,15561,15562,15563,15564,15565,15566,15567,15568,15569,15570,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15585,15586,15587,15588,15592,15593,15594,15595,15596,15597,15598,15599,15600,15601,15602,15603,15604,15605,15606,15607,15871,30348,30357,30358,30359,30360,30362,30363,30364,30365,30367,30368,30369,30370,30371,30372,30373,30374,30375,30531,30533,30534,30535,30536,30537,30538));
DELETE FROM `creature_template_addon` WHERE `entry` IN (15549,15556,15557,15558,15559,15560,15561,15562,15563,15564,15565,15566,15567,15568,15569,15570,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15585,15586,15587,15588,15592,15593,15594,15595,15596,15597,15598,15599,15600,15601,15602,15603,15604,15605,15606,15607,15871,30348,30357,30358,30359,30360,30362,30363,30364,30365,30367,30368,30369,30370,30371,30372,30373,30374,30375,30531,30533,30534,30535,30536,30537,30538);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(15549,0,0,0,4097,0,"25824"),
(15556,0,0,0,4097,0,"25824"),
(15557,0,0,0,4097,0,"25824"),
(15558,0,0,0,4097,0,"25824"),
(15559,0,0,0,4097,0,"25824"),
(15560,0,0,0,4097,0,"25824"),
(15561,0,0,0,4097,0,"25824"),
(15562,0,0,0,4097,0,"25824"),
(15563,0,0,0,4097,0,"25824"),
(15564,0,0,0,4097,0,"25824"),
(15565,0,0,0,4097,0,"25824"),
(15566,0,0,0,4097,0,"25824"),
(15567,0,0,0,4097,0,"25824"),
(15568,0,0,0,4097,0,"25824"),
(15569,0,0,0,4097,0,"25824"),
(15570,0,0,0,4097,0,"25824"),
(15572,0,0,0,4097,0,"25824"),
(15573,0,0,0,4097,0,"25824"),
(15574,0,0,0,4097,0,"25824"),
(15575,0,0,0,4097,0,"25824"),
(15576,0,0,0,4097,0,"25824"),
(15577,0,0,0,4097,0,"25824"),
(15578,0,0,0,4097,0,"25824"),
(15579,0,0,0,4097,0,"25824"),
(15580,0,0,0,4097,0,"25824"),
(15581,0,0,0,4097,0,"25824"),
(15582,0,0,0,4097,0,"25824"),
(15583,0,0,0,4097,0,"25824"),
(15584,0,0,0,4097,0,"25824"),
(15585,0,0,0,4097,0,"25824"),
(15586,0,0,0,4097,0,"25824"),
(15587,0,0,0,4097,0,"25824"),
(15588,0,0,0,4097,0,"25824"),
(15592,0,0,0,4097,0,"25824"),
(15593,0,0,0,4097,0,"25824"),
(15594,0,0,0,4097,0,"25824"),
(15595,0,0,0,4097,0,"25824"),
(15596,0,0,0,4097,0,"25824"),
(15597,0,0,0,4097,0,"25824"),
(15598,0,0,0,4097,0,"25824"),
(15599,0,0,0,4097,0,"25824"),
(15600,0,0,0,4097,0,"25824"),
(15601,0,0,0,4097,0,"25824"),
(15602,0,0,0,4097,0,"25824"),
(15603,0,0,0,4097,0,"25824"),
(15604,0,0,0,4097,0,"25824"),
(15605,0,0,0,4097,0,"25824"),
(15606,0,0,0,4097,0,"25824"),
(15607,0,0,0,4097,0,"25824"),
(15871,0,0,0,4097,0,"25824"),
(30348,0,0,0,4097,0,"25824"),
(30357,0,0,0,4097,0,"25824"),
(30358,0,0,0,4097,0,"25824"),
(30359,0,0,0,4097,0,"25824"),
(30360,0,0,0,4097,0,"25824"),
(30362,0,0,0,4097,0,"25824"),
(30363,0,0,0,4097,0,"25824"),
(30364,0,0,0,4097,0,"25824"),
(30365,0,0,0,4097,0,"25824"),
(30367,0,0,0,4097,0,"25824"),
(30368,0,0,0,4097,0,"25824"),
(30369,0,0,0,4097,0,"25824"),
(30370,0,0,0,4097,0,"25824"),
(30371,0,0,0,4097,0,"25824"),
(30372,0,0,0,4097,0,"25824"),
(30373,0,0,0,4097,0,"25824"),
(30374,0,0,0,4097,0,"25824"),
(30375,0,0,0,4097,0,"25824"),
(30531,0,0,0,4097,0,"25824"),
(30533,0,0,0,4097,0,"25824"),
(30534,0,0,0,4097,0,"25824"),
(30535,0,0,0,4097,0,"25824"),
(30536,0,0,0,4097,0,"25824"),
(30537,0,0,0,4097,0,"25824"),
(30538,0,0,0,4097,0,"25824");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
