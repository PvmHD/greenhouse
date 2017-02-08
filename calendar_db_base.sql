-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generatie Tijd: 29 Dec 2014 om 22:05
-- Server versie: 5.0.51
-- PHP Versie: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `multi-calendar`
--

-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `calendars`
--

CREATE TABLE IF NOT EXISTS `calendars` (
  `calendar_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `share_type` enum('private','shared','public','public_open') NOT NULL,
  `calendar_color` varchar(20) NOT NULL default '#0000FF',
  `login_required` tinyint(1) NOT NULL default '0',
  `cal_startdate` date default NULL,
  `cal_enddate` date default NULL,
  `creator_id` int(11) NOT NULL,
  `can_view` tinyint(1) NOT NULL default '0',
  `can_add` tinyint(1) NOT NULL default '0',
  `can_edit` tinyint(1) NOT NULL default '0',
  `can_dd_drag` tinyint(1) NOT NULL default '0',
  `deleted` tinyint(1) NULL default '0',
  PRIMARY KEY  (`calendar_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


--
-- Gegevens worden uitgevoerd voor tabel `calendars`
--

INSERT INTO `calendars` (`calendar_id`, `name`, `share_type`, `calendar_color`, `login_required`, `cal_startdate`, `cal_enddate`, `creator_id`, `can_add`, `can_edit`) VALUES
(1, 'Room 1', 'public', '#FF5F3F', 0, NULL, NULL, 2, 1, 1);

-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `calendar_dditems`
--

CREATE TABLE IF NOT EXISTS `calendar_dditems` (
  `dditem_id` int(11) NOT NULL auto_increment,
  `calendar_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `phone` varchar(55) NOT NULL,
  `position` varchar(255) NOT NULL,
  PRIMARY KEY  (`dditem_id`),
  UNIQUE KEY `calendar_id` (`calendar_id`,`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=76 ;

--
-- Gegevens worden uitgevoerd voor tabel `calendar_dditems`
--

INSERT INTO `calendar_dditems` (
`dditem_id` ,
`calendar_id` ,
`title` ,
`phone` ,
`position`
)
VALUES (
NULL , '1', 'employee 1', '', ''
);

INSERT INTO `calendar_dditems` (
`dditem_id` ,
`calendar_id` ,
`title` ,
`phone` ,
`position`
)
VALUES (
NULL , '1', 'employee 2', '', ''
);

-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `description` text,
  `phone` varchar(25) default NULL,
  `date_start` date default NULL,
  `time_start` time default NULL,
  `date_end` date default NULL,
  `time_end` time default NULL,
  `allDay` tinyint(1) NOT NULL default '0',
  `calendartype` varchar(155) NOT NULL,
  `user_id` int(11) NOT NULL,
  `color` varchar(10) NOT NULL,
  `assigned_by` int(11) default NULL,
  `repeating_event_id` int(11) default NULL,
  `create_date` datetime NOT NULL,
  `calendar_id` int(11) NOT NULL,
  PRIMARY KEY  (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Gegevens worden uitgevoerd voor tabel `events`
--


-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `repeating_events`
--

CREATE TABLE IF NOT EXISTS `repeating_events` (
  `rep_event_id` int(11) NOT NULL auto_increment,
  `rep_interval` enum('D','W','2W','M','Y') NOT NULL,
  `weekdays` varchar(255) NOT NULL,
  `monthday` enum('dom','dow') NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `bln_broken` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`rep_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Gegevens worden uitgevoerd voor tabel `repeating_events`
--


-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `setting_id` int(11) NOT NULL auto_increment,
  `name` varchar(55) NOT NULL,
  `value` varchar(55) NOT NULL,
  `section` varchar(55) NOT NULL,
  `user_id` int(11) default NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY  (`setting_id`),
  UNIQUE KEY `name` (`name`,`section`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Gegevens worden uitgevoerd voor tabel `settings`
--

INSERT INTO `settings` (`setting_id`, `name`, `value`, `section`, `user_id`, `update_date`) VALUES
(3, 'language', 'EN', '', 2, '2014-12-28 20:11:22');

-- --------------------------------------------------------

--
-- Tabel structuur voor tabel `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL auto_increment,
  `firstname` varchar(255) NOT NULL,
  `infix` varchar(15) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `registration_date` datetime NOT NULL,
  `birth_date` date NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_hash` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL default '0',
  `ip` varchar(55) default NULL,
  `country` varchar(55) default NULL,
  `country_code` varchar(2) default NULL,
  `usertype` enum('superadmin','admin','user') NOT NULL default 'user',
  `admin_group` int(11) default NULL,
  `deleted` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

CREATE TABLE IF NOT EXISTS `schedule` (
  `job_id` int(11) NOT NULL auto_increment,
  `jobname` varchar(255) NOT NULL,
  `last_exec_date` datetime NOT NULL,
  PRIMARY KEY  (`job_id`),
  UNIQUE KEY `jobname` (`jobname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


--
-- Gegevens worden uitgevoerd voor tabel `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `infix`, `lastname`, `email`, `registration_date`, `birth_date`, `username`, `password`, `user_hash`, `active`, `ip`, `country`, `country_code`, `usertype`, `admin_group`, `deleted`) VALUES
(1, '', '', 'superadmin', 'superadmin@somemail', '2014-08-02 10:09:39', '0000-00-00', 'superadmin', 'd4558c97495b2c3954f73bae761c6d0f', '', 1, '', '', '', 'superadmin', NULL, 0),
(2, '', '', 'admin', 'admin@somemail', '2014-08-02 10:10:39', '0000-00-00', 'admin', 'af41d89626f1dc9dfef36870cc9d24f6', '', 1, '', '', '', 'admin', NULL, 0);

--
-- Beperkingen voor gedumpte tabellen
--

--
-- Beperkingen voor tabel `calendar_dditems`
--
ALTER TABLE `calendar_dditems`
  ADD CONSTRAINT `calendar_dditems_ibfk_1` FOREIGN KEY (`calendar_id`) REFERENCES `calendars` (`calendar_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
