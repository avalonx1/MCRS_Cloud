<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%
    String v_clientIP = request.getRemoteAddr();
    
    String id= request.getParameter("id");
    
    String v_fileUploadDir="";
    auth au = new auth(v_clientIP);
         try {
        
           v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

%>

<html>  
    <head><link rel="stylesheet" type="text/css" href="../../../../style/styles_upload.css" media="screen" />
        <title>Upload File</title>
    </head>
    <body>  
        
        <table class="formtable" >
        <%
        
          try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT ID,REFF_CODE,REFF_NAME,REFF_DESC,GROUP_CODE,GROUP_NAME "
                                                    + " FROM v_dwhreff_item WHERE id="+id;
                                                    
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                    out.println("<tr><td>Reference Code</td><td>: " + resultSet.getString("REFF_CODE") + "</td></tr>");
                                                    out.println("<tr><td>Reference Name</td><td>: " + resultSet.getString("REFF_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Reference Desc</td><td>: " + resultSet.getString("REFF_DESC") + "</td></tr>");
                                                    out.println("<tr><td>Group Code</td><td>: " + resultSet.getString("GROUP_CODE") + "</td></tr>");
                                                    out.println("<tr><td>Group Name</td><td>: " + resultSet.getString("GROUP_NAME") + "</td></tr>");
                                                    
                                                    
                                                
                                            }
                                            resultSet.close();
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
      </table>
      
     <div id="stylized" class="myform">
    <form action="reff_item_list_upload_process.jsp" method="post" enctype="multipart/form-data">  
    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <table class="formtable">
    <tr>
    <td>Select File</td><td><input type="file" name="file"/></td>
    </tr>
    <tr>
        <td ><button type="submit">Upload</button></td>
        <td></td>
    </tr>
    
    
    
    </table>
    </form>  
    </div>
    </body>  
    </html>  
    
  