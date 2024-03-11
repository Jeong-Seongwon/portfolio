package emp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EmpDAO {
	private Connection conn;
	private ResultSet rs;
	
	public EmpDAO() {
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
	
	
	public int insertEmp(EmpVO vo) {
		try {
			String checkQuery = "SELECT COUNT(*) FROM emp WHERE empno = ?";
			PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
			checkStmt.setInt(1, vo.getEmpno());
			rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                	// 이미 존재하는 아이디인 경우
                	return -1;
                } else {
                	String sql = "insert into emp values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                	PreparedStatement pstmt = conn.prepareStatement(sql);
                	pstmt.setInt(1,  vo.getEmpno());
                	pstmt.setString(2,  vo.getEname());
                	pstmt.setString(3,  vo.getJob());
                	pstmt.setInt(4,  vo.getMgr());
                	pstmt.setString(5,  vo.getHiredate());
                	pstmt.setFloat(6, vo.getSal());
                	pstmt.setFloat(7, vo.getComm());
                	pstmt.setInt(8, vo.getDeptno());
                	pstmt.setString(9, vo.getPwd());
                	pstmt.setString(10, vo.getEid());
                	pstmt.setString(11, vo.getGender());
                	pstmt.setString(12, vo.getHobby());

                	return pstmt.executeUpdate();
                } 
            } 
		} catch(Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
	
	
	public ArrayList<EmpVO> searchEmp(String key, String val) {
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		PreparedStatement pstmt = null;
		String SQL = null;
		try {
			if (key == null || val == null || key =="" || val == "" || key.equals("null") || val.equals("null") || key.isEmpty() || val.isEmpty()) {
				SQL = "select * from emp";
				pstmt = conn.prepareStatement(SQL);
			} else { if (key.equals("all")) {
						SQL = "select * from emp where empno like ? or ename like ? or ename like upper(?) or job like ? or job like upper(?) or eid like ? or eid like upper(?) or deptno like ? or gender=upper(?)";
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, "%"+val+"%");
						pstmt.setString(2, "%"+val+"%");
						pstmt.setString(3, "%"+val+"%");
						pstmt.setString(4, "%"+val+"%");
						pstmt.setString(5, "%"+val+"%");
						pstmt.setString(6, "%"+val+"%");
						pstmt.setString(7, "%"+val+"%");
						pstmt.setString(8, "%"+val+"%");
						pstmt.setString(9, "%"+val+"%");
					} else { 
						SQL = "SELECT * FROM EMP WHERE "+key+" like ? or "+key+" like upper(?)";
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, "%"+val+"%");
						pstmt.setString(2, "%"+val+"%");
					}
			}				
			rs = pstmt.executeQuery();
			while (rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getString(5));
				vo.setSal(rs.getFloat(6));
				vo.setComm(rs.getFloat(7));
				vo.setDeptno(rs.getInt(8));
				vo.setPwd(rs.getString(9));
				vo.setEid(rs.getString(10));
				vo.setGender(rs.getString(11));
				vo.setHobby(rs.getString(12));
				list.add(vo);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public EmpVO viewEmp(int empno) {
		EmpVO vo = new EmpVO();
		try {
			String sql = "SELECT * FROM EMP WHERE EMPNO=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno); 
			
			ResultSet rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				vo.setEmpno(rs.getInt("EMPNO"));
				vo.setEname(rs.getString("ENAME"));
				vo.setJob(rs.getString("JOB"));
				vo.setMgr(rs.getInt("MGR"));
				vo.setHiredate(rs.getString("HIREDATE"));
				vo.setSal(rs.getFloat("SAL"));
				vo.setComm(rs.getFloat("COMM"));
				vo.setDeptno(rs.getInt("DEPTNO"));
				vo.setPwd(rs.getString("PWD"));
				vo.setEid(rs.getString("EID"));
				vo.setGender(rs.getString("GENDER"));
				vo.setHobby(rs.getString("HOBBY"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	
	public int updateEmp(EmpVO vo) {
		try {
			String sql = "UPDATE EMP SET ENAME=?, JOB=?, MGR=?, HIREDATE=?, SAL=?, COMM=?, DEPTNO=?, pwd=?, eid=?, gender=?, hobby=? WHERE EMPNO=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1,  vo.getEname());
			pstmt.setString(2,  vo.getJob());
			pstmt.setInt(3,  vo.getMgr());
			pstmt.setString(4,  vo.getHiredate());
			pstmt.setFloat(5, vo.getSal());
			pstmt.setFloat(6, vo.getComm());
			pstmt.setInt(7, vo.getDeptno());
			pstmt.setString(8, vo.getPwd());
			pstmt.setString(9, vo.getEid());
			pstmt.setString(10, vo.getGender());
			pstmt.setString(11, vo.getHobby());
			pstmt.setInt(12,  vo.getEmpno());
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	
	public int deleteEmp(int empno) {
		try {
			String sql = "delete emp where empno = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	
	
}
	