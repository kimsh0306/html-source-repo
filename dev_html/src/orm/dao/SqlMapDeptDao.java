package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapDeptDao {
	Logger logger = Logger.getLogger(SqlMapEmpDao.class);
	String resource = "orm/mybatis/Configuration.xml";
	SqlSessionFactory sqlMapper = null;
	
	public List<Map<String,Object>> deptList(){
		List<Map<String,Object>> dlist = null;
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();	//sql문을 요청하기 위한 SqlSession객체 생성하기
			dlist = sqlSes.selectList("deptList");			//하나의 로우 값을 가져와서 dlist에 담는다.
			logger.info("조회한 로우의 수: "+dlist.size());
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dlist;
	}
	
	public static void main(String[] args) {
		SqlMapDeptDao smd = new SqlMapDeptDao();
		smd.deptList();
		
	}	
}
