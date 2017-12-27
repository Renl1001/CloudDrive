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
		$(function() {
			$(".share").click(function() {
				$.get($(this).attr("url"), {}, handleShowLink);
			})
			$("#copyLink").zclip({
				path: "js/ZeroClipboard.swf",
				copy: function() { // 复制
					return $("#linkText").val();
				},
				afterCopy: function() {
					alert('复制成功');
				}
			});
			$("#sidebar").children().each(function() {
				if($(this).hasClass("${path }")) {
					$(this).addClass("list-group-item-info");
				} else {
					$(this).addClass("list-group-item-action");
				}
			})
		})
		function handleShowLink(data) {
			$("#linkText").val(data);
			$("#shareModal").modal("show");
		}

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
					<a class="nav-link nav-current" href="ListFiles">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ShareManage">分享</a>
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
				<div class="list-group" id="sidebar">
					<a href="ListFiles?path=root" class="list-group-item root" >全部文件</a>
					<a href="ListFiles?path=image" class="list-group-item image">图片</a>
					<a href="ListFiles?path=document" class="list-group-item document">文档</a>
					<a href="ListFiles?path=video" class="list-group-item video">视频</a>
					<a href="ListFiles?path=music" class="list-group-item music">音乐</a>
					<a href="ListFiles?path=other" class="list-group-item other">其他</a>
				</div>
			</div>
			<div class="card col-sm-10">
				<div class="card-body">
					<c:choose>
						<c:when test="${empty paths }">
							${path }
						</c:when>
						
						<c:otherwise>
							<div id="menudiv">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#uploadModal">
									<i class="fa fa-cloud-upload"></i> 文件上传
								</button>
								<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#newFolder">
									<i class="fa fa-folder-o fa-lg"></i> 新建文件夹
								</button>
								
							</div>
							<ul class="breadcrumb">
								<c:if test="${lastPath != \"\"}">
									<a href="/ListFiles?path=${lastPath }">返回上一级</a>
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
						</c:otherwise>
					</c:choose>
							

					<table class="table table-hover">
						<thead>
							<tr>
								<th><input id="CheckAll" type="checkbox" /></th>
								<th>文件名</th>
								<th>  </th>
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
												<img src="img/icon/${file.type }.png" alt="logo" style="width:25px;">
												<a href="${folderURL}" class="fileName">${file.fileName}</a>
											</td>
											<td> </td>
											<td>-</td>
										</c:when>
										<c:otherwise>
											<c:url value="/DownLoad" var="downLoadURL">
												<c:param name="fileName" value="${file.uuidName}"></c:param>
												<c:param name="path" value="${path }"></c:param>
											</c:url>
											<c:url value="/ShareFile" var="shareURL">
												<c:param name="fileName" value="${file.uuidName}"></c:param>
												<c:param name="path" value="${path }"></c:param>
												<c:param name="size">${file.size }</c:param>
											</c:url>
											<td>
												<img src="img/icon/${file.type }.png" alt="logo" style="width:25px;">
												<a href="${downLoadURL}" class="fileName">${file.fileName}</a>&nbsp&nbsp
											</td>
											<td>
												<a href="${downLoadURL }"><i class="fa fa-download fa-lg"></i></a>  
												<a href="javascript:void(0);" class="share" url="${shareURL }"><i class="fa fa-share-alt fa-lg"></i></a>
											</td>
											<td>${file.showSize }</td>
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
	
	<!-- 文件上传 -->
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
	
	<!-- 新建文件夹 -->
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
	
	<!-- 显示分享链接 -->
    <div class="modal fade" id="shareModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 模态框头部 -->
				<div class="modal-header">
					<h4 class="modal-title">分享</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- 模态框主体 -->
				<div class="modal-body">
					<p class="text-primary">成功创建分享链接</p>
					<div class="row">
						<div class="col-sm-9">
							<input type="text" id="linkText" class="form-control">
						</div>
						<div class="col-sm-3">
							<button type="button" id="copyLink" class="btn btn-primary">复制链接</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-9">
							<p class="text-muted">可以将链接发送给你的QQ等好友</p>
						</div>
						<div class="col-sm-3">
							<div class="alert alert-success">
								<!-- <strong>成功!</strong> 指定操作成功提示信息。 -->
							</div>
						</div>
					</div>
					
				</div>
				<!-- 模态框底部 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-primary" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>