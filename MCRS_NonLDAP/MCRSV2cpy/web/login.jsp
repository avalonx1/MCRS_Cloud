<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%

String statSession = request.getParameter("stat_session");

String v_clientIP = request.getRemoteAddr();

if (statSession==null) {
    statSession="0";
}

%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Login|MCRS</title>

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
                <div class="login_name">MCRSV4</div>
                <form id="formLogin" method="post" action="">

                    <table border=0 width="">
                        <tr>
                            <td>Username</td>
                            <td><input id="username1" size="15" type="text" name="username" ></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input size="15" type="password" name="password"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><div class="forgetPass"><a href="forget_password.jsp" id="forgetPasswd">Forget Password?</a></div></td>
                            
                        </tr>
                        <tr>
                            
                            <td><input class="button" type="submit" name="login" value="Login"></td>
                        </tr>
                    </table>
                </form>
                    
                

                            <%
                            
                            if (statSession.equals("1")) {
                                 out.println("<div class=alert>Your Session has been expired, please re-login</div>");
                            }

                            if (statSession.equals("2")) {
                                 out.println("<div class=info>Change Password Success, please login re-login</div>");
                            }

                            if(
                             request.getParameter("login") != null) {
                                String username = request.getParameter("username");
                                String password = request.getParameter("password");
                                if (username.length() != 0 && password.length() != 0) {


                                    int stat_in = 0;
                                    ResultSet resultSet = null;
//                                    stat_in=1;
                                    try {
                                        Database db = new Database();
                                        try {
                                       
                                            db.connect(1);
                                            String query;
                                           query = "SELECT id,username,password,group_id,level_id,FLAG,first_name,last_name " +
                                                    " from T_USER " +
                                                    " WHERE username='"+username+"'";
                                            resultSet = db.executeQuery(query);
                                            System.out.println(query);
                                            while (resultSet.next()) {
                                                stat_in=1;
                                                
                                                
                                                if (resultSet.getString("FLAG").equals("1")) {
                                                    stat_in=3;
//                                                
                                                    boolean isEligibleLdap = true;
//                                                    String errCode = "";
//                                                    
//                                                      
//   
//                                                    ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
////                                                    String username="20131254";
////                                                    String password="Password*3";
//        
//                                                    
////                                                    ldapActiveDirectory ldap = new ldapActiveDirectory();
////                                                    ldap.getName(username);
////                                                    ldap.getEmail(username);
////                                                    ldap.getTitle(username);
//                                                        isEligibleLdap=ldap.getAuthByDName(username,password);
                                                        String AttrName= "20160038";
                                                        String AttrFirstName="20160038";
                                                        String AttrLastName="20160038";
                                                        String AttrEmail="20160038";
                                                        String AttrTitle="20160038";
                                                        String AttrIPPhone="20160038";
//
                                                        if (isEligibleLdap) {
                                                            stat_in=3;
                                                             
                                                                session.setAttribute("session_userid", resultSet.getString(1));
                                                                session.setAttribute("session_username", resultSet.getString(2));
                                                                session.setAttribute("session_password", resultSet.getString("password")); //sengaja masuk ke username karena pass sudah dapat dari LDAP
                                                                session.setAttribute("session_group", resultSet.getString(4));
                                                                session.setAttribute("session_level", resultSet.getString(5));
                                                                session.setAttribute("session_first_name", resultSet.getString("first_name"));
                                                                session.setAttribute("session_last_name", resultSet.getString("last_name"));
                                                                
                                                               query = "update T_USER set stat_login=1, IP_ADDRESS='"+v_clientIP+"',last_login=current_timestamp " +
                                                                        "where username='" + resultSet.getString("username") + "' ";


                                                                db.executeUpdate(query);

                                                                int v_changePasswd=0;

                                                                auth au = new auth(v_clientIP);
                                                                try {
                                                                v_changePasswd= au.getChangePasswdStatus(resultSet.getString("id"));


                                                                } catch (SQLException Sqlex) {
                                                                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                                                } finally {
                                                                au.close();
                                                                }
//
                                                                if ( v_changePasswd==1 ) {
                                                                   //response.sendRedirect("password_change_req.jsp?username="+resultSet.getString("username"));
                                                                    response.sendRedirect("views/index.jsp?menuid=1");
                                                                } else {
                                                                    
                                                                    
                                                                    query = "insert into t_user_audit(id,act_tag,act_desc,ip_addr,host_addr,created_userid,created_time) "
                                                                            +"values ( "
                                                                            + "nextval('t_user_audit_seq'),"
                                                                            + "'LOGIN',"
                                                                            + "'User Login : "+resultSet.getString("username")+" - "+resultSet.getString("username")+" "+resultSet.getString("username")+"', "
                                                                            + "'"+v_clientIP+"', "
                                                                            + "'"+v_clientIP+"', "
                                                                            + " "+resultSet.getString("id")+", "
                                                                            + " CURRENT_TIMESTAMP"
                                                                            + " )";
                                                                    
                                                                    db.executeUpdate(query);
                                                                
                                                                    response.sendRedirect("views/index.jsp?menuid=1");
                                                                }
                                                                
                                                        } else {
                                                         out.println("<div class=alert> Authenticate Failed using LDAP Active Directory for username "+resultSet.getString(2)+", Please ensure your password is correct. <br><br> Please contact IT Helpdesk Team for futher information or submit ticket on http://ithelpdesk.bankmuamalat.co.id </div>");
                                                            
                                                        }
                                                        
                                                    } else {
                                                        out.println("<div class=alert> Username "+username+" is missing in LDAP Active Directory database. <br><br> Please contact IT Helpdesk Team for futher information or submit ticket on http://ithelpdesk.bankmuamalat.co.id</div>");
                                                         
                                                    }
    
                                            }
                                            if (stat_in==0) {
                                            out.println("<div class=alert>username is not registered. <br><br> Please contact IT Helpdesk Team for futher information or submit ticket on http://ithelpdesk.bankmuamalat.co.id</div>");
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
                                    out.println("<div class=alert>username or password is null!</div>");
                                }
                             }
                            

                %>

            </div>
        </div>
    </body>
</html>