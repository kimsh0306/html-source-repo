<%@page import="orm.dao.SqlMapBookDao"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>

<%	
	//?book_title=j
	String book_title = request.getParameter("book_title");
	SqlMapBookDao bdao = new SqlMapBookDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("book_title",book_title);
	
	List<Map<String,Object>> elist = bdao.bookList(pmap);
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>