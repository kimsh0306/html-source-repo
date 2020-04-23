<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="json.ui.DeptTestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
DeptTestDao dtd = new DeptTestDao();

//List<Map<String,Object>> dList = new ArrayList<>();//불필요한 데이터를 생성했다.
//List<Map<String,Object>> dList = null;
//dList = dtd.getDeptTest();

List<Map<String,Object>> dList = dtd.getDeptTest();

//DeptTestDao클래스에서 만들었던 getDeptTest()의 반환값을 dList에 담아준다.

//Gson으로 바꿔주기 위해서 Gson클래스 생성
Gson g = new Gson();

//g.toJson(dList) => dList를 Json의 형태로 바꿔준다.
//imsi에 넣어주고 출력한다.
String imsi = g.toJson(dList);

out.print(imsi);

%>
