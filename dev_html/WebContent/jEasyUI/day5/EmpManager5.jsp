<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 - [jEasyUI활용]</title>
<%@ include file="./JEasyUICommon.jsp" %>
	<script type="text/javascript">
		//여기가 전변자리이다.
		var g_address=''; //사용자가 선택한 주소정보 담기
	
		//위치 함수 선언하는 곳
		//표준에서 정해진 클래스가 아니라 easyUI에서 가져온 dialog클래스이다.
		function empINS(){
			$('#dlg_ins').dialog('open');//; => 문장이 끝난 것을 브라우저에 알려준다.
		}
		
		function empUPD(){
			$('#dlg_upd').dialog('open');
		}
		
		
		function empDEL(){
			$('#dlg_del').dialog({
				closed:false
			});
		}
		
		function empnoSearch(){
			//alert("empnoSearch 호출");
			var s_empno = $("#s_empno").val();
			$("#dg_emp").datagrid({
				url:'jsonEmpList.jsp?empno='+s_empno
			});
		}
	</script>
	
	<script type="text/javascript">
		function empList(){
			$("#dg_emp").datagrid({
				 url:"jsonEmpList.jsp"
				 //성공했을 때 출력을 해주기 위해 사용한 함수
				,onLoadSuccess: function(data){
					//Object를 String 문자열로 만들어 줌.
					//var result = JSON.stringify(data);
					//alert("새로고침 처리 성공: "+data+","+result);
				}				 
			});
		}/////////////end of empList
		/////////////////////////////////// DataGrid에 직접 수정 모드 추가하기 시작 ////////////
		function getRowIndex(target){
		    var tr = $(target).closest('tr.datagrid-row');
		    return parseInt(tr.attr('datagrid-row-index'));
		}
		function editrow(target){
		    $('#dg_emp').datagrid('beginEdit', getRowIndex(target));
		}
		function deleterow(target){
		    $.messager.confirm('Confirm','Are you sure?',function(r){
		        if (r){
		            $('#dg_emp').datagrid('deleteRow', getRowIndex(target));
		        }
		    });
		}
		function saverow(target){
		    $('#dg_emp').datagrid('endEdit', getRowIndex(target));
		}
		function cancelrow(target){
		    $('#dg_emp').datagrid('cancelEdit', getRowIndex(target));
		}		
		/////////////////////////////////// DataGrid에 직접 수정 모드 추가하기 끝/////////////	
		
		function zipcode_search(){
			alert("우편번호 찾기");
			//사용자가 입력한 동 정보 담기
			var u_dong = $("#dong").val();//사용자가 입력한 동이름이 담긴다.val()이 나오면 info박스
			if(u_dong == null || u_dong.length<1){
				alert("동을 입력하세요.");
				return;//여기서는 함수의 영역을 빠져나감.
			}else{
				$("#dg_zipcode").datagrid({
					url:'jsonZipCodeList.jsp?dong='+u_dong
				});
			}
		}
		
		//사원정보 등록 처리
		function emp_ins(){
			//alert("저장 호출");
			//화면에서 입력받은 값은 http프로토콜을 이용하여 서버 쪽으로 전송되는데 이때 유니코드로 변환되어 전달된다.
			//해결방법-sever.xml문서에 포트번호 설정 위치(63번라인) URIEncoding="UTF-8" 삽입해야 한다.
			//단 get방식에만 적용됨. post방식일 때는 java코드를 활용하여 별도 처리해야 한다.
			
			//form 안에 묶은 것을 전송한다. 서버에 보낼 때는 name을 사용한다.
			//"action" => 이동한다. empInsert.jsp로.
			$("#f_ins").attr("method","get");
			$("#f_ins").attr("action","empInsert.jsp");
			$("#f_ins").submit();
		}
		
		//사원정보 수정 처리
		function emp_upd(){
			$("#f_upd").attr("method","get");
			$("#f_upd").attr("action","empUpdate.jsp");
			$("#f_upd").submit();
		}
		
	</script>
	
</head>
<body>
<!--===================== 검색 조건 추가하기 시작 =====================-->
<div id="tbar_emp">
	<form id="f_search">
	<table>
		<tr>
			<td width="190px">
				<label width="80px">사원번호</label>
				<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
			</td>
		</tr>
		<tr>
			<td>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true" onclick="empINS()">사원등록</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="empUPD()">사원수정</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="empDEL()">사원삭제</a>
			</td>
		</tr>
	</table>
	</form>
</div>	
<!--===================== 검색 조건 추가하기 끝 =======================-->

	<!-- 선언이 먼저 -->
    <table id="dg_emp"></table>
	<!-- 태그를 최소한으로 -->
	<script type="text/javascript">
		
		$(document).ready(function(){
			/* 동이름 입력 후 엔터를 쳤을 때 처리하기 */
			var t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){	
					//alert("엔터쳤을 때")
					//t.textbox('setValue', $(this).val());
					$("#dg_zipcode").datagrid({
						 url:'jsonZipCodeList.jsp?dong='+$(this).val()
						,singleSelect:true
						
//						,이벤트이름:function(?){
//							
// 						}

						//선택한 로우의 우편번호와 주소 정보 읽어서 변수에 담기
						//여기서 말하는 row는 사용자가 선택한 row의 정보를 가짐.
						,onSelect:function(index,row){
							//아래에서 선택된 로우인지는 어떻게 아는 걸까?
							//alert(row.ADDRESS);
							g_address = row.ADDRESS;//필드명은 mybatis를 사용했으니까 꼭 대문자
						},onDblClickCell:function(index,field, value){
							if("ZIPCODE"==field){//너 우편번호 셀(컬럼)을 선택한거니?
								//더블클릭이벤트 핸들러를 셀을 선택했으니까 세 번째 파라미터의 value는
								//사용자가 선택한 로우의 그 셀의 값을 가진다.
								$("#zipcode").textbox('setValue',value);
								$("#mem_addr").textbox('setValue',g_address);
								$("#dg_zipcode").datagrid("clearSelections");
								$("#dg_zipcode").dialog('close');
							}
						}
					});
				}
			});			
			
			/* 우편번호 찾기 화면에 대한 초기화 */
			//화면에 보여지는 것을 숨겼다. 사원등록 버튼을 누른 후 우편번호찾기를 눌러야 나오게 만들자.
			$("#dlg_zipcode").dialog({
				closed:true
			});
			
			/* 우편번호 찾기 목록 초기화 */
			$("#dg_zipcode").datagrid({
				 title:'우편번호 찾기 검색 결과'
				,columns:[[
					 {field:'ZIPCODE', title:'우편번호', width:100, align:'center'}					
					,{field:'ADDRESS', title:'주소', width:400, align:'left'}					
				]]
			});
			
			/* 우편번호 찾기 버튼 */
			$('#btn_zipcode').linkbutton({
				onClick:function(){
					$("#dlg_zipcode").dialog({
						 closed:false
						,title:'우편번호검색기'
						,width:580
						,height:550
					});
				}
			});
			
			//태그 속성이 아닌 여기에서도 처리하는 것을 해보자.
			//$('#empno').textbox("labelPosition","top");
			//위치! dom구성이 완료되었을 때
			//html이 아닌 js로 dialog의 data-options 옵션 지정하기.
			
			$('#dlg_upd').dialog({
				closed:true
			});
/*************************************** 사원테이블 */
			$('#dg_emp').datagrid({
				 toolbar:'#tbar_emp'
				,singleSelect:true
				,width:'1100px'
				,title:'사원관리  - 자바스크립트만으로 구성하기'
			    //,url:'jsonEmpList.jsp'
			    ,columns:[[
			        {field:'CK',checkbox:true,width:50,align:'center'},
			        {field:'EMPNO',title:'사원번호',width:90,align:'center',editor:'numberbox'},
			        {field:'ENAME',title:'사원이름',width:120,align:'center',editor:'text'},
			        {field:'JOB',title:'JOB',width:130,align:'center',editor:'text'},
			        {field:'HIREDATE',title:'입사일자',width:150,align:'center',editor:'numberbox'},
			        //hidden 속성 유용하게 사용된다.
			        {field:'MGR',title:'MGR',width:90,align:'center',editor:'numberbox',hidden:'true'},
			        {field:'SAL',title:'급여',width:150,align:'center',editor:'numberbox'},
			        {field:'COMM',title:'인센티브',width:100,align:'center',editor:'numberbox'},
			        {field:'DEPTNO',title:'부서번호',width:100,align:'center'
			        	,editor:{
			        		type:'combobox'
			        		,options:{
			        			 valueField:'DEPTNO'//실제 서버에 넘어가는 필드
			        			,textField:'DNAME'//화면에 출력되는 필드
			        			,url:'./jsonDeptList.jsp'
			        			,required:true
			        		}///////end of options
			        	}///////////end of editor
			        		
			        },
		            {field:'action',title:'Action',width:120,align:'center',
		                formatter:function(value,row,index){
		                    if (row.editing){
		                        var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
		                        var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
		                        //s와 c 태그를 붙여주세요.
		                        return s+c;// '안녕'||'내일 봐'
		                    } else {
		                        var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
		                        var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
		                        return e+d;
		                    }
		                }
		            }
			    ]]
				,onEndEdit:function(index,row){
		            var ed = $(this).datagrid('getEditor', {
		                index: index,
		                field: 'productid'
		            });
		            row.productname = $(ed.target).combobox('getText');
		        },
		        onBeforeEdit:function(index,row){
		            row.editing = true;
		            $(this).datagrid('refreshRow', index);
		        },
		        onAfterEdit:function(index,row){
		            row.editing = false;
		            $(this).datagrid('refreshRow', index);
		        },
		        onCancelEdit:function(index,row){
		            row.editing = false;
		            $(this).datagrid('refreshRow', index);
		        },
		        onDblClickRow:function(index,row){
		        	alert("선택했네 ==> "+index+", "+row.EMPNO);
		        }
			});	//////////////////////////////end of datagrid			
		});	//////////////////////////////////end of ready
	</script>
	<!--======================= 우편번호 찾기 시작 =======================-->
	<div id="dlg_zipcode" style="width:100%; max-width:500px; padding:30px 30px;">
		<input class="easyui-textbox" id="dong" name="dong" labelPosition="top"	data-options="prompt:'동이름이나 주소 정보 입력...'" style="width:210px;">
		<a id="btn_search" class="easyui-linkbutton" href="javascript:zipcode_search();" data-options="iconCls:'icon-search'">찾기</a>
		<div style="margin-bottom:10px;"></div>
		<table id="dg_zipcode"></table>
	</div>
	</script>
	<!--======================= 우편번호 찾기 끝 =======================-->
	<!--======================= 사원등록 시작 =======================-->
	<div id="dlg_ins" class="easyui-dialog" data-options="closed:true, title:'사원정보 등록', footer:'#d_ins', modal:'true'" style="width:100%;max-width:580px;padding:30px 60px">
		<form id="f_ins">
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_job" name="mem_job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_hiredate" name="mem_hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_sel" name="mem_sel" label="급여" labelPosition="top" data-options="prompt:'Enter a SEL'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a 인센티브'" style="width:210px">
			</div>	
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="mem_deptno" name="mem_deptno" label="부서번호" labelPosition="top" style="width:210px" 
					data-options="prompt:'Enter a 부서번호'
						         ,valueField: 'DEPTNO' 	<!-- 실제로 넘어가는 값 -->
						         ,textField: 'DNAME' 	<!-- 화면에 보여지는 부분 -->
						         ,url: './jsonDeptList.jsp'
						         ,onSelect: function(rec){
						             var url = 'get_data2.php?id='+rec.id;
		 				             $('#cc2').combobox('reload', url);
	 					         }"
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
	<!--======================= 사원등록 끝 =======================-->
	<!--======================= 사원수정 시작 =======================-->
	<div id="dlg_upd" data-options="closed:true, title:'사원정보 등록', footer:'#d_upd', modal:'true'" class="easyui-dialog" style="width:100%;max-width:580px;padding:30px 60px">
		<form id="f_upd">
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_job" name="mem_job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_hiredate" name="mem_hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_sel" name="mem_sel" label="급여" labelPosition="top" data-options="prompt:'Enter a SEL'" style="width:210px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a 인센티브'" style="width:210px">
			</div>	
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="mem_deptno" name="mem_deptno" label="부서번호" labelPosition="top" style="width:210px" 
					data-options="prompt:'Enter a 부서번호'
						         ,valueField: 'DEPTNO' 	<!-- 실제로 넘어가는 값 -->
						         ,textField: 'DNAME' 	<!-- 화면에 보여지는 부분 -->
						         ,url: './jsonDeptList.jsp'
						         ,onSelect: function(rec){
						             var url = 'get_data2.php?id='+rec.id;
		 				             $('#cc2').combobox('reload', url);
	 					         }"
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
		<div id="d_upd" style="margin-bottom:10px">
			<!-- href 안에서 js로 처리 -->
			<a id="btn_save" href="javascript:emp_upd()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<!-- href 안에서 js로 처리 -->
			<a id="btn_close" href="javascript:$('#dlg_upd').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
	</div>
	<!--======================= 사원수정 끝 =======================-->
	<!--======================= 사원삭제 시작 =======================-->
	<div id="dlg_del" class="easyui-dialog" data-options="closed:true" class="easyui-dialog" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_del">
		삭제
		</form>
	</div>
	<!--======================= 사원삭제 끝 =======================-->
</body>
</html>