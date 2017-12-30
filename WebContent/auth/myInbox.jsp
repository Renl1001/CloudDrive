<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/main.css">

	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/clipboard.min.js"></script>
	<script src="js/ajax.js"></script>

    <script src="js/fileinput.min.js" type="text/javascript"></script>
    <script src="themes/fa/theme.js" type="text/javascript"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script src="js/inbox.js" type="text/javascript"></script>
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
					<a class="nav-link" href="ShareManage">我的分享</a>
				</li>
				<li class="nav-item">
					<a class="nav-link nav-current" href="InboxManage">收件夹</a>
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
				<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#newFolder">
					<i class="fa fa-folder-o fa-lg"></i> 新建收件夹
				</button>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>文件夹</th>
							<th>  </th>
							<th>发布时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="inbox" items="${inboxs}">
							<tr>								
								<c:url value="DelInbox" var="delURL">
									<c:param name="key" value="${inbox.key}"></c:param>
								</c:url>
								<td>
									<img src="img/icon/folder.png" alt="logo" class="fileIcon">
									<a href="Inbox?key=${inbox.key }" target="_blank" class="fileName">${inbox.inboxName }</a>
								</td>
								<td>
									<div class="disabled">
										<a href="${delURL }" title="删除收件夹"><i class="fa fa-ban fa-lg"></i></a>
									</div>  
								</td>
								<td>${inbox.startTime }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 新建收件夹 -->
	<div class="modal fade" id="newFolder">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<form role="form" action="MkInbox" method="post">
					<div class="modal-header">
						<h4 class="modal-title">新建收件夹</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				
					<div class="modal-body">
						<div class="form-group">
							<label for="inboxName">收件夹名:</label>
    						<input type="text" class="form-control" id="inboxName">
						</div>
						
						<div class="form-group">
					      	<label for="illustrate">说明:</label>
					      	<textarea class="form-control" rows="5" id="illustrate"></textarea>
					    </div>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-info" value="新建" id="mkInbox">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 显示收件夹链接 -->
    <div class="modal fade" id="inboxLinkModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 模态框头部 -->
				<div class="modal-header">
					<h4 class="modal-title">创建收件夹</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- 模态框主体 -->
				<div class="modal-body">
					<p class="text-primary">成功创建收件夹</p>
					<div class="row">
						<div class="col-sm-9">
							<input type="text" id="linkText" class="form-control">
						</div>
						<div class="col-sm-3">
							<button id="copyLink" data-clipboard-target="#linkText" class="btn btn-primary">复制链接</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8">
							<p class="text-muted">可以将链接发送给你的QQ等好友</p>
						</div>
					</div>
					<div id="copyInfo">
						<div class="alert alert-success" id="copySuccess">
							<strong>复制成功!</strong>
						</div>
						<div class="alert alert-danger" id="copyError">
							<strong>复制失败!</strong>
						</div>
					</div>
				</div>
				<!-- 模态框底部 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-primary" data-dismiss="modal" >关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>