
ALTER TABLE `users` CHANGE `password` `password` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, CHANGE `user_hash` `user_hash` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL;
