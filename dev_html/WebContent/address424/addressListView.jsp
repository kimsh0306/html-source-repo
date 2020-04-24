<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%
	//DB연동 처리해야 한다.
	List<Map<String,Object>> zdoList = null;
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	zdoList = cDao.getZDOList();
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax실전연습-[1:ajax,2:html,html+js,js,3:myBatis]</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
	table{
		border: 3px solid #CCCCCC;
	}
	td{
		border: .25px solid #CCCCCC;
		text-align: center;
		height: 45px;
	}
	select{
		width: 120px;
	}
</style>
	<script type="text/javascript">
		function siguIN(){
			//i_sigu 셀렉트 박스에 접근했어요.거기에 변화가 있다면 익명함수를 실행할 거예요.
			$("#i_sigu").change(function(){
				//i_sigu 셀렉트에서 선택된 옵션의 각각에 대해 익명함수를 실행할 거예요.
				$("#i_sigu option:selected").each(function(){
					//여기서 this는 "#i_sigu option:selected"이다.
					//sigu input태그 value에 this의 텍스트값(선택된 값)을 가져와서 넣는다.
					$("#sigu").val($(this).text());//this => i_sigu
				});
			});
		}
	</script>
</head>
<body>
	<script type="text/javascript">
		//dom구성이 완료됐을 때 바로 실행된다.
		//레디함수 이용해서 초기화 하자
		$(document).ready(function(){
			$("#i_zdo").change(function(){
				//each문은 for문과 비슷하게 생각하면 된다.
				//선택된 텍스트 값을 p_zdo에 저장해 보자.
				$("#i_zdo option:selected").each(function(){
					var p_zdo = $(this).text();
					//alert("p_zdo:"+p_zdo);
					$("#zdo").val(p_zdo);
					/*
					param은 ajax를 통해서 jsp에 넘겨줄 값이다.
					server는 name값을 사용하는데
					jsp에서 부를 name을 "zdo="+p_zdo; zdo라고 설정했다.
					jsp에서 zdo를 부르면 p_zdo를 사용할 수 있다.
					data는 jsp에게 넘겨줄 값이다.
					data속성에 param을 넣어줘야 한다.
					data속성에 param 변수를 사용하지 않고 "zdo="+p_zdo 이렇게 바로 써줘도 된다.
					*/
					var param ="zdo="+p_zdo; // String param = "zdo=서울"
					//이제부터 비동기 통신을 하겠다.
					//post방식으로 data를 "getSiGuList.jsp"에게 넘겨주면서 요청을 하는 것이다.
					//성공적으로 응답 받았을 때 익명함수를 실행한다.
					$.ajax({
						 method:"post"
						,url:"getSiGuList.jsp"
						,data: param
						,success:function(result){
							$("#d_sigu").html(result);
							//sigu정보를 해당하는 곳에 넣어야 한다.함수를 만든다.
							siguIN();
						}
					});
				});
			});
		});
	</script>

	<table width="600px" height="60px" cellpadding="0" cellspacing="0">
		<tr>
			<td width="60px">시도</td>
			<td width="140px">
				<select id="i_zdo">
					<option value="선택">선택</option> <!-- value 속성이 필요한 이유는? -->
						<%
								for(int i=0;i<zdoList.size();i++){
									Map<String,Object> rmap = zdoList.get(i);
						%>						<%-- <%out.print()%> == <%= ~ %> --%>
												<option value="<%=rmap.get("ZDO")%>"><%=rmap.get("ZDO")%></option>
						<%		
								}////////////////////end of for
						%>				
				</select>	 
			</td>
			<td width="60px">구</td>
			<td width="140px">
				<!-- 아작스로 처리될 부분. id값 기억하기 -->
				<div id="d_sigu"></div>
			</td>
			<td width="60px">동</td>
			<td width="140px">
				<!-- 아작스로 처리될 부분. id값 기억하기 -->
				<div id="d_dong"></div>
				</select>	
			</td>
		</tr>
		<tr>
			<td width="60px">시도</td>
			<td width="140px">
				<input type="text" id="zdo" name="zdo" size="12"/>
			</td>
			<td width="60px">구</td>
			<td width="140px">
				<input type="text" id="sigu" name="sigu" size="12"/>
			</td>
			<td width="60px">동</td>
			<td width="140px">
				<input type="text" id="dong" name="dong" size="12"/>
			</td>
		</tr>
	</table>
</body>
</html>