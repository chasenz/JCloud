package model.bean;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class GetRanNo {  
	    public String getRandomString(int length) {   
	        StringBuffer buffer = new StringBuffer("0123456789abcdefghijklmno"
	        			+ "pqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");   
	        StringBuffer sb = new StringBuffer();   
	        Random random = new Random();   
	        int range = buffer.length();   
	        for (int i = 0; i < length; i ++) {   
	            sb.append(buffer.charAt(random.nextInt(range)));   
	        }   
	        return sb.toString();   
	    }
	   public   static   String splitStr(String   str)   throws   PatternSyntaxException   {      
            // 只允许字母和数字        
            // String   regEx  =  "[^a-zA-Z0-9]";                      
            // 清除掉所有特殊字符   
      String regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";   
      Pattern   p   =   Pattern.compile(regEx);      
      Matcher   m   =   p.matcher(str);      
      return   m.replaceAll("").trim();      
      }   
}
