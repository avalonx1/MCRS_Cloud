<%@include file="../../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="0";
 
 String level_code="";
 String level_name="";
 String level_description="";
 String document_pathkey="";
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     

 
     String denom="999,999,999,999,999.99";
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                            sql = "SELECT id,level_code,level_name,level_description,document_pathkey "
                                 +" from t_user_level where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                level_code = resultSet.getString("level_code");
                                level_name = resultSet.getString("level_name");
                                level_description = resultSet.getString("level_description");
                                document_pathkey =  resultSet.getString("document_pathkey");
                                
                               
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
     
     
 }
 
%>
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#">
    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> Record </h1>
        <p></p>
   <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
   
    <tr>
    <td>Level Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="level_code" name="level_code" size="30" maxlength="30" value="<% out.println((level_code == null) ? "" : level_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Level Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="level_name" name="level_name" size="30" maxlength="100" value="<% out.println((level_name == null) ? "" : level_name); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>Level Desc</td>
    <td><div class="markMandatory"></div></td>
    <td><textarea class="notes_info" id="level_description" name="level_description"  rows="10" cols="50" maxlength="4000"><% out.println((level_description == null) ? "" : level_description); %></textarea>
    </tr>
    
    <tr>
    <td>Document Path Key</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="document_pathkey" name="document_pathkey" size="30" maxlength="50" value="<% out.println((document_pathkey == null) ? "" : document_pathkey); %>"  /></td>
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

    
    
               $('#back').click(function() {
                   
                        filter_itemname= document.getElementById("filter_itemname").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                         $.ajax({
                            type: 'POST',
                            url: "administration/user_management/user_level/user_level_list_data.jsp",
                             data: {id:<%=id%>,
                                filter_itemname:filter_itemname
                            },
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });  
                           
             });
             
             
    $('#modifyForm').submit(function () {
        $("#status_msg").empty();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/user_level/user_level_list_modify_process.jsp",
            data: $(this).serialize(),
            success: function (data) {

                $("#status_msg").empty();
                $("#status_msg").html(data);
                $("#status_msg").show();
            },
            complete: function () {
                $('#loading').hide();
            }
        });
        return false;
    });


</script>

