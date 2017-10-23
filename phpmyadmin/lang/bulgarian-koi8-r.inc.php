<?php
/* $Id: bulgarian-koi8-r.inc.php,v 1.104 2003/08/17 23:36:27 lem9 Exp $ */

/**
 * Translated by Stanislav Yordanov <stan at webthoughts.net>
 * Based on translation made by Georgi Georgiev <chutz at chubaka.homeip.net>
 */

$charset = 'koi8-r';
$text_dir = 'ltr';
$left_font_family = 'sans-serif';
$right_font_family = 'sans-serif';
$number_thousands_separator = ',';
$number_decimal_separator = '.';
// shortcuts for Byte, Kilo, Mega, Giga, Tera, Peta, Exa
$byteUnits = array('�����', '��', '��', '��', '��', '��', '��');

$day_of_week = array('��', '��', '��', '��', '��', '��', '��');
$month = array('������', '��������', '����', '�����', '���', '���', '���', '������', '���������', '�������', '�������', '��������');
// See http://www.php.net/manual/en/function.strftime.php to define the
// variable below
$datefmt = '%e %B %Y � %H:%M';

$timespanfmt = '%s ����, %s ����, %s ������ � %s �������';

 

$strAPrimaryKey = '�e�e ������� �������� ���� ��� ';
$strAbortedClients = '����������';
$strAbsolutePathToDocSqlDir = '���� �������� ���������� ��� �� ��� ������� �� docSQL ������������';
$strAccessDenied = '������� ������';
$strAccessDeniedExplanation = 'phpMyAdmin �� ����� �� �� ������ ��� MySQL �������, �� ������� �������� ����������. ������ �� ��������� �����, ��������������� ��� � �������� � config.inc.php ����� � �� �� �������, �� �� ��������� �� ������������ ������������ �� �������������� �� MySQL �������.';
$strAction = '��������';
$strAddAutoIncrement = '������ AUTO_INCREMENT';
$strAddDeleteColumn = '������/������ ������ �� ��������';
$strAddDeleteRow = '������/������ ��� �� ��������';
$strAddDropDatabase = '������ DROP DATABASE';
$strAddIntoComments = '������ � �����������';
$strAddNewField = '������ ���� ����';
$strAddPriv = '�������� �� ���� ����������';
$strAddPrivMessage = '��� ��������� ���� ����������.';
$strAddPrivilegesOnDb = '������ ���������� ��� �������� ���� �����';
$strAddPrivilegesOnTbl = '������ ���������� ��� �������� �������';
$strAddSearchConditions = '������ ������� �� ������� (���� �� "where" �������):';
$strAddToIndex = ' &nbsp;%s&nbsp;������(�) ����(���)�������� ��� ������� ';
$strAddUser = '�������� �� ��� ����������.';
$strAddUserMessage = '��� ��������� ��� ����������.';
$strAddedColumnComment = '������� �������� ��� ������';
$strAddedColumnRelation = '�������� ������� ��� ������';
$strAdministration = '�������������';
$strAffectedRows = '��������� ������:';
$strAfter = '���� %s';
$strAfterInsertBack = '�� �����';
$strAfterInsertNewInsert = '������ ��� �����';
$strAll = '������';
$strAllTableSameWidth = '��������� �� ������ ������� � ���� � ���� ������?';
$strAlterOrderBy = '���������� �� ��������� ��';
$strAnIndex = '���� ������� ������ �� %s';
$strAnalyzeTable = '����������� �� ���������';
$strAnd = '�';
$strAny = '�����';
$strAnyColumn = '����� ������';
$strAnyDatabase = '����� ���� �����';
$strAnyHost = '����� ����';
$strAnyTable = '����� �������';
$strAnyUser = '����� ����������';
$strArabic = '�������';
$strArmenian = '��������';
$strAscending = '���������';
$strAtBeginningOfTable = '� �������� �� ���������';
$strAtEndOfTable = '� ���� �� ���������';
$strAttr = '��������';
$strAutodetect = '����������� ���������';
$strAutomaticLayout = '����������� ������';

$strBack = '�����';
$strBaltic = '���������';
$strBeginCut = 'BEGIN CUT';
$strBeginRaw = 'BEGIN RAW';
$strBinary = ' ������� ';
$strBinaryDoNotEdit = ' ������� - �� �� ��������� ';
$strBookmarkDeleted = 'Bookmark ���� ������.';
$strBookmarkLabel = '������';
$strBookmarkQuery = '��������� �� SQL-���������';
$strBookmarkThis = '������ ���� SQL-���������';
$strBookmarkView = '���� ���������';
$strBrowse = '��������';
$strBulgarian = '���������';
$strBzError = 'phpMyAdmin �� ���� �� ���������� �������(dump) ������ ������ � Bz2 ������������ � ���� ������ �� PHP. ������ �� ���������� �� ���������� ���������� �� <code>$cfg[\'BZipDump\']</code> ����������� � ���������������� ���� �� ����� phpMyAdmin �� <code>FALSE</code>. ��� ������ �� �� ���������� ������������� �� Bz2 �����������, �� ������ �� ����������� �� ��-���� ������ �� PHP. ����� ��������� %s �� ������ ����������.';
$strBzip = '"bzip-����"';

$strCSVOptions = 'CSV �����';
$strCannotLogin = '�� ���� �� �� ����� ��� MySQL �������';
$strCantLoad = '�� ���� �� ������ ������������ %s,<br />���� ��������� �������������� �� PHP';
$strCantLoadMySQL = '�� ���� �� ������ MySQL ������������,<br />���� ��������� �������������� �� PHP.';
$strCantLoadRecodeIconv = '�� ���� �� �� ������� iconv ��� recode ������������ ���������� �� ������������ �� ������ �� �������(charset), �������������� PHP ����, �� �� ��������� ���������� �� ���� ���������� ��� �������� �������������� �� ������ �� �������(charset) � phpMyAdmin.';
$strCantRenameIdxToPrimary = '�� ���� �� ����������� ������� �� PRIMARY!';
$strCantUseRecodeIconv = '�� ���� �� �� �������� ���� iconv ���� libiconv ���� recode_string ��������� ������ ������������ �� ������������ �� ��������. ��������� �������������� �� PHP.';
$strCardinality = '����������';
$strCarriage = '������ �� ���� �� ���: \\r';
$strCaseInsensitive = '�������������� ��� ���������';
$strCaseSensitive = '������������ ��� ���������';
$strCentralEuropean = '��������� ����������';
$strChange = '�������';
$strChangeCopyMode = '������ ��� ���������� ��� ������ ���������� � ...';
$strChangeCopyModeCopy = '... ������ ������.';
$strChangeCopyModeDeleteAndReload = ' ... ������ ������ �� ��������� �� ������������ � ���� ���� ��������� ������������.';
$strChangeCopyModeJustDelete = ' ... ������ ������ �� ��������� �� �������������.';
$strChangeCopyModeRevoke = ' ... ������ ������ ������� ���������� �� ������ � ���� ���� �� ������.';
$strChangeCopyUser = '������� �� ����� ������������ / �������� �� ����������';
$strChangeDisplay = '�������� ������ �� ���������';
$strChangePassword = '����� �� ��������';
$strCharset = '����� �� �������';
$strCharsetOfFile = '����� �� �������(Charset) �� �����:';
$strCharsets = '������ �� �������';
$strCharsetsAndCollations = '������ �� ������� � �������';
$strCheckAll = '�������� ������';
$strCheckDbPriv = '������� ������������ �� ��';
$strCheckPrivs = '�������� �� ������������';
$strCheckPrivsLong = '������� ������������ �� ���� ����� &quot;%s&quot;.';
$strCheckTable = '�������� �� ���������';
$strChoosePage = '���� �������� �������� �� �����������';
$strColComFeat = '��������� �� ��������� ��� ��������';
$strCollation = '�������';
$strColumn = '������';
$strColumnNames = '��� �� ������';
$strColumnPrivileges = '���������� ���������� �� ��������';
$strCommand = '�������';
$strComments = '���������';
$strCompleteInserts = '����� INSERT-�';
$strCompression = '���������';
$strConfigFileError = 'phpMyAdmin �� ���� �� ������� ����������������� �� ����!<br />���� ���� �� �� ����� ��� PHP ������ ����������� ������ � ���� ��� �� ���� �� ������ �����.<br />���� ��������� ���������������� ���� �������� ���� ���������� ����� ��-���� � ��������� ����������� �� ������ ����� PHP �����. � ��-������ ���� �� ��������, ������ ������� ������� ��� ����� � �������.<br />��� �� ������ ������ ��������, ������ � �����.';
$strConfigureTableCoord = '���� �������������� ������������ �� ������� %s';
$strConfirm = '������������ �� ������� �� �� ���������?';
$strConnections = '��������';
$strCookiesRequired = '����� ������� �� ���������� "Cookies".';
$strCopyTable = '�������� �� ������� (���� �� �����<b>.</b>�������):';
$strCopyTableOK = '������� %s ���� �������� � %s.';
$strCopyTableSameNames = '�� ���� �� �� ������ ��������� ��� ���� ��!';
$strCouldNotKill = 'phpMyAdmin �� ���� �� �������� ������� %s. �������� ���� � ���� ���������.';
$strCreate = '������';
$strCreateIndex = '������ ������ ����� &nbsp;%s&nbsp;������';
$strCreateIndexTopic = '������ ��� ������';
$strCreateNewDatabase = '������ ���� ��';
$strCreateNewTable = '������ ���� ������� � �� %s';
$strCreatePage = '������ ���� ��������';
$strCreatePdfFeat = '��������� �� PDF-�';
$strCriteria = '��������';
$strCroatian = '���������';  
$strCyrillic = '��������';
$strCzech = '�����';

$strDBComment = '�������� ��� ������ �� �����: ';
$strDBGContext = '��������';
$strDBGContextID = '���������� ID';
$strDBGHits = '���������';
$strDBGLine = '�����';
$strDBGMaxTimeMs = '����. �����, ms';
$strDBGMinTimeMs = '���. �����, ms';
$strDBGModule = '�����';
$strDBGTimePerHitMs = '�����/���������, ms';
$strDBGTotalTimeMs = '���� �����, ms';
$strDanish = '������';
$strData = '�����';
$strDataDict = '������ �� �������';
$strDataOnly = '���� �����';
$strDatabase = '��';
$strDatabaseExportOptions = '����� �� ������������ �� ���� �����';
$strDatabaseHasBeenDropped = '������ ����� %s ���� �������.';
$strDatabaseNoTable = '������ ����� �� ������� �������!';
$strDatabaseWildcard = '���� ����� (���� � � wildcard):';
$strDatabases = '���� �� �����';
$strDatabasesDropped = '%s ���� ����� ���� ������� �������.';
$strDatabasesStats = ' ���������� �� ������ �����';
$strDatabasesStatsDisable = '������� ����������';
$strDatabasesStatsEnable = '������� ����������';
$strDatabasesStatsHeavyTraffic = '���������: ������������� �� ���������� �� ������ ����� ���� �� ������ ����� ����� ������ ����� ��� ������� � MySQL �������.';
$strDbPrivileges = '���������� ���������� �� ������ �����';
$strDbSpecific = '���������� �� ������ �����';
$strDefault = '�� ������������';
$strDefaultValueHelp = '�� ����������� �� ������������, ���� �������� ���� ���� ��������, ��� ������� ����� ��� ��������, ����������� ������� ������: a';
$strDelOld = '�������� �������� ��� ���������� ��� ������� ����� ���� �� �����������. ������� �� �� �������� ���� ����������?';
$strDelete = '������';
$strDeleteAndFlush = '�������� ������������� � ���� ���� ����������� ������������.';
$strDeleteAndFlushDescr = '���� � ���-������ �����, �� �������������� �� ������������ ���� �� ������ �������� �����.';
$strDeleteFailed = '��������� ���������!';
$strDeleteUserMessage = '��� �������� ���������� %s.';
$strDeleted = '����� ���� ������';
$strDeletedRows = '������� ������:';
$strDeleting = '��������� �� %s';
$strDescending = '���������';
$strDescription = '��������';
$strDictionary = '������';
$strDisabled = '���������';
$strDisplay = '������';
$strDisplayFeat = '������ �������������';
$strDisplayOrder = '������ ��������:';
$strDisplayPDF = '������ PDF �����';
$strDoAQuery = '������� "��������� �� ������" (������ ��  ����������: "%")';
$strDoYouReally = '������������ �� ������� �� ��������� ��������';
$strDocu = '������������';
$strDrop = '�������';
$strDropDB = '������� �� %s';
$strDropSelectedDatabases = '������ ��������� ���� �����';
$strDropTable = '������ ���������';
$strDropUsersDb = '������ ������� ����� ����� ���� ����� ���� ���� �� �������������.';
$strDumpComments = '��������� �� ��������� ��� ��������, ���� inline SQL-���������';
$strDumpSaved = '�������(����) ���� �������� ��� ���� %s.';
$strDumpXRows = '����-�� %s ���� ���� �������� �� %s.';
$strDumpingData = '���� (�����) �� ������� � ���������';
$strDynamic = '���������';

$strEdit = '�����������';
$strEditPDFPages = '����������� �� PDF ��������';
$strEditPrivileges = '����������� �� ������������';
$strEffective = '���������';
$strEmpty = '��������';
$strEmptyResultSet = 'MySQL ����� ������ �������� (�.�. ���� ������).';
$strEnabled = '���������';
$strEnd = '����';
$strEndCut = 'END CUT';
$strEndRaw = 'END RAW';
$strEnglish = '���������';
$strEnglishPrivileges = ' ���������: ������� �� ������������ �� MySQL �� �������� �� ���������. ';
$strError = '������';
$strEstonian = '��������';
$strExcelOptions = '����� �� Excel'; 
$strExecuteBookmarked = '���������� �� �������� SQL-������';
$strExplain = 'Explain SQL';
$strExport = '������������';
$strExportToXML = '������������ � XML ������';
$strExtendedInserts = '��������� INSERT-�';
$strExtra = '������������';

$strFailedAttempts = '��������� �� �����';
$strField = '����';
$strFieldHasBeenDropped = '������ %s ���� �������';
$strFields = '������';
$strFieldsEmpty = ' ������ �� �������� � ������! ';
$strFieldsEnclosedBy = '�������� �� �������� ���';
$strFieldsEscapedBy = '���������� �� ����������� �������';
$strFieldsTerminatedBy = '�������� ��������� ���';
$strFileAlreadyExists = '������ %s ���� ���������� �� �������, ������� ����� �� ����� ��� �������� ������� �� ������������.';
$strFileCouldNotBeRead = '������ �� ���� �� ���� ��������';
$strFileNameTemplate = '������ �� ��������� ���';
$strFileNameTemplateHelp = '����������� __DB__ �� ��� �� ������ �����, __TABLE__ �� ��� �� ��������� � ������� �� %sstrftime%s �� �������� �� ������� �� �������, ���� ����������� �� ���� �������� �����������. ����� ���� ����� �� ���� �������.';
$strFileNameTemplateRemember = '��������� �� �������';
$strFixed = '��������';
$strFlushPrivilegesNote = '���������: phpMyAdmin ����� ��������������� ���������� �������� �� ��������� �� ������������ �� MySQL. ������������ �� ���� ������� ���� �� �� ��������� �� ������������ ����� �������� ������� ��� ��� ���� �� ��������� ������� �� ����. � ���� ������, ������ �� %s����������� ������������%s ����� �� ����������.';
$strFlushTable = '�������� ���� �� ��������� ("FLUSH")';
$strFormEmpty = '������ �������� ��� ������ �� �������!';
$strFormat = '������';
$strFullText = '����� ��������';
$strFunction = '�������';

$strGenBy = '���������� ��';
$strGenTime = '����� �� ����������';
$strGeneralRelationFeat = '���� ����������� �� ���������';
$strGerman = '������';
$strGlobal = '��������';
$strGlobalPrivileges = '�������� ����������';
$strGlobalValue = '�������� ��������';
$strGo = '����������';
$strGrantOption = '������';
$strGrants = '������&nbsp;����.';
$strGreek = '������';
$strGzip = '"gzip-����"';

$strHasBeenAltered = '���� ���������.';
$strHasBeenCreated = '���� ���������.';
$strHaveToShow = '������ �� �������� ���� ���� ������ �� ���������';
$strHebrew = '�����';
$strHome = '������';
$strHomepageOfficial = '��������� phpMyAdmin ��� ��������';
$strHomepageSourceforge = '���������� �� phpMyAdmin �� Sourceforge';
$strHost = '����';
$strHostEmpty = '����� �� ����� � ������!';
$strHungarian = '��������';

$strId = 'ID';
$strIdxFulltext = '�������������';
$strIfYouWish = '��� ������� �� �������� ���� ����� ������ �� ���������, ������� ������ �� �������� ��������� ��� �������.';
$strIgnore = '���������';
$strIgnoringFile = '���������� �� ���� %s';
$strImportDocSQL = '���������� docSQL ���������';
$strImportFiles = '����������� �� �������';
$strImportFinished = '������������� �������';
$strInUse = '�����';
$strIndex = '������';
$strIndexHasBeenDropped = '������� %s ���� ������';
$strIndexName = '��� �� �������&nbsp;:';
$strIndexType = '��� �� �������&nbsp;:';
$strIndexes = '�������';
$strInnodbStat = 'InnoDB ���������';
$strInsecureMySQL = '������ ��������������� ���� ������� ��������� (root ��� ������), ����� ������������ �� ���������������� ������ �� MySQL �� ������������. ������ MySQL ������ � ��������� � ���� �� ������������ � ���� �� ���� ����� ������. T����� �� �������� ���� ����� � �����������.';
$strInsert = '������';
$strInsertAsNewRow = '������ ���� ��� ���';
$strInsertNewRow = '������ ��� ���';
$strInsertTextfiles = '������ �������� ������� � ���������';
$strInsertedRowId = '�������� ID �� ����:';
$strInsertedRows = '�������� ����:';
$strInstructions = '����������';
$strInvalidName = '"%s" � �������� ���� � ��� �� ������ �� � ���������� �� ��� �� ���� �� �����,������� ��� ����. ';

$strJapanese = '�������';
$strJumpToDB = '����� ��� ���� ����� &quot;%s&quot;.';
$strJustDelete = '������ ������������� �� ��������� � ������������.';
$strJustDeleteDescr = '&quot;���������&quot; ����������� �� ���� ������ �� ������� ����� ����������, ������ �� �� ���������� ������������.';

$strKeepPass = '�� �� �� ����� ��������';
$strKeyname = '��� �� �����';
$strKill = '����';
$strKorean = '��������';

$strLaTeX = 'LaTeX';
$strLaTeXOptions = 'LaTeX �����';
$strLandscape = '��������';
$strLength = '�������';
$strLengthSet = '�������/��������*';
$strLimitNumRows = '���� �� ��������';
$strLineFeed = '������ �� ���� �� ���: \\n';
$strLines = '������';
$strLinesTerminatedBy = '�������� ��������� �';
$strLinkNotFound = '�������� �� �� ��������';
$strLinksTo = '���� ���';
$strLithuanian = '��������';
$strLoadExplanation = '���� ����� � ������ �� ������������, �� ������ �� �� ��������� ��� �� ������ ��������.';
$strLoadMethod = 'LOAD �����';
$strLocalhost = '�������';
$strLocationTextfile = '�������������� �� ��������� ����';
$strLogPassword = '������:';
$strLogUsername = '���:';
$strLogin = '����';
$strLoginInformation = '���������� �� �������';
$strLogout = '����� �� ���������';

$strMIME_MIMEtype = 'MIME-���';
$strMIME_available_mime = '�������� MIME-������';
$strMIME_available_transform = '�������� �������������';
$strMIME_description = '��������';
$strMIME_file = '������� ���';
$strMIME_nodescription = '���� �������� �� ���� �������������.<br />���� �������� �� ��� ������ ������� ���� ����� ����� %s.';
$strMIME_transformation = '��������� �������������';
$strMIME_transformation_note = '�� ������� �� ���������� ����� �� ��������������� � ������� MIME-type ������������� �������� �� %s�������� �� ���������������%s';
$strMIME_transformation_options = '����� �� ���������������';
$strMIME_transformation_options_note = '���� �������� ����������� �� ������� �� ��������������� ���� ���������� ������� ������: \'a\',\'b\',\'c\'...<br />��� ������ �� ��������� ������� ��������� ����� ("\") ��� �������� ������� ("\'") ����� ���� ���������, ��������� ���� ��� ������������ ������� ��������� ����� (�������� \'\\\\xyz\' ��� \'a\\\'b\').';
$strMIME_without = 'MIME-types �������� � �������� ����� �� ���������� ������� ������� �� �������������';
$strMissingBracket = '������ �����';
$strModifications = '��������� ���� ���������';
$strModify = '�������';
$strModifyIndexTopic = '������� �� ������';
$strMoreStatusVars = '����� ���������� �� �����������';
$strMoveTable = '����������� �� ������� ��� (���� �� �����<b>.</b>�������):';
$strMoveTableOK = '��������� %s ���� ���������� ��� %s.';
$strMoveTableSameNames = '�� ���� �� �� �������� ��������� ��� ���� ��!';
$strMultilingual = '�����������';
$strMustSelectFile = '������ �� �������� ���� �� ��������.';
$strMySQLCharset = 'MySQL ����� �� �������';
$strMySQLReloaded = 'MySQL � ����������.';
$strMySQLSaid = 'MySQL ��������: ';
$strMySQLServerProcess = 'MySQL %pma_s1% � ��������� �� %pma_s2% ���� %pma_s3%';
$strMySQLShowProcess = 'MySQL �������';
$strMySQLShowStatus = '���������� �� ����������� �� MySQL �������';
$strMySQLShowVars = '�������� ���������� �� MySQL';

$strName = '���';
$strNext = '�������';
$strNo = '��';
$strNoDatabases = '���� ���� �� �����';
$strNoDatabasesSelected = '���� ������� ���� �����.';
$strNoDescription = '���� ��������';
$strNoDropDatabases = '"DROP DATABASE" ������� � ���������.';
$strNoExplain = '�������� Explain SQL';
$strNoFrames = 'phpMyAdmin � �� ���������� ��� ���������� �������, ����� �������� <b>frames</b>.';
$strNoIndex = '�� � ��������� ������!';
$strNoIndexPartsDefined = '�� �� ���������� ����� �� ������!';
$strNoModification = '���� �������';
$strNoOptions = '���� ������ ���� �����';
$strNoPassword = '���� ������';
$strNoPermission = '��� ������� ���� ����� �� ����� �� ����� %s.';
$strNoPhp = '��� PHP ���';
$strNoPrivileges = '���� ����������';
$strNoQuery = '���� SQL ������!';
$strNoRights = '� ������� �� ����������� � ���������� ����� �� �� �� �������� ���!';
$strNoSpace = '������������ �������� ������������ �� ��������� �� ����� %s.';
$strNoTablesFound = '� ������ ����� ���� �������.';
$strNoUsersFound = '���� ����������(�).';
$strNoUsersSelected = '�� �� ������� �����������.';
$strNoValidateSQL = '�������� Validate SQL';
$strNone = '����';
$strNotNumber = '���� �� � �����!';
$strNotOK = '�� � OK';
$strNotSet = '�������  <b>%s</b> �� � �������� ��� �� � ���������� � %s';
$strNotValidNumber = ' �� � ������� ����� �� ���!';
$strNull = '������';
$strNumSearchResultsInTable = '%s ����������(�) � ������� <i>%s</i>';
$strNumSearchResultsTotal = '<b>����:</b> <i>%s</i> ����������(�)';
$strNumTables = '�������';

$strOK = 'OK';
$strOftenQuotation = '���������� �������. �� ����� ��������, �� ���� ������ char � varchar �� ��������� � �������.';
$strOperations = '��������';
$strOptimizeTable = '������������ �� ���������';
$strOptionalControls = '�� �����. ���������� ��� �� �� ����� ��� ����� ��������� �������.';
$strOptionally = '�� �����';
$strOptions = '�����';
$strOr = '���';
$strOverhead = '�������� �����';
$strOverwriteExisting = '������������ �� �������������� �������';

$strPHP40203 = '��� ���������� PHP 4.2.3, ����� ��� �������� ��� � �����-������� ��������� (mbstring). ����� ���������� �� PHP ���� 19404. �� � �������������� �� ���������� ���� ������ �� PHP � phpMyAdmin.';
$strPHPVersion = '������ �� PHP';
$strPageNumber = '����� �� ����������:';
$strPaperSize = '������ �� ��������';
$strPartialText = '�������� ��������';
$strPassword = '������';
$strPasswordChanged = '�������� �� %s ���� ��������� �������.';
$strPasswordEmpty = '�������� � ������!';
$strPasswordNotSame = '�������� �� � ������!';
$strPdfDbSchema = '������� �� ���� ����� "%s" - �������� %s';
$strPdfInvalidPageNum = '����������� ����� �� PDF����������!';
$strPdfInvalidTblName = '������� "%s" �� ����������!';
$strPdfNoTables = '���� �������';
$strPerHour = '�� ���';
$strPerMinute = '�� ������';
$strPerSecond = '�� �������';
$strPhoneBook = '��������� ��������';
$strPhp = '������ PHP ���';
$strPmaDocumentation = 'phpMyAdmin ������������';
$strPmaUriError = '�� <tt>$cfg[\'PmaAbsoluteUri\']</tt> ������ �� �� ������ �������� � ���������������� ����!';
$strPortrait = '���������';
$strPos1 = '������';
$strPrevious = '��������';
$strPrimary = 'PRIMARY';
$strPrimaryKey = '������ ����';
$strPrimaryKeyHasBeenDropped = ' ������� ���� ���� ������.';
$strPrimaryKeyName = '����� �� ������� ���� ������ �� �... PRIMARY!';
$strPrimaryKeyWarning = '("PRIMARY" <b>������</b> �� � ����� �� <b>� ���������� ��</b> ������� ����!)';
$strPrint = '���������';
$strPrintView = '������ �� �����';
$strPrivDescAllPrivileges = '������� ������ ���������� ����� GRANT.';
$strPrivDescAlter = '��������� ��������� �� ����������� �� ������������ �������.';
$strPrivDescCreateDb = '��������� ��������� �� ���� ���� ����� � �������.';
$strPrivDescCreateTbl = '��������� ��������� �� ���� �������.';
$strPrivDescCreateTmpTable = '��������� ����������� �� �������� �������.';
$strPrivDescDelete = '��������� ��������� �� �����.';
$strPrivDescDropDb = '��������� ��������� �� ���� ����� � �������.';
$strPrivDescDropTbl = '��������� ��������� �� �������.';
$strPrivDescExecute = '��������� ������������ �� ��������� ���������; ���� ����� � ���� ������ �� MySQL.';
$strPrivDescFile = '��������� ����������� �� ����� �� � ������������ �� ����� ��� �������.';
$strPrivDescGrant = '��������� �������� �� ����������� � ���������� ��� ������������ �� ��������� � ������������.';
$strPrivDescIndex = '��������� ��������� � ���������� �� �������.';
$strPrivDescInsert = '��������� �������� � �������� �� �����.';
$strPrivDescLockTables = '��������� ���������� �� ������� �� �������� �����.';
$strPrivDescMaxConnections = '���������� ���� �� ������ ��������, ����� ����������� ���� �� ������ �� ���.';
$strPrivDescMaxQuestions = '���������� ���� �� ��������, ����� ����������� ���� �� ������� ��� ������� �� ���.';
$strPrivDescMaxUpdates = '���������� ���� �� ���������, ����� �������� ����� ������� ��� ���� �����, ����� ����� ���������� ���� �� �������� �� ���.';
$strPrivDescProcess3 = '��������� ��������� �� ������� �� ����� �����������.';
$strPrivDescProcess4 = '��������� ������� �� ������ ������ � ������� � ���������.';
$strPrivDescReferences = '���� ����� � ���� ������ �� MySQL.';
$strPrivDescReload = '��������� ������������ �� ���������� ��������� � ����������(flashing) �� ���� �� �������.';
$strPrivDescReplClient = '���� ������� �� ���������� �� ���� ���� �� slaves / masters.';
$strPrivDescReplSlave = '����� �� replication slaves.';
$strPrivDescSelect = '��������� ������ �� �����.';
$strPrivDescShowDb = '���� ������ �� ������ ������ �� ������ �����.';
$strPrivDescShutdown = '��������� ������� �� �������.';
$strPrivDescSuper = '��������� ���������, ���� ��� � ��������� ����������� ���� �� ����������; ������� �� �� �������� ��������������� ��������, ���� ������������ �� �������� ���������� ��� ������� �� ����� �� ����� �����������.';
$strPrivDescUpdate = '��������� ������� �� �����.';
$strPrivDescUsage = '���� ����������.';
$strPrivileges = '����������';
$strPrivilegesReloaded = '������������ ���� ����������� �������.';
$strProcesslist = '������ �� ���������';
$strProperties = '��������';
$strPutColNames = '������� ������� �� �������� �� ������ ���';

$strQBE = '��������� �� ������';
$strQBEDel = '������';
$strQBEIns = '������';
$strQueryFrame = '�������� �� ������';
$strQueryFrameDebug = '���������� �� �����������';
$strQueryFrameDebugBox = '������� ���������� �� ������� �� ������:\nDB: %s\n�������: %s\n������: %s\n\n������ ���������� �� ������� �� ������:\n��: %s\n�������: %s\n������: %s\n\n������������ �� �����������: %s\n������������ �� ������ �� ��������(frameset): %s.';
$strQueryOnDb = 'SQL-������ ��� ������ �� ����� <b>%s</b>:';
$strQuerySQLHistory = 'SQL-����������';
$strQueryStatistics = '<b>���������� �� ��������</b>: �� ����� � ���������, %s ������ �� ��������� ��� �������.';
$strQueryTime = '�������� ���� %01.4f �������';
$strQueryType = '��� �� ��������';
$strQueryWindowLock = '�� ������������� ���� ������ ����� ���� ���������';

$strReType = '������';
$strReceived = '��������';
$strRecords = '������';
$strReferentialIntegrity = '�������� �� ����������� �� ��������';
$strRelationNotWorking = '�������������� ����������� �� ������ ��� �������� (linked) ������� �� ������������. �� �� ��������� ���� �������� %s���%s.';
$strRelationView = '������ �� ���������';
$strRelationalSchema = '���������� �����';
$strRelations = '�������';
$strReloadFailed = '��������� ���� �� ������������ �� MySQL.';
$strReloadMySQL = '������������ �� MySQL';
$strReloadingThePrivileges = '������������ �� ������������';
$strRememberReload = '�� ���������� �� ����������� �������.';
$strRemoveSelectedUsers = '������������ �� ��������� �����������';
$strRenameTable = '������������ �� ��������� ��';
$strRenameTableOK = '������� %s ���� ������������ �� %s';
$strRepairTable = '��������� �� ���������';
$strReplace = '�������';
$strReplaceNULLBy = '������� NULL �';
$strReplaceTable = '������� ������� �� ��������� � ������� �� �����';
$strReset = '�������';
$strResourceLimits = '�������� �����������';
$strRevoke = '������';
$strRevokeAndDelete = '������ ������� ������� ���������� �� ������������� � ���� ���� �� ������.';
$strRevokeAndDeleteDescr = '������������� ��� ��� �� ���� USAGE ���������� ������ �� �� ���������� ������������.';
$strRevokeGrant = '�������� �� ������&nbsp;����.';
$strRevokeGrantMessage = '��� ����������� �������� ���������� �� %s';
$strRevokeMessage = '��� ��������� ������������ �� %s';
$strRevokePriv = '������ �� ����������';
$strRowLength = '������� �� ����';
$strRowSize = ' ������ �� ��� ';
$strRows = '������';
$strRowsFrom = '���� ���������� ��';
$strRowsModeFlippedHorizontal = '������������ (�������� ������)';
$strRowsModeHorizontal = '������������';
$strRowsModeOptions = '� %s ��� � �������� ������� �� �������� ���� ����� %s<br />';
$strRowsModeVertical = '����������';
$strRowsStatistic = '���������� �� ��������';
$strRunQuery = '������� ��������';
$strRunSQLQuery = '���������� SQL ������/������ ��� ���� �� ����� %s';
$strRunning = '������ �� %s';
$strRussian = '�����';

$strSQL = 'SQL';
$strSQLOptions = 'SQL �����';
$strSQLParserBugMessage = '��� �������� ���������� �� ��� �������� ��� � SQL �������. ���� �������� ��-�����, � ��������� ������������ �� ���������. ����� �������� ������� �� �������� ���� �� ����, �� ���������� ���� � �������� ��� ����� �������� ��������� � �������. ������ ���� ���� �� �� ������� �� ��������� �������� ���� ����������� �� �������� ��� �� MySQL. �������� ���������� �� MySQL ������� ��-����, ��� ��� ������, ���� ���� �� �� ������� ��� ����������� �� ��������. ��� ��� ��� ����� �������� ��� ������� ���� ������ ��� ������ ���������� �� ��������� ��� �� ����� ������, ���� ���������� ������ SQL ������ ���� �� ����������� ������, � ��������� ��������� �� ��� � ������� �� ������� � CUT �������� ��-����:';
$strSQLParserUserError = '�������, �� ��� ������ � SQL �������� ��. �������� ������� �� MySQL ������� �� ����, ��� ��� ������, �� ������ �� �� ������� � ��������������� �� ��������';
$strSQLQuery = 'SQL-���������';
$strSQLResult = 'SQL ��������';
$strSQPBugInvalidIdentifer = '��������� �������������';
$strSQPBugUnclosedQuote = '����������� �������';
$strSQPBugUnknownPunctuation = '��������� ���������� �� ������';
$strSave = '������';
$strSaveOnServer = '��������� �� ������� � ���������� %s';
$strScaleFactorSmall = '������ � ������ ����� �� �� �� ������ ������� �� ���� ��������';
$strSearch = '�������';
$strSearchFormTitle = '������� � ������ �����';
$strSearchInTables = '� ���������:';
$strSearchNeedle = '���� ��� ��������� �� ������� (������ �� ����������: "%"):';
$strSearchOption1 = '���� ���� �� ������';
$strSearchOption2 = '������ ����';
$strSearchOption3 = '������� �����';
$strSearchOption4 = '���� ��������� �����';
$strSearchResultsFor = '��������� �� ��������� �� "<i>%s</i>" %s:';
$strSearchType = '������:';
$strSecretRequired = '���������������� ���� ��� ����� �� ����� ������ (blowfish_secret).'; 
$strSelect = '������';
$strSelectADb = '���� �������� ���� �����';
$strSelectAll = '���������� ������';
$strSelectFields = '������ ���� (������� ����):';
$strSelectNumRows = '� �����������';
$strSelectTables = '������ �������';
$strSend = '�������';
$strSent = '���������';
$strServer = '������ %s';
$strServerChoice = '����� �� ������';
$strServerStatus = '���������� �� ����������� �� MySQL �������';
$strServerStatusUptime = '���� MySQL ������ ������ �� %s. ��������� � �� %s.';
$strServerTabProcesslist = '�������';
$strServerTabVariables = '����������';
$strServerTrafficNotes = '<b>������ �� �������</b>: ���� ������� �������� ���������� �� �������� ������ �� MySQL ������� �� ����� � ���������.';
$strServerVars = '�������� ���������� � ���������';
$strServerVersion = '������ �� �������';
$strSessionValue = '�������� �� �������';
$strSetEnumVal = '��� ���� �� ������ � "enum" ��� "set", ���� �������� ����������� ����������� ���� ������: \'a\',\'b\',\'c\'...<br />��� � ���������� �� ������� ������� ����� ("\") ��� �������� ("\'") ����� ���� ���������, ������� ������� ����� ���� ��� (��������:  \'\\\\xyz\' ��� \'a\\\'b\').';
$strShow = '������';
$strShowAll = '������ ������';
$strShowColor = '������ ����';
$strShowCols = '������ ��������';
$strShowDatadictAs = '������ �� ������� �� �������';
$strShowFullQueries = '��������� �� ������� ������';
$strShowGrid = '������ �����';
$strShowPHPInfo = '���������� �� PHP ';
$strShowTableDimension = '������ ������������ �� ���������';
$strShowTables = '������ ���������';
$strShowThisQuery = ' ��������� �� �������� ������';
$strShowingRecords = '������� ������ ';
$strSimplifiedChinese = '�������� ��������';
$strSingly = '(����������)';
$strSize = '������';
$strSort = '���������';
$strSpaceUsage = '���������� �����';
$strSplitWordsWithSpace = '������ ������ �� �� �������� � �������� (" ").';
$strStatCheckTime = '�������� ��������';
$strStatCreateTime = '���������';
$strStatUpdateTime = '�������� ����������';
$strStatement = '���������';
$strStatus = '��������';
$strStrucCSV = 'CSV �����';
$strStrucData = '����������� � �������';
$strStrucDrop = '������ \'������ ���������\'';
$strStrucExcelCSV = 'CSV �� Ms Excel �����';
$strStrucOnly = '���� �����������';
$strStructPropose = '�������� ��������� �� ���������';
$strStructure = '���������';
$strSubmit = '����������';
$strSuccess = '������ SQL-��������� ���� ��������� �������';
$strSum = '����';
$strSwedish = '�������';
$strSwitchToTable = '��������� ��� ���������� �������';

$strTable = '������� ';
$strTableComments = '��������� ��� ���������';
$strTableEmpty = '����� �� ��������� � ������!';
$strTableHasBeenDropped = '��������� %s ���� �������';
$strTableHasBeenEmptied = '��������� %s ���� ����������';
$strTableHasBeenFlushed = '���� �� ������� %s ���� ���������';
$strTableMaintenance = '��������� �� ���������';
$strTableOfContents = '����������';
$strTableOptions = '����� �� ���������';
$strTableStructure = '��������� �� �������';
$strTableType = '��� �� ���������';
$strTables = '%s �������(�)';
$strTblPrivileges = '���������� �� ��������� ����������';
$strTextAreaLength = ' ������ ��������� ��,<br /> ���� ���� ���� �� �� � ������������ ';
$strThai = '����������';
$strTheContent = '������������ �� ����� ���� �����������.';
$strTheContents = '������������ �� ����� �������� ������������ �� ��������� �� ������ � ��������� �������� ��� �������� �������.';
$strTheTerminator = '������ �� ���� �� ����.';
$strThisHost = '���� ����';
$strThisNotDirectory = '���� �� ���� ����������';
$strThreadSuccessfullyKilled = '����� %s ���� ������� ����������.';
$strTime = '�����';
$strTotal = '����';
$strTotalUC = '����';
$strTraditionalChinese = '����������� ��������';
$strTraffic = '������';
$strTransformation_image_jpeg__inline = '������� thumbnail; �����: ������, �������� � ������� (������� ������������ ���������)';
$strTransformation_image_jpeg__link = '������� �������� �� ���� ����������� (�� �������� �������, i.e.).';
$strTransformation_image_png__inline = '��� image/jpeg: inline';
$strTransformation_text_plain__dateformat = '����� ���� TIME, TIMESTAMP ��� DATETIME � �� ��������� ���� �������� �������� ������ �� ����. ������� ����� � ������������ (� ������) ����� �� ���� �������� ��� ������� (�� ������������: 0). ������� ����� ������������ �������� ������ �� ������ � ���������� �� ����������� �� ��������� �� PHP - strftime().';
$strTransformation_text_plain__external = '���� �� ������: �������� �������� ���������� � ������� ������� � �������� ���� ����������� ����. ����� ����������� ����� �� ������������. �� ������������ � Tidy, �� �� ������ HTML ����. �� ����������� �� ���������, ������ ����� �� ����������� ����� libraries/transformations/text_plain__external.inc.php � �� �������� ���������� �� ����� ��� ����������� �� ����� ����������. ������� ����� ������ � ������ �� ���������� ����� ����� ������ �� ���������� � ������� ����� �� ����������� �� ����������. ��� ������� ���������� � ��������� � 1, �� ���������� ������ ����������� htmlspecialchars() (�� ������������ � 1). ��� ���������� ��������� � ��������� � 1, �� ������� NOWRAP �� �������� �� ������������, ���� �� ����� ����� �� ���� ������� ��� �������������� (�� ������������ � 1)';
$strTransformation_text_plain__formatted = '������� ������������ ����������� �� ������.';
$strTransformation_text_plain__imagelink = '������� ����������� � ������ �� ������ ��������� ������� ���; ������� ����� � ������� ���� "http://domain.com/", ������� ����� � �������� � �������, ������� � ����������.';
$strTransformation_text_plain__link = '������� �������� �� ������ ��������� ������� ���; ������� ����� � ������� ���� "http://domain.com/", ������� ����� � ���������� �� ��������.';
$strTransformation_text_plain__substr = '������� ���� �� ���. ������� ����� � ������������ �� ����� �� �� �������� ������ ����� (�� ������������ � 0). ������� ����� ������ ����� ����� �� �� ������. ��� � ������, �� ����� ����� ������� �����. ������� ����� ������ ��� ������� �� ����� �������� (�� ������������: ...) .';
$strTransformation_text_plain__unformatted = '������� HTML ���� ���� HTML �������. ��� HTML �����������.';
$strTruncateQueries = '����������� �� ���������� ������';
$strTurkish = '������';
$strType = '���';

$strUkrainian = '���������';
$strUncheckAll = '����������� ������';
$strUnicode = 'Unicode';
$strUnique = '��������';
$strUnknown = '��������';
$strUnselectAll = '������������ ������';
$strUpdComTab = '���� ����������� ������������ � �������������� ������� ���� ��� �� �������� ������ Column_comments �������';
$strUpdatePrivMessage = '��� ���������� ������������ �� %s.';
$strUpdateProfile = '���������� �� ������:';
$strUpdateProfileMessage = '������� ���� �������.';
$strUpdateQuery = '������� �����������';
$strUsage = '����������';
$strUseBackquotes = '��������� ������� ������� ����� ����� �� ������� � ������';
$strUseHostTable = '��������� ������� Host';
$strUseTables = '��������� ���������';
$strUseTextField = '��������� ���������� ����';
$strUser = '����������';
$strUserAlreadyExists = '���������� %s ���� ����������!';
$strUserEmpty = '��������������� ��� � ������!';
$strUserName = '������������� ���';
$strUserNotFound = '�������� ���������� �� ���� ������ � ��������� � ������������.';
$strUserOverview = '������� �� �������������';
$strUsers = '�����������';
$strUsersDeleted = '��������� ����������� ���� ������� �������.';
$strUsersHavingAccessToDb = '����������� ����� ���� ������ �� &quot;%s&quot;';

$strValidateSQL = '��������� SQL-�';
$strValidatorError = 'SQL ���������� �� ���� �� ���� �������������. ���� ��������� ���� ��� ����������� ������������ PHP ����������, ���� ����� � ������� � %s��������������%s.';
$strValue = '��������';
$strVar = '����������';
$strViewDump = '���� (�����) �� ���������';
$strViewDumpDB = '���� (�����) �� ��';
$strViewDumpDatabases = '������� �� ���� (�����) �� ���� �����';

$strWebServerUploadDirectory = '������������ �� upload �� ��� �������';
$strWebServerUploadDirectoryError = '������������ ����� ��� ������� �� upload �� ���� �� ���� ����������';
$strWelcome = '����� ����� � %s';
$strWestEuropean = '������� ����������';
$strWildcard = '������ �� ����������';
$strWithChecked = '������ ��� �������:';
$strWritingCommentNotPossible = '������ �� �������� �� � ��������';
$strWritingRelationNotPossible = '������ �� ��������� �� � ��������';
$strWrongUser = '������ ���/������. ������ �������.';

$strXML = 'XML';

$strYes = '��';

$strZeroRemovesTheLimit = '���������: �������������� �� ���� ����� � 0 (����) �������� �������������.';
$strZip = '"zip-����"';

$strToggleScratchboard = 'toggle scratchboard';  //to translate

$strUseThisValue = 'Use this value';  //to translate
$strWindowNotFound = 'The target browser window could not be updated. Maybe you have closed the parent window or your browser is blocking cross-window updates of your security settings';  //to translate
$strBrowseForeignValues = 'Browse foreign values';  //to translate
?>
