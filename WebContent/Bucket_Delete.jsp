<%@ page language="java" contentType="text/html; charset=EUC-KR"
    import="java.sql.*"%>
<%
String Book_id=request.getParameter("Book_id");
Connection conn =null;
Statement stmt=null;
ResultSet rs=null;

try{

    Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
	String userId = "root";
	String userPass = "ehql413";
	
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("데이터베이스에 연결할 수 없습니다.");
	stmt = conn.createStatement();
	
	//String sql = "delete from member where C_ssn='" + request.getParameter("del")+ "'";
	String command = String.format("delete from bucketlist where Book_id='%s';",Book_id);
	
	stmt.executeUpdate(command);
	stmt.close();
	conn.close();
	response.sendRedirect("Bucket.jsp");
	}
	
	catch(Exception e){
	out.println(e);
	}
	%>