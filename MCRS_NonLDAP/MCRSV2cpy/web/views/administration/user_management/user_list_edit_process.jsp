<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%
   
    String objid = request.getParameter("id");
      
    String username = request.getParameter("username");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String groupUser = request.getParameter("groupUser");
    String levelUser = request.getParameter("levelUser");
    String ip = request.getParameter("ip");
    String email = request.getParameter("email");
    
    boolean update = true;
    String errorMessage = "";

    boolean cfname = Pattern.matches("[a-zA-Z0-9 ]+", fname);
    boolean clname = Pattern.matches("[a-zA-Z0-9 ]+", lname);
    boolean cgroup = Pattern.matches("[\\w]+", groupUser);
    boolean cip = Pattern.matches("([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){1,3}(:\\d{1,3})?|", ip);
    boolean cemail = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", email);
    //out.println(cusername+"-"+cname);

    if (!fname.equals("")) {
    if (!cfname) {
        update = false;
        errorMessage += "-Field first name must be filled with character only<br>";
    }
    }
    
    if (!lname.equals("")) {
    if (!clname) {
        update = false;
        errorMessage += "-Field last name must be filled with character only<br>";
    }
    }
    
    
    if (!cgroup) {
        update = false;
        errorMessage += "-Field Group must be filled with numeric<br>";
    }

    if (!cemail) {
        update = false;
        errorMessage += "-Field Email must be filled with email standar { ex: example@example.com }<br>";
    }

    if (update) {
        try {
            Database db = new Database();
            try {
                db.connect(1);
                String sql;

                sql = "update T_user set "
                        + " FIRST_NAME ='"+fname+"',"
                        + " LAST_NAME ='"+lname+"',"
                        + " GROUP_ID ='"+groupUser+"',"
                        + " LEVEL_ID ='"+levelUser+"',"
                        + " IP_ADDRESS ='"+ip+"',"
                        + " EMAIL ='"+email+"'"
                        + " where ID="+objid;
                
                //out.println(sql);
                db.executeUpdate(sql);

                out.println("<div class=info>Update User " + username + " Success<br></div>");
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

%>
  
    
<script type="text/javascript">
    $('#loading_inner').show();
    

    filter_username= document.getElementById("filter_username").value;
    filter_status= document.getElementById("filter_status").value;
    
    $.ajax({
        type: 'POST',
        url: "administration/user_management/user_list_data.jsp",
        data: {objid:<%=objid%>,filter_username:filter_username,filter_status:filter_status},
        success: function(data) {
            $("#data_inner").empty();
            $('#data_inner').html(data);
            $("#data_inner").show();
            $("#status_msg").delay(3000).hide(400);
                  
        },
        complete: function(){
            $('#loading_inner').hide();
            
        }
    })
    
</script>
