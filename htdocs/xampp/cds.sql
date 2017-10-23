# Host: localhost
# Erstellungszeit: 01. September 2003 um 23:56
# Server Version: 4.0.13
# PHP-Version: 4.3.2
# Datenbank: `cdcol`
# --------------------------------------------------------

#
# Tabellenstruktur für Tabelle `cds`
#
# Erzeugt am: 21. Mai 2002 um 18:24
# Aktualisiert am: 21. Oktober 2002 um 00:03
#

CREATE TABLE `cds` (
  `titel` varchar(200) default NULL,
  `interpret` varchar(200) default NULL,
  `jahr` int(11) default NULL,
  `id` bigint(20) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=8 ;

#
# Daten für Tabelle `cds`
#

INSERT INTO `cds` (`titel`, `interpret`, `jahr`, `id`) VALUES ('Beauty', 'Ryuichi Sakamoto', 1990, 1);
INSERT INTO `cds` (`titel`, `interpret`, `jahr`, `id`) VALUES ('Goodbye Country (Hello Nightclub)', 'Groove Armada', 2001, 4);
INSERT INTO `cds` (`titel`, `interpret`, `jahr`, `id`) VALUES ('Glee', 'Bran Van 3000', 1997, 5);
