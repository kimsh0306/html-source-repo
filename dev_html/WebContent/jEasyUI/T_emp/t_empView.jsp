<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <script type="text/javascript">
    	function empnoSearch(){
    		
    	}
    	function empList(){
    		$("#dg_emp").datagrid({
    			url:"t_jsonEmp.jsp"
    		})
    	}
    	function empINS(){
    		
    	}
    	function empUPD(){
    		
    	}
    	function empDEL(){
    		
    	}
    </script>
</head>
<body>
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
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#dg_emp").datagrid({
			 	toolbar:'#tbar_emp'
				//,url:"t_jsonEmp.jsp"
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
			})
		});
		
	</script>
</body>
</html>