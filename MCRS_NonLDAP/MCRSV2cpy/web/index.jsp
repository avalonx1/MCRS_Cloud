<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%

    String ipLocal = request.getRemoteAddr();
    
    
    
    auth lo = new auth(ipLocal);
    int ismaintenance=0;
    try {
     ismaintenance= lo.isMaintenance();
    } catch (SQLException Sqlex) {
         out.println(Sqlex.getMessage());
    }finally {
         lo.close();
    }
         
//    if (ismaintenance == 1) {
//        response.sendRedirect("maintenance.jsp");
//    } else {
        if ((String) session.getAttribute("session_username") == null && 
        (String) session.getAttribute("session_password") == null && 
        (String) session.getAttribute("session_level") == null) {
            String statSession = request.getParameter("stat_session");
            if (statSession==null) {
//                response.sendRedirect("login_non_ad.jsp");
                response.sendRedirect("login.jsp");
            }else {
                response.sendRedirect("login.jsp?stat_session=1");
//                response.sendRedirect("login_masuk.jsp?stat_session=1");
//                response.sendRedirect("login_non_ad.jsp?stat_session=1");
            }
            
        } else {
            response.sendRedirect("views/index.jsp?menuid=1");
        }
//    }


%>