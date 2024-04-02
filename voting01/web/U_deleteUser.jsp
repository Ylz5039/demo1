<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String id=request.getParameter("id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
        PreparedStatement deleteStatement = connection.prepareStatement("delete from users where id=?");
        deleteStatement.setInt(1,Integer.parseInt(id));
        int deleteResult = deleteStatement.executeUpdate();
        deleteStatement.close();
        if(deleteResult > 0) {
            PreparedStatement updateStatement = connection.prepareStatement("SET @count = 0");
            updateStatement.executeUpdate();
            updateStatement.close();
            updateStatement = connection.prepareStatement("UPDATE users SET id = @count:= @count + 1");
            updateStatement.executeUpdate();
            updateStatement.close();
            updateStatement = connection.prepareStatement("ALTER TABLE users AUTO_INCREMENT = 1");
            updateStatement.executeUpdate();
            updateStatement.close();
            response.sendRedirect("W_admin.jsp");
        } else {
            out.print("删除失败！");
        }
        connection.close();
    } catch (SQLException | ClassNotFoundException e) {
        out.print("操作失败：" + e.getMessage());
    }
%>
</body>
</html>