<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");
    String additem = request.getParameter("additem");
    String voteForName = request.getParameter("VOTE_FORM_NAME");
    if (additem != null && !additem.isEmpty()) {
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM FILM WHERE ITEM = ?");
        preparedStatement.setString(1, additem);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            request.setAttribute("addMessage01", true);
        } else {
            PreparedStatement selectStatement = connection.prepareStatement("SELECT STARTTIME, ENDTIME FROM FILM WHERE VOTE_FORM_NAME = ?");
            selectStatement.setString(1, voteForName);
            ResultSet selectResult = selectStatement.executeQuery();
            if (selectResult.next()) {
                String startTime = selectResult.getString("STARTTIME");
                String endTime = selectResult.getString("ENDTIME");
                preparedStatement = connection.prepareStatement("INSERT INTO FILM (ITEM, STARTTIME, ENDTIME, VOTE_FORM_NAME, COUNT) VALUES (?, ?, ?, ?, 0)");
                preparedStatement.setString(1, additem);
                preparedStatement.setString(2, startTime);
                preparedStatement.setString(3, endTime);
                preparedStatement.setString(4, voteForName);
                preparedStatement.executeUpdate();
                request.setAttribute("addMessage", true);
            } else {
                // 处理未找到指定 VOTE_FORM_NAME 的情况
            }
            selectResult.close();
            selectStatement.close();
        }
        resultSet.close();
        preparedStatement.close();
    } else {
        request.setAttribute("addMessage01", true);
    }
    connection.close();
    request.setAttribute("VOTE_FORM_NAME", voteForName);
    request.getRequestDispatcher("V_changeVote.jsp").forward(request, response);
%>