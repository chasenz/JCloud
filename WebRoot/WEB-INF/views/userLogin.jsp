<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>网盘登录</title>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="resource/css/normalize.min.css">
<link href='resource/css/style.css' rel='stylesheet' type='text/css'>
</head>
<script language="javascript">  
	function flushCode() {
    // 每次刷新的时候获取当前时间，防止浏览器缓存刷新失败
    var time = new Date();
    document.getElementById("scode").src = "<%=request.getContextPath()%>/getCode?time=" + time;
} 
</script> 
<body>
  <div class="wrapper">
  <form class="login" method="post" action="/MyCloud/doUserLogin">
    <p class="title">Log in</p>
    <input type="text" placeholder="Username" autofocus name="uName"/>
    <i class="fa fa-user"></i>
    <input type="password" placeholder="Password" name="uPwd" />
    <i class="fa fa-key"></i>
    <input type="text" placeholder="Code"  name="vcode"/>
	 <i class="fa fa-archive"></i>
	<img alt="验证码" id="scode" src="<%=request.getContextPath() %>/getCode" ><a href="#" onClick="javascript:flushCode();">看不清?</a>
    <a href="sign">没有账户?</a>
    <button type="submit" name="Submit">
      <i class="spinner"></i>
      <span class="state" >Log in</span>
    </button>
  </form>

 <div style="text-align:center;clear:both;margin-top:80px">
<script src="/gg_bd_ad_720x90.js" type="text/javascript"></script>
<script src="/follow.js" type="text/javascript"></script>
</div>

  </p>
</div>

</body>
</html>
