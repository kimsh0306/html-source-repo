<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
1.테이블을 그린다.
2.쿼리문을 xml파일에 작성한다.
	- mapper namespace의 값을 empMapperSH로 지정하고 log4j.properties에 추가한다.
	- Configuration에 empSH.xml파일의 물리적인 위치를 추가해 준다.
3.쿼리문을 가지고 DB를 다녀올 Dao를 준비한다. SqlMapEmpDaoSH
4.DB에서 가져온 data를 json형식으로 바꿔줄 jsonEmpListSH을 준비한다. 

*get, post 방식
	data를 어디에 담느냐의 차이이다.
	get은 header에 담고, post는 body에 담는다.
	
*jsp는 서버(톰캣)에서 사는 아이. 서버에서 구동되는 아이.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
    
    <!-- 함수 정의 -->
    <script type="text/javascript">
    	//head에서 선언한 변수나 함수를 전역(head,body)에서 사용가능하다.
    	//여기가 전역변수 위치이다.
    	
    	//사원수정 버튼을 클릭하기 전 선택한 로우의 사원번호를 담을 변수를 선언한다.
	    var row_empno;
    	
    	//로우가 선택될 때마다 카운트해 줄 변수를 선언한다.
    	var cnt = 0;
    
    	function empnoSearch(){
    		alert("사원번호 조회하기 성공");
    		//조건검색을 하기 위해서 입력한 값을 가져와야 한다.
    		//input박스에 사용자가 입력한 값을 가져온다.
    		var s_empno = $("#s_empno").val();
    		alert("사용자가 입력한 값:"+s_empno);
    		$("#dg_emp").datagrid({
    			//get방식으로
    			//?empno1=7947(사용자가 입력한 값 = s_empno = 파라미터)을 jsonEmpListSH에 보낸 것과 같다.
    			//서버에서 값을 꺼낼 때 사용하는 name은 empno이다.
    			//서버에 값을 저장
    			url:'jsonEmpListSH.jsp?empno1='+s_empno
    		});
    	}
    	
    	function empList(){
    		//alert("조회버튼 성공");
    		$("#dg_emp").datagrid({
				url:"jsonEmpListSH.jsp"
    		});
    	}
    	
    	function empINS(){
    		//alert("등록버튼 성공");    
    		$("#dlg_ins").dialog({
    			closed:false
    		});
    	}
    	
    	function empUPD(){
    		alert("수정버튼 성공"); 
    		if(cnt>1){
    			alert("한 사원만 선택하세요.")
    		}
    		if(cnt==0){
    			alert("사원을 선택해 주세요.")
    		}
    		if(cnt==1){
    			
    			//비동기 통신(요청).몰래 가서 data를 가져온다.
    			$.ajax({
    				
    				//선택한 로우의 사원번호가 담겨있는 row_empno를 empno1이라는 이름으로 넘긴다.
    				url:'jsonEmpListSH.jsp?empno1='+row_empno
    						
    				//만약 성공적으로 응답이 온다면
    				,success:function(data){
    					$("#dlg_upd").dialog({
    						closed:false
    					});
    					
//    					alert(data);
						//json에서 데이터를 뽑는 방법.
//						alert(data[0].EMPNO);
						
						//setValue로 input박스 해당 컬럼에 맞는 값을 넣어주겠다.
						//setValue 함수, 파라미터에 data[0].EMPNO을 넣어서 호출했다.
						$("#u_empno").textbox('setValue',data[0].EMPNO);
						$("#u_ename").textbox('setValue',data[0].ENAME);
						$("#u_job").textbox('setValue',data[0].JOB);
						$("#u_hiredate").textbox('setValue',data[0].HIREDATE);
						$("#u_sal").textbox('setValue',data[0].SAL);
						$("#u_comm").numberbox('setValue',data[0].COMM);
						$("#u_deptno").combobox('setValue',data[0].DEPTNO);
    				}
//     					//제이슨을 문자열로 바꿔주는 방법. 따로 정리해 두기.
//     					var result = JSON.stringify(data);
//     					//문자열을 json객체로 바꿔주는 방법. 따로 정리해 두기.
//     					var arr = JSON.parse(result);
//     					alert(arr);
    			
//     				,error:function(req,sta,err){
//     					alert("err"+err);
//     				}
    			
    			});
    		}
    	}
    	
    	function empDEL(){
//    		alert("삭제버튼 성공");   	
    		
			var empnos = [];
			//getSelections 함수, 파라미터는 없다.
			var rows = $('#dg_emp').datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
				//push => put,add한다고 생각하면 된다.
			    empnos.push(rows[i].EMPNO);
			}
			//배열에 들어있는 값 사이에 ,로 
//			alert(empnos.join(','));
			
			//예)pempno = "10,20,30"
			//join을 하면 문자열이 반환된다.
			//var을 쓰지 않고도 선언할 수 있다.
			pempno = empnos.join(','); 
			
//			$.messager.progress();//막대기 바 0%~100%
			//문자열의 길이가 0보다 클 때 = 선택된 로우가 있다면
			if(empnos.length>0){
				//실질적으로 jsp에게 요청하는 문장.
				//페이지 이동
				location.href="empDeleteSH.jsp?empno="+pempno
			}else{
				alert("사원을 선택하세요.");
			}
			$("#dg_emp").datagrid('clearSelections');    		
    	}
    	
    	/********************************** (insert)사원등록 dialog 안 save버튼을 클릭했을 때 호출되는 메소드 */
    	function emp_ins(){
    		//저장버튼을 누르면 form전송이 이루어져야 한다.
    		
    		/*
    		form전송은 자동으로 name과 값이 매칭되서 서버에게 전달된다.
    		select할 때 했던 var s_empno = $("#s_empno").val();을 해주지 않아도 된다.
    		*/
    		
    		//get방식으로 form전송을 하겠다.
    		//attr이 method라는 속성에 get이라는 값을 주는 것이다.
    		//태그 속성에 써도 되지만 제이쿼리를 사용했다.
//    		$("#f_ins").attr("속성","값")
    		$("#f_ins").attr("method","get");
    		//form을 전송할 장소를 지정해 준다.
    		$("#f_ins").attr("action","empInsertSH.jsp");
    		
    		/*
    		get방식으로 서버에게 name값들을 보내고 empInsertSH.jsp에서 
    		request.getParameter를 통해서 name의 값을 사용할 수 있게 된다.
    		*/
    		
    		//이것을 쓰지 않으면 전송되지 않는다!!!!
    		//submit은 실제로 보냈다는 의미이다.
    		$("#f_ins").submit();
    	}
    	/********************************** (updte)사원수정 dialog 안 save버튼을 클릭했을 때 호출되는 메소드 */
    	function emp_upd(){
    		$("#f_upd").attr("method","get");
    		$("#f_upd").attr("action","empUpdateSH.jsp");
    		$("#f_upd").submit();
    	}
    </script>
    
</head>
<body>
	<!--=========================================== (update dialog) 사원수정 시작 -->
	<div id="dlg_upd" class="easyui-dialog" data-options="closed:true, title:'사원정보 수정', footer:'#d_upd', modal:'true'" style="width:100%;max-width:580px;padding:30px 60px">
		<form id="f_upd">
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_empno" name="u_empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_ename" name="u_ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_job" name="u_job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_hiredate" name="u_hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_sal" name="u_sal" label="급여" labelPosition="top" data-options="prompt:'Enter a SEL'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="u_comm" name="u_comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a 인센티브'" style="width:210px">
			</div>	
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="u_deptno" name="u_deptno" label="부서번호" labelPosition="top" style="width:210px" 
					data-options="prompt:'Enter a 부서번호'
						         ,valueField: 'DEPTNO' 	<!-- 실제로 넘어가는 값 -->
						         ,textField: 'DNAME' 	<!-- 화면에 보여지는 부분 -->
						         ,url: './jsonDeptListSH.jsp'"
 			>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_zipcode" name="u_zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:100px">
			<a id="u_btn_zipcode" href="#" class="easyui-linkbutton" >우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_mem_addr" name="u_mem_addr" label="주소" labelPosition="top" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_upd" style="margin-bottom:10px">
			<!-- href 안에서 js로 처리 -->
			<a id="u_btn_save" href="javascript:emp_upd()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<!-- href 안에서 js로 처리 -->
			<a id="u_btn_close" href="javascript:$('#dlg_upd').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
	</div>	
	
	<!--======================= 수정 완료 메시지 =========================-->
	<%
		String result = request.getParameter("result");
		if("1".equals(result)){
	%>
		<script type="text/javascript">
		alert("수정이 완료되었습니다.");
		</script>
	<%	
		}
		else if("0".equals(result)){
	%>
		<script type="text/javascript">
		alert("수정이 실패했습니다.");	
		</script>
	<%
		}
	%>
	<!--======================= 삭제 완료 메시지 =========================-->
	
	<%
		String d_result = request.getParameter("d_result");
		if("1".equals(d_result)){
	%>
		<script type="text/javascript">
		alert("삭제가 완료되었습니다.");
		</script>
	<%	
		}
		else if("0".equals(d_result)){
	%>
		<script type="text/javascript">
		alert("삭제를 실패했습니다.");	
		</script>
	<%
		}
	%>	
	
	<!--=========================================== (update dialog) 사원수정 끝 -->
	<!--=========================================== (insert dialog) 사원등록 시작 -->
	<div id="dlg_ins" class="easyui-dialog" data-options="closed:true, title:'사원정보 등록', footer:'#d_ins', modal:'true'" style="width:100%;max-width:580px;padding:30px 60px">
		<form id="f_ins">
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="job" name="job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="hiredate" name="hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="sal" name="sal" label="급여" labelPosition="top" data-options="prompt:'Enter a SEL'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a 인센티브'" style="width:210px">
			</div>	
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="deptno" name="deptno" label="부서번호" labelPosition="top" style="width:210px" 
					data-options="prompt:'Enter a 부서번호'
						         ,valueField: 'DEPTNO' 	<!-- 실제로 넘어가는 값 -->
						         ,textField: 'DNAME' 	<!-- 화면에 보여지는 부분 -->
						         ,url: './jsonDeptListSH.jsp'"
 			>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:100px">
			<a id="btn_zipcode" href="#" class="easyui-linkbutton" >우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" labelPosition="top" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_ins" style="margin-bottom:10px">
			<!-- href 안에서 js로 처리 -->
			<a id="btn_save" href="javascript:emp_ins()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<!-- href 안에서 js로 처리 -->
			<a id="btn_close" href="javascript:$('#dlg_ins').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
	</div>
	<!--=========================================== (insert dialog) 사원등록 끝->
	<!--=========================================== 테이블 그리기 시작 -->
	<table id="dg_emp"></table>

	<div id="tbar_emp">
		<table>
			<tr>
				<td>
					<label width="80px">사원번호</label>
					<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
				</td>
			</tr>
			<tr>
				<td>
					<!-- href="javascript:void(0)" => 실제 클릭 이벤트는 작동하지 않도록 하기 위함 -->
 					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
 			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true" onclick="empINS()">사원등록</a>
 			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="empUPD()">사원수정</a>
 			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="empDEL()">사원삭제</a>
				</td>
			</tr>
		</table>
	</div>
	<!--=========================================== 테이블 그리기  끝-->
	<!--=========================================== 돔 구성 시작-->
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("#dg_emp").datagrid({
				 toolbar:'#tbar_emp'
				,url:"jsonEmpListSH.jsp"
				,width:'1100px'
				,title:'사원관리  - 자바스크립트만으로 구성하기'
			    ,columns:[[
			        {field:'CK',checkbox:true,width:50,align:'center'},
			        //field:'실제컬럼명' title:'알리아스명'
			        //field 속성의 값은 json 형식에 맞추기 때문에 대문자를 썼다.
			        {field:'EMPNO',title:'사원번호',width:90,align:'center'},
			        {field:'ENAME',title:'사원이름',width:120,align:'center'},
			        {field:'JOB',title:'JOB',width:130,align:'center'},
			        {field:'HIREDATE',title:'입사일자',width:150,align:'center'},
			        //hidden 속성 유용하게 사용된다.
			        {field:'MGR',title:'MGR',width:90,align:'center',hidden:'true'},
			        {field:'SAL',title:'급여',width:150,align:'center'},
			        {field:'COMM',title:'인센티브',width:100,align:'center'},
			        {field:'DEPTNO',title:'부서번호',width:100,align:'center'}
			    ]]
			
				//onClickRow이벤트의 이벤트 핸드러에 대해 정의해 준다.
				//클릭한 로우 row.EMPNO를 다른 곳에서도 사용하기 위해서 전역변수(head) 위치에 변수를 선언해서 담아 준다.
				,onClickRow:function(index,row){
					//로우를 선택할 때마다 cnt가 1씩 증가한다.
					cnt++;
//					alert("클릭한 인덱스는:"+index+", 클릭한 로우는:"+row.EMPNO);
					//row_empno는 전역변수로 선언했다.
					//왜냐하면 xml에서 조건검색을 하기 위해서.
					//row.EMPNO => 왜 대문자? field속성 값과 맞춰야 한다.
					row_empno = row.EMPNO;
					alert("클릭한 인덱스는:"+index+", 클릭한 로우의 사원번호는:"+row_empno);
				}
				
				//이벤트:이벤트핸들러 => onUnselect:function(){}
				,onUnselect:function(index,row){
					cnt=cnt-2;
				}
			});/////////////end of datagrid
		});/////////////////end of ready
	<!--=========================================== 돔 구성 끝-->
	</script>
</body>
</html>