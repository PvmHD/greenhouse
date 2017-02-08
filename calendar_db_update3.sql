ALTER TABLE `calendars` CHANGE `share_type` `share_type` ENUM( 'private', 'shared', 'public', 'public_open', 'private_group' ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;

ALTER TABLE `settings` DROP `setting_id` ;

ALTER TABLE `calendars` ADD `can_delete` TINYINT( 1 ) NOT NULL DEFAULT '0' AFTER `can_edit` ;

ALTER TABLE `calendars` CHANGE `can_dd_drag` `can_dd_drag` VARCHAR( 55 ) NULL DEFAULT NULL ;

UPDATE `calendars` SET `can_dd_drag` = "only_owner" WHERE `can_dd_drag` =0;

ALTER TABLE `calendars` ADD `can_change_color` TINYINT( 1 ) NOT NULL DEFAULT '0' AFTER `can_delete` ;