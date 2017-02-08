CREATE TABLE IF NOT EXISTS `schedule` (
  `job_id` int(11) NOT NULL auto_increment,
  `jobname` varchar(255) NOT NULL,
  `last_exec_date` datetime NOT NULL,
  PRIMARY KEY  (`job_id`),
  UNIQUE KEY `jobname` (`jobname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
