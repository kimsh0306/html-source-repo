package jeasyui.member;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/*
 * DML(기본) - 프로시저 - MyBatis=>반복되는 코드를 줄여주는 솔루션으로 많이 이용된다.일괄처리 수정 가능.[ORM솔루션-30%이상 줄어듦]
 * 오라클 DB연동 - 입력/수정/삭제/조회 and 화면,이벤트 처리 => 8시간 안에 프로그램 하나를 끝낼 수 있어야 한다.
 */

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;
public class MemberDAO {
	/*********************************************************************여기까지 세트*/
	DBConnectionMgr 		dbMgr 	= DBConnectionMgr.getInstance();
	//물리적으로 떨어져 있는 
	Connection 				con		= null;
	//셀렉트할 때 사용하는
	PreparedStatement 		pstmt 	= null;
	//프로시저만 전담할 수 있는 인터페이스
	CallableStatement 		cstmt 	= null;
	//REFCURSOR를 조작하려면
	OracleCallableStatement ocstmt 	= null;
	//공통으로 있어야 한다. 커서를 조작할 수 있는
	//rs.next()커서를 다음으로 옮겨주세요,
	//rs.previous(),
	//rs.absolute(3)절대값 3번째 위치로 옮겨주세요.
	ResultSet 				rs 		= null;
	/*********************************************************************/
	
	//회원목록 조회 실습1 - SELECT문으로 처리
	public List<Map<String,Object>> procMemberList(){
		List<Map<String,Object>> mList = new ArrayList<>();
		
		try {
			//DBConnectionMGR 공통 코드를 작성했으므로(담았으므로) 드라이버명, 계정정보, orcl11[SID]는 모두 생략할 수 있다.
			con = dbMgr.getConnection();
			//프로시저를 호출할 때 사용하는 메소드
			
			/* (?)파라미터자리에 옵션 세 가지
			 * IN(사용자가 입력한 값)
			 * OUT
			 * INOUT
			 * 
			 * REFCursor 화면 밖으로 꺼낼 수 있다. 꺼낸 것을 json으로 바꿔줘야 한다.
			 */
			
			cstmt = con.prepareCall("{call proc_memberList(?)}");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			//프로시저 처리 요청 메소드 호출(처리해 주세요.)
			cstmt.execute();
			//오라클에서만 제공되는 REFCURSOR이므로 오라클에서 제공하는 인터페이스로 형전환하기
			ocstmt = (OracleCallableStatement)cstmt;
			rs = ocstmt.getCursor(1);
			Map<String,Object> rmap = null;
			//map에 담을 생각이다.
			while(rs.next()) {//커서의 위치에 데이터가 존재하니? 응(참)
				//참일 때 맵을 생성하자.
				//구현체니까 HashMap
				rmap = new HashMap<>();
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				rmap.put("mem_name", rs.getString("mem_name"));
				rmap.put("zipcode", rs.getString("zipcode"));
				rmap.put("mem_addr", rs.getString("mem_addr"));
				rmap.put("mem_email", rs.getString("mem_email"));
				//주소번지를 넣어주세요.
				mList.add(rmap);
			}
			
			/*
			Table => rows+cols(컬럼) 
			오라클 안에는 cursor가 살고 있다.
			cursor를 조작하면 데이터를 꺼낼 수 있다.
			*/
			
		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
		}
		return mList;
	}
	//회원목록 조회 실습2 - 프로시저를 활용해서 처리(금융,물류,회계,보험 만들어진 프로시저를 가져다 쓸 줄 알아야 한다.)
	public List<Map<String,Object>> memberList(){
		List<Map<String,Object>> mList = null;
		
		return mList;
	}
	public static void main(String[] args) {
		//단위테스트 하려면 인스턴스화 해야 한다.
		MemberDAO mdao = new MemberDAO();
		List<Map<String,Object>> mList = null;
		mList = mdao.procMemberList();
		if(mList != null) {
			System.out.println("mList.size() ==> "+mList.size());//3
			System.out.println("mList.size() ==> "+mList.get(0).get("mem_name"));//3
			System.out.println("mList.size() ==> "+mList.get(1).get("mem_name"));//3
			System.out.println("mList.size() ==> "+mList.get(2).get("mem_name"));//3
		}
		
	}

}
