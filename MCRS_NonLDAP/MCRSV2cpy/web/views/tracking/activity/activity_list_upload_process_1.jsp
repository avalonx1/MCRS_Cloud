<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%
    String v_clientIP = request.getRemoteAddr();
    
    
    String v_fileUploadDir="";
    auth au = new auth(v_clientIP);
         try {
        
           v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
         
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
            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
            
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
                
            }
                
            
            String file = new String(dataBytes);
            String contentSearch = new String(dataBytes);
            String contentValue = new String();
            String fileExt = new String();
            
           
            
            
            saveFile = file.substring(file.indexOf("filename=\"") + 10 );
            saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.indexOf("\\") + 1 , saveFile.indexOf("\""));
            saveFile = saveFile.replace(" ", "_");
            
            fileExt = saveFile.substring(saveFile.indexOf(".")+1);
            
            contentValue = contentSearch.substring(contentSearch.indexOf("form-data; name=\"id\"") + 21);
            contentValue = contentValue.substring(0,contentValue.indexOf("-")-1);
            
            contentValue = contentValue.trim();
            
            int idact = Integer.parseInt(contentValue);
            
            
            
            out.println(idact+2+" "+saveFile+" "+fileExt);
            
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
            
            saveFile = v_fileUploadDir+"/"+ saveFile;
                    
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
