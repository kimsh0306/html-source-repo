<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%
/**************************************************************
jsp에서는 name에 들어있는 값을 사용할 수 있다.
***************************************************************/
	//param으로 넘겨준 name값을 받을 변수를 선언한다.
	//zdo는 param에서 설정한 name이고 
	//p_zdo는 request.getParameter("zdo")와 같다.
	String zdo = request.getParameter("zdo");
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("zdo", zdo);
	
	//DB연동 처리해야 한다.
	List<Map<String,Object>> siguList = null;
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	siguList = cDao.getSiGuList(pmap);
%>	
	<select id="i_sigu">
<%
		for(int i=0;i<siguList.size();i++){
			Map<String,Object> rmap = siguList.get(i);
%>	
						<!--
						map에 있는 값을 꺼낼 때 오라클 테이블 컬럼명과 같은 값을 key("SIGU")값에 넣어 준다.
						rmap.get("SIGU") => "SIGU"를 말한다.
						-->
						<option value="<%=rmap.get("SIGU")%>"><%=rmap.get("SIGU")%></option>
<%		
		}////////////////////end of for
%>				

	</select>	