<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>b2.jsp-[시작페이지]</title>
</head>
<body>
b2.jsp
<script type="text/javascript">
	function move(){
		//쿼리스트링으로 mode 값을 넘긴다.
		location.href="./a2.jsp?mode=update";
	}
</script>
<button onClick="move()">a2페이지</button>
</body>
</html>