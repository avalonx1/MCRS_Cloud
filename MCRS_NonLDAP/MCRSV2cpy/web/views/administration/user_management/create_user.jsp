<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%
           int i = 0;
   
    %>

    
<form id="modifyForm" method="post" action="#">   
       
<div id="stylized" class="myform">
<h1>Create User form</h1>
        <p></p>
         <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
       
    <tr>
    <td>Username</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="username" name="username" size="30" maxlength="50" /></td>
    </tr>
    
        
    
    <tr>
    <td>Password</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="password" id="password" name="password" size="30" maxlength="50" /></td>
    </tr>
    
    <tr>
    <td>First Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="fname" name="fname" size="30" maxlength="50" /></td>
    </tr>
    
    <tr>
    <td>Last Name</td>
    <td></td>
    <td><input type="text" id="lname" name="lname" size="30" maxlength="50" /></td>
    </tr>

    <tr>
    <td>Employee ID</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="empid" name="empid" size="30" maxlength="15" /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Group</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="groupUser" name="groupUser">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||group_code||'] - '||group_name AS DESC "
                                                    + " FROM t_user_group  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                            }
                                            resultSet.close();
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
    </select></td>
  </tr>
  
  <tr>
    <td width="100" align="left">Level</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="levelUser" name="levelUser">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||level_code||'] - '||level_name AS DESC "
                                                    + " FROM t_user_level  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                            }
                                            resultSet.close();
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
    </select></td>
  </tr>
  
     <tr>
    <td>IP Address</td>
    <td></td>
    <td><input type="text" id="ip" name="ip" size="30" maxlength="20" /></td>
    </tr>
    
    <tr>
    <td>Email</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="email" name="email" size="30" maxlength="50" /></td>
    </tr>
    
    
      
 
       </table></td></tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left"> <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>
                    
    </div>
</form>
    
    
<script type="text/javascript">
    
    var widthform = $(".myform").css("width");
    var widthfill=widthform.substr(0, widthform.length-2)-300;
    //alert(widthfill);
    
    $("#stylized input").css("width",widthfill);   
    $("#stylized select").css("width",widthfill);    
    $("#stylized textarea").css("width",widthfill);    
        
    $('#modifyForm').submit(function(){
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/create_user_proses.jsp",
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

