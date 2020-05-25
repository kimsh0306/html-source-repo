<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String,Object>> eList = new ArrayList<>(); 
	eList = (List<Map<String,Object>>)request.getAttribute("eList");
	System.out.print(eList.size());
	Gson gson = new Gson();
	String imsi = gson.toJson(eList);
	out.print(imsi);
%>