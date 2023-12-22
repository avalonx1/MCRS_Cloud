<%@include file="../../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 String tableName="t_report_group";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="0";
 
 String group_code="";
 String group_name="";
 String group_description="";
 String record_stat="";
 
 
 
 
               
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
                                
                            sql = "SELECT id,group_code,group_name,group_description,record_stat "
                                 +" from "+tableName+" where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                group_code = resultSet.getString("group_code");
                                group_name = resultSet.getString("group_name");
                                group_description = resultSet.getString("group_description");
                                record_stat = resultSet.getString("record_stat");
                                
                                
                               
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
    <td>Group Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="group_code" name="group_code" size="30" maxlength="30" value="<% out.println((group_code == null) ? "" : group_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Group Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="group_name" name="group_name" size="30" maxlength="100" value="<% out.println((group_name == null) ? "" : group_name); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>Group Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="group_description" name="group_description"  rows="10" cols="50" maxlength="4000"><% out.println((group_description == null) ? "" : group_description); %></textarea>
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
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/report_group/report_group_list_data.jsp",
                            data: "",
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
            url: "administration/report_management/report_group/report_group_list_modify_process.jsp",
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

