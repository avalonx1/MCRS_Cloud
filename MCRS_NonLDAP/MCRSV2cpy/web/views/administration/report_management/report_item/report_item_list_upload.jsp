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

                                            sql = "SELECT ID,REPORT_CODE,REPORT_NAME,REPORT_DESCRIPTION,DEPT_CODE,DEPT_NAME,"
                                                    + "DIV_CODE,DIV_NAME,DOCUMENT_PATHKEY,REPORT_FREQ_NAME,REPORT_OWNER_NAME FROM v_report_item WHERE id="+id;
                                                    
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                    out.println("<tr><td>Report Code</td><td>: " + resultSet.getString("REPORT_CODE") + "</td></tr>");
                                                    out.println("<tr><td>Report Name</td><td>: " + resultSet.getString("REPORT_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Doc Path Name</td><td>: " + resultSet.getString("DOCUMENT_PATHKEY") + "</td></tr>");
                                                    out.println("<tr><td>Report Frequency</td><td>: " + resultSet.getString("REPORT_FREQ_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Name</td><td>: " + resultSet.getString("REPORT_OWNER_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Department</td><td>: " + resultSet.getString("DEPT_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Division</td><td>: " + resultSet.getString("DIV_NAME") + "</td></tr>");
                                                    
                                                
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
    <form action="report_item_list_upload_process.jsp" method="post" enctype="multipart/form-data">  
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
    
  