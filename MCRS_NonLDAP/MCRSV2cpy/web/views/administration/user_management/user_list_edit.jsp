<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%
    String objid  = request.getParameter("objid");
    String USERNAME = "";
    String FIRST_NAME="";
    String LAST_NAME ="";
    String EMP_ID="";
    String IP_ADDRESS="";
    String GROUP_ID="";
    String LEVEL_ID="";
    String EMAIL="";
    String FLAG="";
    
    
               
                    try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                            sql = "select ID, USERNAME, FIRST_NAME, LAST_NAME, EMP_ID, IP_ADDRESS, "
                                    + "GROUP_ID, LEVEL_ID, EMAIL,FLAG "
                                    + "from T_USER where id=" + objid;
         
                            //out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                USERNAME = resultSet.getString("USERNAME");
                                FIRST_NAME = resultSet.getString("FIRST_NAME");
                                LAST_NAME = resultSet.getString("LAST_NAME");
                                EMP_ID = resultSet.getString("EMP_ID");
                                IP_ADDRESS= resultSet.getString("IP_ADDRESS");
                                GROUP_ID= resultSet.getString("GROUP_ID");
                                LEVEL_ID= resultSet.getString("LEVEL_ID");
                                EMAIL= resultSet.getString("EMAIL");
                                FLAG= resultSet.getString("FLAG");
                                
                                
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
    
    
%>
<div id="stylized" class="myform">
    <form class="cmenu" id="updateUserForm" method="post" action="#">

        <h1>Edit User form</h1>
        <p></p>
        <label>First Name
            <span class="small">Add your first name</span>
        </label>
        <input type="hidden" name="id" value="<%=objid%>" />
        <input type="hidden" name="username" value="<%=USERNAME%>" />
        <input type="text"  name="fname" maxlength="50" value="<% out.println((FIRST_NAME == null) ? "" : FIRST_NAME); %>" />
        <label>Last Name
            <span class="small">Add your last name</span>
        </label>
        <input type="text"  name="lname" maxlength="50" value="<% out.println((LAST_NAME == null) ? "" : LAST_NAME); %>"/>
        <label>User Group
            <span class="small">Add your user group</span>
        </label>
        <select id="groupUser" name="groupUser">

            <%
                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,GROUP_NAME FROM T_USER_GROUP ORDER BY ID";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            if (GROUP_ID.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                            
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
            %>

        </select>
        <label>User level
            <span class="small">Add your user level</span>
        </label>
        <select id="levelUser" name="levelUser">

            <%
                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,LEVEL_NAME FROM T_USER_LEVEL ORDER BY ID";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            if (LEVEL_ID.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                            
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
            %>

        </select>
        <label>IP Address
            <span class="small">Add a valid IP Address</span>
        </label>
        <input type="text" name="ip"  maxlength="20" value="<% out.println((IP_ADDRESS == null) ? "" : IP_ADDRESS); %>"/>

        <label>Email
            <span class="small">Add a valid Email address</span>
        </label>
        <input type="text" name="email"  maxlength="50" value="<% out.println((EMAIL == null) ? "" : EMAIL); %>"/>

        <span class="small">*) mandatory</span>
        <button type="submit">Submit</button>
        <div class="spacer"></div>
        <!--<button type="reset">Reset</button> -->
         <div class="spacer_form"></div>

    </form>
</div>
            
            

<script type="text/javascript">

    var widthform = $(".myform").css("width");
    var widthfill=widthform.substr(0, widthform.length-2)-300;
    //alert(widthfill);
    
    $("#stylized input").css("width",widthfill);   
    $("#stylized select").css("width",widthfill);    
    $("#stylized textarea").css("width",widthfill); 
    
            
      
    $('#updateUserForm').submit(function(){
        
        //alert('hai canrik');
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/user_list_edit_process.jsp",
            data: $(this).serialize(),
            success: function(data) {
                $("#status_msg").empty();
                $("#status_msg").html(data);
                $("#status_msg").show();
            },
            complete: function(){
                $('#loading').hide();
            }
                        
        });
        return false;
    });

    
</script>
