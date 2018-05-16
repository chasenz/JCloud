package model.bean;

import java.io.*;
import java.security.MessageDigest;

public class TransformMD5 {
	/** 
     * 将16位byte[] 转换为32位String 
     * 字符串操作 
     * @param buffer 
     * @return 
     */  
    private String toHex(byte buffer[]) {  
        StringBuffer sb = new StringBuffer(buffer.length * 2);  
        for (int i = 0; i < buffer.length; i++) {  
            sb.append(Character.forDigit((buffer[i] & 240) >> 4, 16));  
            sb.append(Character.forDigit(buffer[i] & 15, 16));  
        }  
  
        return sb.toString();  
    }
    
    public String getMD5(String pwd) {  
        try {            
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");  
            messageDigest.update(pwd.getBytes());  
            String md5_pwd=toHex(messageDigest.digest());
            return md5_pwd;
        } catch (Exception e) {  
            e.printStackTrace();  
        }
        return "fails";
    } 
	/** 
     * 文件转换操作 
     * @param buffer 
     * @return 
     */ 
    public static byte[] createChecksum(InputStream fis) throws Exception {  	  
    	   byte[] buffer = new byte[1024];  
    	   MessageDigest complete = MessageDigest.getInstance("MD5"); //如果想使用SHA-1或SHA-256，则传入SHA-1,SHA-256  
    	   int numRead;  
    	  
    	   do {  
    	       numRead = fis.read(buffer);    //从文件读到buffer，最多装满buffer  
    	       if (numRead > 0) {  
    	       complete.update(buffer, 0, numRead);  //用读到的字节进行MD5的计算，第二个参数是偏移量  
    	       }  
    	   } while (numRead != -1);  
    	  
    	   fis.close();  
    	   return complete.digest();  
    	}  
    	  
    	public static String getFileMD5(InputStream fis) throws Exception {  
    	   byte[] b = createChecksum(fis);  
    	   String result = "";  
    	  
    	   for (int i=0; i < b.length; i++) {  
    	       result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring(1);//加0x100是因为有的b[i]的十六进制只有1位  
    	   }  
    	   return result;  
    	}  
}
