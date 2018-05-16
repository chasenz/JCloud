package MyCloud;

import java.util.List;

public interface UserInfoDAO {
	public UserInfo findById(java.lang.String uName);
	public int findUser(String uName,String uPwd);
	public int findNo(String uNo);
	public void addUser(UserInfo ui);
	public void updatePwd(String nuPwd,String uName);
	public int adminFind();
}
