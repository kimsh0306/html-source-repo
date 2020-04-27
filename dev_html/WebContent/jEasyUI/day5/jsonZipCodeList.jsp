<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>

<%
	String dong = request.getParameter("dong");
	SqlMapCommonDao cdao = new SqlMapCommonDao();
	
	Map<String,Object> pmap = new HashMap<>();
	//뺄 때는 대문자, 넣을 때는 내 맘대로.
	pmap.put("dong",dong);
	
	List<Map<String,Object>> zlist = cdao.zipcodeList(pmap);
	Gson g = new Gson();
	String imsi = g.toJson(zlist);
	out.print(imsi);
%>