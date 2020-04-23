<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap, java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String book_title = request.getParameter("book_title");
	String choMode = request.getParameter("choMode");
	out.print(book_title+","+choMode);
	SqlMapBookDao bDao = new SqlMapBookDao();
	
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("book_title",book_title);
	pmap.put("choMode",choMode);
	
	List<Map<String,Object>> bList = null;	
	bList = bDao.bookList(pmap);
	//out.print(bList);
%>

<table border="1">
<%   //조회 결과가 없을 때
   if(bList ==null ) {
%>
   <tr>
      <td>조회결과가 없습니다.</td>
   </tr>
<%   //조회 결과가 있을 때
   } else {
      for(int i=0; i<bList.size(); i++) {
         Map<String, Object> rmap = bList.get(i);    
%>
   <tr>
   		<!-- "BOOK_TITLE" 대문자 -->
   		<!-- 속성은 어트리뷰트로 접근한다. -->
      <td id="<%=rmap.get("BOOK_NO")%>"><%out.print(rmap.get("BOOK_TITLE"));%></td>
   </tr>
<%
      }
   }   
%>
</table>