<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.T_empDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
	String empno = request.getParameter("empno");
	Map<String,Object> eMap = new HashMap<>();

	//조건검색을 눌러서 empno가 null인 상황이라면
	//null이 아니면 맵에 담아.
	if(empno!=null){
	eMap.put("empno", empno);
	}
	
	T_empDao edao = new T_empDao();
	List<Map<String,Object>> elist = edao.empList(eMap);
	
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>