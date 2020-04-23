<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성 + 초성검사]</title>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
   <style type="text/css">
      #d_search {
         position: absolute; /* 디폴트는 positive */
         border: 1px dotted black;
         background: #AACCFF;
      }
   </style>
   <script type="text/javascript">
   //함수 선언, 전역변수 위치
   	function choSeongAccount(str){
		var cho = [
					 "ㄱ","ㄲ","ㄴ","ㄷ","ㄸ"
					,"ㄹ","ㅁ","ㅂ","ㅃ","ㅅ"
					,"ㅆ","ㅇ","ㅈ","ㅉ","ㅊ"
					,"ㅋ","ㅌ","ㅍ","ㅎ"
				  ];
		var code;
		var result='';//ㅈㅂ을 반환하는 변수
		//alert(str.charCodeAt());
		for(i=0;i<str.length;i++){
			code = str.charCodeAt(i)-44032;
			//$("#d_msg").append(code+" ");
			if(code > -1 && code < 11172) result += cho[Math.floor(code/588)];
		}
		return result;
	}      
   </script>
</head>
<!-- ===================================================================== -->
<body>
   <script type="text/javascript">
   //DOM구성이 완료 되었을 때 
      $(document).ready(function (){
         var t = $('.textbox-f');// == #book_title로 해도 된다.
         t.textbox('textbox').bind('keyup', function(e) {
        	var v_word = $('#_easyui_textbox_input1').val().toUpperCase();
        	var choKeyword = choSeongAccount(v_word);
        	
        	//초성 검색 구분
        	if(v_word !="" && choKeyword==""){
        		choMode = "Y";
        	}else{
        		choMode = "N";
        	}
        	
        	//alert("choMode:"+choMode);
            
        	var p_word = $('#_easyui_textbox_input1').val(); //
            var param = "book_title="+p_word+"&choMode="+choMode;
            
            $.ajax({
               method: 'post'
               ,url: 'htmlBookList.jsp'
               ,data: param
               ,success: function(result) {
                  //alert("result : "+result);
                  $("#d_search").css("boder","1px solid #000000");
                  $("#d_search").css("background","#FFFFFF");
                  $("#d_search").css("top",$("#_easyui_textbox_input1").offset().bottom+"px");
                  $("#d_search").css("left",$("#_easyui_textbox_input1").offset().left+"px");
                  $("#d_search").html(result); //htmlBookList.jsp페이지내용 => html
                  var tds = document.getElementByTagName("td");//array전환
                  for(var i=0;i<tds.length;i++){
                	  tds[i].onmouseover = function(){
                		  var b_no = $(this).attr("id");//1,2,3,,,,,갯수만큼
                		  alert("b_no ==> "+b_no);
                		  
                		  var targetURL='';	  
                		  if("2"==$(this).attr("id")){
                			  targetURL = 'bookSearchDetail2.jsp';
                		  }else if("3"==$(this).attr("id")){
                			  targetURL = bookSearchDetail3.jsp';
                		  }
                		  //밖에 ajax가 있는 데 안에 또 ajax를 배포할 수 있다.
                		  $.ajax({
                			  url:targetURL
                		  });
                		  }
                		  tds[i].onclick = function(){
                			  $("#_easyui_textbox_input1").val($(this).text());
                			  clearMethod();
                		  
                		  
                	  }//////////td
                  }
               }
               ,error: function(xhrObject) {
                  alert(xhrObject.responseText);
               }
            });////////////////end of ajax
	         if($("#_esayui_textbox_input1").val().length==0){
	        	 alert("아무것도 없음.");
	         }
         });///////////////////end of keyup
      });//////////////////////end of ready
   </script>
   <input id="book_title"class="easyui-textbox" style="width:400px"/> 
   <div id="d_search">조회결과 처리 화면</div>
</body>
</html>