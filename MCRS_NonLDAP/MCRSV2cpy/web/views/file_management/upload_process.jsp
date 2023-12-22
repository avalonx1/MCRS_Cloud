<%@include file="../../includes/check_auth_layer3.jsp"%>
        <%
        
        
        String id = request.getParameter("id");
        
        
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
            
            saveFile = v_fileUploadDir+saveFile;
                    
            File ff = new File(saveFile);
            
            try {
            
                FileOutputStream fileOut = new FileOutputStream(ff);
                fileOut.write(dataBytes, startPos,(endPos - startPos));
                fileOut.flush();
                fileOut.close();
                
                out.println("Upload Success...");
            } catch(Exception e) {
                out.println(e);
            }
            
                
            }
        
        %>
        
       
  