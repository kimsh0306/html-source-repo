package project.restaurant;
//3

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;


public class RestaurantDao {
	//공통적으로 필요한 부분
	DBConnectionMgr 	dbMgr 	= DBConnectionMgr.getInstance();
	Connection 			con 	= null;
	PreparedStatement 	pstmt 	= null;
	ResultSet			rs		= null;
	CallableStatement 	cstmt	= null;
	//오라클에서 제공하는 오라클 콜러블스테이트먼트가 따로 필요하다.
	//오라클 회사에서 지원하는 클래스 -> 이것을 이용해서 프로시저를 진행해 보자
	OracleCallableStatement ocstmt = null;
	
	/***********************************************
	 * 프로시저를 활용하여 로그인 처리하기
	 * @param mem_id: 사용자가 입력한 아이디
	 * @param mem_pw: 사용자가 입력한 비번
	 * @return msg: proc_login2020(u_id IN varchar2, u_pw IN varchar2, msg OUT varchar2)
	 ************************************************/
	public String login(String mem_id,String mem_pw) {
		String msg = null;
		try {
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{}");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return msg;
	}
	public List<Map<String,Object>> procRestList(){
	      List<Map<String,Object>> rList = null;
	      StringBuilder sql = new StringBuilder();

	      try {
	    	 //오라클사가 배포하는 드라이버 클래스를 스탠함.
	         con = dbMgr.getConnection();//물리적으로 떨어져 있는 서버에 연결통로 확보
	         //사용하는 이유는 프로시저라서.외우자.
	         //DML을 요철할 땐 PreparedStatement
	         //프로시저를 요청할 땐 CallableStatement
	         cstmt = con.prepareCall("{call proc_restaurant(?)}");
	         //프로시저의 OUT속성을 지정해주는 문장
	         //커서 타입을 지정해 줘야하니까
	         cstmt.registerOutParameter(1, OracleTypes.CURSOR);
	         //오라클에 살고 있는 옵티마이저에게 처리해 주세요.
	         //처리해달라고 요청
	         cstmt.execute();
	         ocstmt = (OracleCallableStatement)cstmt;
	         rs = ocstmt.getCursor(1);
	         rList = new ArrayList<>();
	         Map<String,Object> rmap = null;
	         while(rs.next()) {
	            rmap = new HashMap<>();
	            rmap.put("res_num", rs.getInt("res_num"));
	            rmap.put("res_name", rs.getString("res_name"));
	            rmap.put("res_tel", rs.getString("res_tel"));
	            rmap.put("res_addr", rs.getString("res_addr"));
	            rmap.put("res_hate", rs.getInt("res_hate"));
	            rmap.put("res_like", rs.getInt("res_like"));
	            rmap.put("res_photo", rs.getString("res_photo"));
	            rmap.put("res_info", rs.getString("res_info"));
	            rmap.put("res_time", rs.getString("res_time"));
	            rmap.put("lat", rs.getDouble("lat"));
	            rmap.put("lng", rs.getDouble("lng"));
	            rList.add(rmap);
	         }
	         System.out.println(rList.size());//5
	      } catch (NullPointerException ne) {
	         System.out.println(ne.toString());
	         System.out.println("데이터베이스서버 상태를 확인 하세요.");
	      } catch (SQLException se) {
	         System.out.println("[[Query]]"+sql.toString());
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbMgr.freeConnection(con, pstmt, rs);
	      }		
		return rList;
	}
   public List<Map<String,Object>> restList() {
	      List<Map<String,Object>> rList = null;
	      StringBuilder sql = new StringBuilder();
	      sql.append("SELECT res_num, res_name, res_tel, res_addr      ");
	      sql.append("      , res_hate ,res_like, res_photo, res_info  ");
	      sql.append("      , res_time, lat, lng                       ");
	      sql.append("  FROM restaurant                                ");
	      try {
	         con = dbMgr.getConnection();
	         pstmt = con.prepareStatement(sql.toString());
	         rs = pstmt.executeQuery();
	         rList = new ArrayList<>();
	         Map<String,Object> rmap = null;
	         //rList = new Vector<Map<String,Object>>();
	         while(rs.next()) {
	            rmap = new HashMap<>();
	            rmap.put("res_num", rs.getInt("res_num"));
	            rmap.put("res_name", rs.getString("res_name"));
	            rmap.put("res_tel", rs.getString("res_tel"));
	            rmap.put("res_addr", rs.getString("res_addr"));
	            rmap.put("res_hate", rs.getInt("res_hate"));
	            rmap.put("res_like", rs.getInt("res_like"));
	            rmap.put("res_photo", rs.getString("res_photo"));
	            rmap.put("res_info", rs.getString("res_info"));
	            rmap.put("res_time", rs.getString("res_time"));
	            rmap.put("lat", rs.getDouble("lat"));
	            rmap.put("lng", rs.getDouble("lng"));
	            rList.add(rmap);
	         }
	         System.out.println(rList.size());//5
	      } catch (NullPointerException ne) {
	         System.out.println(ne.toString());
	         System.out.println("데이터베이스서버 상태를 확인 하세요.");
	      } catch (SQLException se) {
	         System.out.println("[[Query]]"+sql.toString());
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbMgr.freeConnection(con, pstmt, rs);
	      }
	      return rList;
	   }
	
	public List<Map<String,Object>> mapRestList(){
		List<Map<String,Object>> mrList = null;
		StringBuilder sql = new StringBuilder();
		//셀렉트문 작성
		sql.append(" SELECT res_name, res_photo ,lat, lng ");
		sql.append(" FROM restaurant ");
		
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
	        rs = pstmt.executeQuery();
	        mrList = new ArrayList<Map<String,Object>>();
	        Map<String,Object> rmap = null;
	        //rList = new Vector<Map<String,Object>>();
	        while(rs.next()) {
	           rmap = new HashMap<String,Object>();
	           rmap.put("res_num", rs.getInt("res_num"));
	           rmap.put("res_photo", rs.getString("res_photo"));
	           rmap.put("lat", rs.getDouble("lat"));
	           rmap.put("lng", rs.getDouble("lng"));
	           mrList.add(rmap);
	        }
	        System.out.println(mrList.size());//5
			
		} catch (SQLException se) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			
		}
		return mrList;
	}
	
	//VO가 아닌 Map을 사용해 보자.
	public int restINS(Map<String,Object> pMap) {
		int result = 0;
		//문자열을 결합할 때
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO restaurant(res_num, res_name, res_tel, res_addr ");
        sql.append("        ,res_hate, res_like, res_photo                      ");
        sql.append("        ,res_info, res_time, lat, lng)                      ");
        sql.append("VALUES(seq_restaurant_num.nextval,?,?,?,0,0,?,?,?,?,?)		");
        
		//문제가 발생할 수 있으니까
		try {
			con = dbMgr.getConnection();
			//String타입으로 변환하기 위해 .toString()을 붙였다.
			pstmt = con.prepareStatement(sql.toString());
			int i= 0;
			pstmt.setString(++i, pMap.get("res_name").toString());
			pstmt.setString(++i, pMap.get("res_tel").toString());
			pstmt.setString(++i, pMap.get("res_addr").toString());
			pstmt.setString(++i, pMap.get("res_photo").toString());
			pstmt.setString(++i, pMap.get("res_info").toString());
			pstmt.setString(++i, pMap.get("res_time").toString());
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lat").toString()));
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lng").toString()));
			result = pstmt.executeUpdate();
			System.out.println("result: "+result);
		} catch (SQLException se) {
			System.out.println("[[qurey]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public static void main(String[] args) {
		List<Map<String,Object>> rList = null;
		RestaurantDao rdao = new RestaurantDao();
		rList = rdao.mapRestList();
		System.out.println(rList.size());
		//rdao.procRestList();
	}
}
