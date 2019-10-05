<%@ page language="java" contentType="text/html; charset=utf-8"
import = "java.sql.*" %>
<%
Class.forName("org.gjt.mm.mysql.Driver");

String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
String userId = "root";
String userPass = "ehql413";

Connection conn=null; //DB 연결 변수
Statement stmt=null;  //Statement 생성 변수
ResultSet rs=null;    //결과값 변수

try {
	conn=DriverManager.getConnection(jdbcUrl,userId,userPass);
	
	stmt=conn.createStatement();
	
	//String C_ssn = request.getParameter("C_ssn");
	String C_ssn= (String)session.getAttribute("C_ssn");
	
	String sql = String.format("SELECT Book_id,Book_name,Price,Type,Company,Writer,Count FROM bucketlist WHERE C_ssn='%s';",C_ssn);
	
	rs=stmt.executeQuery(sql);

%><table border="1" cellspacing="1">
<tr>
<td>Book_id</td>
<td>Book_name</td>
<td>Price</td>
<td>Type</td>
<td>Company</td>
<td>Writer</td>
<td>Count</td>
<TD>비고</TD>

</tr>
<%
while(rs.next()){
	

%><tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getInt(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><%=rs.getInt(7) %></td>

<TD>

<A href="Bucket_Delete.jsp?
Book_id=<%=rs.getString(1)%>">삭제</A>
<A href="payment.jsp?
Price=<%=rs.getInt(3)%>&
Count=<%=rs.getInt(7)%>&
Book_name=<%=rs.getString(2)%>&
Book_id=<%=rs.getString(1)%>">결제</A>

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