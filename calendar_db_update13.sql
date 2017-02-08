
UPDATE `calendars` SET `can_view` =1 WHERE `share_type` = 'public';

UPDATE `calendars` SET `can_view` =0 WHERE `share_type` = 'private';

ALTER TABLE `groups` ADD `deleted` INT( 11 ) NOT NULL DEFAULT '0';



