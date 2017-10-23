<?php
// $Id: mdb_querytool_testGetQueryString.php,v 1.3 2005/03/18 15:08:30 quipo Exp $

require_once dirname(__FILE__).'/mdb_querytool_test_base.php';


class TestOfMDB_QueryTool_GetQueryString extends TestOfMDB_QueryTool
{
    function TestOfMDB_QueryTool_GetQueryString($name = __CLASS__) {
        $this->UnitTestCase($name);
    }
    function test_selectAll() {
        $this->qt =& new MDB_QT(TABLE_QUESTION);
        if (DB_TYPE == 'ibase') {
            $expected = 'SELECT question.id AS id,question.question AS question FROM question';
        } else {
            $expected = 'SELECT question.id AS "id",question.question AS "question" FROM question';
        }
        $this->assertEqual($expected, $this->qt->getQueryString());
    }
    function test_selectWithWhere() {
        $this->qt =& new MDB_QT(TABLE_QUESTION);
        $this->qt->setWhere('id=1');
        if (DB_TYPE == 'ibase') {
            $expected = 'SELECT question.id AS id,question.question AS question FROM question WHERE id=1';
        } else {
            $expected = 'SELECT question.id AS "id",question.question AS "question" FROM question WHERE id=1';
        }
        $this->assertEqual($expected, $this->qt->getQueryString());
    }
    function test_selectWithJoin() {
        $this->qt =& new MDB_QT(TABLE_QUESTION);
        $joinOn = TABLE_QUESTION.'.id='.TABLE_ANSWER.'.question_id';
        $this->qt->setJoin(TABLE_ANSWER, $joinOn, 'left');
        
        if (DB_TYPE == 'ibase') {
            $expected = 'SELECT answer.id AS t_answer_id,answer.answer AS t_answer_answer,answer.question_id AS t_answer_question_id,question.id AS id,question.question AS question FROM question LEFT JOIN answer ON question.id=answer.question_id';
        } else {
            $expected = 'SELECT answer.id AS "_answer_id",answer.answer AS "_answer_answer",answer.question_id AS "_answer_question_id",question.id AS "id",question.question AS "question" FROM question LEFT JOIN answer ON question.id=answer.question_id';
        }
        $this->assertEqual($expected, $this->qt->getQueryString());
    }
}

if (!defined('TEST_RUNNING')) {
    define('TEST_RUNNING', true);
    $test = &new TestOfMDB_QueryTool_GetQueryString();
    $test->run(new HtmlReporter());
}
?>