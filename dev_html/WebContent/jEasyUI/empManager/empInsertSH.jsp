<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapEmpDaoSH"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* 
jsp - Dao - xml 
form으로 넘어온 name들을 다 꺼내서 map에 하나씩 다 담는다.
그 map을 Dao에게 전달하고 Dao는 그 map을 xml문서에게 파리미터로 넘겨준다.
거기서 받은 return값을 가지고 응답페이지를 처리한다.

**이 jsp는 응답페이지로서의 역할을 한다.
	submit으로 전송하는 것은 ajax와는 다르게 페이지 이동이 일어난다.
	그래서 전송이 되고 응답페이지가 완성되었을 때 지금 이 jsp페이지로 이동된다.
	그런데 return값이 1이면 insert에 성공했다는 것이니까 
	다시 처음화면(EmpManagerSH.jsp)으로 돌아가도록 지시할 것이다.
*/

	//form으로 넘어온 name들을 다 꺼내자.
	//equest.getParameter()는 return type이 String이다.
	String empno 		= request.getParameter("empno");
	String ename 		= request.getParameter("ename");
	String job 			= request.getParameter("job");
	String hiredate 	= request.getParameter("hiredate");
	String sal 			= request.getParameter("sal");
	String comm 		= request.getParameter("comm");
	String deptno 		= request.getParameter("deptno");
	
	//꺼내서 String에 담았으니까 필요한 아이들은 형변환을 해주자.
	int iempno = 0;
	if(request.getParameter("empno") != null && empno.length() != 0){
		iempno = Integer.parseInt(empno);
	};	
	double dsal = 0.0;
	if(sal != null && sal.length() != 0){
		dsal = Double.parseDouble(sal);
	};	
	double dcomm = 0.0;
	if(comm != null && comm.length() != 0){
		dcomm = Double.parseDouble(comm);
	};	
	int ideptno  = 0;
	if(deptno  != null && deptno.length() != 0){
		ideptno  = Integer.parseInt(deptno);
	};	
	
	SqlMapEmpDaoSH sDao = new SqlMapEmpDaoSH();
	Map<String,Object> eIns1 = new HashMap<>();
	
	//오라클에 한 로우만 insert,update,delete할 수 있다.
	
	eIns1.put("empno1", iempno);
	eIns1.put("ename1", ename);
	eIns1.put("job1", job);
	eIns1.put("hiredate1", hiredate);
	eIns1.put("comm1", dcomm);
	eIns1.put("sal1", dsal);
	eIns1.put("deptno1", ideptno);
	
	int result = sDao.empIns(eIns1);
	
	//돌아가는 화면 전환 지시하기
	if(result == 1){
		response.sendRedirect("EmpManagerSH.jsp");//페이지 이동-
		
	}
%>