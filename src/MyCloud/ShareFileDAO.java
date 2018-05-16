package MyCloud;

import java.util.List;

public interface ShareFileDAO {
	public ShareFile findById(String fNo);
	public int confirmShare(String fNo,String fPwd);
	public void addShare(ShareFile sf);
	public void delShare(String fNo);
}
