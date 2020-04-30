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

public class SqlMapEmpDaoSH2 {

	String resource = "orm.mybatis.Configuration.xml";
	
	public List<Map<String,Object>> empList(){
		
		List<Map<String,Object>> elist = new ArrayList<>();
		
		try {
			
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			elist = sqlSes.selectList("empListSH");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return elist;
	}

}
