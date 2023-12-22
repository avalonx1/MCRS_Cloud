<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%
    
      String v_clientIP = request.getRemoteAddr();
      String v_userID = (String) session.getAttribute("session_userid");
    
    
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
            
            
            saveFile = file.substring(file.indexOf("filename=\"") + 10 );
            saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.indexOf("\\") + 1 , saveFile.indexOf("\""));
            saveFile = saveFile.replace(" ", "_");
            
            
            
            fileExt = saveFile.substring(saveFile.indexOf(".")+1);
            
            boolean fileExist = false;
            
            int filelength = 0;
            
            filelength = saveFile.length();
                    
            if (filelength>0) {
                fileExist = true;
            }
            
            double bytes = saveFile.length();
            double kilobytes = (bytes / 1024);
            double megabytes = (kilobytes / 1024);
               
            
            String tablename ="t_dwhreff_item_file";
            String tablenameseq =tablename+"_seq";
            
            String saveFileOri = saveFile;
            
            
            
            
            if (fileExist) {
             //insert to db doc map
            String sql="default";
            try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                
                
                    contentValue = contentSearch.substring(contentSearch.indexOf("form-data; name=\"id\"") + 21);
                    contentValue = contentValue.substring(0,contentValue.indexOf("-")-1);
                    contentValue = contentValue.trim();
                    int idreff = Integer.parseInt(contentValue);
                    saveFile = "DOCREFF_"+idreff+"_"+saveFile;
                    
                    
                boolean checkFileFormat = false;
                String format_fileext = "";
                String file_format = "";
                
                sql = " select a.*,file_length-char_fix_length-char_any_length char_req_length from ( "
                  +"select id,file_format, "
                  +"substr(file_format,length(file_format) - POSITION ('.' IN reverse(file_format)) + 2,length(file_format)) file_ext, "
                  +"length(replace(replace(replace(replace(file_format,']',''),'[',''),'{',''),'}','')) file_length, "
                  +"POSITION ('[' in  file_format) start_char_fix, "
                  +"POSITION (']' in  file_format) stop_char_fix, "
                  +"case when position ('[' in  file_format)=0 then 0 else length(substr(file_format,POSITION ('[' in  file_format)+1,POSITION (']' in  file_format)-POSITION ('[' in  file_format)-1 )) end char_fix_length, "
                  +"POSITION ('{' in  file_format) start_char_any, "
                  +"POSITION ('}' in  file_format) stop_char_any, "
                  +"case when position ('{' in  file_format)=0 then 0 else length(substr(file_format,POSITION ('{' in  file_format)+1,POSITION ('}' in  file_format)-POSITION ('{' in  file_format)-1 )) end char_any_length "
                  +"from t_dwhreff_item ) a "
                  + "where id="+idreff+" ";
                  
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                
                    format_fileext = resultSet.getString("file_ext");
                    file_format = resultSet.getString("file_format");
                }
                
                
                boolean cfile_format = Pattern.matches(file_format, saveFileOri);
                      
                if (cfile_format) {
                    checkFileFormat =  true;
                }
                
            
                
                if (checkFileFormat && !reachMaxFilesize) {
        
                    
                        //setelah lolos check format
                        boolean checkFileBefore = false;

                        sql = "select id from "+tablename+" where doc_path_key='"+saveFile+"' and fileid="+idreff+" ";
                        resultSet = db.executeQuery(sql);

                        while (resultSet.next()) {
                        checkFileBefore= true;
                        }

                        
                        
                        if (!checkFileBefore) {

                            //CREATE FILE
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
                                
                                String saveFileFull = v_fileUploadDir+"/"+ saveFile;

                                File ff = new File(saveFileFull);

                                try {

                                    FileOutputStream fileOut = new FileOutputStream(ff);
                                    fileOut.write(dataBytes, startPos,(endPos - startPos));
                                    fileOut.flush();
                                    fileOut.close();


                                } catch(Exception e) {
                                    out.println(e);
                                }
                                
                                
                                if (ff.exists()) {
                                
                                sql = "insert into "+tablename+" (id,fileid,userid,doc_path_key,created_time,status_process,status_info) values "
                                   + " (nextval('"+tablenameseq+"'),"+idreff+","+v_userID+",'"+saveFile+"',CURRENT_TIMESTAMP,0,'File Ready')";

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
                                //END CREATE FILE

                        } //end checkfilebefore
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
                                    alert("File Format not match with refference data! File Name : <%=saveFileOri%> regex:<%=file_format%>");
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
            
            
            }else {
                                %>
                                <script type="text/javascript">
                                    alert("File not found!");
                                    window.close();
                                </script>
                                <%
                    }//end fileexist
               }//endmaxsize
            }
            
%>
