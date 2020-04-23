<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="json.ui.JsonDeptList"%>
<!-- jsp에 대한 선언문 5~6번-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	JsonDeptList jdl = new JsonDeptList();
	java.util.List<Map<String,Object>> deptList =
			jdl.getDeptList();
	Gson g = new Gson();
	String temp = g.toJson(deptList);
	out.print(temp);
	
%>