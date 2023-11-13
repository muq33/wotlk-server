-- DB update 2020_09_04_02 -> 2020_09_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_04_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_04_02 2020_09_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598881203255566000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881203255566000');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5 */ 
SET @Build := 12340;

UPDATE `item_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (54576, 54577, 54578, 54579, 54580, 54581, 54582, 54583, 54584, 54585, 54586, 54587, 54588, 54589, 54590, 54591, 53125, 53126, 53127, 53129, 53132, 53133, 53134, 53486, 53487, 53488, 53489, 53490, 54556, 54557, 54558, 54559, 54560, 54561, 54562, 54563, 54564, 54565, 54566, 54567, 54569, 54571, 54572, 54573, 53103, 53110, 53111, 53112, 53113, 53114, 53115, 53116, 53117, 53118, 53119, 53121, 37337, 53097, 54617, 54452, 54068, 54651, 54653, 56806, 52276, 52541, 52562, 52563, 52565, 52706, 52709, 52729, 53510, 53637, 54455);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
