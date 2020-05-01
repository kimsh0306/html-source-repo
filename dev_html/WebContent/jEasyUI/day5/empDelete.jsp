<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empnoArr = request.getParameter("empno");
	String empnos[]	= null;
	if(empnoArr!=null){
		empnos = empnoArr.split(",");
	}
	int result = 0;
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	result = eDao.empDEL(empnos);
	out.print("result:"+result);
	//response.sendRedirect("EmpManagerVer8.jsp");//페이지 이동
	if(result > 0){//등록 성공했을 때
		//sendRedirect() 이것을 쓰지 않으면 페이지 이동이 안 된다.***
		//계속 나올 것이기 때문에 중요!!
		response.sendRedirect("EmpManagerVer8.jsp?mode=update");//페이지 열리기 전 DB를 경유한다.
	}
	//등록 실패했을 때
	else{
		response.sendRedirect("empDeleteFail.jsp");
	}
%>