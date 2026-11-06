SELECT VERSION() AS mysql_version,
       DATABASE() AS current_database,
       @@autocommit AS autocommit_enabled,
       @@foreign_key_checks AS foreign_keys_enabled;
