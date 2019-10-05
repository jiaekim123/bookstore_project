<%@ page language="java" contentType="text/html; charset=EUC-KR"
%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<h2> 비회원 로그인 성공</h2><br>
<%  
	String Ssn = request.getParameter("ssn");
	session.setAttribute("C_ssn", Ssn); 
%>
<a href="BooksInfo.jsp"> [쇼핑 계속] </a> 

<%
Connection conn =null;
Statement stmt=null;
ResultSet rs=null;
try
{
	Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
	String userId = "root";
	String userPass = "ehql413";
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("데이터베이스에 연결할 수 없습니다.");
	stmt = conn.createStatement();
	String command = String.format("insert into customer(Ssn,Name,Phone_number,E_mail,Address,Is_member) VALUES('%s','','','','',0);", Ssn);
	int row=stmt.executeUpdate(command);

}
finally
{
	try{
		stmt.close();
	}
	catch(Exception ignored){
		
	}
	try{
		conn.close();
	}
	catch(Exception ignored){
		
	}
}
%>
</html>