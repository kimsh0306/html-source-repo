package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapEmpDao {
	Logger logger = Logger.getLogger(SqlMapEmpDao.class);
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";//전역변수 위치로 옮겼다.
	
	/****************************************************************
	 * 사원등록 구현하기
	 * sql문 INSERT INTO emp VALUES(?,?,?,?,?,?,?,?)
	 * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
	 * @return int
	 ****************************************************************/
	
	//여기 오는 쿼리문 => INSERT INTO emp VALUES(?,?,?,?,?,?,?,?)
	//화면 설계서에 쿼리문도 표기해 둬라.
	public int empINS(Map<String,Object> pMap) {
		logger.info("empINS 호출 성공");		
		
		int result = 0;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();			
			result = sqlSes.insert("empINS",pMap);
			//오토커밋모드가 꺼진 상태이므로 반드시 커밋해야 한다.
			sqlSes.commit();
			logger.info("result:"+result);//executeUpdate():int
		} catch (Exception e) {
			e.printStackTrace();//힌트가 많다.
		}
		return result;
	}
	
	public List<Map<String,Object>> empList(Map<String,Object> pMap){
		logger.info("empList 호출 성공");
		
		List<Map<String,Object>> elist = null;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			//하나의 로우 값을 가져와서 담는다.
			elist = sqlSes.selectList("empList",pMap);
			System.out.println("조회한 로우의 수: "+elist.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return elist;
	}
	
	/****************************************************************
	 * 사원수정 구현하기
	 * sql문 UPDATE emp SET ........... WHERE 컬럼명 = 값
	 * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
	 * @return int
	 ****************************************************************/
	
	public int empUPD(Map<String,Object> pMap) {
		logger.info("empUPD 호출 성공");		
		int result = 0;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();			
			result = sqlSes.update("empUPD",pMap);
			//오토커밋모드가 꺼진 상태이므로 반드시 커밋해야 한다.
			sqlSes.commit();
			logger.info("result:"+result);//executeUpdate():int
		} catch (Exception e) {
			e.printStackTrace();//힌트가 많다.
		}
		return result;
	}
	
	/****************************************************************
	 * 사원삭제 구현하기
	 * sql문 DELETE FROM 테이블명 WHERE 컬럼명 IN (값)
	 * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
	 * @return int
	 ****************************************************************/
	
	public int empDEL(String empnos[]) {
		logger.info("empDEL 호출 성공");		
		int result = 0;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			
			List<Integer> list = new ArrayList<>();
			for(int i=0;i<empnos.length;i++) {
				list.add(Integer.parseInt(empnos[i]));
			}
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();			
			result = sqlSes.delete("empDelete",list);
			//오토커밋모드가 꺼진 상태이므로 반드시 커밋해야 한다.
			sqlSes.commit();
			logger.info("result:"+result);//executeUpdate():int
		} catch (Exception e) {
			e.printStackTrace();//힌트가 많다.
		}
		return result;
	}
	
	public static void main(String[] args) {
		SqlMapEmpDao eDao = new SqlMapEmpDao();
		eDao.empList(null);
		java.util.Map<String,Object> pMap = new java.util.HashMap<>();
		pMap.put("empno",9010);
		int result = eDao.empINS(pMap);
		System.out.println("result:"+result);
	}
}
