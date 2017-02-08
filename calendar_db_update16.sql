
ALTER TABLE `calendar_dditems` ADD `nightshift` TINYINT(1) NOT NULL DEFAULT '0' AFTER `endtime`;

update `events` set `date_end` = DATE_ADD(`date_start`, INTERVAL 1 DAY) WHERE `date_start` = `date_end` AND `time_start` > `time_end`;

