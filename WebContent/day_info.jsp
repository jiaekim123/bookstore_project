<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR" import = "java.sql.*"%>
    
<%
String is_manager = (String)session.getAttribute("manager");
if(null == is_manager){
   response.sendRedirect("ManagerLogin.html"); 
}
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";
String C_ssn= (String)session.getAttribute("C_ssn");
String date_select = "";
Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수
try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	stmt=conn.createStatement();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Day information</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

</head>
<body>
<form action=day_info2.jsp method=get>
<h3>일별 지출액</h3>
<%
String date = "SELECT DISTINCT DATE FROM sale_info";
rs = stmt.executeQuery(date);
%>
<select name = "day_select" id = "day_select" onchange="getselect(this)">
<% while(rs.next()){%>
	<option value = "<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%}%>
</select> 
<%

//String date_info = "SELECT * FROM sale_info WHERE DATE = '%s',url";
//rs = stmt.executeQuery(date_info);
%>
<table border=1>

<tr><td>DAY : </td><td><input type=text name=date_info maxlength="20" size="12"> </td>
<td><input type=submit value = "확인" name=Next maxlength="20" size="12"> </td></tr>
</table>
<%
rs.close();
stmt.close();
conn.close();

}catch(SQLException e){
out.println("err"+e.toString());
}
%>
</form>
</body>
</html>