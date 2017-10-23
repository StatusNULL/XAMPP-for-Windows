<?php
/**
 * Basic error renderer with default PEAR_Error object.
 *
 * @version    $Id: errorbasic.php,v 1.2 2005/08/18 13:56:35 farell Exp $
 * @author     Laurent Laville <pear@laurent-laville.org>
 * @package    HTML_Progress2
 * @subpackage Examples
 * @access     public
 * @example    examples/errorhandling/errorbasic.php
 *             errorbasic source code
 */

require_once 'HTML/Progress2.php';
require_once 'PEAR.php';

// Example A. ---------------------------------------------

// A1. Exception
$pb1 = new HTML_Progress2(null, HTML_PROGRESS2_BAR_VERTICAL, '0', 130);

print 'still alive !';

?>