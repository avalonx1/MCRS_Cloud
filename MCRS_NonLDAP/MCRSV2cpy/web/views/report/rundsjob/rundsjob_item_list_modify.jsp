<%@include file="../../../includes/check_auth_layer3.jsp"%>

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
 
 String job_code="";
 String job_name="";
 String job_desc="";
 String groupid="";
 String etljob_param_desc="";
 String etljob_runqa="";
 String etljob_runusr="";
 
 
 
               
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
                                
                             sql = "select id,job_code, job_name, job_desc, groupid,etljob_runqa,etljob_runusr,etljob_param_desc " 
                                +" from t_rundsjob_item where id="+id;

         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                job_code = resultSet.getString("job_code");
                                job_name = resultSet.getString("job_name");
                                job_desc = resultSet.getString("job_desc");
                                groupid = resultSet.getString("groupid");
                                etljob_runqa = resultSet.getString("etljob_runqa");
                                etljob_runusr = resultSet.getString("etljob_runusr");
                                etljob_param_desc = resultSet.getString("etljob_param_desc");
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
    <td>Job Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="job_code" name="job_code" size="20" maxlength="30" value="<% out.println((job_code == null) ? "" : job_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Job Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="job_name" name="job_name" size="50" maxlength="100" value="<% out.println((job_name == null) ? "" : job_name); %>"  /></td>
    
    </tr>
    
    
    <tr>
    <td>Job Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="job_desc" name="job_desc"  rows="10" cols="50" maxlength="4000"><% out.println((job_desc == null) ? "" : job_desc); %></textarea>
    
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
    <td>Param Descritpion</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="etljob_param_desc" name="etljob_param_desc" size="100" maxlength="150" value="<% out.println((etljob_param_desc == null) ? "" : etljob_param_desc); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>ETL Job Run QA</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="etljob_runqa" name="etljob_runqa" size="100" maxlength="150" value="<% out.println((etljob_runqa == null) ? "" : etljob_runqa); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>ETL Job Run User</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="etljob_runusr" name="etljob_runusr" size="100" maxlength="150" value="<% out.println((etljob_runusr == null) ? "" : etljob_runusr); %>"  /></td>
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
                            url: "report/rundsjob/rundsjob_item_list_data.jsp",
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
            url: "report/rundsjob/rundsjob_item_list_modify_process.jsp",
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

