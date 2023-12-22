<%
  String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path+"/";
  String MainPath=getPath;
  response.sendRedirect(MainPath);

%>
