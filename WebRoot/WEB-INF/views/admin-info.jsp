<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>管理界面</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="resource/css/bootstrap.min.css" rel="stylesheet">
		<link href="resource/css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="resource/css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body>
<%
	String aName=(String)session.getAttribute("aName");
	String uNum=(String)request.getAttribute("uNum");
	String fNum=(String)request.getAttribute("fNum");
	String aSize=(String)request.getAttribute("aSize");
%>
		<div class="container">
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="#">后台首页</a>
						<div class="nav-collapse">
							<ul class="nav">
								<li class="active">
									<a href="home">首页</a>
								</li>
								<li>
									<a href="admin-info">网盘信息</a>
								</li>
								<li>
									<a href="index">用户首页</a>
								</li>
								

									</ul>
								</li>
							</ul>

							<ul class="nav pull-right">
								<li>
									<a href="#">@<% out.print(aName);%></a>
								</li>
								<li>
									<a href="alogOut">Logout</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="span3">
					<div class="well" style="padding: 8px 0;">
						<ul class="nav nav-list">
							<li class="nav-header">
								我的操作
							</li>
							<li >
								<a href="admin-home"><i class="icon-white icon-home"></i> 文档管理</a>
							</li>
							<li class="active">
								<a href="admin-info"><i class="icon-folder-open"></i> 网盘信息</a>
							</li>
						</ul>
					</div>
				</div>
 					<div class="span9">
					<h1>
						网盘状态
					</h1>
					<form id="edit-profile" class="form-horizontal" 
					action="#" method="post">
						<fieldset>
							<legend>网盘详细信息如下</legend>	
							
							<div class="control-group">
								<label class="control-label" for="input01">文件总数：</label>
								<div class="controls">
									<p class="help-block"><%out.print(fNum);%></p>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label" for="input01">用户总数</label>
								<div class="controls">
									<p class="help-block"><%out.print(uNum);%></p>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label" for="input01">云盘使用：</label>
								<div class="controls">
									<p class="help-block"><%out.print(aSize);%></p>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
		</div>
		<script src="resource/js/jquery.min.js"></script>
		<script src="resource/js/bootstrap.min.js"></script>
		<script src="resource/js/site.js"></script>
	</body>
</html>