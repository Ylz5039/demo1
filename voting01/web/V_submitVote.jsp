<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>投票结果</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String voteFormName = request.getParameter("VOTE_FORM_NAME");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");

        PreparedStatement ps = connection.prepareStatement("SELECT * FROM film WHERE VOTE_FORM_NAME = ?");
        ps.setString(1, voteFormName);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            response.sendRedirect("W_admin.jsp");
        } else {
            String[] items = request.getParameterValues("ITEM");
            for (String option : items) {
                String sql = "INSERT INTO film (VOTE_FORM_NAME, ITEM, COUNT, STARTTIME, ENDTIME) VALUES (?, ?, 0, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, voteFormName);
                statement.setString(2, option);
                statement.setString(3, startTime);
                statement.setString(4, endTime);
                statement.executeUpdate();
            }
            String alterTableQuery = "ALTER TABLE users ADD COLUMN " + voteFormName + " VARCHAR(255) DEFAULT 'false'";
            PreparedStatement alterstatement=connection.prepareStatement(alterTableQuery);
            alterstatement.executeUpdate();
        }
        rs.close();
        ps.close();
        connection.close();
        request.setAttribute("createVote", true);
        request.getRequestDispatcher("W_admin.jsp").forward(request, response);
    } catch (Exception e) {
        response.sendRedirect("W_admin.jsp");
    }
%>
</body>
</html>