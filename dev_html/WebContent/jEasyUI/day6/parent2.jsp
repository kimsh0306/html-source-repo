<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String,Object>> mList = new ArrayList<>();
	Map<String,Object> rmap = new HashMap<>();
	rmap.put("name","이성계");
	mList.add(rmap);
	rmap = new HashMap<>();
	rmap.put("name","유재석");
	mList.add(rmap);
	rmap = new HashMap<>();
	rmap.put("name","강호동");
	mList.add(rmap);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../day5/JEasyUICommon.jsp" %>
</head>
<body>
	<table id="dg" class="easyui-datagrid" style="width:600px" title="데이터 출력 방법 종류">
		<thead>
			<tr>
				<th data-options="field:'name',with:150">이름</th>
			</tr>
		</thead>
		<tbody>
<%
	for(int i=0;i<mList.size();i++){
		Map<String,Object> rmap2 = mList.get(i);
%>
			<tr><td width="150"><% out.print(rmap2.get("name")); %></td></tr>
<%
	}
%>			

		</tbody>
	</table>
	<table border="1" title="데이터 출력 방법 종류" style="width:600px">
		<thead>
			<tr>
				<th>이름</th>
				<th>주소</th>
			</tr>
		</thead>
		<tbody>
<%
	for(int i=0;i<mList.size();i++){
		Map<String,Object> rmap2 = mList.get(i);
		
%>
			<tr>
				<td width="150"><% out.print(rmap2.get("name")); %></td>
				<td>주소</td>
			</tr>
<%
	}
%>
		</tbody>
	</table>
</body>
</html>