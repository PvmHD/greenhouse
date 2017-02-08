ALTER TABLE `log` ADD `event_id` INT(11) NULL AFTER `user_id`;
ALTER TABLE `log` ADD `ip` VARCHAR(55) NOT NULL AFTER `date`;
ALTER TABLE `log` ADD `info` VARCHAR(255) NULL AFTER `ip`;

ALTER TABLE `calendars` ADD `all_event_mods_to_admin_when_loggedin` TINYINT(1) NOT NULL DEFAULT '0' AFTER `all_event_mods_to_admin`;


ALTER TABLE `calendars` CHANGE `calendar_admin_email` `calendar_admin_email` VARCHAR(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

