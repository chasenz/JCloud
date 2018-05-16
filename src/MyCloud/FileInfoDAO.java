package MyCloud;
import java.util.List;

public interface FileInfoDAO {
	public List<FileInfo> adminFind();
	public FileInfo findById(java.lang.String fNo);
	public List<FileInfo> findAll(java.lang.String uNo);
	public List<FileInfo> findSearch(String uNo,String fName);
	public int  findByName(java.lang.String fName);
	public int  findByHash(java.lang.String fHash);
	public int  findCount();
	public void addFile(FileInfo fi);
	public void delFile(java.lang.String fNo);
	public void updateFile(String newName,String oldName,String uNo);
}
