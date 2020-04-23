package json.ui;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class DeptTestDao {
	
	DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	List<Map<String, Object>> dList = new ArrayList<>();
	
	public List<Map<String, Object>> getDeptTest(){
		
		StringBuilder sql = new StringBuilder();
		//SELECT 0 as ck.....
		//check박스 컬럼을 위해서 실제 데이터는 없지만 ck 컬럼을 보여달라는 쿼리문을 작성했다.
		
		sql.append("SELECT 0 as ck, deptno, dname, loc");
		sql.append(" FROM deptTest");
		
		try {
			
			con = dbMgr.getConnection();
			//StringBuilder는 Object 타입인데 prepareStatement()의 파라미터 타입이 String이기 때문에
			//sql을 toString으로 형변환 해준다.
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			Map<String, Object> dMap = null;
			
			while(rs.next()) {
				
				//위에 쿼리문으로 보여진 결과(컬럼)를 담는다.
				dMap = new HashMap<String, Object>();
				
				dMap.put("ck", rs.getInt("ck"));
				dMap.put("deptno", rs.getInt("deptno"));
				dMap.put("dname", rs.getString("dname"));
				dMap.put("loc", rs.getString("loc"));
				dList.add(dMap);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL문 오류");
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("그 외 오류");
			e.printStackTrace();
		}
		return dList;
	}
	
	
}
