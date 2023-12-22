<%@ page language="java" import="javax.servlet.http.Part,Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
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
  
 
  
%>

<html>
<head>
  <title>File Upload Example</title>
</head>

<body>
  <h1>Files Received at the Server</h1>
  <br/>

<%
    
    out.println(request.getAttribute("message"));
    
  for (Part p: request.getParts()) {

    /* out.write("Part: " + p.toString() + "<br/>\n"); */
      
    out.write("Part name: " + p.getName()+ " <br/>\n");
    out.write("Size: " + p.getSize() + "<br/>\n");
    out.write("Content Type: " + p.getContentType() + "<br/>\n");
    out.write("Header Names:");
    for (String name: p.getHeaderNames()) {
        out.write(" " + name);
    }
      String downloadLink=getPath+"/DownloadServlet?filename="+request.getAttribute("filename");
      
    out.println( "<a href='"+downloadLink +"'> download </a>");
    out.write("<br/><br/>\n");

/*
 * If the part is a text file, the following code can be added to read
 * the uploaded file, and dumps it on the response.

    java.io.InputStreamReader in =
      new java.io.InputStreamReader(p.getInputStream());

    int c = in.read();
    while (c != -1) {
      if (c == '\n') out.write("<br/>");
      out.write(c);
      c = in.read();
    }
 */

  }
%>

</body>
</html>

