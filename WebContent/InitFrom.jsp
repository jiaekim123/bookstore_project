<%@ page language="java" contentType="text/html; charset=EUC-KR"


%>
<%
String is_manager = (String)session.getAttribute("manager");
if(null == is_manager){
   response.sendRedirect("ManagerLogin.html"); 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=EUC-KR">
<title>상품 정보 관리</title>
</head>
<body>
<h4>상품코드를 입력하세요.</h4>
<form action=Reader.jsp method=get>
상품코드:<input type=text name=Book_id size=30>
<input type=submit value="확인">
</form>
</body>
</html>