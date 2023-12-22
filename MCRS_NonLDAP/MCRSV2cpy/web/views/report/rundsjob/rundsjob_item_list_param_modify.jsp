<%@include file="../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 
  
 if (action.equals("1")) {
     actionCode="QA";
 }else {
     actionCode="USER";
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
 
 header_title_act="Add Parameter Report "+actionCode+" version";

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
     
                      
                      String etljob_run="";
                      
                      
                      if (action.equals("1")) {
                          etljob_run=etljob_runqa;
                      }else {
                          etljob_run=etljob_runusr;
                      }
                              
 
%>
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#">
    <input type="hidden" id="id" name="id" value="<%=id%>" />
     <input type="hidden" id="RunType" name="RunType" value="<%=action%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> </h1>
        <p></p>
     <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
    <tr>
    <td>Job Code</td>
    <td><div class="markMandatory"></div></td>
    <td><input axis="readonly" class="input-readonly" type="text" readonly="true" id="job_code" name="job_code" size="20" maxlength="30" value="<% out.println((job_code == null) ? "" : job_code); %>"  /></td>
    </tr>    
        
    <tr>
    <td>Job Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input axis="readonly" type="text" readonly="true" id="job_name" name="job_name" size="50" maxlength="100" value="<% out.println((job_name == null) ? "" : job_name); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>ETL Job Script </td>
    <td><div class="markMandatory">*</div></td>
    <td><input axis="readonly" type="text" readonly="true" id="etljob_run" name="etljob_run" size="100" maxlength="150" value="<% out.println((etljob_run == null) ? "" : etljob_run); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>Parameter</td>
    <td><div class="markMandatory">*</div></td>
    <td><input axis="textmiring" type="text" id="etljob_param" name="etljob_param" size="100" maxlength="150" placeholder="<% out.println((etljob_param_desc == null) ? "" : etljob_param_desc); %>" /></td>
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
            url: "report/rundsjob/rundsjob_item_list_param_modify_process.jsp",
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

