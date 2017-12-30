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
				<img src="img/logo.png" alt="logo" class="logo">
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
					<img src="img/avatar.gif" class="rounded-circle" alt="head" style="width:40px;">
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
						${name }
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="DoLogout">退出登录</a>
					</div>
				</li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="card">
			<div class="card-body">
				<c:choose>
					<c:when test="${empty inboxBaseURL }">
						<ul class="breadcrumb">
							<a href="InboxManage">收件夹</a>
							<span class="gt">></span>
							${path }
						</ul>
						<table class="table table-hover">
							<thead>
								<tr>
									<th><input id="CheckAll" type="checkbox" /></th>
									<th>文件名</th>
									<th>  </th>
									<th>大小</th>
									<th>上传日期</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="file" items="${files}">
									<tr>
										<td><input name="subBox" type="checkbox" /></td>
										<c:url value="/DownLoad" var="downLoadURL">
											<c:param name="fileName" value="${file.uuidName}"></c:param>
											<c:param name="path" value="${file.path }"></c:param>
										</c:url>
										<c:url value="/DelFile" var="delURL">
											<c:param name="fileName" value="${file.uuidName}"></c:param>
											<c:param name="path" value="${file.path }"></c:param>
										</c:url>
										<td>
											<img src="img/icon/${file.type }.png" alt="logo" class="fileIcon">
											<a href="${downLoadURL}" class="fileName">${file.fileName}</a>
										</td>
										<td>
											<div class="disabled">
												<a href="${downLoadURL }" title="下载"><i class="fa fa-download fa-lg"></i></a>  
												<a href="${delURL }" title="删除" ><i class="fa fa-trash-o fa-lg"></i></a>
											</div>
										</td>
										<td>${file.showSize }</td>
										<td>${file.updateTime }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
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
											<c:param name="path" value="${inbox.path}"></c:param>
										</c:url>
										<td>
											<img src="img/icon/folder.png" alt="logo" class="fileIcon">
											<a href="InboxManage?path=inbox/${inbox.inboxName }" class="fileName">${inbox.inboxName }</a>
										</td>
										<td>
											<a href="#" title="收件地址" data-toggle="popover" data-placement="left" data-content="${inboxBaseURL }?key=${inbox.key }"><i class="fa fa-link fa-lg"></i></a>
											&nbsp&nbsp
											<a href="${delURL }" title="删除收件夹"><i class="fa fa-trash-o fa-lg"></i></a>
										</td>
										<td>${inbox.startTime }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<!-- 新建收件夹 -->
	<div class="modal fade" id="newFolder">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<form role="form" id="mkinboxfolder" action="MkInbox" method="post">
					<div class="modal-header">
						<h4 class="modal-title">新建收件夹</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				
					<div class="modal-body">
						<div class="form-group">
							<label for="inboxName">收件夹名:</label>
    						<input type="text" class="form-control" id="inboxName" name="inboxName">
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
					
					<div class="alert alert-danger" id="createInboxInfo">
						<strong></strong>
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