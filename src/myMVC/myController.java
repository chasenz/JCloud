package myMVC;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import MyCloud.*;
import model.bean.*;
@Controller
public class myController {
	TransformMD5 transMD5 = new TransformMD5();
	GetFileSize gfs = new GetFileSize();
	public List fileList,subfList,sfileList,afileList,asubfList;
	int pagesize=5;
	FileInfo fi = new FileInfo();
	@Resource
	UserInfoDAO userdao;
	@Resource
	FileInfoDAO filedao;
	@Resource
	ShareFileDAO sfdao;
	@Resource
	AdminInfoDAO admindao;
	//用户登录
	@RequestMapping("/doUserLogin")
	public String doUserLogin(UserInfo u,String vcode,HttpSession session){
		GetRanNo grn = new GetRanNo();
		vcode=grn.splitStr(vcode);//过滤特殊字符
		String getcode=(String) session.getAttribute("code");
		if(!(vcode.toLowerCase().equals(getcode.toLowerCase()))){
			return "codefail";
		}
		u.setuName(grn.splitStr(u.getuName()));
		u.setuPwd(grn.splitStr(u.getuPwd()));
		String md5_pwd=transMD5.getMD5(u.getuPwd());
		int count=userdao.findUser(u.getuName(),md5_pwd);
		if(count!=0){
			session.setAttribute("uName", u.getuName());
			fileList=filedao.findAll(userdao.findById(u.getuName()).getuNo());
			int endsize=pagesize;
			if(fileList.size()<pagesize)
				endsize=fileList.size();
			session.setAttribute("fileList", fileList.subList(0, endsize));
			int current_page=1;
			session.setAttribute("current_page",current_page);
			return "user-home";
		}
		return "codefail";
	}
	//用户注册
	@RequestMapping("/doUseReg")
	public String doUseReg(UserInfo u,String vcode,String uPwd2,HttpSession session){
		GetRanNo grn = new GetRanNo();
		vcode=grn.splitStr(vcode);//过滤特殊字符
		u.setuName(grn.splitStr(u.getuName()));
		u.setuPwd(grn.splitStr(u.getuPwd()));
		session.removeAttribute("re-result");
		String getcode=(String) session.getAttribute("code");
		if(!(vcode.toLowerCase().equals(getcode.toLowerCase()))){
			return "codefail";
		}
		if(userdao.findById(u.getuName())!=null){
			session.setAttribute("reg-result", "用户名已存在！");
			return "codefail";
		}
		if(!(u.getuPwd().equals(uPwd2))){
			session.setAttribute("reg-result", "密码不一致！");
			return "codefail";
		}
		String md5_pwd=transMD5.getMD5(u.getuPwd());
		String getNo="";
		do{
			getNo=grn.getRandomString(5);
		}while(userdao.findNo(getNo)!=0);
		u.setuPwd(md5_pwd);
		u.setuNo(getNo);
		userdao.addUser(u);
		return "userLogin";
	}
	//基本信息
	@RequestMapping("/profile")
	public String profile(HttpServletRequest request) throws Exception{
		String uName = (String) request.getSession().getAttribute("uName");
		String uNo = userdao.findById(uName).getuNo();
		ServletContext sc = request.getSession().getServletContext();  
        String path = sc.getRealPath("/resource/upload")+"/"+uName;
        File file = new File(path);
        String fSize = gfs.getFSize(file);
        request.setAttribute("pro-uNo", uNo);
        request.setAttribute("pro-fSize", fSize);
        return "user-profile";
	}
	//修改密码
	@RequestMapping("/doSet")
	public String doSet(String uPwd,String nuPwd,String nuPwd2,HttpSession session){
		System.out.println("n1:"+nuPwd+",n2:"+nuPwd2);
		if(!nuPwd.equals(nuPwd2)){
			session.setAttribute("set-result", "两次密码不一致！");
			return "user-set";
		}
		String uName = (String) session.getAttribute("uName");
		String md5_pwd=transMD5.getMD5(uPwd);
		if(userdao.findUser(uName, md5_pwd)==0){
			session.setAttribute("set-result", "原始密码错误！");
			return "user-set";
		}
		else{
			String md5_npwd=transMD5.getMD5(nuPwd);
			userdao.updatePwd(md5_npwd, uName);
			session.setAttribute("set-result", "修改成功！");
			return "user-set";
		}
	}
	//分页操作
	@RequestMapping("/mylist")
	public String homepage(int up_down,int cho_page,HttpSession session){
		int current_page=(Integer) session.getAttribute("current_page");
		int page=0;
		if(cho_page==0){
			page=current_page+up_down;
		}
		else
			page=cho_page;
		String uName=(String) session.getAttribute("uName");
		fileList=filedao.findAll(userdao.findById(uName).getuNo());
		int psize=fileList.size();
		int last_page=psize/pagesize+1;
		int endsize=pagesize;
		if(psize<endsize)
			endsize=pagesize;
		if(page<=0){
			page=1;
			subfList=fileList.subList(0, endsize);
			session.setAttribute("fileList", subfList);
		}
		if(page>=last_page){
			page=last_page;
			subfList=fileList.subList(psize-psize%pagesize, psize);
			session.setAttribute("fileList", subfList);
		}
		else{
			int former=(page-1)*pagesize;
			int latter=page*pagesize;
			subfList=fileList.subList(former,latter);
			session.setAttribute("fileList", subfList);
		}
		session.setAttribute("current_page", page);
		return "user-home";
	}
	//删除文件
	@RequestMapping("/delFile")
	public String delFile(@Param("fNo")String fNo,HttpServletRequest request){
		FileInfo fi = filedao.findById(fNo);
        ServletContext sc = request.getSession().getServletContext();  
        String path = sc.getRealPath("/resource/upload")+fi.getfPath().trim()+fi.getfName().trim();
        System.out.println("path:"+path);
        File file = new File(path);
        if(file.exists()){
         boolean d = file.delete();
         }
        filedao.delFile(fNo);//删除文件表信息
        sfdao.delShare(fNo);//删除分享表信息
 		String uName=(String) request.getSession().getAttribute("uName");
 		fileList=filedao.findAll(userdao.findById(uName).getuNo());
 		int endsize=pagesize;
		if(fileList.size()<pagesize)
			endsize=fileList.size();
		request.getSession().setAttribute("fileList", fileList.subList(0, endsize));
 		return "user-home";
	}
	//搜索操作
	@RequestMapping("/doSearch")
	public String doSearch(String sName,HttpSession session){
		String uName=(String) session.getAttribute("uName");
		sfileList=filedao.findSearch(userdao.findById(uName).getuNo(), sName);
		int endsize=pagesize;
		if(sfileList.size()<pagesize)
			endsize=fileList.size();
		session.setAttribute("fileList", sfileList);
		return "user-home";
	}
	//用户上传
	@RequestMapping("/doUpload")
	public String oneFileUpload(  
	            @RequestParam("file") CommonsMultipartFile file,  
	            HttpServletRequest request, ModelMap model) {  
	  
	        // 获得原始文件名  
	        String fileName = file.getOriginalFilename();  
//	        System.out.println("原始文件名:" + fileName);
	        
	        //验证文件名是否冲突
	        if(filedao.findByName(fileName)>0){	        
	        	request.getSession().setAttribute("up-result", "文件重名！"); 
		        return "user-upload";  
	        }
	        
	        //创建用户文件夹
	        String uName=(String) request.getSession().getAttribute("uName");
	  
	        // 获得项目的路径  
	        ServletContext sc = request.getSession().getServletContext();  
	        // 上传位置  
	        String path = sc.getRealPath("/resource/upload") + "/"+uName+"/"; // 设定文件保存的目录  
	        
	        File f = new File(path); 
	        String file_MD5="";
	        if (!f.exists())  
	            f.mkdirs();  
	        if (!file.isEmpty()) {  
	            try {        
	                InputStream in = file.getInputStream();
	                InputStream hash_in = file.getInputStream();
	                
	                //文件HASH验证
	                file_MD5=transMD5.getFileMD5(hash_in);
	                System.out.println("文件Hash:" + file_MD5);
	                if(filedao.findByHash(file_MD5)>0){
	                	request.getSession().setAttribute("up-result", "禁止重复上传！");
//	                	File delFile = new File(path + fileName);
//	                	delFile.delete();
	         	        return "user-upload"; 
	                }
	                FileOutputStream fos = new FileOutputStream(path + fileName);
	                int b = 0;  
	                while ((b = in.read()) != -1) {  
	                    fos.write(b);  
	                }  
	                fos.close();  
	                in.close();  
	            } catch (Exception e) {  
	                e.printStackTrace();  
	            }  
	        }  
	        //保存到数据库
	        Date date = new Date();
	        DateFormat mydate = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
	        fi.setuNo(userdao.findById(uName).getuNo());
	        fi.setfNo(file_MD5.substring(8, 24));
	        fi.setfName(fileName);
	        fi.setfPath("/"+uName+"/");
	        fi.setfHash(file_MD5);
	        fi.setfDate(mydate.format(date));
	        filedao.addFile(fi);
	        System.out.println("上传图片到:" + path + fileName);  
	        // 保存文件地址，用于JSP页面回显  
	        request.getSession().setAttribute("up-result", "上传成功！"); 
	        return "user-upload";  
	    }
	//下载操作
	@RequestMapping("/downFile")  
	public void downFile(HttpServletRequest request,  
	        HttpServletResponse response,String fNo) {   
	    FileInfo fi = filedao.findById(fNo);
	    // 得到要下载的文件名  
	    String fileName = fi.getfName().trim();   
	    try {   
	        // 获取上传文件的目录  
	        ServletContext sc = request.getSession().getServletContext();  
	        String path = sc.getRealPath("/resource/upload")+fi.getfPath().trim()+fi.getfName().trim(); 
	        // 得到要下载的文件  
	        File file = new File(path);  
	          
	        // 如果文件不存在  
	        if (!file.exists()) {  
	            request.setAttribute("message", "您要下载的资源已被删除！！");  
	            System.out.println("您要下载的资源已被删除！！");  
	            return;  
	        }   
	        // 设置响应头，控制浏览器下载该文件  
	        response.setHeader("content-disposition", "attachment;filename="  
	                + URLEncoder.encode(fileName, "UTF-8"));  
	        // 读取要下载的文件，保存到文件输入流  
	        FileInputStream in = new FileInputStream(path);  
	        // 创建输出流  
	        OutputStream out = response.getOutputStream();  
	        // 创建缓冲区  
	        byte buffer[] = new byte[1024];  
	        int len = 0;  
	        // 循环将输入流中的内容读取到缓冲区当中  
	        while ((len = in.read(buffer)) > 0) {  
	            // 输出缓冲区的内容到浏览器，实现文件下载  
	            out.write(buffer, 0, len);  
	        }  
	        // 关闭文件输入流  
	        in.close();  
	        // 关闭输出流  
	        out.close();  
	    } catch (Exception e) {  
	    	e.printStackTrace(); 
	    }  
	}  
	//重命名操作
	@RequestMapping("doReName")
	public String doReName(String newName,String fNo,HttpSession session,HttpServletRequest request) throws UnsupportedEncodingException{
		System.out.println("old:"+fNo+",new:"+newName);
		String uName=(String) session.getAttribute("uName");
		String uNo=userdao.findById(uName).getuNo();
		FileInfo fi = filedao.findById(fNo);
		if(filedao.findByName(newName)!=0){
			session.setAttribute("re-result", "文件名重复");
			request.setAttribute("re_fName", fi.getfName());
			request.setAttribute("re_fNo", fNo);
			return "user-rename";
		}
		//修改物理文件名
		ServletContext sc = session.getServletContext();  
        String path = sc.getRealPath("/resource/upload")+fi.getfPath().trim()+fi.getfName().trim(); 
        String newpath = sc.getRealPath("/resource/upload")+fi.getfPath().trim()+newName.trim();
        System.out.println(path);
        System.out.println(newpath);
        File file = new File(path); 
        File newfile = new File(newpath);
        file.renameTo(newfile); 
        //修改数据库名
        filedao.updateFile(newName, fi.getfName(), uNo);
        request.setCharacterEncoding("utf-8");
        session.setAttribute("re-result", "更新成功");
		request.setAttribute("re_fName", newName);
		request.setAttribute("re_fNo", fNo);
		return "user-rename";
	}
	//分享操作
	@RequestMapping("doShare")
	public String doShare(String fNo,HttpSession session,HttpServletRequest request){
		String fName = filedao.findById(fNo).getfName();
		request.setAttribute("share_fNo", fNo);
		request.setAttribute("share_fName", fName);
		if(sfdao.findById(fNo)!=null){
			String fPwd = sfdao.findById(fNo).getfPwd();
			request.setAttribute("share_fPwd", fPwd);
			return "user-share";
		}
		else{
			ShareFile sf = new ShareFile();
			GetRanNo grn = new GetRanNo();
			sf.setfNo(fNo);
			String fPwd = grn.getRandomString(4);
			sf.setfPwd(fPwd);
			sfdao.addShare(sf);
			request.setAttribute("share_fPwd", fPwd);
			return "user-share";
		}
	}
	//访客下载操作
	@RequestMapping("downGuest")
	public String downGuest(String fNo,String fPwd,HttpSession session
			,HttpServletRequest request,HttpServletResponse response){
		if(sfdao.confirmShare(fNo, fPwd)==0){
			session.setAttribute("guest-result", "提取码或文件编码错误！");
			return "guest-home";
		}
		else
			downFile(request,response,fNo);
		return "guest-home";
	}
	//管理员登录验证
	@RequestMapping("/doAdminLogin")
	public String doAdminLogin(AdminInfo a,String vcode,HttpSession session){
		String getcode=(String) session.getAttribute("code");
		if(!(vcode.toLowerCase().equals(getcode.toLowerCase()))){
			return "codefail";
		}
		String md5_pwd=transMD5.getMD5(a.getaPwd());
		int count=admindao.confirm(a.getaName(),md5_pwd);
		if(count!=0){
			session.setAttribute("aName", a.getaName());
			afileList=filedao.adminFind();
			int endsize=pagesize;
			if(afileList.size()<pagesize)
				endsize=afileList.size();
			session.setAttribute("afileList", afileList.subList(0, endsize));
			int current_page=1;
			session.setAttribute("a_current_page",current_page);
			return "admin-home";
		}
		return "codefail";
	}
	//管理员分页
	@RequestMapping("/alist")
	public String ahomepage(int up_down,int cho_page,HttpSession session){
		int current_page=(Integer) session.getAttribute("a_current_page");
		int page=0;
		if(cho_page==0){
			page=current_page+up_down;
		}
		else
			page=cho_page;
		afileList=filedao.adminFind();
		int psize=afileList.size();
		int last_page=psize/pagesize+1;
		int endsize=pagesize;
		if(psize<endsize)
			endsize=pagesize;
		if(page<=0){
			page=1;
			asubfList=afileList.subList(0, endsize);
			session.setAttribute("afileList", asubfList);
		}
		if(page>=last_page){
			page=last_page;
			asubfList=afileList.subList(psize-psize%pagesize, psize);
			session.setAttribute("fileList", asubfList);
		}
		else{
			int former=(page-1)*pagesize;
			int latter=page*pagesize;
			asubfList=afileList.subList(former,latter);
			session.setAttribute("fileList", asubfList);
		}
		session.setAttribute("a_current_page", page);
		return "admin-home";
	}
	@RequestMapping("/admin-info")
	public String adminInfoPage(HttpServletRequest request) throws Exception{
		int uNum = userdao.adminFind();
		int fNum = filedao.adminFind().size();
		ServletContext sc = request.getSession().getServletContext();  
        String path = sc.getRealPath("/resource/upload")+"/";
        File file = new File(path);
        String fSize = gfs.getFSize(file);
		request.setAttribute("uNum", String.valueOf(uNum));
		request.setAttribute("fNum", String.valueOf(fNum));
		request.setAttribute("aSize", fSize);
		return "admin-info";
	}
	//登录页面（index）
	@RequestMapping({
					"/userLogin",
					"/index"
					})
	public String indexPage(){
		return "userLogin";
	}
	//注册页面
	@RequestMapping("/sign")
	public String signPage(){
		return "useRegister";
	}
	//管理员登录
	@RequestMapping("/admin")
	public String adminLPage(){
		return "adminLogin";
	}
	//管理员首页
	@RequestMapping("/admin-home")
	public String adminhomePage(HttpSession session){
		afileList=filedao.adminFind();
		int endsize=pagesize;
		if(afileList.size()<pagesize)
			endsize=afileList.size();
		session.setAttribute("afileList", afileList.subList(0, endsize));
		return "admin-home";
	}
	//用户主页（home)
	@RequestMapping({
				"/user-home",
				"home"
				})
	public String homePage(HttpSession session){
		String uName=(String) session.getAttribute("uName");
		fileList=filedao.findAll(userdao.findById(uName).getuNo());
		int endsize=pagesize;
		if(fileList.size()<pagesize)
			endsize=fileList.size();
		session.setAttribute("fileList", fileList.subList(0, endsize));
		return "user-home";
	}
	//上传页面
	@RequestMapping("/user-upload")
	public String uploadPage(){
		return "user-upload";
	}
	//账户设置
	@RequestMapping("/settings")
	public String settingsPage(){
		return "user-set";
	}
	//使用指南
	@RequestMapping("/help")
	public String helpPage(){
		return "help";
	}
	//退出操作
	@RequestMapping("/logOut")
	public String logOutPage(HttpSession session){
		session.removeAttribute("uName");
		return "userLogin";
	}
	//管理员退出
	@RequestMapping("/alogOut")
	public String alogOutPage(HttpSession session){
		session.removeAttribute("aName");
		return "adminLogin";
	}
	//重命名
	@RequestMapping("/user-rename")
	public String reNamePage(String fNo,String fName,HttpServletRequest request){
		request.setAttribute("re_fName", fName.trim());
		request.setAttribute("re_fNo", fNo.trim());
		return "user-rename";
	}
	//访客(分享)页面
	@RequestMapping("/guest")
	public String guestPage(){
		return "guest-home";
	}
}
