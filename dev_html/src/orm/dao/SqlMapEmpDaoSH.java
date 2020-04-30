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
	
	//다른 메소드에서도 필요하기 때문에 전역변수 위치에 놓는다.
	String resource = "orm/mybatis/Configuration.xml";
	
	public List<Map<String,Object>> empList(Map<String,Object> eMap2){
		
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
			
			//쿼리문을 요청해주는 sqlSes.selectList()를 사용하기 위해 만든다.
			//파라미터가 비어있으면 디폴트 값은 commit이 안된다. true를 넣어주면 자동으로 commit이 된다. 이것을 outoCommit이라고 한다.
			sqlSes = sqlMapper.openSession();
			
			//sqlSes.selectList()를 사용해서 쿼리문을 실제로 요청해 보자.
			//파라미터에는 xml에서 설정해 놓은 id값("empListSH")을 넣는다.
			//"empListSH"(쿼리문)가 pMap을 사용할 수 있다는 의미이다.
			eList = sqlSes.selectList("empListSH", eMap2);
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
			
			//오토커밋을 해주는 방법2
//			sqlSes.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return empIns;
	}
	
}
