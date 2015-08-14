<!doctype html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Lista de Proyectos</title>
</head>

<body>

<?php 
   $out = explode("\n", shell_exec("ls ../"));
?>

<ul>
<?php foreach($out as $p): ?>

	<?php if(strpos($p, '.') !== false): ?>
	<li><a href="http://<?php echo $p ?>" target="_blank"><?php echo $p ?></a></li>
	<?php endif; ?>

<?php endforeach; ?>
<ul/>
</body>

</html>
