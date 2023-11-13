-- DB update 2021_09_24_02 -> 2021_09_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_24_02 2021_09_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632231511675504900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632231511675504900');

DELETE FROM `areatrigger_teleport` WHERE `ID` IN (4233, 4267);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_27_00' WHERE sql_rev = '1632231511675504900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
