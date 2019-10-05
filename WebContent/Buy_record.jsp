<%@ page language="java" contentType="text/html; charset=utf-8"
import = "java.sql.*" %>


<%
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";
String C_ssn= (String)session.getAttribute("C_ssn");


Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	
	stmt=conn.createStatement();
	
	String sql = "SELECT R.C_ssn, R.B_id, R.B_price, P.Pay_date FROM record AS R , payment AS P WHERE R.P_number=P.Pay_number AND R.C_ssn="+C_ssn+";";
	
	rs=stmt.executeQuery(sql);
	
	
	
	if(C_ssn == null){
		response.sendRedirect("login_session.html");
	}

%>


<table border="1" cellspacing="1">
<tr>
<td>C_ssn</td>
<td>B_id</td>
<td>B_price</td>
<td>Pay_Date</td>

</tr>
<%
while(rs.next()){
	

%><tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getInt(3) %></td>
<td><%=rs.getString(4) %></td>

</tr>
<%
}
%></table>

<%
rs.close();
stmt.close();
conn.close();

}catch(SQLException e){
out.println("err"+e.toString());
}
%>