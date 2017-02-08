/* not implemented yet
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `payer_email` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `amount` float NOT NULL,
  `currency` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `txn_id` varchar(100) NOT NULL,
  `txn_type` varchar(100) NOT NULL,
  `payer_id` varchar(155) NOT NULL,
  `payment_status` varchar(100) NOT NULL,
  `payment_type` varchar(155) NOT NULL,
  `create_date` datetime NOT NULL,
  `payment_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `startdate` datetime NOT NULL,
  `enddate` datetime NOT NULL,
  `subscription_type` enum('trial','standard') NOT NULL,
  PRIMARY KEY (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


*/