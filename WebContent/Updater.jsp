<%@page contentType="text/html; charset=EUC-KR" errorPage="DBError.jsp"%>
<%@page import="java.sql.*"%>

<%
request.setCharacterEncoding("euc-kr");
String Book_id = request.getParameter("Book_id");
String Book_name = request.getParameter("Book_name");
String Price = request.getParameter("Price");
String Type = request.getParameter("Type");
String Company = request.getParameter("Company");
String Writer = request.getParameter("Writer");
String Count = request.getParameter("Count");
if(Book_id==null||Book_name==null||Price==null||Type==null||Company==null||Writer==null||Count==null)
	throw new Exception("������ �����Ͱ� �ֽ��ϴ�.");


Connection conn =null;
Statement stmt = null;

try{
	Class.forName("org.gjt.mm.mysql.Driver");
	String jdbcUrl="jdbc:mysql://localhost:3306/bookstore"; //�� �ּҿ� ��Ʈ, DB��ġ
	String userId = "root";
	String userPass = "ehql413";
	
	conn = DriverManager.getConnection(jdbcUrl,userId,userPass);
	if(conn==null)
		throw new Exception("�����ͺ��̽��� ������ �� �����ϴ�.");
	stmt = conn.createStatement();
	String command = String.format("update book set Book_name:='%s', Price:=%s, Type:='%s', Company:='%s', Writer:='%s', Count:=%s where Book_id='%s';",Book_name,Price,Type,Company,Writer,Count,Book_id);
	
	int rowNum=stmt.executeUpdate(command);
	if(rowNum<1)
		throw new Exception("�����͸� DB�� �Է��� �� �����ϴ�.");
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
response.sendRedirect("UpdateResult.jsp?Book_id="+Book_id);
%>
