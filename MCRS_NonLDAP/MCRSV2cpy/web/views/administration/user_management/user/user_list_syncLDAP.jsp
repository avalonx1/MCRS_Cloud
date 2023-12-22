<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
    String id="0";
    int inc = 0;
    int incsukses = 0;
    int incerr = 0;
    String tableName="t_user";
   
    String username="";

    
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
              
                   
                   sql = "SELECT id,username,password,group_id,level_id,FLAG " +
                                                    " from T_USER " +
                                                    " WHERE FLAG=1 and first_name is null order by username";
                    resultSet = db.executeQuery(sql);
                    
                   
                    ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
                    boolean isActiveLDAP = false;
                    
                    while (resultSet.next()) {
                        
                    username= resultSet.getString("username");       
                    isActiveLDAP = ldap.isRegisterLDAP(username);
                    
                    if (isActiveLDAP) {
                    String AttrFirstName=ldap.getFirstName(username).replace("'", "''");
                    String AttrLastName=ldap.getLastName(username).replace("'", "''");
                    String AttrEmail=ldap.getEmail(username).replace("'", "''");
                    String AttrTitle=ldap.getTitle(username).replace("'", "''");
                    String AttrIPPhone=ldap.getIPPhone(username).replace("'", "''");
                    
                    
                    
                        sql = "update "+tableName+" SET "
                               + "first_name='" + AttrFirstName + "' ,"
                               + "last_name='" + AttrLastName + "' ,"
                               + "email='" + AttrEmail + "' ,"
                               + "title='" + AttrTitle + "' ,"
                               + "emp_id='" + username + "' ,"
                               + "contact_ext='" + AttrIPPhone + "' "
                                +" where id="+resultSet.getString("id");

               
                        //debug mode            
                               if (v_debugMode.equals("1")) {
                               out.println("<div class=sql>"+sql+"</div>");
                               }
                        //out.println(incsukses+" "+id+" "+sql);
                        
                        db.executeUpdate(sql);
                        
                        incsukses++;
                        //out.println("<div class=info> Update LDAP "+username+" Success<br></div>");

                  } else {
                        incerr++;
                         out.println("<div class=warning>User " + username + " is not registered in LDAP Active Directory, please check on LDAP Database first. <br></div>");
                    }
                       
                    
                    inc++;
                    }    
                    
                    
                    out.println("<div class=info> Update LDAP "+incsukses+" Record(s) Success and "+incerr+" Record(s) Failed data scan "+inc+" Record(s)</div>");
                    
                    
                    
               
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        

    

    
    
%>

