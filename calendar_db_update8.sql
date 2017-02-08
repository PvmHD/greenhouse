ALTER TABLE `calendar_dditems` ADD `color` VARCHAR( 15 ) NULL ;

ALTER TABLE `events` ADD `myurl` VARCHAR( 1024 ) NULL AFTER `phone` ;

ALTER TABLE `calendar_dditems` CHANGE `position` `info` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;

ALTER TABLE `calendar_dditems` DROP `phone` ;