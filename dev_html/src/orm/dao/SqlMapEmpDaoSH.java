package orm.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapEmpDaoSH {
	
/* 
DAO에서 반환타입이 List인 메소드를 만든다. 
empInsertSH.jsp에서 이곳에서 만든 각각의 메소드를 호출한다.
empUpdateSH.jsp
empDeleteSH.jsp
 */
	
	//다른 메소드에서도 사용하기 때문에 전역변수 위치에 놓는다.
	String resource = "orm/mybatis/Configuration.xml";
	
	public List<Map<String,Object>> empList(Map<String,Object> uList){
		
		//null로 선언만 해놓을 수 있지만 널포인트익셉션 오류를 사전 방지하기 위해 생성도 해준다.
		List<Map<String,Object>> eList = new ArrayList<>();
		
		//finally에서도 사용하기 때문에 try문에서 빼서 여기로 위치를 변경했다.
		SqlSession sqlSes = null;
		
		try {
			
			//항상 try문 안에 써야 한다.
			Reader reader = Resources.getResourceAsReader(resource);
			
			//SqlSessionFactory 싱글톤으로 관리해 줘야 하는 아이이다.
			//어플리케이션 스쿠프라서 어플리케이션이 실행되는 동안 한 번만 실행되기 때문이다.
			//con(연결통로)의 역할
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			
			//sqlMapper.openSession();의 return type이 SqlSession!!
			//쿼리문을 요청해주는 sqlSes.selectList()를 사용하기 위해 만든다.
			//파라미터가 비어있으면 디폴트 값은 commit이 안된다. true를 넣어주면 자동으로 commit이 된다. 이것을 outoCommit이라고 한다.
			sqlSes = sqlMapper.openSession();
			
			//sqlSes.selectList()를 사용해서 쿼리문을 실제로 요청해 보자.
			//sqlSes.selectList()의 리턴 타입이 List이기 때문에
			//리턴 타입이 List인 메소드를 만든 것이다.
			//이 메소드의 파라미터에는 xml에 존재하는 쿼리문의 아이디"empListSH"와 파라미터로 받은 사용자가 입력한 값uList를 넣은 것이다.  
			//sqlSes.selectList("empListSH", uList)이다. 이것을 eList 변수에 담았다.
			//"empListSH"가 uList를 사용할 수 있다는 의미이다.**********
			eList = sqlSes.selectList("empListSH", uList);
			System.out.println("eList size"+eList.size());
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			
			sqlSes.close();
		}
		return eList;
	}
	
	public int empIns(Map<String,Object> eIns) {
		
		int empIns = 0;
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			
			//sqlMapper.openSession();의 return type이 SqlSession!!
			
			//오토커밋을 해주는 방법1 파라미터에  true입력 => sqlMapper.openSession(true);
			SqlSession sqlSes = sqlMapper.openSession(true);
			empIns = sqlSes.insert("empInsSH", eIns);
			
			//커밋을 해주는 방법
//			sqlSes.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return empIns;
	}
	
	public int empUpd(Map<String,Object> pMap) {
		
		int result = 0;
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			result = sqlSes.update("empUpdSH",pMap);
			
			//커밋!!!!!!!!!!!!!!!!!!!!!!!
			sqlSes.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int empDel(List<Integer> eList) {
		
		int result = 0; 
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			result = sqlSes.delete("empDelSH", eList);
			
			//커밋!!!!!!!!!!!!!!!!!!!!!!!!!!!
			sqlSes.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}	
}
