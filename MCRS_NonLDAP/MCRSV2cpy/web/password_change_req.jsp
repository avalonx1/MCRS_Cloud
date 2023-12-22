<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>

<%

    
            session.removeAttribute("session_username");
            session.removeAttribute("session_password");
            session.removeAttribute("session_level");
            session.removeAttribute("session_nama");
            session.removeAttribute("session_first_name");
            session.removeAttribute("session_last_name");
            session.invalidate();
            
            
String v_clientIP = request.getRemoteAddr();
String vusername = request.getParameter("username");
          
          

%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Change Password|MCRS</title>

        <script type="text/javascript">

            function mainFocus(){
                var a= document.getElementById('username1');
                a.focus();
            }
        </script>
        
    </head>
    <body onload="mainFocus()">
        <div class="login_back">
            <div class="login_front">
                <div class="company_icon"></div>
                <div class="login_name">MCRS</div>
                <form id="formLogin" method="post" action="">

                    <table border=0 width="">
                       
                        <tr>
                            <td colspan="2" >Change Password Needed</td>
                            
                        </tr>
                        <tr>
                            <td>Usernames</td>
                            <td><input readonly=true id="username" size="15" type="text" name="username" value="<%=vusername%>"></td>
                        </tr>
                        <tr>
                            <td>Current Password</td>
                            <td><input size="15" id="curr_password" type="password" name="curr_password"></td>
                        </tr>
                        <tr>
                            <td>New Password</td>
                            <td><input size="15" id="new_password" type="password" name="new_password"></td>
                        </tr>
                        <tr>
                            
                            <td><input class="button" type="submit" name="login" value="Save"></td>
                        </tr>
                    </table>
                </form>
                   
                        <%
                        
                        int stat_in = 0;
                        
                        String session_userid="";
                                                String session_username="";
                                                String session_password="";
                                                String session_group="";
                                                String session_level="";
                                                String session_first_name="";
                                                String session_last_name="";
                                                
                        
                        if(request.getParameter("login") != null) {
                                String username = request.getParameter("username");
                                String curr_password = request.getParameter("curr_password");
                                String new_password = request.getParameter("new_password");
                                
                                //out.println(username+" "+curr_password+" "+new_password);  
                                
                                
                                if (username.length() != 0 && curr_password.length() != 0 && new_password.length()!=0 ) {

                                    ResultSet resultSet = null;
                                    try {
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String query;
                                           query = "SELECT id,username,password,group_id,level_id,FLAG,first_name,last_name " +
                                                    " from T_USER " +
                                                    " WHERE username='"+username+"' and password=upper(md5('" + curr_password + "')) ";
                                           
                                            resultSet = db.executeQuery(query);
                                            
                                            
                                                                                          
                                            //debug mode            
                                            //out.println("<div class=sql>"+query+"</div>");
                                           
                        
                                            while (resultSet.next()) {
                                                stat_in=1;
                                                
                                                if (resultSet.getString("FLAG").equals("1")) {
                                                stat_in=2;
                                                
                                                query = "update T_USER set stat_login=1, IP_ADDRESS='"+v_clientIP+"',last_login=current_timestamp, password=upper(md5('" + new_password + "')), change_paswd_notif=0 " +
                                                        "where username='" + resultSet.getString("username") + "' ";
                                                db.executeUpdate(query);
                                                
                                                
                                                session_userid = resultSet.getString(1);
                                                
                                                session_username = resultSet.getString(2);
                                                session_password=resultSet.getString(3);
                                                session_group=resultSet.getString(4);
                                                session_level=resultSet.getString(5);
                                                session_first_name=resultSet.getString("first_name");
                                                session_last_name=resultSet.getString("last_name");
                                                
                                                
                                               
                              
                                                
                                                } else {
                                                    out.println("<div class=alert> User "+resultSet.getString(2)+" is not active, please contact gumilar.supendi@muamalatbank.com </div>");
                                                }

                                            }
                                            if (stat_in==0) {
                                            out.println("<div class=alert>wrong username or password! if you forgot the password please contact IT-MIS (it.mis@bankmuamalat.co.id)</div>");
                                            }

                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                                    

                                } else {
                                    out.println("<div class=alert>username or password cannot null!</div>");
                                }
                                
                                
                            }

                        
                        if (stat_in==2) {
                            
                          
                           
                           
                           response.sendRedirect("login.jsp?stat_session=2");
                        
                        }       
                                                
                            %>
            </div>
        </div>
    </body>
</html>