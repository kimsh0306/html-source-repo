<%@page import="orm.dao.SqlMapEmpDaoSH"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//여기에는 html이 없어!!

	//넘어온 값이 빈 문자열이면 여기서 초기화한 값이 저장된다.
	//수정하지 않으면 기존 값 그대로.
	int 	u_empno = 0;
	String	u_ename = request.getParameter("u_ename");
	String 	u_job = request.getParameter("u_job");
	String 	u_hiredate = request.getParameter("u_hiredate");
	double	u_sal = 0.0;
	double	u_comm = 0.0;
	int 	u_deptno = 0;
	
	//넘어온 값이 빈 문자열이 아닐 때 == 넘어온 값의 길이가 0이 아닐 때
	if(request.getParameter("u_empno").length() != 0){
		u_empno = Integer.parseInt(request.getParameter("u_empno"));
	}
	if(request.getParameter("u_sal").length() != 0){
		u_sal = Double.parseDouble(request.getParameter("u_sal"));
	}
	if(request.getParameter("u_comm").length() != 0){
		u_comm = Double.parseDouble(request.getParameter("u_comm"));
	}
	if(request.getParameter("u_deptno").length() != 0){
		u_deptno = Integer.parseInt(request.getParameter("u_deptno"));
	}
	
	Map<String,Object> pMap = new HashMap<>();
	pMap.put("u_empno1", u_empno);
	pMap.put("u_ename1", u_ename);
	pMap.put("u_job1", u_job);
	pMap.put("u_hiredate1", u_hiredate);
	pMap.put("u_sal1", u_sal);
	pMap.put("u_comm1", u_comm);
	pMap.put("u_deptno1", u_deptno);
	
	SqlMapEmpDaoSH sDao = new SqlMapEmpDaoSH();
	
	int result = sDao.empUpd(pMap);
	out.print(result);
	
	//페이지를 이동하면서 성공에 대한 결과값을 보냈다.
	response.sendRedirect("EmpManagerSH.jsp?result="+result);

%>