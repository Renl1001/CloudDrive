<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
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
					<a class="nav-link nav-current" href="#">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">分享</a>
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
			<div class="col-sm-2">
				<div class="list-group">
					<c:url value="/ListFiles" var="pathURL">
						<c:param name="path" value="root"></c:param>
					</c:url>
					<a href="${pathURL }" class="list-group-item list-group-item-info">全部文件</a>
					<c:url value="/ListFiles" var="pathURL">
						<c:param name="path" value="photo"></c:param>
					</c:url>
					<a href="${pathURL }" class="list-group-item list-group-item-action">图片</a>
					<a href="#" class="list-group-item list-group-item-action">文档</a>
					<a href="#" class="list-group-item list-group-item-action">视频</a>
					<a href="#" class="list-group-item list-group-item-action">音乐</a>
					<a href="#" class="list-group-item list-group-item-action">其他</a>
				</div>
			</div>
			<div class="card col-sm-10">
				<div class="card-body">
					<div id="menudiv">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#uploadModal">
							<i class="fa fa-cloud-upload"></i> 文件上传
						</button>
						<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#newFolder">
							<i class="fa fa-folder-o fa-lg"></i> 新建文件夹
						</button>
						<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg" role="document">
								<div class="modal-content">
									<form action="UpLoad" id="upLoadForm" enctype="multipart/form-data" method="post">
										<div class="modal-header">
											<h5 class="modal-title" id="uploadModalLabel">文件上传</h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<input type="text" class="pathText" name="path" value="${path }">
											<div class="file-loading">
												<input type="file" name="txt_file" id="uploadFile" />
											</div>
											<div id="kartik-file-errors"></div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
											<button type="submit" class="btn btn-primary" title="上传">上传</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="modal fade" id="newFolder">
						<div class="modal-dialog">
							<div class="modal-content">
								<form role="form" action="MkDir" method="post">
									<div class="modal-header">
										<h4 class="modal-title">新建文件夹</h4>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
								
									<div class="modal-body">
										<input type="text" class="form-control" name="folderName" id="name" placeholder="请输入文件夹名">
										<input type="text" class="pathText" name="path" value="${path }">
									</div>
	
									<div class="modal-footer">
										<input type="submit" class="btn btn-info" value="提交按钮">
										<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
									</div>
								</form>
							</div>
						</div>
					</div>

					<ul class="breadcrumb">
						<c:if test="${lastPath != \"\"}">
							<c:url value="/ListFiles" var="folderURL">
								<c:param name="path" value="${lastPath }"></c:param>
							</c:url>
							<a href="${folderURL}">返回上一级</a>
							<span class="gt">|</span>
						</c:if>
						
						<c:forEach var="ml" items="${paths }">
							<c:choose>
								<c:when test="${ml.key == \"root\" }">
									<c:url value="/ListFiles" var="folderURL">
										<c:param name="path" value="${ml.value }"></c:param>
									</c:url>
									<a href="${folderURL }">全部文件</a>
								</c:when>
								<c:otherwise>
									<span class="gt">></span>
									<c:url value="/ListFiles" var="folderURL">
										<c:param name="path" value="${ml.value }"></c:param>
									</c:url>
									<a href="${folderURL }">${ml.key }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>

					<table class="table table-hover">
						<thead>
							<tr>
								<th><input id="CheckAll" type="checkbox" /></th>
								<th>文件名</th>
								<th>大小</th>
								<th>修改日期</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="file" items="${files}">
								<tr>
									<td><input name="subBox" type="checkbox" /></td>
									<c:choose>
										<c:when test="${file.type == \"folder\" }">
											<c:url value="/ListFiles" var="folderURL">
												<c:param name="path" value="${path}/${file.fileName }"></c:param>
											</c:url>
											<td>
												<a href="${folderURL}" class="fileName">${file.fileName}</a>
											</td>
											<td>-</td>
										</c:when>
										<c:otherwise>
											<c:url value="/DownLoad" var="downLoadURL">
												<c:param name="fileName" value="${file.uuidName}"></c:param>
												<c:param name="path" value="${path }"></c:param>
											</c:url>
											<c:url value="/Share" var="shareURL">
												<c:param name="fileName" value="${file.uuidName}"></c:param>
												<c:param name="path" value="${path }"></c:param>
											</c:url>
											<td>
												<a href="${downLoadURL}" class="fileName">${file.fileName}</a>&nbsp&nbsp
												<a href="${downLoadURL}"><i class="fa fa-download fa-lg"></i></a>  
												<a href="${shareURL }"><i class="fa fa-share-alt fa-lg"></i></a>
											</td>
											<td>${file.size/1024 } KB</td>
										</c:otherwise>
									</c:choose>
									
									<td>${file.updateTime }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div class="container">
			<h4>All Copyright Reserved ©2017 ACM</h4>
		</div>
	</footer>
</body>
</html>