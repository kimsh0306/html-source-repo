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

import jsp.emp.SelectController;

public class T_empDao {
	
	String resource = "orm/mybatis/Configuration.xml";
	
	public List<Map<String,Object>> empList(Map<String,Object> eMap){
		Logger logger = Logger.getLogger(T_empDao.class);
		logger.info("empList 호출 성공");		
		List<Map<String,Object>> eList = new ArrayList<>();
		
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			
			eList = sqlSes.selectList("t_empList",eMap);
			
		} catch (Exception e) {
			logger.error("에러"+e);
			e.printStackTrace();
		}
		return eList;	
	}

}
