<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>

<%
    
      String v_clientIP = request.getRemoteAddr();
      String v_userID = (String) session.getAttribute("session_userid");
      String v_username = (String) session.getAttribute("session_username");
    
    
        String v_fileUploadDir="";
        double v_maxsizeUploadMB = 50; 
        auth au = new auth(v_clientIP);
         try {
        
           v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
           v_maxsizeUploadMB = Double.parseDouble(au.getParamValue("MAXSIZE_UPLOAD_MB"));
           
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         } 
    
    
         //mulai upload
           String saveFile = new String();
           String contentType = request.getContentType();
            
            if ( (contentType !=null ) &&  (contentType.indexOf("multipart/form-data") >=0 )){
            
            DataInputStream in = new DataInputStream(request.getInputStream());
            
            
            int formDataLength = request.getContentLength();
            boolean reachMaxFilesize = false;
            
            
            if ((formDataLength/1024/1024)>v_maxsizeUploadMB) {
                    reachMaxFilesize = true;
                    
                    %>
                                <script type="text/javascript">
                                    alert("File too large.. Maximum Size Allowed : <%=v_maxsizeUploadMB%> MB, Your File Size : <%=Math.round(formDataLength/1024/1024)%> MB");
                                    window.close();
                                </script>
                                <%
                    
                } else {
            
            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
            
            
            while (totalBytesRead < formDataLength ) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
                
            }
                
            
            String file = new String(dataBytes,"CP1256");
            String contentSearch = new String(dataBytes,"CP1256");
            String contentValue = new String();
            String fileExt = new String();
            String filenameonly = new String();
            
            
            saveFile = file.substring(file.indexOf("filename=\"") + 10 );
            saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.indexOf("\\") + 1 , saveFile.indexOf("\""));
            saveFile = saveFile.replace(" ", "_");
            
            fileExt = saveFile.substring(saveFile.indexOf(".")+1);
            
            filenameonly = saveFile.substring(1,saveFile.length()-fileExt.length()-1);
            
            boolean filenotExist = false;
            
            if (saveFile.length()>0 ) {
                filenotExist = true;
            }
            
                                    
            String saveFileOri = saveFile;
            String tag_code = "DOCJRNLADJ";
            saveFile = tag_code+"_"+v_username+"_"+saveFile;
             
            if (filenotExist) {
             //insert to db doc map
            String sql="default";
            try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                
                
                boolean checkFileFormat = false;
                String format_fileext = "";
                String format_filecasesensitive = "";
                String file_format = "";
                String file_formatcheck_combined = "";
                String list_ext = "";
                boolean cfile_format = false;
                
                sql = " select value as file_format from t_param where name='FILE_FORMAT_UPLOAD' ";
                  
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                    file_format = resultSet.getString("file_format");
                }
                
                
               sql = " select case when string_agg(file_extension||' ('||case when case_sensitive=1 then 'case sensitive' else 'case insensitive' end||')',';') is null "
                        + "then 'Extension Not Defined Tag Code:"+tag_code+"' else string_agg(file_extension||' ('||case when case_sensitive=1 then 'case sensitive' else 'case insensitive' end||')',';') end as list_ext "
                        + " from t_file_extension where tag_code='"+tag_code+"' ";
                
                  
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                    list_ext = resultSet.getString("list_ext");
                }
                
                                
                sql = " select file_extension,case_sensitive from t_file_extension where tag_code='"+tag_code+"' ";
                  
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                    
                
                    format_fileext = resultSet.getString("file_extension");
                    format_filecasesensitive = resultSet.getString("case_sensitive");
                    
                    if (format_filecasesensitive.equals("0")) {
                        format_fileext = format_fileext.toUpperCase();
                        
                        saveFileOri = filenameonly +"."+fileExt.toUpperCase();
                    }
                    
                    file_formatcheck_combined = file_format+"."+format_fileext;
                            
                    cfile_format= Pattern.matches(file_formatcheck_combined, saveFileOri);
                    
                    if (cfile_format) {
                    checkFileFormat =  true;
                    }
                    
                }
                
            
                 if (checkFileFormat && !reachMaxFilesize) {
                
                     
                    contentValue = contentSearch.substring(contentSearch.indexOf("form-data; name=\"id\"") + 21);
                    contentValue = contentValue.substring(0,contentValue.indexOf("-")-1);
                    contentValue = contentValue.trim();
                    int idusr = Integer.parseInt(contentValue);

            
                boolean checkFileBefore = false;
                
                sql = "select id from t_journal_adjust_file where doc_path_key='"+saveFile+"' and created_userid="+idusr+" ";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                checkFileBefore= true;
                }
                                            
                if (!checkFileBefore) {
                
                            //Upload File 
                        int lastiIndex = contentType.lastIndexOf("=");
                        String boundary = contentType.substring(lastiIndex +1, contentType.length());
                        int pos;

                        pos = file.indexOf("filename=\"");
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;


                        int boundaryLocation = file.indexOf(boundary,pos) - 4;

                        int startPos = ((file.substring(0,pos)).getBytes("CP1256")).length;
                        int endPos = ((file.substring(0,boundaryLocation)).getBytes("CP1256")).length;

                        String SaveFileFull = v_fileUploadDir+"/"+ saveFile;
                        

                        File ff = new File(SaveFileFull);

                        
                        try {

                            FileOutputStream fileOut = new FileOutputStream(ff);
                            fileOut.write(dataBytes, startPos,(endPos - startPos));
                            fileOut.flush();
                            fileOut.close();


                        } catch(Exception e) {
                            out.println(e);
                        }
                                
                        
                        
                        if (ff.exists()) {
                            
                        sql = "insert into t_journal_adjust_file (id,created_userid,doc_path_key,created_time,status_process,status_desc) values "
                            + " (nextval('t_journal_adjust_file_seq'),"+v_userID+",'"+saveFile+"',CURRENT_TIMESTAMP,0,'File Ready')";
                
                        db.executeUpdate(sql);
                
                
                                %>
                                <script type="text/javascript">
                                    alert("Upload Success..");
                                    window.close();
                                </script>
                                <%
                                }else {
                                
                                %>
                                <script type="text/javascript">
                                    alert("Upload Failed..");
                                    window.close();
                                </script>
                                <%
                                }

                }
                 else {
                            
                    
                    //Upload File 
                        int lastiIndex = contentType.lastIndexOf("=");
                        String boundary = contentType.substring(lastiIndex +1, contentType.length());
                        int pos;

                        pos = file.indexOf("filename=\"");
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;


                        int boundaryLocation = file.indexOf(boundary,pos) - 4;

                        int startPos = ((file.substring(0,pos)).getBytes("CP1256")).length;
                        int endPos = ((file.substring(0,boundaryLocation)).getBytes("CP1256")).length;

                        String SaveFileFull = v_fileUploadDir+"/"+ saveFile;
                        

                        File ff = new File(SaveFileFull);

                        
                        try {

                            FileOutputStream fileOut = new FileOutputStream(ff);
                            fileOut.write(dataBytes, startPos,(endPos - startPos));
                            fileOut.flush();
                            fileOut.close();


                        } catch(Exception e) {
                            out.println(e);
                        }
                        
                                %>
                                <script type="text/javascript">
                                    alert("File <%=saveFileOri%> Overwritten..");
                                    window.close();
                                </script>
                                <%
                               

                        }
                
                } else {
                                %>
                                <script type="text/javascript">
                                   alert("File Format not match with refference data or filesize more than 100MB. File: <%=saveFileOri%> Pattern File Allowed:<%=file_format%> and list extension allowed : <%=list_ext%>");
                                    window.close();
                                </script>
                                <%
                    }//end checkFileFormat
                
                
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
            else {
                                %>
                                <script type="text/javascript">
                                    alert("File not found!");
                                    window.close();
                                </script>
                                <%
                    }//end fileexist
            
            
            } //end maxsize
            }
            
%>