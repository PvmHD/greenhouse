
ALTER TABLE `calendars` ADD `active` ENUM( 'yes', 'no', 'period' ) NULL DEFAULT 'yes' AFTER `initial_show` ;

ALTER TABLE `calendars` ADD `alterable_startdate` DATE NULL DEFAULT NULL AFTER `cal_enddate` ,
ADD `alterable_enddate` DATE NULL DEFAULT NULL AFTER `alterable_startdate` ;

ALTER TABLE `users` ADD `user_info` TEXT NULL ;


