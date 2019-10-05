<%@page contentType="text/html; charset=EUC-KR" errorPage="DBError.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<%!
private String toUnicode(String str){
	try{
		byte[] b = str.getBytes("ISO-8859-1");
		return new String(b);
	}
	catch (java.io.UnsupportedEncodingException uee){
		System.out.println(uee.getMessage());
		return null;
	}
}
%>
<%
String Book_id = request.getParameter("Book_id");
if(Book_id==null)
	throw new Exception("상품코드를 입력하세요.");


Connection conn =null;
Statement stmt = null;
ResultSet rs = null;
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //내 주소와 포트, DB위치
	String userId = "root";
	String userPass = "ehql413";
	
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("데이터베이스에 연결할 수 없습니다.");
	stmt = conn.createStatement();
	
	String sql=String.format("select * from book where Book_id='%s';",Book_id);
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		String Book_name = rs.getString("Book_name");
		int Price = rs.getInt("Price");
		String Type = rs.getString("Type");
		String Company = rs.getString("Company");
		String Writer = rs.getString("Writer");
		int Count= rs.getInt("Count"); 
		request.setAttribute("Book_id", Book_id);
		request.setAttribute("Book_name", toUnicode(Book_name));
		request.setAttribute("Price", new Integer(Price));
		request.setAttribute("Type", toUnicode(Type));
		request.setAttribute("Company", toUnicode(Company));
		request.setAttribute("Writer", toUnicode(Writer));
		request.setAttribute("Count", new Integer(Count));
		
	}
}
finally{
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
RequestDispatcher dispatcher = request.getRequestDispatcher("EditForm.jsp");
dispatcher.forward(request,response);
%>
