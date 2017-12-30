<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>收件夹</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/main.css">

    <script src="js/jquery-3.2.1.min.js"></script>

    <script src="js/fileinput.min.js" type="text/javascript"></script>
    <script src="themes/fa/theme.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
	<script src="js/locales/zh.js" type="text/javascript"></script>
	<script type="text/javascript">
		
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-sm main-navigation">
		<div class="container">
			<a class="navbar-brand" href="#">
				<img src="img/logo.gif" alt="logo" style="width: 40px;"> CloudDrive
			</a>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="Home">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-current" href="#">收件夹</a>
				</li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="card">
			<div class="card-body">
				<form>
					<div class="form-group">
						<h1>${inbox.inboxName }</h1>
					</div>
					
					<div class="form-group">
						<p>${inbox.illustrate }</p>
					</div>
					<div class="form-group">
						<label for="usr">学号:</label>
						<input type="text" class="form-control-inline" id="usr">
						<label for="pwd">姓名:</label>
						<input type="text" class="form-control-inline" id="pwd">
					</div>
					<div class="form-group">
						<input type="file" name="txt_file" multiple  id="uploadFile" />
					</div>
					<button type="submit" class="btn btn-primary">提交</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>