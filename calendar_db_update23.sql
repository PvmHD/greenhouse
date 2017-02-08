

ALTER TABLE `calendars` ADD `calendar_textcolor` VARCHAR(55) NULL AFTER `calendar_color`;

ALTER TABLE `events` ADD `dropdown3_option_id` INT(11) NULL AFTER `dropdown2_option_id`, ADD `dropdown4_option_id` INT(11) NULL AFTER `dropdown3_option_id`, ADD `dropdown5_option_id` INT(11) NULL AFTER `dropdown4_option_id`;

ALTER TABLE `users` ADD `user_color` VARCHAR(10) NOT NULL AFTER `user_info`;

ALTER TABLE `events` CHANGE `team_member_id` `team_member_id` VARCHAR(255) NULL DEFAULT NULL;

SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `events` ADD UNIQUE( `title`, `date_start`, `time_start`, `date_end`, `time_end`, `allDay`, `user_id`, `calendar_id`);
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `users` ADD `phone` VARCHAR(55) NULL AFTER `email`;

