<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>deleteVote</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
    String voteFormName = request.getParameter("VOTE_FORM_NAME");
    if (request.getAttribute("delMessage") == null || !(Boolean)request.getAttribute("delMessage")) {
        String deleteQuery = "DELETE FROM FILM WHERE VOTE_FORM_NAME=?";
        PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
        preparedStatement.setString(1, voteFormName);
        preparedStatement.executeUpdate();

        String dropColumnQuery="ALTER TABLE USERS DROP COLUMN "+voteFormName;
        PreparedStatement dropColumnStatement=connection.prepareStatement(dropColumnQuery);
        dropColumnStatement.executeUpdate();
        dropColumnStatement.close();

        preparedStatement = connection.prepareStatement("SET @count = 0");
        preparedStatement.executeUpdate();
        preparedStatement = connection.prepareStatement("UPDATE FILM SET ID = @count:= @count + 1");
        preparedStatement.executeUpdate();
        preparedStatement = connection.prepareStatement("ALTER TABLE FILM AUTO_INCREMENT = 1");
        preparedStatement.executeUpdate();
        request.setAttribute("delVote", true);
        request.setAttribute("voteFormName", voteFormName);
        request.getRequestDispatcher("V_manageVote.jsp").forward(request, response);
    }
%>
</body>
</html>