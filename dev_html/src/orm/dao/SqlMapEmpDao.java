package orm.dao;

import java.io.Reader;
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
	public List<Map<String,Object>> empList(Map<String,Object> pMap){
		logger.info("empList 호출 성공");
		
		
		List<Map<String,Object>> elist = null;
		String resource = "orm/mybatis/Configuration.xml";
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			//하나의 로우 값을 가져와서 elist에 담는다.
			elist = sqlSes.selectList("empList",pMap);
			System.out.println("조회한 로우의 수: "+elist.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return elist;
	}
	
	public static void main(String[] args) {
		SqlMapEmpDao eDao = new SqlMapEmpDao();
		eDao.empList(null);
		
	}
}
