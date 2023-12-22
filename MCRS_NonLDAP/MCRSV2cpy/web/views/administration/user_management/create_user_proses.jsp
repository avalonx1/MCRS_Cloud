<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%

    String creator = (String) session.getAttribute("session_username");
    String username = request.getParameter("username");
    String pass = request.getParameter("password");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String groupUser = request.getParameter("groupUser");
    String levelUser = request.getParameter("levelUser");
    String ip = request.getParameter("ip");
    String email = request.getParameter("email");
    String empid = request.getParameter("empid");
    String tableName="t_user";
    String seqTableName=tableName+"_seq";

    String tableName2="t_view_menu";
    String seqTableName2=tableName2+"_seq";



    boolean insert = true;
    String errorMessage = "";

    boolean cusername = Pattern.matches("[\\w]+", username);
    boolean cpass = Pattern.matches("[\\w\\@\\!\\*]+", pass);
    boolean cfname = Pattern.matches("[a-zA-Z0-9 ]+", fname);
    boolean clname = Pattern.matches("[a-zA-Z0-9 ]+", lname);
    boolean cempid = Pattern.matches("[0-9]+", empid);
    boolean cgroup = Pattern.matches("[\\d]+", groupUser);
    boolean cip = Pattern.matches("([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){1,3}(:\\d{1,3})?|", ip);
    boolean cemail = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", email);
    //out.println(cusername+"-"+cname);

    if (!cusername) {
        insert = false;
        errorMessage += "-Field Username must be filled with alpha numeric<br>";
    }
    if (!cpass) {
        insert = false;
        errorMessage+="-Field New Password must be filled with alpha numeric [a-z;A-z;0-9;_]<br>";
    }
    
    
    if (!cfname) {
        insert = false;
        errorMessage += "-Field first name must be filled with character only<br>";
    }
    
     if (!cempid) {
        insert = false;
        errorMessage += "-Field employee id name must be filled with numeric only<br>";
    }
    
    if (!lname.equals("")) {
    if (!clname) {
        insert = false;
        errorMessage += "-Field last name must be filled with character only<br>";
    }
    }
    

    
    if (!email.equals("")) {
    if (!cemail) {
        insert = false;
        errorMessage += "-Field Email must be filled with email standar { ex: exp@example.com }<br>";
    }
    }

    if (insert) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                String stat_user="0";
                
                sql = "SELECT id,username,password,group_id,level_id,FLAG " +
                                                    " from T_USER " +
                                                    " WHERE username='"+username+"' ";
                resultSet = db.executeQuery(sql);
                while (resultSet.next()) {                                   
                       stat_user="1";
                }          
                
                
                if (stat_user.equals("0")) {
                
                sql = "insert into "+tableName+" (id,username,password,first_name,last_name,group_id,level_id,ip_address,email,creator,creation_time,flag,emp_id,first_time_login,nda_confirmed,change_paswd_notif) "
                        + "values (nextval('"+seqTableName+"'),'" + username + "',UPPER(md5('" + pass + "')),'" + fname + "','" + lname + "','" + groupUser + "',"
                        + "'" + levelUser + "','" + ip + "','" + email + "','" + creator + "',CURRENT_DATE,1,'"+empid+"',1,1,1)";
                db.executeUpdate(sql);
                
                
                out.println("<div class=info>Create User " + username + " Success<br></div>");
                }else {
                out.println("<div class=warning>User " + username + " already created, please check again. <br></div>");
                }
                    
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

<script type="text/javascript">
 
    $('#loading').show();
    $.ajax({
        type: 'POST',
        url: "administration/user_management/create_user.jsp",
        data: "",
        success: function(data) {
            $("#data").empty();
            $('#data').html(data);
            $("#data").show();
            $("#status_msg").delay(5000).hide(400);                  
        },
        complete: function(){
            $('#loading').hide();            
        }
    })
    
</script>
