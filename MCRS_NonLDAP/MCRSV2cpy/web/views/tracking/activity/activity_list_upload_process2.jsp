<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>

<%
 String id= request.getParameter("id");

%>
<html>  
    <head>
        <link rel="stylesheet" type="text/css" href="../../../style/login.css" media="screen" />
        <title>Upload Activity Document</title>
    </head>
    <body>  
        <form action="activity_list_upload_process.jsp?id=<%=id%>" method="post" enctype="multipart/form-data">  
        
         <table class="formtable" >
             
             
        <%
           
            
            
            try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT ID,ACT_ITEMS_NAME,ITEMS_NAME,USERNAME_NAME,REQ_NAME,REQ_EMAIL,REQ_DIVISION_NAME FROM V_ACT_DAILY WHERE id="+id;
                                                    
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                    out.println("<tr><td>Activity Code</td><td>: " + resultSet.getString("ID") + "</td></tr>");
                                                    out.println("<tr><td>Activity Name</td><td>: " + resultSet.getString("ACT_ITEMS_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Item Name</td><td>: " + resultSet.getString("ITEMS_NAME") + "</td></tr>");
                                                    out.println("<tr><td>PIC</td><td>: " + resultSet.getString("USERNAME_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Name</td><td>: " + resultSet.getString("REQ_NAME") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Email</td><td>: " + resultSet.getString("REQ_EMAIL") + "</td></tr>");
                                                    out.println("<tr><td>Requestor Division</td><td>: " + resultSet.getString("REQ_DIVISION_NAME") + "</td></tr>");
                                                    
                                                
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
            
            
            
           String saveFile = new String();
            String contentType = request.getContentType();
            
            if ( (contentType !=null ) &&  (contentType.indexOf("multipart/form-data") >=0 )){
            DataInputStream in = new DataInputStream(request.getInputStream());
            
            int formDataLength = request.getContentLength();
            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
            
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
                
            }
                
            
            String file = new String(dataBytes);
            
            saveFile = file.substring(file.indexOf("filename=\"") + 10 );
            saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
            
            saveFile = saveFile.substring(saveFile.indexOf("\\") + 1 , saveFile.indexOf("\""));
            
            int lastiIndex = contentType.lastIndexOf("=");
            
            String boundary = contentType.substring(lastiIndex +1, contentType.length());
            
            int pos;
            
            pos = file.indexOf("filename=\"");
            pos = file.indexOf("\n",pos) + 1;
            pos = file.indexOf("\n",pos) + 1;
            pos = file.indexOf("\n",pos) + 1;
            
            
            int boundaryLocation = file.indexOf(boundary,pos) - 4;
            
            int startPos = ((file.substring(0,pos)).getBytes()).length;
            int endPos = ((file.substring(0,boundaryLocation)).getBytes()).length;
            
            saveFile = "F:/upload/"+ saveFile;
                    
            File ff = new File(saveFile);
            
            try {
            
                FileOutputStream fileOut = new FileOutputStream(ff);
                fileOut.write(dataBytes, startPos,(endPos - startPos));
                fileOut.flush();
                fileOut.close();
                
                
            } catch(Exception e) {
                out.println(e);
            }
            
            
            
            
                
            }
            
            
        
        %>
        
       
            <tr>
            <td>Select File:</td> 
            <td><input type="file" name="file"/></td>
            </tr>
            <tr><td align="left">
                    <input type="submit" value="upload"/>  
                </td>
            </tr>
        </table>
            </form>  
        </body>  
    </html>  
    
  