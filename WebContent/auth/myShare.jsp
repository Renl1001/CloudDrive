<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>CloudDrive</title>
	<link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet"
        type="text/css" />

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/jquery.zclip.js" type="text/javascript"></script>
	<script src="js/ajax.js"></script>

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
	<nav class="navbar navbar-expand-sm bg-light navbar-light main-navigation">
		<div class="container">
			<a class="navbar-brand" href="#">
				<img src="img/logo.gif" alt="logo" style="width:40px;">
				CloudDrive
			</a>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="home.jsp">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ListFiles">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-current" href="#">分享</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">收件夹</a>
				</li>
				<li class="nav-item">
					<img src="img/head.jpg" class="rounded-circle" alt="head" style="width:40px;">
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
						${name }
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="/CloudDrive/DoLogout">退出登录</a>
					</div>
				</li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="card">
			<div class="card-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input id="CheckAll" type="checkbox" /></th>
							<th>文件名</th>
							<th>  </th>
							<th>下载次数</th>
							<th>大小</th>
							<th>分享时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="share" items="${shares}">
							<tr>
								<td><input name="subBox" type="checkbox" /></td>								
								<c:url value="DelShare" var="delURL">
									<c:param name="key" value="${share.key}"></c:param>
								</c:url>
								<td>
									<img src="img/icon/${share.type }.png" alt="logo" style="width:25px;">
									<a href="Share?key=${share.key }" class="fileName">${share.fileName}</a>&nbsp&nbsp
								</td>
								<td>  
									<a href="${delURL }"><i class="fa fa-ban fa-lg"></i></a>
								</td>
								<td>${share.downloads }</td>
								<td>${share.showSize }</td>
								<td>${share.shareTime }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
</body>
</html>