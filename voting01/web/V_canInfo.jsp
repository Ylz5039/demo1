<%@ page import="java.sql.*, java.util.Calendar" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    String currentName = (String) session.getAttribute("name");
    String voteFormName = request.getParameter("VOTE_FORM_NAME");
    Connection connection = null;
    PreparedStatement selectStatement = null;
    ResultSet resultSet = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/VOTE?serverTimezone=GMT%2B8", "root", "!Tyh20040801");

        String checkTimeQuery = "SELECT STARTTIME, ENDTIME FROM film WHERE VOTE_FORM_NAME = ?";
        selectStatement = connection.prepareStatement(checkTimeQuery);
        selectStatement.setString(1, voteFormName);
        resultSet = selectStatement.executeQuery();
        Timestamp currentTime = new Timestamp(Calendar.getInstance().getTime().getTime());
        if (resultSet.next()) {
            Timestamp startTime = resultSet.getTimestamp("STARTTIME");
            Timestamp endTime = resultSet.getTimestamp("ENDTIME");
            if (!(currentTime.after(startTime) && currentTime.before(endTime))) {
                request.setAttribute("TimeSet01", true);
                request.getRequestDispatcher("W_voteHall.jsp").forward(request, response);
                return;
            }
        }
        String checkUserVoteQuery = "SELECT " + voteFormName + " FROM users WHERE name = ?";
        selectStatement = connection.prepareStatement(checkUserVoteQuery);
        selectStatement.setString(1, currentName);
        resultSet = selectStatement.executeQuery();

        if(resultSet.next()) {
            String hasVote=resultSet.getString(voteFormName);
            if(hasVote.equals("true")){
            response.sendRedirect("V_info.jsp?VOTE_FORM_NAME=" + voteFormName);
            }
            else {
            request.setAttribute("notVote",true);
            request.getRequestDispatcher("W_voteHall.jsp").forward(request,response);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (selectStatement != null) try { selectStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>