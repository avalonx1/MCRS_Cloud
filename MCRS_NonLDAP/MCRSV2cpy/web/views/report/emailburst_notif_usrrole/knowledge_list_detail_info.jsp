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
 
 String t_name="";
 String t_desc="";
 String t_status="";
 String t_script="";
 
 
 
     id  = request.getParameter("id");
     
    
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                              sql = "select id,t_name,t_desc,t_status,t_script,"
                                      + "maker_userid,maker_nik,maker_user_fullname,maker_dt_stamp,"
                                      + "modified_userid,modified_nik,modified_user_fullname,modified_dt_stamp "
                              + " from v_knowledge_bank "
                              + "  where id="+id;
                                   
         
                          
                          //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                        
                        
                            resultSet = db.executeQuery(sql);
                           // String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                t_name = resultSet.getString("t_name");
                                t_desc = resultSet.getString("t_desc");
                                t_status = resultSet.getString("t_status");
                                t_script = resultSet.getString("t_script");                                
                                
  
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
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> Record </h1>
        <p></p>
   <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
   
    <tr>
    <td>Knowledge Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" readonly="true" id="t_name" name="t_name" size="60" maxlength="100" value="<% out.println((t_name == null) ? "" : t_name); %>"  /></td>
    </tr>
    
    <tr>
    <td>Knowledge Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" readonly="true" id="t_desc" name="t_desc"  rows="5" cols="50" ><% out.println((t_desc == null) ? "" : t_desc); %></textarea>
    </tr>
    
    <tr>
    <td>Knowledge Script</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" readonly="true" id="t_script" name="t_script"  rows="40" cols="100" ><% out.println((t_script == null) ? "" : t_script); %></textarea>
    </tr>
 
    
    <tr>
    <td width="100" align="left">Status</td>
    <td></td>
    <td width="100" align="left"><select readonly="true" id="t_status" name="t_status">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            if (t_status.equals("1")) {
                                            sql = "SELECT 1 AS ID, 'Draft' AS DESCR ";
                                            } else {
                                                sql = "SELECT 2 AS ID, 'Final' AS DESCR";
                                            }        
                                            
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (t_status.equalsIgnoreCase(resultSet.getString(1))) {
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

<script type="text/javascript">

    
    
               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/knowledge_bank/knowledge_list_data.jsp",
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
             
             


</script>

