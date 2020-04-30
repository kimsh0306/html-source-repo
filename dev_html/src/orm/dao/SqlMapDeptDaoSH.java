package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapDeptDaoSH {
	
	String config = "orm/mybatis/Configuration.xml";

	public List<Map<String,Object>> deptList(){
		
		List<Map<String,Object>> dList = new ArrayList<>();
		
		try {
			
			Reader reader = Resources.getResourceAsReader(config); 
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			dList = sqlSes.selectList("deptListSH");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dList;
	}
}
