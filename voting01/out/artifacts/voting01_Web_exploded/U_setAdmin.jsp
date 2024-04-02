<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>setAdmin</title>
</head>
<body>
<%
    String currentName=request.getParameter("username");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
    Statement preparedStatement =connection.createStatement();
    ResultSet resultSet=preparedStatement.executeQuery("SELECT GRADE FROM users WHERE name='"+currentName+"'");
    if(resultSet.next()){
        String userGrade = resultSet.getString("GRADE");
        if(!userGrade.equals("admin")){
            Statement updateStatement=connection.createStatement();
            updateStatement.executeUpdate("UPDATE users SET GRADE='admin' WHERE name='"+currentName+"'");
            updateStatement.close();
            request.setAttribute("setAdmin",true);
        }
    }
    resultSet.close();
    preparedStatement.close();
    connection.close();
    request.getRequestDispatcher("U_usersMessage.jsp").forward(request,response);
%>
</body>
</html>
