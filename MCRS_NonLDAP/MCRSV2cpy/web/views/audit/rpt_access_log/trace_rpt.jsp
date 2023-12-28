<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%

  String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
  String getAttrHome="/index.jsp?stat_session=3";
  String getAttrDocs="/docs";
  String getHomePath = getPath+getAttrHome;
  String v_mainPath=getHomePath;
  String v_docsPath=getPath+getAttrDocs;
  //out.println(v_mainPath);
          
  String v_maintenancePath=getPath+"maintenance.jsp";
  String v_userID = (String) session.getAttribute("session_userid");        
  String v_userLevel = (String) session.getAttribute("session_level");
  String v_userName = (String) session.getAttribute("session_username");
  String v_userGroup = (String) session.getAttribute("session_group");
  String v_firstName = (String) session.getAttribute("session_first_name");
  String v_lastName = (String) session.getAttribute("session_last_name");
  String reportID = (String) session.getAttribute("reportID");
  
  String v_url = request.getParameter("url"); 
  String v_modulID  = request.getParameter("modul_id");
  
  String v_clientIP = request.getRemoteAddr();
  String v_clientHost = request.getRemoteHost();
          
           
    if ( ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null && (String) session.getAttribute("session_group") == null) 
    || !request.getMethod().equalsIgnoreCase("post") ) {
     %><script> window.location.href="<%=v_mainPath%>"; </script><%  
    } else {


String pagepath = request.getParameter("pagepath");


          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
            
                sql = "insert into t_report_item_download_log ("
                    +"id, report_id,Access_code,created_userid,created_time,report_filename) "
                    +"values ( "
                    + "nextval('t_report_item_download_log_seq'),"
                    + ""+reportID+","
                    + "'"+acctype+"',"
                    + ""+userid+", "
                    + "CURRENT_TIMESTAMP, "
                    + "'"+filename+"' "
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
 %>