<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = 0;
	String ename = "";
	String job = "";
	int mgr = 0;
	String hiredate = "";
	double sal = 0.0;
	double comm = 0.0;
	int deptno = 0;
	if(request.getParameter("empno")!=null){
		empno = Integer.parseInt(request.getParameter("empno"));
	}
	//request가 소문자 라는 건 내장객체 => 인스턴스화 없이 사용할 수 있다.
	//"ename" => 서버에서 사용자가 입력한 사원번호를 듣기할 수 있다. 들은 그것을 파라미터로 넘긴다. 
	ename = request.getParameter("ename");
	job = request.getParameter("job");
	if(request.getParameter("mgr")!=null){//그룹코드임
		mgr = Integer.parseInt(request.getParameter("mgr"));
	}
	hiredate = request.getParameter("hiredate");
	if(request.getParameter("sal")!=null){
		empno = Integer.parseInt(request.getParameter("sal"));
	}
	if(request.getParameter("comm")!=null){
		empno = Integer.parseInt(request.getParameter("comm"));
	}
	if(request.getParameter("deptno")!=null){
		empno = Integer.parseInt(request.getParameter("deptno"));
	}
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	int result = 0;
	Map<String,Object> pMap = new HashMap<>();
	pMap.put("empno",empno);
	pMap.put("ename",ename);
	pMap.put("job",job);
	pMap.put("mgr",mgr);
	pMap.put("hiredate",hiredate);
	pMap.put("sal",sal);
	pMap.put("comm",comm);
	pMap.put("deptno",deptno);
	result = eDao.empINS(pMap);
	response.sendRedirect("EmpManagerVer6.jsp");//페이지 이동
%>