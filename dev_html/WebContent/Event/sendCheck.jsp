<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 파라미터로 넘어오는 값을 체크하는 페이지 -->
<!-- 
get 방식
화면이 없어도 테스트가 가능한 것
 -->
<%	//스크립틀릿
	String u_id = request.getParameter("u_id");
	out.print("u_id:"+u_id);
%>	