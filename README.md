# JCloud 
项目采用SSM+SqlSever架构，共设有管理员、会员、游客三种角色。

会员可以实现用户的上传、删除、重命名、查询、分享文件等操作； 

游客可以查看使用手册、注册、下载分享的文件；

管理可以对会员和文件系统进行管理。

## 结构

```
com.cloud.interceptor包 
	CommonInterceptor类：自定义SpringMVC拦截器 
model.bean包 
	GetFileSize类：返回文件夹或文件大小，并根据大小转换成KB、MB、GB 
	GetRanNo类：获取随机字符串，用于生成uNo和aNo 
	ImageServlet类：生成验证码 
	TransformMD5类：将字符串转成对应MD5值；获取文件MD5值 
MyCloud包 
	集成数据库交互的操作 
myMVC包 
	逻辑控制操作
```
```
| 用户页面 	| 页面名称     	| 注释         	|
|----------	|--------------	|--------------	|
|          	| user-home    	| 用户操作主页 	|
|          	| user-profile 	| 用户属性     	|
|          	| user-rename  	| 用户重命名   	|
|          	| user-set     	| 用户修改密码 	|
|          	| user-upload  	| 用户上传     	|
|          	| user-share   	| 用户分享     	|
```
```   
| 管理员页面 	| 页面名称   	| 注释           	|
|------------	|------------	|----------------	|
|            	| admin-home 	| 管理员操作主页 	|
|            	| admin-info 	| 管理员属性     	|
```
```
| 系统页面 	| 页面名称    	| 注释           	|
|----------	|-------------	|----------------	|
|          	| adminLogin  	| 管理员登录     	|
|          	| useRegister 	| 用户注册       	|
|          	| userLogin   	| 用户登录       	|
|          	| guest-home  	| 访客界面       	|
|          	| codefail    	| 验证码等错误页 	|
```
## 部署

SqlSever导入JCloudDB.sql数据库脚本，完成数据库部署
## 演示

#### 登陆页面

![](https://github.com/Umbrellazc/JCloud/blob/master/images/login.png)

#### 用户主页

![](https://github.com/Umbrellazc/JCloud/blob/master/images/home.png)

#### 分享

用户分享

![](https://github.com/Umbrellazc/JCloud/blob/master/images/share.png)

游客下载

![](https://github.com/Umbrellazc/JCloud/blob/master/images/download_share.png)
