<%@ page language="java" import="Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%
 

          String v_userID = (String) session.getAttribute("session_userid"); 
          String v_userName = (String) session.getAttribute("session_username");
          String v_firstName = (String) session.getAttribute("session_first_name");
          String v_lastName = (String) session.getAttribute("session_last_name");
            
String v_clientIP = request.getRemoteAddr();
String v_clientHost = request.getRemoteHost();



if (v_userID!=null) {
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
            
                sql = "insert into t_user_audit(id,act_tag,act_desc,ip_addr,host_addr,created_userid,created_time) "
                        +"values ( "
                        + "nextval('t_user_audit_seq'),"
                        + "'LOGOUT',"
                        + "'User Logout : "+v_userName+" - "+v_firstName+" "+v_lastName+"', "
                        + "'"+v_clientIP+"', "
                        + "'"+v_clientHost+"', "
                        + " "+v_userID+", "
                        + " CURRENT_TIMESTAMP"
                        + " )";

                db.executeUpdate(sql);
                
      
                     } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
          
    }

          
          session.removeAttribute("session_username");
          session.removeAttribute("session_password");
          session.removeAttribute("session_level");
          session.removeAttribute("session_nama");
          session.removeAttribute("session_first_name");
          session.removeAttribute("session_last_name");
          session.invalidate();
                        
//          response.sendRedirect("login.jsp");
          response.sendRedirect("loginAD.jsp");
           
            
 %>