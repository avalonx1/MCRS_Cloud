<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*"%>


<%
    
    String v_userID = (String) session.getAttribute("session_userid");
    
String v_clientIP = request.getRemoteAddr();
String v_debugMode="0";

         auth au = new auth(v_clientIP);
         try {
         
         v_debugMode=au.getParamValue("DEBUG_MODE");

         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }
         
    
    String parentID = request.getParameter("dir");
        String modulID = request.getParameter("modul");
        String groupID = request.getParameter("group");
        String levelID = request.getParameter("level");

        if (parentID == null) {
            return;
        }
        String treeData = "";

   
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;

                sql = "select MENU_ID ID, "
                    +"case MENU_ID WHEN 38 then NAME||' ('||(select count(1) from t_usr_file_share_recipient a where a.userid="+v_userID+")||')' "
                    +"WHEN 40 then NAME||' ('||(select count(1) from t_usr_file_share_recipient a left join t_usr_file_share b on a.fileid=b.id where b.userid="+v_userID+")||')' "
                    +"WHEN 37 then NAME||' ('||(select count(1) from t_usr_file_share a where a.userid="+v_userID+")||')' "
                    +"else NAME end NAME_TREE  ,"
                    + "'/'||(select VALUE from T_PARAM where NAME='APPNAMEURL')||URL URL,LEAF from v_menu_matrix where user_group_id='" + groupID + "' and user_level_id='" + levelID + "' and  modul='" + modulID + "' and parent_menu='" + parentID + "' and stat=1 and status_matrix=1 order by urutan";
                
                 //debug mode            
                        if (v_debugMode.equals("1")) {
                        //out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                
                resultSet = db.executeQuery(sql);
                
                System.out.println("INI TREE MENU AKSES= "+sql);
                while (resultSet.next()) {
                    if (resultSet.getString("LEAF").equals("0")) {
                        treeData += "<li id=\"tree_"+resultSet.getString(1)+"\" class=\"directory collapsed\"><a href=\"" + resultSet.getString(3) + "\" rel=\"" + resultSet.getString(1) + "\">" + resultSet.getString(2) + "</a></li>";
                    } else {
                        treeData += "<li id=\"tree_"+resultSet.getString(1)+"\" class=\"file\"><a href=\"" + resultSet.getString(3) + "\" rel=\"" + resultSet.getString(1) + "\">" + resultSet.getString(2) + "</a></li>";
                    }
                }
                
                treeData = "<ul class=\"jqueryFileTree\" style=\"display: none;\">" + treeData + "</ul>";
                out.println(treeData);
                      //out.println(sql);
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close();
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
  
%>
