<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapDeptDaoSH"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	SqlMapDeptDaoSH dDao = new 	SqlMapDeptDaoSH();
	List<Map<String,Object>> dList = dDao.deptList();
	Gson gson = new Gson();
	String imsi = gson.toJson(dList);
	out.print(imsi);
%>