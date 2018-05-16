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
	String result=(String)session.getAttribute("guest-result");
%>	
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
									<a href="index">@guest</a>
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
							<li class="active">
								<a href="index"><i class="icon-white icon-home"></i> 登录网盘</a>
							</li>
							<li >
								<a href="sign"><i class="icon-folder-open"></i> 注册网盘</a>
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
						访客界面
					</h1>
					<form id="edit-profile" class="form-horizontal" 
					action="/MyCloud/downGuest" method="post">
						<fieldset>
							<legend>输入提取码完成下载</legend>	
							
							<div class="control-group">
								<label class="control-label" for="input01">文件编号：</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" value="输入编号" name="fNo"/>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label" for="input01">提取密码：</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" value="输入密码" name="fPwd"/>
									<p class="help-block">请输入四位密码！</p>
								</div>
							</div>
							<label class="label" for="fileInput">结果：<% out.print(result);
															session.setAttribute("guest-result", "null"); %></label>			
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">下载</button> <button class="btn">取消</button>
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