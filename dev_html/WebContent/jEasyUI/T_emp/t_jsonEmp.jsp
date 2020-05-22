<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.T_empDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Map<String,Object> eMap = new HashMap<>();
	T_empDao edao = new T_empDao();
	List<Map<String,Object>> elist = edao.empList();
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>