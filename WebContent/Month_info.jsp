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

Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수
ResultSet rs2=null; 
try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	stmt=conn.createStatement();
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Month information</title>
</head>
<body>
<form action=Month_info2.jsp method=get>
<h3>월별 지출액</h3>
<%
String date = "SELECT DISTINCT DATE FROM sale_info";
rs = stmt.executeQuery(date);
%>


<select name = "month_select" id = "month_select" style = "width:80px;">
<% while(rs.next()){
	String month = rs.getString(1);
	String[] dateArray = month.split("-");
	for(int i = 0;i<dateArray.length;i++){
		//System.out.println(dateArray[i]);
	}
	%>
	
	<option value = "<%=dateArray[0]+'-'+dateArray[1]%>"><%=dateArray[0]+'-'+dateArray[1]%></option>
<%}%>
</select> 

<table border=1>

<tr><td>MONTH : </td><td><input type=text name=month_info maxlength="20" size="12"> </td>
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