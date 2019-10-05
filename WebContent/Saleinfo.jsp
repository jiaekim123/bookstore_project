<%@ page language="java" contentType="text/html; charset=utf-8"
import = "java.sql.*" %>


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

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	
	stmt=conn.createStatement();
	
	String sql = "SELECT * FROM sale_info";
	
	rs=stmt.executeQuery(sql);
	
	//String C_ssn = request.getParameter("C_ssn");
	
	//if(C_ssn == null){		response.sendRedirect("login_session.html");	}

%> 
<input type="button" value="DAY" onclick="window.location='day_info.jsp'" >
<input type="button" value="MONTH" onclick="window.location='Month_info.jsp'" >

<table border="1" cellspacing="1">
<tr>
<td>Sale_number</td>
<td>Date</td>
<td>Price</td>
<td>Book_id</td>
<td>M_ssn</td>
<TD>비고</TD>

</tr>
<%
while(rs.next()){
	

%><tr>
<td><%=rs.getInt(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getInt(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>

<TD>

<A href="">정보</A>

</TD>
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