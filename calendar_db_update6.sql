ALTER TABLE `calendars` ADD `users_can_email_event` TINYINT( 1 ) NOT NULL DEFAULT '0',
    ADD `all_event_mods_to_admin` TINYINT( 1 ) NOT NULL DEFAULT '0';
