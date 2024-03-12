package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDAO {

	String driverName = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "sejong";
	
	private UserDAO() throws Exception {
		Class.forName(driverName);
		System.out.println("������ �ѹ�");
	}

	static UserDAO dao = null;

    public String nulStr(String s){
        String ret="";
        if(s!=null) ret=s;
        return ret;
    }


	public static UserDAO getInstance() throws Exception {
		if (dao == null)
			dao = new UserDAO();
		return dao;
	}


	public int signupUser(UserVO vo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DriverManager.getConnection(url, user, pass);
                String sql = "insert into web_account values(?, ?, ?, ?, ?, ?)";

                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, vo.getId());
       			pstmt.setString(2, vo.getPassword());
       			pstmt.setString(3, vo.getName());
        		pstmt.setString(4, vo.getBirth());
        		pstmt.setString(5, vo.getGender());
        		pstmt.setString(6, vo.getEmail());
        		
        		return pstmt.executeUpdate();
            
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pstmt.close();
			conn.close();
		}
		return -1;
	}
	
	public UserVO loginUser(String id, String password) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DriverManager.getConnection(url, user, pass);
			String sql = "SELECT * FROM WEB_ACCOUNT WHERE ID=? AND PASSWORD=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id); 
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			
			UserVO vo = new UserVO();
			if (rs.next()) {
				vo.setId(rs.getString("ID"));
				vo.setPassword(rs.getString("PASSWORD"));
				vo.setName(rs.getString("NAME"));
				vo.setBirth(rs.getString("BIRTH"));
				vo.setGender(rs.getString("GENDER"));
				vo.setEmail(nulStr(rs.getString("EMAIL")));
			} 
			return vo;

		} finally {
			pstmt.close();
			conn.close();
		}
	}
	
	public int updateUser(UserVO vo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DriverManager.getConnection(url, user, pass);
                String sql = "update web_account set password=?, name=?, birth=?, gender=?, email=? where id=?";

                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, vo.getPassword());
       			pstmt.setString(2, vo.getName());
       			pstmt.setString(3, vo.getBirth());
        		pstmt.setString(4, vo.getGender());
        		pstmt.setString(5, vo.getEmail());
        		pstmt.setString(6, vo.getId());
                int res = pstmt.executeUpdate();
                
                return res;
            
		} finally {
			pstmt.close();
			conn.close();
		}
	}

	public int resignUser(UserVO vo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DriverManager.getConnection(url, user, pass);
                String sql = "delete web_account where id=?";

                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, vo.getId());
                int res = pstmt.executeUpdate();
                return res;
            
		} finally {
			pstmt.close();
			conn.close();
		}
	}
}
