<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.restaurant.RestaurantDao" %>
<%@ page import = "java.util.*, com.google.gson.Gson" %>
<%-- 스크립틀릿 - 자바코드를 쓸 수 있는 땅  --%>
<%
	RestaurantDao rDao = new RestaurantDao();
	List<Map<String,Object>> mrList = rDao.procRestList();
	Gson g = new Gson();
	String imsi = g.toJson(mrList);
	out.print(imsi);
	
%>