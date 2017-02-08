CREATE TABLE IF NOT EXISTS `calendar_locations` (
`location_id` int( 11 ) NOT NULL AUTO_INCREMENT ,
`calendar_id` int( 11 ) NOT NULL ,
`name` varchar( 255 ) NOT NULL ,
PRIMARY KEY ( `location_id` ) ,
UNIQUE KEY `calendar_id` ( `calendar_id` , `name` )
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT =1;

CREATE TABLE IF NOT EXISTS `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `group_users` (
  `group_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`group_user_id`),
  UNIQUE KEY `group_id` (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

REPLACE INTO `groups` (`name`, admin_id)
    SELECT CONCAT("group: ",lastname), user_id
    FROM users  WHERE `usertype` = "admin" AND `deleted` = 0;

REPLACE INTO `group_users` ( user_id, group_id )
    SELECT `user_id` , `group_id`
    FROM `users` u
    LEFT JOIN `groups` g ON ( g.admin_id = u.admin_group )
    WHERE `usertype` = "user"
    AND `deleted` =0;

ALTER TABLE `group_users` ADD INDEX ( `user_id` ) ;

ALTER TABLE `group_users` ADD INDEX ( `group_id` ) ;

ALTER TABLE `calendars` ADD `usergroup_id` INT( 11 ) NULL AFTER `share_type` ;

ALTER TABLE `group_users`
  ADD CONSTRAINT `group_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_users_group_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE;



UPDATE `calendars` c1 SET usergroup_id = ( SELECT group_id
FROM `groups`
WHERE admin_id = c1.creator_id
AND share_type = 'private_group' );

ALTER TABLE `repeating_events` ADD `every_x_days` INT( 11 ) NOT NULL AFTER `rep_interval` ;

ALTER TABLE `calendars` ADD `origin` VARCHAR( 255 ) NOT NULL DEFAULT 'default' AFTER `name` ;

CREATE TABLE IF NOT EXISTS `calendar_options` (
  `name` varchar(55) NOT NULL,
  `value` varchar(55) NOT NULL,
  `section` varchar(55) NOT NULL,
  `calendar_id` int(11) DEFAULT NULL,
  `update_date` datetime NOT NULL,
  UNIQUE KEY `name` (`name`,`section`,`calendar_id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `calendar_options` CHANGE `value` `value` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;


ALTER TABLE `repeating_events` ADD `every_x_weeks` INT( 11 ) NOT NULL AFTER `every_x_days` ;

ALTER TABLE `events` ADD INDEX ( `calendar_id` ) ;

