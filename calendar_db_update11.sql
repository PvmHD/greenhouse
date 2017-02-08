CREATE TABLE IF NOT EXISTS `current_editing` (
  `current_editing_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `edit_date` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`current_editing_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

REPLACE INTO `calendar_options` ( `name`, `value`, `section`, `calendar_id`, `update_date` ) SELECT  'show_description_field', 1, '', `calendar_id`, NOW() FROM `calendars` c;