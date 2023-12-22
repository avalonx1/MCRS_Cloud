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
 
 String reff_code="";
 String reff_name="";
 String reff_desc="";
 String groupid="";
 String file_format="";
 String flag_start_pos="";
 String flag_stop_pos="";
 String etljob_name="";
 
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     

                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                             sql = "select id,reff_code, reff_name, reff_desc, groupid,flag_start_pos,flag_stop_pos,file_format,etljob_name " 
                                +" from t_dwhreff_item where id="+id;

         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                reff_code = resultSet.getString("reff_code");
                                reff_name = resultSet.getString("reff_name");
                                reff_desc = resultSet.getString("reff_desc");
                                groupid = resultSet.getString("groupid");
                                file_format = resultSet.getString("file_format");
                                flag_start_pos = resultSet.getString("flag_start_pos");
                                flag_stop_pos = resultSet.getString("flag_stop_pos");
                                etljob_name = resultSet.getString("etljob_name");
                               
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
    <td>Reff Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="reff_code" name="reff_code" size="20" maxlength="30" value="<% out.println((reff_code == null) ? "" : reff_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Reff Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="reff_name" name="reff_name" size="50" maxlength="100" value="<% out.println((reff_name == null) ? "" : reff_name); %>"  /></td>
    
    </tr>
    
    
    <tr>
    <td>Reff Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="reff_desc" name="reff_desc"  rows="10" cols="50" maxlength="4000"><% out.println((reff_desc == null) ? "" : reff_desc); %></textarea>
    
    </tr>
    
    <tr>
    <td>File Format Info</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="file_format" name="file_format" size="50" maxlength="150" value="<% out.println((file_format == null) ? "" : file_format); %>"  /></td>
    </tr>
    
    
    
    <td width="100" align="left">Group</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="groupid" name="groupid">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                           sql = "SELECT * from ( SELECT id ID,group_code||' - '||group_name AS DESC, 2 ORD,branch_flag "
                                                    + " FROM t_user_group where branch_flag<>1 ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (groupid.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
    <td>Flag Start Position</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="flag_start_pos" name="flag_start_pos" size="10" maxlength="5" value="<% out.println((flag_start_pos == null) ? "" : flag_start_pos); %>"  /></td>
    </tr>
    
    <tr>
    <td>Flag Stop Position</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="flag_stop_pos" name="flag_stop_pos" size="10" maxlength="5" value="<% out.println((flag_stop_pos == null) ? "" : flag_stop_pos); %>"  /></td>
    </tr>
    
     <tr>
    <td>ETL Job Name</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="etljob_name" name="etljob_name" size="100" maxlength="200" value="<% out.println((etljob_name == null) ? "" : etljob_name); %>"  /></td>
    </tr>
    
    
</table></td>  
            </tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left">
                    <p></p>
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
                        filter_groupid= document.getElementById("filter_groupid").value;
                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/dwhreff/reff_item/reff_item_list_data.jsp",
                            data: {filter_itemname:filter_itemname,filter_groupid:filter_groupid},
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
            url: "report/dwhreff/reff_item/reff_item_list_modify_process.jsp",
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

