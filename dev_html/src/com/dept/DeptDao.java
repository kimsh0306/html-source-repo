package com.dept;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;


public class DeptDao {
	DBConnectionMgr		dbMgr	= null;
	Connection			con		= null;
	PreparedStatement	pstmt	= null;
	ResultSet			rs		= null;
	
	public List<Map<String,Object>> deptList() {
		List<Map<String,Object>> dlist = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			//parsing-DBMS 실행계획-옵티마이저-Open..Fetch..Close
			//세 개 컬럼은 Map에 담고 여러 개의 로우는 List에 담기**************
			Map<String,Object> rMap = null;
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("deptno",rs.getInt("deptno"));
				rMap.put("dname",rs.getInt("dname"));
				rMap.put("loc",rs.getInt("loc"));
				dlist.add(rMap); //컬럼 세 개가, 로우 한 개가.
			}
			System.out.println(dlist.size());	//0
		} catch (SQLException e) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Exception]]"+sql.toString());
		} finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dlist;
	}
}
