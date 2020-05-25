package jsp.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import orm.dao.T_empDao;

public class SelectController {

	//다오를 인스턴스화 하고
	//리스트 반환받아서 request객체에 setAttribute를 해주고
	//응답페이지 주소를 리턴해 준다.
	
	public String process(HttpServletRequest req, HttpServletResponse res) {
		Logger logger = Logger.getLogger(SelectController.class);
		logger.info("process 호출 성공");
		//사용자가 입력한 값 꺼내기
		String empno = req.getParameter("empno");
		
		//맵에 포장하기
		Map<String, Object> eMap = new HashMap<>();
		//null 체크 주의하기********
		if(empno!=null) {
			eMap.put("empno", empno);
		}
		//그 맵을 다오의 empList()에 파라미터로 넘겨주기
		T_empDao dao = new T_empDao();
		List<Map<String,Object>> eList = dao.empList(eMap);
		logger.info("eList의 사이즈: "+eList.size());
		
		//리스트 반환받아서 request객체에 setAttribute를 해준다.(저장)
		req.setAttribute("eList", eList);
		
		String path = "./select.jsp";
		return path;
	}
}
