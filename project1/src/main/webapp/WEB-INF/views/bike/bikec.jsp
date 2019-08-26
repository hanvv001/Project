<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
			var min = "<c:out value='${click }'></c:out>";
		$("#click").click(function(){
			
			$("#count").html(min-1);			
			
		});
		
		
		
	});
</script>

</head>
<body>
	<div>
	<h3><c:out value="${click }"></c:out> </h3>
	<div id="count"></div>
	<button type="button" id="click">대여</button>
	</div>
	
</body>
</html>