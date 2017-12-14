<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page='<%="/CheckLogin"%>' />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CloudDrive</title>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<!-- popper.min.js 用于弹窗、提示、下拉菜单 -->
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<!-- 最新的 Bootstrap4 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">

<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
</head>

<body>
	<div id="wrapper">
		<header class="background_white">
			<div id="logo">
				<img src="img/logo.gif" alt="logo">
			</div>
			<form action="DoLogout" method="post">
				<input type="submit" value="退出登录" style="float:right">
			</form>
			<div id="banner">
				<h1>CloudDrive</h1>
			</div>
		</header>

		<div id="container">
			<div id="sidebar" class="background_white">
				<div id="bkgreen">
					<h3>Sidebar</h3>
				</div>
				<ul>
					<c:url value="ListFiles" var="pathURL">
			            <c:param name="path" value="root"></c:param>
			        </c:url>
					<li><a href="${pathURL }">全部文件</a></li>
					<c:url value="ListFiles" var="pathURL">
			            <c:param name="path" value="photo"></c:param>
			        </c:url>
					<li><a href="${pathURL }">图片</a></li>
					<li><a href="#">文档</a></li>
					<li><a href="#">视频</a></li>
					<li><a href="#">音乐</a></li>
					<li><a href="#">其他</a></li>
				</ul>
			</div>
			<div id="main" class="background_white">
				<div id="menudiv">
					<form action="UpLoad" id="upLoadForm" enctype="multipart/form-data" method="post">
						<input type="text" class="pathText" name="path" value="${path }">
						<input type="file" id="upLoadBtn" name="file" value="上传"/>
						<input type="submit" value="提交">
					</form>
				</div>
				<div id='dialog-modal'></div>
				<hr>
				<div id="path">
					<c:if test="${lastPath != \"\"}">
						<c:url value="ListFiles" var="folderURL">
				            <c:param name="path" value="${lastPath }"></c:param>
				        </c:url>
						<a href="${folderURL}">返回上一级</a>
						<span class="gt">|</span>
					</c:if>
					
					<c:forEach var="ml" items="${paths }">
						<c:choose>
							<c:when test="${ml.key == \"root\" }">
								<c:url value="ListFiles" var="folderURL">
						            <c:param name="path" value="${ml.value }"></c:param>
						        </c:url>
								<a href="${folderURL }">全部文件</a>
							</c:when>
							<c:otherwise>
								<span class="gt">></span>
								<c:url value="ListFiles" var="folderURL">
						            <c:param name="path" value="${ml.value }"></c:param>
						        </c:url>
								<a href="${folderURL }">${ml.key }</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				
				<div id="content">
					<!-- 按钮：用于打开模态框 -->
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
					  新建文件夹
					</button>
					<!-- 模态框 -->
					<div class="modal fade" id="myModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<!-- 模态框头部 -->
								<div class="modal-header">
									<h4 class="modal-title">新建文件夹</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								<form role="form" action="MkDir" method="post">
									<!-- 模态框主体 -->
									<div class="modal-body">
										<input type="text" class="form-control" name="folderName" id="name" placeholder="请输入文件夹名">
										<input type="text" class="pathText" name="path" value="${path }">
									</div>

									<!-- 模态框底部 -->
									<div class="modal-footer">
										<input type="submit" class="btn btn-info" value="提交按钮">

										<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<table>
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
								        		<c:url value="ListFiles" var="folderURL">
										            <c:param name="path" value="${path}/${file.fileName }"></c:param>
										        </c:url>
										        <td>
								        			<a href="${folderURL}">${file.fileName}</a>
								        		</td>
								        		<td>-</td>
								        	</c:when>
								        	<c:otherwise>
									        	<c:url value="/DownLoad" var="downLoadURL">
										            <c:param name="fileName" value="${file.uuidName}"></c:param>
										            <c:param name="path" value="${path }"></c:param>
										        </c:url>
										        <td>
								        			${file.fileName}&nbsp&nbsp<a href="${downLoadURL}">下载</a>
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
		<footer class="background_white">
			<h4>All Copyright Reserved ©2017 ACM</h4>
			<label id="time"></label>
		</footer>
	</div>
</body>
</html>