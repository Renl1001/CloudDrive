<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>CloudDrive</title>
	<link rel="stylesheet" type="text/css" href="/CloudDrive/css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet"
        type="text/css" />

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

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
					<a class="nav-link nav-current" href="ShareManage">分享</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">收件夹</a>
				</li>
				
				<c:choose>
					<c:when test="${empty name }">
						<!-- 未登录 -->
						<li class="nav-item">
							&nbsp&nbsp&nbsp
						</li>
						<li class="nav-item">
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#login">登录 </button>
						</li>
						<li class="nav-item">	
							&nbsp&nbsp&nbsp
						</li>
						<li class="nav-item">
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#signup">注册 </button>
						</li>
					</c:when>
					<c:otherwise>
						<!-- 登录成功 -->
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
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<div class="card-container col-sm-8">
				<div class="card">
					<div class="card-body">
						<c:choose>
							<c:when test="${empty share }">
								找不到资源
							</c:when>
							<c:otherwise>
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
								<div class="row">
									<div class="card col-sm-2">
										<img src="img/icon/${share.type }.png" alt="logo" style="width:80px;"> 
									</div>	
									<div class="card col-sm-10">
										<div class="row">
											<div class=" col-sm-6">
												<div>文件名:</div>
												<div>大小:</div>
												<div>热度:</div>
											</div>
											<div class=" col-sm-6">
												<div>${share.fileName }</div>
												<div>${share.size/1024 } kb</div>
												<div>${share.downloads } </div>
											</div>		
										</div>	
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>	
				</div>
			</div>
			<div class="card col-sm-4">
				<div class="card-body">
					热门资源
				</div>
			</div>
		</div>
	</div>
</body>
</html>