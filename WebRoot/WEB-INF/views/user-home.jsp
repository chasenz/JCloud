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
		<title>用户主页</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="resource/css/bootstrap.min.css" rel="stylesheet">
		<link href="resource/css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="resource/css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body>
<%
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
							<li class="active">
								<a href="user-home"><i class="icon-white icon-home"></i> 我的文档</a>
							</li>
							<li>
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
					<div class="well summary">
						<ul>
							<li>
							<span class="count">Welcome！</span> 以下是文件列表
							</li>
						</ul>
					</div>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th width="19%" align="center">
									文件名
								</th>
								<th width="32%" align="center">
									编号
								</th>
								<th width="28%" align="center">
									上传日期
								</th>
								<th width="21%" align="center">
									操作
								</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${sessionScope.fileList}" var="FileInfo">
							<tr>
								<td>
									${FileInfo.fName}
								</td>
								<td>
									${FileInfo.fNo}
								</td>
								<td>
									${FileInfo.fDate}
								</td>
								<td>
									<p><a href="downFile?fNo=${FileInfo.fNo}" class="view-link">下载</a>|
                                      <a href="delFile?fNo=${FileInfo.fNo}" class="view-link">删除</a>|                                      
                                      <a href="doShare?fNo=${FileInfo.fNo}" class="view-link">分享</a>|
                                      <a href="user-rename?fName=${FileInfo.fName}&&fNo=${FileInfo.fNo}" class="view-link">重命名</a></p>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="pagination">
						<ul>
							<li>
								<a href="mylist?up_down=-1&&cho_page=0">&laquo;</a>
							</li>
							<li>
								<a href="mylist?up_down=0&&cho_page=1">1</a>
							</li>
							<li>
								<a href="mylist?up_down=0&&cho_page=2">2</a>
							</li>
							<li>
								<a href="mylist?up_down=0&&cho_page=3">3</a>
							</li>
							<li>
								<a href="mylist?up_down=0&&cho_page=4">4</a>
							</li>
							<li>
								<a href="mylist?up_down=1&&cho_page=0">&raquo;</a>
							</li>
						</ul>
					</div>   
			  </div>
			</div>
		</div>
		<script src="resource/js/jquery.min.js"></script>
		<script src="resource/js/bootstrap.min.js"></script>
		<script src="resource/js/site.js"></script>
	</body>
</html>