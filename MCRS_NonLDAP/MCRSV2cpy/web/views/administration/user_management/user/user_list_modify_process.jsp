<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String creator = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    
    String tableName="t_user";
    String seqTableName=tableName+"_seq";


    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String username = "";
   
    String first_time_login="";
    String nda_confirmed="";
    String change_paswd_notif="";
    String homescreen_notif="";
            
    if (actionCode.equals("ADD")){
    
    username = request.getParameter("username");
   
    
    }else {
        
    first_time_login=request.getParameter("first_time_login");
    nda_confirmed=request.getParameter("nda_confirmed");
    change_paswd_notif=request.getParameter("change_paswd_notif");
    homescreen_notif = request.getParameter("homescreen_notif");
    }
    
    
    //String first_name=request.getParameter("first_name");
    //String last_name =request.getParameter("last_name");
    String emp_id=request.getParameter("emp_id");
    String group_id=request.getParameter("group_id");
    String level_id=request.getParameter("level_id");
    //String email=request.getParameter("email");
    String notification_msg=request.getParameter("notification_msg");
    
    
 
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
  
   // boolean cfirst_name = Pattern.matches("[a-zA-Z0-9 ]+", first_name);
   // boolean clast_name = Pattern.matches("[a-zA-Z0-9 ]+", last_name);
   // boolean cemail = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", email);
   
    if (actionCode.equals("ADD")){
        
    boolean cusername = Pattern.matches("[\\w]+", username);
   
    
    
    if (!cusername) {
        validate = false;
        errorMessage += "-Field Username must be filled with alpha numeric<br>";
    }
   
    }
    
   /* 
    if (!cfirst_name) {
        first_name="NULL";
        validate = false;
        errorMessage += "-Field first name must be filled with character only<br>";
    }
    
    
    if (!last_name.equals("")) {
    if (!clast_name) {
        last_name="NULL";
        validate = false;
        errorMessage += "-Field last_name must be filled with character only<br>";
    }
    }
    
    
    if (!cemail || email.equals("")) {
       email="NULL";
       validate = false;
       errorMessage += "-Field Email must be filled with email standar { ex: example@example.com }<br>";
    }
    
    
    if (emp_id.equals("")) {
        last_name="NULL";
        validate = false;
        errorMessage += "-Field employe id (nik) cannot null <br>";
    }
    */
    
     if (actionCode.equals("EDT")) {
    
     /*    
         if (first_time_login.equals("")) {
        last_name="NULL";
        validate = false;
        errorMessage += "-Field fist time login cannot null (insert with 1 or 0) <br>";
    }
       
       */
         
    if (nda_confirmed.equals("")) {
        nda_confirmed="NULL";
        validate = false;
        errorMessage += "-Field NDA Confirmed cannot null (insert with 1 or 0) <br>";
    }
          
    if (change_paswd_notif.equals("")) {
        change_paswd_notif="NULL";
        validate = false;
        errorMessage += "-Field Change Passwd Notif cannot null (insert with 1 or 0) <br>";
    }
    
     }
    
    
    
 
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
               
                   String stat_user="0";
                   sql = "SELECT id,username,password,group_id,level_id,FLAG " +
                                                    " from T_USER " +
                                                    " WHERE username='"+username+"' ";
                    resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {                                   
                           stat_user="1";
                           
                             //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                    }          

                
                if (stat_user.equals("0")) {
                
                    boolean isEligibleLdap = false;
                    
                    ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
                     
                    boolean isActiveLDAP = ldap.isRegisterLDAP(username);

                    
                    if (isActiveLDAP) {
                        
                    
                    String AttrFirstName=ldap.getFirstName(username).replace("'", "''");;
                    String AttrLastName=ldap.getLastName(username).replace("'", "''");;
                    String AttrEmail=ldap.getEmail(username).replace("'", "''");;
                    String AttrTitle=ldap.getTitle(username).replace("'", "''");;
                    String AttrIPPhone=ldap.getIPPhone(username).replace("'", "''");;
                    
                       
                    
                    
                sql = "insert into "+tableName+" "
                        + "(id,username,password,first_name,last_name,group_id,level_id,"
                        + "email,creator,creation_time,flag,emp_id,"
                        + "first_time_login,nda_confirmed,change_paswd_notif,homescreen_notif,notification_msg,title,contact_ext) "
                        + "values (nextval('"+seqTableName+"'),"
                        + "'" + username + "',"
                        //+ "'" + username + "',"
                        + "UPPER(md5('" + username+ "')),"
                        + "'" + AttrFirstName + "',"
                        + "'" + AttrLastName + "',"
                        + "" + group_id + ","
                        + "" + level_id + ","
                        + "'" + AttrEmail + "',"
                        + "'" + creator + "',"
                        + "CURRENT_TIMESTAMP,"
                        + "1,"
                        + "'"+username+"',"
                        + "1,1,0,1,"
                        + "'"+notification_msg+"', "
                        + "'"+AttrTitle+"', "
                        + "'"+AttrIPPhone+"' "
                        + ")";
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                    } else {
                         out.println("<div class=warning>User " + username + " is not registered in LDAP Active Directory, please check on LDAP Database first. <br></div>");
                    }
                
                
                }else {
                out.println("<div class=warning>User " + username + " already created, please check again. <br></div>");
                }
                   
               
                actionDesc="Add";
                        
               }else {
                   
                   sql = "SELECT id,username,password,group_id,level_id,FLAG " +
                                                    " from T_USER " +
                                                    " WHERE id='"+id+"' ";
                    resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {                                   
                           username= resultSet.getString("username");
                           
                             //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                    }    
                    
                    ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
                    boolean isActiveLDAP = ldap.isRegisterLDAP(username);
                    
                    if (isActiveLDAP) {
                    String AttrFirstName=ldap.getFirstName(username).replace("'", "''");;
                    String AttrLastName=ldap.getLastName(username).replace("'", "''");;
                    String AttrEmail=ldap.getEmail(username).replace("'", "''");;
                    String AttrTitle=ldap.getTitle(username).replace("'", "''");;
                    String AttrIPPhone=ldap.getIPPhone(username).replace("'", "''");;
                    
                    
                 sql = "update "+tableName+" SET "
                        + "first_name='" + AttrFirstName + "' ,"
                        + "last_name='" + AttrLastName + "' ,"
                        + "email='" + AttrEmail + "' ,"
                        + "title='" + AttrTitle + "' ,"
                        + "emp_id='" + username + "' ,"
                        + "contact_ext='" + AttrIPPhone + "' ,"
                        + "group_id=" + group_id + " ,"
                        + "level_id=" + level_id + " ,"
                        + "creator='" + creator + "',"
                        + "first_time_login="+first_time_login+","
                        + "nda_confirmed="+nda_confirmed+","
                        + "change_paswd_notif="+change_paswd_notif+","
                        + "homescreen_notif="+homescreen_notif+","
                        + "notification_msg='"+notification_msg+"' "
                         +" where id="+id;
                 
                 actionDesc="Edit";
                 //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                   
                
                } else {
                         out.println("<div class=warning>User " + username + " is not registered in LDAP Active Directory, please check on LDAP Database first. <br></div>");
                    }
                    
               }
               
               
               
                
                 %>
                <script type="text/javascript">
                    
                    
                    filter_itemname= document.getElementById("filter_itemname").value;
                   filter_group_id= document.getElementById("filter_group_id").value;
                   filter_level_id= document.getElementById("filter_level_id").value;
                   filter_userstatus= document.getElementById("filter_userstatus").value;
                   
                   
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/user_management/user/user_list_data.jsp",
                        data: {id:<%=id%>,
                                filter_itemname:filter_itemname,
                                filter_group_id:filter_group_id,
                                filter_level_id:filter_level_id,
                                filter_userstatus:filter_userstatus                            
                        },
                        success: function(data) {
                            $("#data_inner").empty();
                            $('#data_inner').html(data);
                            $("#data_inner").show();
                            $("#status_msg").delay(5000).hide(400);                  
                        },
                        complete: function(){
                            $('#loading').hide();
                        }
                    });
                </script>
                    <%
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

    

    
    
%>

