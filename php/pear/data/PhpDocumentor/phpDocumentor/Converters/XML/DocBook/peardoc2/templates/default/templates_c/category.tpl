<?php /* Smarty version 2.5.0, created on 2003-04-28 19:40:56
         compiled from category.tpl */ ?>
<chapter id="<?php echo $this->_tpl_vars['id']; ?>
">
<title><?php echo $this->_tpl_vars['category']; ?>
</title>
<?php if (isset($this->_sections['ids'])) unset($this->_sections['ids']);
$this->_sections['ids']['name'] = 'ids';
$this->_sections['ids']['loop'] = is_array($this->_tpl_vars['ids']) ? count($this->_tpl_vars['ids']) : max(0, (int)$this->_tpl_vars['ids']);
$this->_sections['ids']['show'] = true;
$this->_sections['ids']['max'] = $this->_sections['ids']['loop'];
$this->_sections['ids']['step'] = 1;
$this->_sections['ids']['start'] = $this->_sections['ids']['step'] > 0 ? 0 : $this->_sections['ids']['loop']-1;
if ($this->_sections['ids']['show']) {
    $this->_sections['ids']['total'] = $this->_sections['ids']['loop'];
    if ($this->_sections['ids']['total'] == 0)
        $this->_sections['ids']['show'] = false;
} else
    $this->_sections['ids']['total'] = 0;
if ($this->_sections['ids']['show']):

            for ($this->_sections['ids']['index'] = $this->_sections['ids']['start'], $this->_sections['ids']['iteration'] = 1;
                 $this->_sections['ids']['iteration'] <= $this->_sections['ids']['total'];
                 $this->_sections['ids']['index'] += $this->_sections['ids']['step'], $this->_sections['ids']['iteration']++):
$this->_sections['ids']['rownum'] = $this->_sections['ids']['iteration'];
$this->_sections['ids']['index_prev'] = $this->_sections['ids']['index'] - $this->_sections['ids']['step'];
$this->_sections['ids']['index_next'] = $this->_sections['ids']['index'] + $this->_sections['ids']['step'];
$this->_sections['ids']['first']      = ($this->_sections['ids']['iteration'] == 1);
$this->_sections['ids']['last']       = ($this->_sections['ids']['iteration'] == $this->_sections['ids']['total']);
?>
&<?php echo $this->_tpl_vars['ids'][$this->_sections['ids']['index']]; ?>
;
<?php endfor; endif; ?>
</chapter>
<!-- Generated by phpDocumentor v <?php echo $this->_tpl_vars['phpdocversion']; ?>
 <?php echo $this->_tpl_vars['phpdocwebsite']; ?>
 -->
<!-- Keep this comment at the end of the file
Local variables:
mode: sgml
sgml-omittag:t
sgml-shorttag:t
sgml-minimize-attributes:nil
sgml-always-quote-attributes:t
sgml-indent-step:1
sgml-indent-data:t
sgml-parent-document:nil
sgml-default-dtd-file:"../../../../manual.ced"
sgml-exposed-tags:nil
sgml-local-catalogs:nil
sgml-local-ecat-files:nil
End:
vim600: syn=xml fen fdm=syntax fdl=2 si
vim: et tw=78 syn=sgml
vi: ts=1 sw=1
-->