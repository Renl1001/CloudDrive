<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/login.css">
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<title>登录</title>
</head>
<body>
	<form method="post" action="DoLogin">
  		<table>
  			<tr>
  				<td>用户名:</td><td><input type="text" id="userName" name="userName"></td>
  			</tr>
  			<tr>
  				<td>密码:</td><td><input type="password" id="pwd" name="pwd"></td>
  			</tr>
  			<tr><td><span id="errorInfo"></span></td></tr>
  			<tr>
  				<td><input type="submit" value="登录"></td>
  			</tr>
  		</table>
  	</form>
</body>
</html>