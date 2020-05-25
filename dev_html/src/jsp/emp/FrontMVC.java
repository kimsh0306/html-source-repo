package jsp.emp;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class FrontMVC extends HttpServlet {
		
	Logger logger = Logger.getLogger(FrontMVC.class);
	
	//톰캣이 자동으로 doGet 메소드를 호출하고(콜백메소드) 파라미터에 req, res 객체를 주입했다.*** 
	//이것의 의존성 객체주입이다. 내가 인스턴스화 하는 것이 아니라 다른 곳에서 객체주입을 해주는 것.
	public void doService(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		
		// view에서 요청해서 만들어진 request객체에서 url을 가져오는 것이다.
		// URI에는 쿼리스트링이 담기지 않는다.***
		String command = req.getRequestURI();
		logger.info("command1:"+command);
		
		//contextPath는 빈 문자열인 상태이다. /이 넘어오면 빈 문자열이라고 한다.
		String contextpath = req.getContextPath();
		
		//subsring ==> 지정한 지점 이후만 남기겠다.
		//넘어온 /jEasyUI/t_emp/select.mvc의 첫번째 contextpath를 (지금은 /) 
		//잘라서 jEasyUI/t_emp/select.mvc 이렇게 만들었다.
		command = command.substring(contextpath.length()+1);
		logger.info("command2:"+command);
		
		//가장 마지막에 있는 .의 인덱스(위치)를 반환해 준다.
		int dot = command.lastIndexOf(".");
		
		//시작 지점부터 마지막 지점까지를 남기겠다.
		//jEasyUI/t_emp/select
		command = command.substring(0, dot);
		logger.info("command3:"+command);
		
		//split은 ("/") /를 기준으로 나누고, 그것을 배열에 담는다.
		//"/"을 기준으로 값이 인덱스에 나위어 담길 것이다.
		String uri[] = command.split("/");
		command = uri[2];
		logger.info("command4:"+command);
		
		String path = null;
		if("select".equals(command)) {
			SelectController select = new SelectController();
			//path는 응답페이지 주소이다.
			path = select.process(req, res);
		}
		else if("insert".equals(command)) {
			
		}
		else if("update".equals(command)) {
			
		}
		else if("delete".equals(command)) {
			
		}
		
		/*
		sendRidiect와 forward
		sendRidiect => url이 바뀐다. 새로운 요청인 것이다. 요청의 흐름이 휴지되는 것이 아니기 때문에 이전 페이지의 req를 사용할 수 없다. List 같은 건 보낼 수가 없다.
		forward 	=> url이 바뀌지 않는다. 이전 페이지의 요청이 그대로 유지되는 것이다. 이전 페이지의 req를 사용할 수가 있고, getAttribute를 할 수 있는 것이다.
		*/
		
		//요청의 흐름을 select.jsp로 보내겠다.
		RequestDispatcher view = req.getRequestDispatcher(path);
		view.forward(req, res);
		
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		logger.info("doGet 호출 성공");
		doService(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		logger.info("doPost 호출 성공");
		doService(req,res);
	}
}