<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
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
				<img src="img/logo.gif" alt="logo" style="width:40px;">
				CloudDrive
			</a>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="Home">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ListFiles">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-current" href="ShareManage">分享</a>
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
		<div class="row">
			<div class="card col-sm-9">
				<div class="card-body">
					<c:choose>
						<c:when test="${empty share }">
							找不到资源
						</c:when>
						<c:otherwise>
							<div class="container">
								${share.user } 的分享
							</div>
							<table class="table table-hover">
								<thead>
									<tr>
										<th>文件名</th>
										<th>大小</th>
										<th>分享时间</th>
										<th> </th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<img src="img/icon/${share.type }.png" alt="logo" class="fileIcon">
											<a href="${downLoadURL}" class="fileName">${share.fileName}</a>&nbsp&nbsp
										</td>
										<td>${share.showSize }</td>
										<td>${share.shareTime }</td>
										<td>
											<c:url value="/DownLoad" var="downLoadURL">
												<c:param name="fileName" value="${share.uuidName}"></c:param>
												<c:param name="url" value="${share.url }"></c:param>
												<c:param name="key" value="${share.key }"></c:param>
											</c:url>
											<a href="${downLoadURL}">
												<button type="button" class="btn btn-outline-primary" id="downloadBtn">
													<i class="fa fa-download fa-lg"></i> 下载
												</button>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card col-sm-3">
				<div class="card-body">
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
					热门资源<br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>