# mysql_fix_privilege_tables_323_to_40.sql
#
# Upgrades MySQL tables from 3.23 format to 4.0 format.
#
# Basically, this is scripts\mysql_fix_privilege_tables.sh that came
# in the mysql-4.0.12-win.zip distribution.  The shell commands and
# steps for 3.22 have been removed.
#
# This also corrects the case of some field names.  The original
# script mistakenly used lower case names in two queries.  Said
# queries have comments above them start with the word "TWEAKED:"
#
# This file is needed because mysql_fix_privilege_tables.sh does not
# work for users having one or more of the following conditions:
#    Use Windows operating systems.
#    Have changed the name of their "root" user.
#    Have mysql instlalled in non-default locations.
#
# Usage:
#    mysql -u root -p -f mysql < mysql_fix_privilege_tables_323_to_40.sql
#
# This is part of the "MySQL Basics" tutorial:
#    http://www.analysisandsolutions.com/code/mybasic.htm
#
# Author: Daniel Convissor <danielc@AnalysisAndSolutions.com>
# Date:   2003-08-05 12:30:00
# URI:    http://www.analysisandsolutions.com/code/mysql_fix_privilege_tables_323_to_40.sql


# Converting all privilege tables to MyISAM format

ALTER TABLE user type=MyISAM;
ALTER TABLE db type=MyISAM;
ALTER TABLE host type=MyISAM;
ALTER TABLE columns_priv type=MyISAM;
ALTER TABLE tables_priv type=MyISAM;


# Fix old password format, add File_priv and func table

alter table user change password password char(16) NOT NULL;
CREATE TABLE if not exists func (
  name char(64) DEFAULT '' NOT NULL,
  ret tinyint(1) DEFAULT '0' NOT NULL,
  dl char(128) DEFAULT '' NOT NULL,
  type enum ('function','aggregate') NOT NULL,
  PRIMARY KEY (name)
);


# If the new grant columns didn't exists, copy File -> Grant
# and Create -> Alter, Index, References

UPDATE user SET Grant_priv=File_priv, References_priv=Create_priv,
  Index_priv=Create_priv, Alter_priv=Create_priv;
UPDATE db SET References_priv=Create_priv, Index_priv=Create_priv,
  Alter_priv=Create_priv;
UPDATE host SET References_priv=Create_priv, Index_priv=Create_priv,
  Alter_priv=Create_priv;


# The second alter changes ssl_type to new 4.0.2 format

ALTER TABLE user
  ADD ssl_type enum('','ANY','X509', 'SPECIFIED') NOT NULL,
  ADD ssl_cipher BLOB NOT NULL,
  ADD x509_issuer BLOB NOT NULL,
  ADD x509_subject BLOB NOT NULL;
ALTER TABLE user MODIFY ssl_type enum('','ANY','X509', 'SPECIFIED')
  NOT NULL;


# Create tables_priv and columns_priv if they don't exists

CREATE TABLE IF NOT EXISTS tables_priv (
  Host char(60) DEFAULT '' NOT NULL,
  Db char(60) DEFAULT '' NOT NULL,
  User char(16) DEFAULT '' NOT NULL,
  Table_name char(60) DEFAULT '' NOT NULL,
  Grantor char(77) DEFAULT '' NOT NULL,
  Timestamp timestamp(14),
  Table_priv set('Select','Insert','Update','Delete','Create','Drop',
    'Grant','References','Index','Alter') DEFAULT '' NOT NULL,
  Column_priv set('Select','Insert','Update','References')
    DEFAULT '' NOT NULL,
  PRIMARY KEY (Host,Db,User,Table_name)
);

CREATE TABLE IF NOT EXISTS columns_priv (
  Host char(60) DEFAULT '' NOT NULL,
  Db char(60) DEFAULT '' NOT NULL,
  User char(16) DEFAULT '' NOT NULL,
  Table_name char(60) DEFAULT '' NOT NULL,
  Column_name char(59) DEFAULT '' NOT NULL,
  Timestamp timestamp(14),
  Column_priv set('Select','Insert','Update','References')
    DEFAULT '' NOT NULL,
  PRIMARY KEY (Host,Db,User,Table_name,Column_name)
);


# Change the user,db and host tables to MySQL 4.0 format
# TWEAKED:  case correction on Alter_priv

alter table user
  add Show_db_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Alter_priv,
  add Super_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Show_db_priv,
  add Create_tmp_table_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Super_priv,
  add Lock_tables_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Create_tmp_table_priv,
  add Execute_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Lock_tables_priv,
  add Repl_slave_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Execute_priv,
  add Repl_client_priv enum('N','Y') DEFAULT 'N' NOT NULL
    AFTER Repl_slave_priv;


# Convert privileges so that users have similar privileges as before
# TWEAKED:  case correction on several field names

update user set Show_db_priv=Select_priv, Super_priv=Process_priv,
  Execute_priv=Process_priv, Create_tmp_table_priv='Y',
  Lock_tables_priv='Y', Repl_slave_priv=File_priv,
  Repl_client_priv=File_priv where user<>"";


# Add fields that can be used to limit number of questions and
# connections for some users.

alter table user
  add max_questions int(11) NOT NULL AFTER x509_subject,
  add max_updates int(11) unsigned NOT NULL AFTER max_questions,
  add max_connections int(11) unsigned NOT NULL AFTER max_updates;


# Add Create_tmp_table_priv and Lock_tables_priv to db and host

alter table db
  add Create_tmp_table_priv enum('N','Y') DEFAULT 'N' NOT NULL,
  add Lock_tables_priv enum('N','Y') DEFAULT 'N' NOT NULL;
alter table host
  add Create_tmp_table_priv enum('N','Y') DEFAULT 'N' NOT NULL,
  add Lock_tables_priv enum('N','Y') DEFAULT 'N' NOT NULL;
