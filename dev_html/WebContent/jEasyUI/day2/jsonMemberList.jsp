<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jeasyui.member.MemberDAO, java.util.List, java.util.Map"%>
<%@ page import="com.google.gson.Gson"%>
    <%-- html의 땅(jsp주석 조심할 것) => 반드시 jsp주석으로 처리할 것 --%>
<%
	//스크립틀릿 - 자바의 땅
	MemberDAO mdao = new MemberDAO();
	List<Map<String,Object>> mList = null;
	mList = mdao.procMemberList();
	Gson g = new Gson();
	String imsi = g.toJson(mList);
	out.print(imsi);
%>
