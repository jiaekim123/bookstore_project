<%@ page language="java" contentType="text/html; charset=utf-8" errorPage="DBError.jsp"%>
<%@ page import = "java.sql.*" %>


 <html>
 <head><title> 로그인 결과 </title></head>
<%  String id = request.getParameter("id"); 
	String pw = request.getParameter("pw"); 
%>

<%
Connection conn =null;
Statement stmt=null;

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
	String sql = String.format("SELECT Id, C_ssn FROM member AS M WHERE Id = '%s' AND M.Password = '%s';", id, pw);
	
	ResultSet rs =stmt.executeQuery(sql);
	if(rs.next()) {
		%>
		<h2> 로그인 성공 </h2><br>
        <%= rs.getString("Id")%>
        <b> 회원님 환영합니다 </b><br>
        <b> 세션 아이디 : </b>
        <%= rs.getString("C_ssn")%> 
        <%  
        	session.setAttribute("C_ssn", rs.getString("C_ssn"));
		%>
		<br>
		<a href="BooksInfo.jsp"> 
          	[쇼핑 계속] 
      	</a> 
      	
      <% } else {%>
    	  <h2> 로그인 실패 </h2><br>
    	  <b> 아이디와 패스워드를 다시 확인하세요 ! </b><br>
    	  <a href="login_session.html"> 
          	로그인 페이지로 이동 
      	</a> 

      <%}

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

 
