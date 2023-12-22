<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@ page language="java" import="java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*,Engines.*"%>
<%
    String path = request.getContextPath();
    String getProtocol=request.getScheme();
    String getDomain=request.getServerName();
    String getPort=Integer.toString(request.getServerPort());
    String getPath = getProtocol+"://"+getDomain+":"+getPort+path+"/index.jsp?stat_session=1";
  
    String v_clientIP = request.getRemoteAddr();
    String vuserid = request.getParameter("username");
    String vpass = request.getParameter("password");
    String vresp ="";
        
//        auth au = new auth(v_clientIP);
//        try {         
//            vresp = HttpPost.sendPost(vuserid, vpass);
//            out.println(vresp+" <a href="+getPath+"> masuk </a>");
//        } catch (Exception except) {
//            out.println("Success! AD");
//        } finally {
//        out.println("Failed! AD");
//            au.close();
//        }
        
          
          try {

            URL url = new URL("http://10.81.27.97:19177/ldap/authlogin");
//            con = (HttpURLConnection) myurl.openConnection();
            
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                        conn.addRequestProperty("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36");
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			conn.setRequestProperty("Content-Type", "application/json");
                        conn.setRequestProperty("Accept", "application/json");
//                      

                        String postData = "{\n  \"userid\": "+vuserid+",\n  \"password\": "+vuserid+"}";
                        byte[] out = postData.getBytes(StandardCharsets.UTF_8);

//			conn.setUseCaches(false);


                        //Write
                        OutputStream stream = conn.getOutputStream();
                        stream.write(out);
                        
                        System.out.println(conn.getResponseCode() + " " + conn.getResponseMessage());
                        conn.disconnect();
                        
                        try (DataOutputStream dos = new DataOutputStream(conn.getOutputStream())) {
				dos.writeBytes(postData);
			}
                        try (BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream())))
			{
				String line;
				while ((line = br.readLine()) != null) {
					System.out.println(line);
				}
			} 

        }
        
%>

