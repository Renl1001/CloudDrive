<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>CloudDrive</title>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/ajax.js"></script>
	<script src="js/jquery.validate.min.js" type="text/javascript"></script>
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- Font Awesome -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
	<!-- <script src="themes/fa/theme.js" type="text/javascript"></script> -->
	<!--  -->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<link rel="stylesheet" type="text/css" href="css/checkbox.css">
   	<script src="js/mkfoldercheck.js" type="text/javascript"></script>
	<script src="js/signupcheck.js" type="text/javascript"></script>
	<script src="js/logincheck.js" type="text/javascript"></script>
	<script src="js/home.js" type="text/javascript"></script>
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
					<a class="nav-link nav-current" href="Home">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ListFiles">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ShareManage">我的分享</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="InboxManage">收件夹</a>
				</li>
				<c:choose>
					<c:when test="${empty name }">
						<!-- 未登录 -->
						<li class="nav-item">
							<button type="button" class="btn btn-primary nav-button" data-toggle="modal" data-target="#login">登录 </button>
						</li>
						<li class="nav-item">
							<button type="button" class="btn btn-primary nav-button" data-toggle="modal" data-target="#signup">注册 </button>
						</li>
					</c:when>
					<c:otherwise>
						<!-- 登录成功 -->
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
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>
	
	<div class="container">
		<div class="topsharetitle">
		Top 12 hot shares
		</div>
		<div class="row">
			<c:forEach var="share" items="${shares}">
				<div class="card-container col-sm-4">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div class="col-xl-3"></div>
								<div class="col-xl-6" >
									<img  class="home_icon" src="img/icon/${share.type }.png" > 
								</div>
							</div>
							<div class="row">
								<!-- <div class="col-sm-1"></div> -->
								<div class="col-sm-12">
									<div class="row" style="padding-top:15px">
										<div class="col-sm-3">
											文件名 
										</div>
										<div class="col-sm-9 ellipsis">
											<a href="Share?key=${share.key }" target="_blank" class="fileName" title="${share.fileName}">${share.fileName}</a>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-3">
											热度 
										</div>
										<div class="col-sm-9">
											${share.downloads }
										</div>
									</div>
									<div class="row">
										<div class="col-sm-3">
											大小
										</div>
										<div class="col-sm-9">
											${share.showSize }
										</div>
									</div>
									<div class="row">
										<div class="col-sm-3">
											分享者
										</div>
										<div class="col-sm-9">
											${share.user }
										</div>
									</div>
								</div>
							</div>
						</div>	
					</div>	
				</div> <!--card-container -->	
			</c:forEach>
		</div>	
	</div>
	
	<!-- 登录模态框  -->
	<div class="modal fade" id="login">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" id="loginForm" method="post" action="DoLogin" role="form">
				    <div class="row">
				        <div class="col-md-offset-6 col-md-12">
							<span class="heading">用户登录</span>
							<div class="form-group">
								<input type="text" class="form-control" id="userName" name="userName" placeholder="用户名或电子邮件">
								<i class="fa fa-user"></i>
							</div>
							<div class="form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="密　码">
								<i class="fa fa-lock"></i>
								<!--<a href="#" class="fa fa-question-circle"></a>-->
							</div>
							<div class="form-group">
								<div class="main-checkbox">
									<input type="checkbox" value="None" id="checkbox1" name="isSave"/>
									<label for="checkbox1"></label>
								</div>
								<span class="text">记住用户名</span>
								<!--<button type="submit" class="btn btn-default">登录</button>-->
							</div>
				        </div>
				    </div>
					<!-- 模态框底部 -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" value="登录">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
						 
					</div>
					<c:if test="${not empty message }">
						<div class="alert alert-danger" id="loginError">
							<strong>${message }</strong>
						</div>	
					</c:if>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 注册模态框  -->
	<div class="modal fade" id="signup">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" id="signupForm" method="post" action="DoRegister" role="form">
					<!-- 模态框主体 -->
				    <div class="row">
				        <div class="col-md-offset-6 col-md-12">			            
				                <span class="heading">用户注册</span>
				                <div class="form-group">
				                    <input type="text" class="form-control" id="ruserName" name="ruserName" placeholder="用户名">
				                    <i class="fa fa-user"></i>
				                </div>
				                <div class="form-group">
				                    <input type="password" class="form-control" id="rpwd" name="rpwd" placeholder="密码">
				                    <i class="fa fa-lock"></i>
				                    <!--<a href="#" class="fa fa-question-circle"></a>-->
				                </div>
				                <div class="form-group">
				                    <input type="password" class="form-control" id="rrepwd" name="rrepwd" placeholder="再次输入密码">
				                    <i class="fa fa-lock"></i>
				                    <!--<a href="#" class="fa fa-question-circle"></a>-->
				                </div>
				        </div>
				    </div>
					<!-- 模态框底部 -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" value="注册">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
					</div>
					<c:if test="${not empty rmessage }">
						<div class="alert alert-danger" id="registerError">
							<strong>${rmessage }</strong> 
						</div>	
					</c:if>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
