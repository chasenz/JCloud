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
<%
	String result=(String)session.getAttribute("up-result");
	String uName=(String)session.getAttribute("uName");
%>	
	<div class="container">
		<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="#">网盘首页</a>
						<div class="nav-collapse">
							<ul class="nav">
								<li class="active">
									<a href="home">首页</a>
								</li>
								<li>
									<a href="settings">账户设置</a>
								</li>
								<li>
									<a href="help">使用指南</a>
								</li>
								

									</ul>
								</li>
							</ul>
						  <form class="navbar-search pull-left" action="/MyCloud/doSearch">
								<input type="text" class="search-query span2" placeholder="Search" name="sName"/>
								<input type="submit" name="button" id="button" value="提交">
							</form>
							<ul class="nav pull-right">
								<li>
									<a href="settings">@<% out.print(uName);%></a>
								</li>
								<li>
									<a href="logOut">Logout</a>
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
								<a href="user-home"><i class="icon-white icon-home"></i> 我的文档</a>
							</li>
							<li class="active">
								<a href="user-upload"><i class="icon-folder-open"></i> 上传文档</a>
							</li>
		
							<li class="nav-header">
								我的信息
							</li>
							<li>
								<a href="profile"><i class="icon-user"></i> 基本信息</a>
							</li>
							<li>
								<a href="settings"><i class="icon-cog"></i> 修改密码</a>
							</li>
							<li class="divider">
							</li>
							<li>
								<a href="help"><i class="icon-info-sign"></i> 使用指南</a>
							</li>
						</ul>
					</div>
				</div>
            <div class="span9">
					<h1>
						文件上传
					</h1>
					<form id="edit-profile" class="form-horizontal"
					action="/MyCloud/doUpload"method="post" enctype="multipart/form-data">
						<fieldset>
							<legend>禁止重复上传</legend>	
							<div class="control-group">
							  <label class="control-label" for="fileInput">读入文件</label>
								<div class="controls">
									<input class="input-file" id="fileInput" type="file" name="file"/>
								</div>
							</div>
							<label class="label" for="fileInput">结果：<% out.print(result);
															session.setAttribute("up-result", "null"); %></label>										
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">上传</button> <button class="btn">取消</button>
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