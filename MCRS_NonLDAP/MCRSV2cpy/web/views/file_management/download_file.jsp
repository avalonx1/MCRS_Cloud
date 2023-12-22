<%@include file="../../includes/check_auth_layer3.jsp"%>
<%


String filename = request.getParameter("filename");
String sourceid = request.getParameter("sourceid");

if (sourceid == null ) {
    sourceid = "0";
}
        
String filename_full = v_fileUploadDir+"/"+filename;
        
        
File fileToDownload = new File(filename_full);

if(fileToDownload.exists()){

response.setContentType("application/octet-stream");
String disHeader = "Attachment; Filename=\""+filename+"\"";
response.setHeader("Content-Disposition", disHeader);



InputStream in = null;
ServletOutputStream outs = response.getOutputStream();

try {
in = new BufferedInputStream
(new FileInputStream(fileToDownload));
int ch;
while ((ch = in.read()) != -1) {
outs.print((char) ch);
}
}
finally {
if (in != null) in.close(); // very important
}

outs.flush();
outs.close();
in.close();

      
} else {
   response.sendRedirect("filenotfound.jsp?sourceid="+sourceid);
}


%>
        