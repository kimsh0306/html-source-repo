<%@page import="orm.dao.SqlMapEmpDaoSH"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String res = request.getParameter("empno");
	String empnos[] = res.split(",");
	
	List<Integer> eList = new ArrayList<>();
	
	for(int i=0;i<empnos.length;i++){
		int result = Integer.parseInt(empnos[i]);
		//Map은 put, List는 add
		eList.add(result);
	}
	
	SqlMapEmpDaoSH sDao = new SqlMapEmpDaoSH();
	
	//반환 값을 get방식으로 url에 붙여 보내야 하기 때문에 result변수에 담아 준다.
	int result = sDao.empDel(eList);
	
	response.sendRedirect("EmpManagerSH.jsp?d_result="+result);
	
%>