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
		<title>网盘—文件上传</title>
		<meta name="resource/viewport" content="width=device-width, initial-scale=1.0">
		<link href="resource/css/bootstrap.min.css" rel="stylesheet">
		<link href="resource/css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="resource/css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body>
	<div class="container">
		<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="#">网盘首页</a>
						<div class="nav-collapse">
							<ul class="nav">
								<li class="active">
									<a href="guest-home">首页</a>
								</li>
								<li>
									<a href="index">账户设置</a>
								</li>
								<li>
									<a href="help">使用指南</a>
								</li>
								

									</ul>
								</li>
							</ul>
							<ul class="nav pull-right">
								<li>
									<a href="#">@Help</a>
								</li>
								<li>
									<a href="sign">Sign in</a>
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
							<li>
								<a href="index"><i class="icon-white icon-home"></i> 登录网盘</a>
							</li>
							<li >
								<a href="sign"><i class="icon-folder-open"></i> 注册网盘</a>
							</li>
							<li class="divider">
							</li>
							<li class="active">
								<a href="help"><i class="icon-info-sign"></i> 使用指南</a>
							</li>
						</ul>
					</div>
				</div>
            <div class="span9">
				<h1>
					使用指南
				</h1>
					<h2>
					</h2>
					<ul class="messages">
						<li class="well">
							<p class="message">
								  <p>本软件是采用Java EE开发的网络云盘，可以实现用户的注册、登陆与用户的资料管理（上传、下载、重命名、删除、查询、分享）</P>
  								<p>运行环境:基于windows操作系统，理论上任意操作系统带有浏览器与联网功能均可以运行本系统。</P>
  								<p>用例：</P>
								<p>1、 普通用户要注册个人信息，登录系统，上传文档，删除文件，重命名文件，查询文件，分享文件；</P>
								<p>2、 管理员要登录系统，对注册的用户进行管理登记，对文件进行管理；</P>
								<p>3、 未登录用户可以注册账户，获取分享文件。</P>
							</p>
							<span class="meta">Written <em>2 weeks ago</em> by <em>Admin</em></span>
						</li>

			</div>
		<script src="resource/js/jquery.min.js"></script>
		<script src="resource/js/bootstrap.min.js"></script>
		<script src="resource/js/site.js"></script>
	</body>
</html>