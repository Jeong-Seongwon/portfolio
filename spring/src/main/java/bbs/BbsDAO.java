package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {		
	        Class.forName("oracle.jdbc.OracleDriver");

	        String dbID = "system";
	        String dbPassword = "sejong";
	        String dbURL = "jdbc:oracle:thin:@localhost:1521/xe";	
	        
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT SYSDATE,SYSTIMESTAMP FROM DUAL";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO ABBS(BBSTITLE,USERID,BBSDATE,BBSCONTENT) VALUES (?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext());
			
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, bbsContent);
			//pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		

	public ArrayList<Bbs> getList(int pageNumber, String key, String val) {
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		PreparedStatement pstmt = null;
		String SQL = null;
		try {
			if (key == null || val == null || key =="" || val == "" || key.equals("null") || val.equals("null") || key.isEmpty() || val.isEmpty()) {
				SQL = "select * from (select bbsid, bbstitle, userid, bbsdate, bbscontent, bbsavailable, bbsviews, floor((rownum-1)/10)+1 as pagenum from (select * from abbs where bbsavailable=1 order by bbsid desc)) where pagenum = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, pageNumber);
			} else { if (key.equals("all")) {
						SQL = "select * from (select bbsid, bbstitle, userid, bbsdate, bbscontent, bbsavailable, bbsviews, floor((rownum-1)/10)+1 as pagenum from (select * from abbs where bbsavailable=1 and (bbsid like ? or bbstitle like ? or userid like ? or bbscontent like ?) order by bbsid desc)) where pagenum = ?";
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, "%"+val+"%");
						pstmt.setString(2, "%"+val+"%");
						pstmt.setString(3, "%"+val+"%");
						pstmt.setString(4, "%"+val+"%");
						pstmt.setInt(5, pageNumber);
					} else { if (key.equals("bbsTC")) {
								SQL = "select * from (select bbsid, bbstitle, userid, bbsdate, bbscontent, bbsavailable, bbsviews, floor((rownum-1)/10)+1 as pagenum from (select * from abbs where bbsavailable=1 and (bbstitle like ? or bbscontent like ?) order by bbsid desc)) where pagenum = ?";
								pstmt = conn.prepareStatement(SQL);
								pstmt.setString(1, "%"+val+"%");
								pstmt.setString(2, "%"+val+"%");
								pstmt.setInt(3, pageNumber);
							} else {
								SQL = "select * from (select bbsid, bbstitle, userid, bbsdate, bbscontent, bbsavailable, bbsviews, floor((rownum-1)/10)+1 as pagenum from (select * from abbs where bbsavailable=1 and "+key+" like ? order by bbsid desc)) where pagenum = ?";
								pstmt = conn.prepareStatement(SQL);
								pstmt.setString(1, "%"+val+"%");
								pstmt.setInt(2, pageNumber);
							}
					}
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsViews(rs.getInt(7));
				list.add(bbs);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public int lastPage(String key, String val) {
		PreparedStatement pstmt = null;
		String SQL = null;
		try {
			if (key == null || val == null || key =="" || val == "" || key.equals("null") || val.equals("null") || key.isEmpty() || val.isEmpty()) {
				SQL = "select count(*) from abbs where bbsavailable=1";
				pstmt = conn.prepareStatement(SQL);
			} else { if (key.equals("all")) {
						SQL = "select count(*) from abbs where bbsavailable=1 and (bbsid like ? or bbstitle like ? or userid like ? or bbscontent like ?)";
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, "%"+val+"%");
						pstmt.setString(2, "%"+val+"%");
						pstmt.setString(3, "%"+val+"%");
						pstmt.setString(4, "%"+val+"%");
					} else { if (key.equals("bbsTC")) {
								SQL = "select count(*) from abbs where bbsavailable=1 and (bbstitle like ? or bbscontent like ?)";
								pstmt = conn.prepareStatement(SQL);
								pstmt.setString(1, "%"+val+"%");
								pstmt.setString(2, "%"+val+"%");
							} else {
								SQL = "select count(*) from abbs where bbsavailable=1 and "+key+" like ?";
								pstmt = conn.prepareStatement(SQL);
								pstmt.setString(1, "%"+val+"%");
							}
					}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return (rs.getInt(1)+9)/10;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	
	public void setBbsViews (int bbsID, int bbsViews) {
		String SQL = "update abbs set bbsviews = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsViews+1);
			pstmt.setInt(2, bbsID);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM ABBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsViews(rs.getInt(7));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE ABBS SET bbsTitle = ?, bbsdate = ?, bbsContent = ? WHERE bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, getDate());
			pstmt.setString(3, bbsContent);
			pstmt.setInt(4, bbsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE ABBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
