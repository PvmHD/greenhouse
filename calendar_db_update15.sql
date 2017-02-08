
ALTER TABLE `calendar_dditems` ADD `starttime` VARCHAR( 55 ) NULL AFTER `info` ,
ADD `endtime` VARCHAR( 55 ) NULL AFTER `starttime` ;

ALTER TABLE `calendar_dditems` ADD `allDay` TINYINT( 1 ) NOT NULL DEFAULT '1' AFTER `endtime` ;

ALTER TABLE calendar_dditems DROP FOREIGN KEY calendar_dditems_ibfk_1;

ALTER TABLE `calendar_dditems` DROP INDEX `calendar_id` ;

ALTER TABLE `calendar_dditems` ADD INDEX(`calendar_id`);

ALTER TABLE `calendar_dditems` ADD FOREIGN KEY (`calendar_id`) REFERENCES `calendars`(`calendar_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `users` CHANGE `infix` `infix` VARCHAR( 15 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL ;

ALTER TABLE `calendars` ADD `order_id` INT(11) NOT NULL AFTER `all_event_mods_to_admin`;

