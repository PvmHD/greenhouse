
CREATE TABLE IF NOT EXISTS `event_files` (
  `event_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `filename` varchar(55) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `file_extension` varchar(5) NOT NULL,
  `type` varchar(255) NOT NULL,
  `upload_date` datetime NOT NULL,
  `create_id` int(11) NOT NULL,
  PRIMARY KEY (`event_file_id`),
  UNIQUE KEY `filename` (`filename`,`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

