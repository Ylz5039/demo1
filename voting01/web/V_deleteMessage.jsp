<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>deleteMessage</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
    String delid = request.getParameter("delid");
    String voteFormName = request.getParameter("voteFormName"); // 获取voteFormName参数的值
    if (delid != null && !delid.isEmpty()) {
        int delidInt = Integer.parseInt(delid);
        if(delid!=null&&!delid.isEmpty()){
            if (request.getAttribute("delMessage") == null || !(Boolean)request.getAttribute("delMessage")) {
                String deleteQuery = "DELETE FROM FILM WHERE ID=?";
                PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setInt(1, delidInt);
                preparedStatement.executeUpdate();
                preparedStatement = connection.prepareStatement("SET @count = 0");
                preparedStatement.executeUpdate();
                preparedStatement = connection.prepareStatement("UPDATE FILM SET ID = @count:= @count + 1");
                preparedStatement.executeUpdate();
                preparedStatement = connection.prepareStatement("ALTER TABLE FILM AUTO_INCREMENT = 1");
                preparedStatement.executeUpdate();
                request.setAttribute("delMessage", true);
                request.setAttribute("voteFormName", voteFormName);
                request.getRequestDispatcher("V_changeVote.jsp").forward(request, response);
            }
        }
    }
%>
</body>
</html>