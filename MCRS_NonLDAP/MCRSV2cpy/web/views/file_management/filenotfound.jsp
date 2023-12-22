<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>


<%
    
  String sourceid= request.getParameter("sourceid");
  int screenidcvt = Integer.parseInt(sourceid);
  
  
   String v_userName = (String) session.getAttribute("session_username");
   String v_firstName = (String) session.getAttribute("session_first_name");
   String v_lastName = (String) session.getAttribute("session_last_name");
          
          
  String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path+"/index.jsp?stat_session=1";
  String v_mainPath=getPath;

  String msg="";
  
  switch(screenidcvt){
		   case 1:
			msg ="Sorry for the inconvenience. File that you're looking for is Not Found. Please ensure you're type proper link on notification <br/>Please contact IT-MIS Team (it.mis@bankmuamalat.co.id) for further information.";
			break;
                   default:
                     msg = "Sorry for the inconvenience. File that you're looking for is Not Found. Please contact IT-MIS Team (it.mis@bankmuamalat.co.id) for further information.";
        }
      
          
%>
<br/>
Hi <% out.println(v_firstName+" "+v_lastName+" ("+v_userName+")"); %>,<br/>
<%=msg%>
<br/>
<br/>
<a href=<%=getPath%>> back to main site </a>