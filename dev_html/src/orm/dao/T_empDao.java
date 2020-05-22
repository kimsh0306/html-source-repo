package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class T_empDao {
	
	String resource = "orm/mybatis/Configuration.xml";
	
	public List<Map<String,Object>> empList(){
		
		List<Map<String,Object>> eList = new ArrayList<>();
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			eList = sqlSes.selectList("t_empList");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return eList;	
	}
	public static void main(String[] args) {
		T_empDao tDao = new T_empDao();
		System.out.println(tDao.empList().size());
	}
}
