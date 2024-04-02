<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>VOTE_DO</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    String currentName = (String) session.getAttribute("name");
    String voteFormName=request.getParameter("voteFormName");
    Connection connection = null;
    PreparedStatement selectStatement = null;
    PreparedStatement updateStatement = null;
    PreparedStatement updateStatement1 = null;
    ResultSet resultSet = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");

        String updateQuery = "UPDATE users SET " + voteFormName + " = ? WHERE name = ?";
        updateStatement1 = connection.prepareStatement(updateQuery);
        updateStatement1.setString(1, "true");
        updateStatement1.setString(2, currentName);
        updateStatement1.executeUpdate();

        String selectQuery = "SELECT COUNT FROM FILM WHERE ID=?";
        selectStatement = connection.prepareStatement(selectQuery);
        selectStatement.setString(1, id);
        resultSet = selectStatement.executeQuery();
        int num = 0;
        out.println(id);
        if(resultSet.next()) {
            num = resultSet.getInt("COUNT");
            out.println(num);
        }
        num++;
        out.println(num);
        String updateQuery1 = "UPDATE FILM SET COUNT = ? WHERE ID = ?";
        updateStatement = connection.prepareStatement(updateQuery1);
        updateStatement.setInt(1, num);
        updateStatement.setString(2, id);
        updateStatement.executeUpdate();
        request.getRequestDispatcher("W_voteHall.jsp").forward(request, response);
    } catch (Exception e) {
        out.println(currentName);
        out.println(voteFormName);
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (selectStatement != null) {
                selectStatement.close();
            }
            if (updateStatement != null) {
                updateStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
</body>
</html>