<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="DBError.jsp"%>
<%@ page import = "java.sql.*" %>
<%
String is_manager = (String)session.getAttribute("manager");
if(null == is_manager){
   response.sendRedirect("ManagerLogin.html"); 
}

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
	
	//String command = String.format("insert into customer(Ssn,Name,Phone_number,E_mail,Address,Is_member) VALUES('%s','%s','%s','%s','%s','%s');",Ssn,Name,Phone_number,E_mail,Address,Is_member);
	String sql = "select C_ssn,Id,Point from member";
	rs=stmt.executeQuery(sql);


%>

<form action="delete_do.jsp" method="post">
<table border="1" cellspacing="0">
<tr>
<td>C_ssn</td>
<td>Id</td>
<td>Point</td>
<th>비고</th>
</tr>
<%
while(rs.next()){
	

%><tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><a href="delete_do.jsp?del=<%=rs.getString(1) %>">삭제</a>
<a href="Buy_record.jsp">구입내역</a>
</td>
</tr>
<%
}
%>
</table>
</form>
<%
rs.close();
stmt.close();
conn.close();
}
catch(SQLException e){
	out.println("err"+e.toString());
}
%>
