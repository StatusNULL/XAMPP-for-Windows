<?php
//
// +------------------------------------------------------------------------+
// | PEAR :: PHPUnit                                                        |
// +------------------------------------------------------------------------+
// | Copyright (c) 2002-2004 Sebastian Bergmann <sb@sebastian-bergmann.de>. |
// +------------------------------------------------------------------------+
// | This source file is subject to version 3.00 of the PHP License,        |
// | that is available at http://www.php.net/license/3_0.txt.               |
// | If you did not receive a copy of the PHP license and are unable to     |
// | obtain it through the world-wide-web, please send a note to            |
// | license@php.net so we can mail you a copy immediately.                 |
// +------------------------------------------------------------------------+
//
// $Id: InheritedTestCase.php,v 1.3 2004/01/01 10:31:45 sebastian Exp $
//

require_once 'PHPUnit/Framework/TestCase.php';
require_once 'PHPUnit/Tests/Framework/OneTestCase.php';

class PHPUnit_Tests_Framework_InheritedTestCase extends PHPUnit_Tests_Framework_OneTestCase {
    public function test2() {
    }
}

/*
 * vim600:  et sw=2 ts=2 fdm=marker
 * vim<600: et sw=2 ts=2
 */
?>
