package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapCommonDao {
	//에러가 났을 때 바로 찍어볼 수 있도록 사용한다.
	Logger logger = Logger.getLogger(SqlMapCommonDao.class);
	//SqlSessionFactory는 SqlSession을 인스턴스화 해주기 위한 역할
	//SqlSessionFactory는 con(오라클과의 연결 통로)의 역할
	SqlSessionFactory sqlMapper = null;
	
	/*******************************************************************************
	 * 주소 검색 - 도 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>> 
	 * 업무설명: 
	 * 작성자: 강감찬
	 * 2020년 04월 24일
	 *******************************************************************************/
	
	public List<Map<String,Object>> getZDOList(){
		logger.info("getZDOList 호출 성공");//어디까지 진행되다가 막혔는 지 확인하기 위해서.
		List<Map<String,Object>> zdoList = null;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			//getZCOList가 어디있는지 어떻게 아는가? 쿼리문이 쓰인 xml파일을 Configuration에 등록했기 때문에.
			zdoList = sqlSes.selectList("getZCOList");
			System.out.println("조회한 로우의 수: "+zdoList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zdoList;
	}
	
	/*******************************************************************************
	 * 주소 검색 - 구 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>> 
	 * 업무설명: 
	 * 작성자: 강감찬
	 * 2020년 04월 24일
	 *******************************************************************************/
	public List<Map<String,Object>> getSiGuList(Map<String,Object> pmap){
		logger.info("getSiGuList 호출 성공");//어디까지 진행되다가 막혔는 지 확인하기 위해서.
		List<Map<String,Object>> siguList = null;
		//dbMgr의 역할을 해준는 곳이 "orm/mybatis/Configuration.xml"이다.
		//driver클래스,ip,pw,port 등의 정보가 담겨있다.
		String resource = "orm/mybatis/Configuration.xml";
		try {
			//Reader는 "orm/mybatis/Configuration.xml"을 읽는 역할을 한다.
			Reader reader = Resources.getResourceAsReader(resource);
			//읽은 정보를 가지고 SqlSessionFactory를 생성한다.
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sqlMapper을 가지고 SqlSession을 생성한다. 오라클에 sql문으로  요청하기 위해서.
			SqlSession sqlSes = sqlMapper.openSession();
			//mybatis의 기능, 최대의 장점 - 로우를 일일이 하나씩 map에 넣지 않아도 알아서 List에 담아 준다.*****
			//모든 로우 값을 가져와서 siguList에 담는다.
			siguList = sqlSes.selectList("getSiGuList",pmap);
			System.out.println("조회한 로우의 수: "+siguList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return siguList;
	}
	
	/*******************************************************************************
	 * 주소 검색 - 동 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>> 
	 * 업무설명: 
	 * 작성자: 강감찬
	 * 2020년 04월 24일
	 *******************************************************************************/
	public List<Map<String,Object>> getDongList(Map<String,Object> pmap){
		logger.info("getZDOList 호출 성공");//어디까지 진행되다가 막혔는 지 확인하기 위해서.
		List<Map<String,Object>> dongList = null;
		return dongList;
	}
	public static void main(String[] args) {
		SqlMapCommonDao smd = new SqlMapCommonDao();
		smd.getSiGuList(null);
	}
}
