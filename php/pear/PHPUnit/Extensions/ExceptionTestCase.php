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
// $Id: ExceptionTestCase.php,v 1.5 2004/01/04 10:25:09 sebastian Exp $
//

require_once 'PHPUnit/Framework/TestCase.php';

/**
 * A TestCase that expects an Exception of class
 * fExpected to be thrown.
 *
 * @package phpunit.extensions
 * @author  Sebastian Bergmann <sb@sebastian-bergmann.de>
 */
class PHPUnit_Extensions_ExceptionTestCase extends PHPUnit_Framework_TestCase {
    // {{{ Members

    /**
    * The name of the expected Exception.
    *
    * @var    string
    * @access private
    */
    private $expected = '';

    // }}}
    // {{{ public function __construct($name, $exception)

    /**
    * @param  string  $name
    * @param  string  $exception
    * @access public
    */
    public function __construct($name, $exception) {
        parent::__construct($name);
        $this->expected = $exception;
    }

    // }}}
    // {{{ protected function runTest()

    /**
    * @access public
    */
    protected function runTest() {
        try {
            parent::runTest();
        }

        catch (Exception $e) {
            if (is_a($e, $this->expected)) {
                return;
            } else {
                throw $e;
            }
        }

        $this->fail('Expected exception ' . $this->expected);
    }

    // }}}
}

/*
 * vim600:  et sw=2 ts=2 fdm=marker
 * vim<600: et sw=2 ts=2
 */
?>
