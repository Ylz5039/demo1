<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String username=request.getParameter("username");
    String userpwd=request.getParameter("userpwd");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8","root","!Tyh20040801");
    PreparedStatement preparedStatement =connection.prepareStatement("select * from users where name=? and pwd=?");
    preparedStatement.setString(1,username);
    preparedStatement.setString(2,userpwd);
    ResultSet resultSet=preparedStatement.executeQuery();
    if(resultSet.next()){
        session.setAttribute("name",resultSet.getString(2));
        response.sendRedirect("W_voteHall.jsp");
    }
    else{
        response.sendRedirect("index.jsp");
    }
    resultSet.close();
    preparedStatement.close();
    connection.close();
%>
</body>
</html>
