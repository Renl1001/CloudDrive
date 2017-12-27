<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>CloudDrive</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/themes/fa/theme.min.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/fileinput.min.js" type="text/javascript"></script>
	<script src="themes/fa/theme.min.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/main.js" type="text/javascript"></script>
	<script src="js/locales/zh.js" type="text/javascript"></script>
</head>

<body>
	<nav class="navbar navbar-expand-sm main-navigation">
		<div class="container">
			<a class="navbar-brand" href="#">
				<img src="img/logo.gif" alt="logo" style="width:40px;"> CloudDrive
			</a>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link nav-current" href="home.jsp">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ListFiles">网盘</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ShareManage">分享</a>
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
	<div class="modal fade" id="login">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 模态框头部 -->
				<form class="form-horizontal" method="post" action="DoLogin" role="form">
					<!-- 模态框主体 -->
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
									<input type="checkbox" value="None" id="checkbox1" name="check"/>
									<label for="checkbox1"></label>
								</div>
								<span class="text">记住我</span>
								<!--<button type="submit" class="btn btn-default">登录</button>-->
							</div>
				        </div>
				    </div>
					<!-- 模态框底部 -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" value="登录">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
					</div>	 
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="signup">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 模态框主体 -->
			    <div class="row">
			        <div class="col-md-offset-6 col-md-12">
			            <form class="form-horizontal">
			                <span class="heading">用户注册</span>
			                <div class="form-group">
			                    <input type="email" class="form-control" id="inputEmail3" placeholder="用户名">
			                    <i class="fa fa-user"></i>
			                </div>
			                <div class="form-group">
			                    <input type="password" class="form-control" id="inputPassword3" placeholder="密码">
			                    <i class="fa fa-lock"></i>
			                    <!--<a href="#" class="fa fa-question-circle"></a>-->
			                </div>
			                <div class="form-group">
			                    <input type="password" class="form-control" id="reinputPassword3" placeholder="重新输入密码">
			                    <i class="fa fa-lock"></i>
			                    <!--<a href="#" class="fa fa-question-circle"></a>-->
			                </div>
			            </form>
			        </div>
			    </div>
				<!-- 模态框底部 -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" data-dismiss="modal">注册</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
				</div>	 
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="card-container col-sm-4">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="card col-sm-4">
								<img src="img/logo.gif" alt="logo" style="width:40px;"> 
							</div>	
							<div class="card col-sm-8">
								<div class="row">
									<div class=" col-sm-6">
										<div>文件名:</div>
										<div>大小:</div>
										<div>热度:</div>
									</div>
									<div class=" col-sm-6">
										<div>hello.c</div>
										<div>1024kb</div>
										<div>9000</div>
									</div>		
								</div>	
							</div>
							
						</div>
					</div>	
				</div>
			</div>
			
			<div class="card-container col-sm-4">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="card col-sm-4">
								<img src="img/logo.gif" alt="logo" style="width:40px;"> 
							</div>	
							<div class="card col-sm-8">
								<div class="row">
									<div class=" col-sm-6">
										<div>文件名:</div>
										<div>大小:</div>
										<div>热度:</div>
									</div>
									<div class=" col-sm-6">
										<div>hello.c</div>
										<div>1024kb</div>
										<div>9000</div>
									</div>		
								</div>	
							</div>
							
						</div>
					</div>	
				</div>
			</div>
			<div class="card-container col-sm-4">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="card col-sm-4">
								<img src="img/logo.gif" alt="logo" style="width:40px;"> 
							</div>	
							<div class="card col-sm-8">
								<div class="row">
									<div class=" col-sm-6">
										<div>文件名:</div>
										<div>大小:</div>
										<div>热度:</div>
									</div>
									<div class=" col-sm-6">
										<div>hello.c</div>
										<div>1024kb</div>
										<div>9000</div>
									</div>		
								</div>	
							</div>
							
						</div>
					</div>	
				</div>
			</div>
			<div class="card-container col-sm-4">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="card col-sm-4">
								<img src="img/logo.gif" alt="logo" style="width:40px;"> 
							</div>	
							<div class="card col-sm-8">
								<div class="row">
									<div class=" col-sm-6">
										<div>文件名:</div>
										<div>大小:</div>
										<div>热度:</div>
									</div>
									<div class=" col-sm-6">
										<div>hello.c</div>
										<div>1024kb</div>
										<div>9000</div>
									</div>		
								</div>	
							</div>
							
						</div>
					</div>	
				</div>
			</div>
			
			
		</div>
	</div>
	
</body>

</html>


<!-- <form method="post" action="DoLogin">
  		<table>
  			<tr>
  				<td>用户名:</td><td><input type="text" id="userName" name="userName"></td>
  			</tr>
  			<tr>
  				<td>密码:</td><td><input type="password" id="pwd" name="pwd"></td>
  			</tr>
  			<tr><td><span id="errorInfo"></span></td></tr>
  			<tr>
  				<td><input type="submit" value="登录"></td>
  			</tr>
  		</table>
  	</form> -->