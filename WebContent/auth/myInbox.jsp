<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>CloudDrive</title>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/ajax.js"></script>
	<script src="js/jquery.validate.min.js" type="text/javascript"></script>
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- fileinput -->
	<link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
	<script src="js/fileinput.min.js" type="text/javascript"></script>
	<script src="js/locales/zh.js" type="text/javascript"></script>
	<!-- Font Awesome -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
	<script src="themes/fa/theme.js" type="text/javascript"></script>
	<!-- clipboard -->
	<script src="js/clipboard.min.js"></script>
	<!--  -->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<link rel="stylesheet" type="text/css" href="css/checkbox.css">
	<script src="js/checkbox.js" type="text/javascript"></script>
    <script src="js/inbox.js" type="text/javascript"></script>
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
						<div class="row">
							<ul class="breadcrumb col-sm-9">
								<a href="InboxManage">收件夹</a>
								<span class="gt"> > </span>
								${path }
							</ul>
							<div id="menudiv" class="col-sm-3">
								<button type="button" class="btn btn-primary checkShow" data-toggle="modal" data-target="#uploadModal">
									<i class="fa fa-cloud-download"></i> 下载
								</button>
								<button type="button" class="btn btn-outline-danger checkShow" data-toggle="modal" data-target="#delInfoModal">
									<i class="fa fa-trash-o fa-lg"></i> 删除
								</button>
							</div>
						</div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th>
										<div class="main-checkbox">
											<input type="checkbox" value="None" id="CheckAll" name="check"/>
											<label for="CheckAll"></label>
										</div>
									</th>
									<th>文件名</th>
									<th>  </th>
									<th>大小</th>
									<th>上传日期</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="index" value="0" />
								<c:forEach var="file" items="${files}">
									<c:set var="index" value="${index+1}" />
									<tr>
										<td>
											<div class="main-checkbox">
												<input type="checkbox" value="None" id="check${index }" name="subBox"/>
												<label for="check${index }"></label>
											</div>
										</td>
										<td>
											<img src="img/icon/${file.type }.png" alt="logo" class="fileIcon">
											<a href="${downLoadURL}" class="fileName">${file.fileName}</a>
										</td>
										<td>
											<div class="param">
												<span class="fileName">${file.uuidName}</span>
												<span class="path">${file.path }</span>
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
										<td>
											<img src="img/icon/folder.png" alt="logo" class="fileIcon">
											<a href="InboxManage?path=inbox/${inbox.inboxName }" class="fileName">${inbox.inboxName }</a>
										</td>
										<td>
											<a href="#" title="收件地址" data-toggle="popover" data-placement="left" data-content="${inboxBaseURL }?key=${inbox.key }"><i class="fa fa-link fa-lg"></i></a>
											&nbsp&nbsp
											<a href="javascript:void(0);" title="删除收件夹" class="delInbox"><i class="fa fa-trash-o fa-lg"></i></a>
											<div class="param">
												<span class="key">${inbox.key}</span>
												<span class="inboxName">${inbox.uuidName}</span>
											</div>
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
	<!-- 删除提示信息 -->
	<div class="modal fade" id="delInfoModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">删除文件</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
			
				<div class="modal-body">
					<i class="fa fa-info-circle"></i> 确定删除选中文件？
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" id="confirmDeletion">删除</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 删除收件夹提示信息 -->
	<div class="modal fade" id="delInboxModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="DelInbox" method="post">
					<div class="modal-header">
						<h4 class="modal-title">删除收件夹</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				
					<div class="modal-body">
						<i class="fa fa-info-circle"></i> 删除收件夹后，收件内容也会丢失，确定继续删除？
						<div class="disabled">
							<input type="text" name="key" id="subkey" />
							<input type="text" name="inboxName" id="subInboxName" />
						</div>
					</div>
	
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">删除</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>