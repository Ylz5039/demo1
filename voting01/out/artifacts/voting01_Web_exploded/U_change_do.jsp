<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String id=request.getParameter("id");
    String name=request.getParameter("username");
    String pwd=request.getParameter("userpwd");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
    PreparedStatement preparedStatement =connection.prepareStatement("update users set name=?,pwd=? where id=?");
    preparedStatement.setString(1,name);
    preparedStatement.setString(2,pwd);
    preparedStatement.setInt(3,Integer.parseInt(id));
    int i=preparedStatement.executeUpdate();
    if(i>0){
        response.sendRedirect("U_usersMessage.jsp");
    }
    else{
        out.print("修改失败！");
    }
    preparedStatement.close();
    connection.close();
%>
</body>
</html>
