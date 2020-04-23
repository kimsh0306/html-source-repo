<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String tb_id = request.getParameter("tb_id");
	out.print("사용자가 입력한 아이디:"+tb_id);
%>