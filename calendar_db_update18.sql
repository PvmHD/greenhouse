ALTER TABLE `events` ADD `repeating_divergent` TINYINT(1) NOT NULL DEFAULT '0' AFTER `repeating_event_id`;

ALTER TABLE `events` ADD `dropdown1_option_id` VARCHAR(255) NULL AFTER `calendar_id`, ADD `dropdown2_option_id` VARCHAR(255) NULL AFTER `dropdown1_option_id`;

CREATE TABLE IF NOT EXISTS `custom_fields` (
  `field_id` int(11) NOT NULL,
  `field_type` varchar(55) NOT NULL,
  `label` varchar(255) NOT NULL,
  `default_value` varchar(255) NOT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `custom_fields_options` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` INT(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `color` varchar(10) NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `custom_fields` ADD `visible` TINYINT(1) NOT NULL DEFAULT '0' AFTER `default_value`;

INSERT INTO `custom_fields` (`field_id`, `field_type`, `label`, `default_value`, `visible`) VALUES
(1, 'dropdown', '', '', 0),
(2, 'dropdown', '', '', 0);


ALTER TABLE `users` ADD `trial` TINYINT(1) NOT NULL DEFAULT '0' AFTER `user_info`;


