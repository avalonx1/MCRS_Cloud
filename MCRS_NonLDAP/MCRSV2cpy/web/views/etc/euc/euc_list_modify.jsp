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
 
 String euc_name="";
 String euc_desc="";
 String euc_purpose="";
 String euc_type="";
 String euc_status="";
 String euc_userpic="";
 String euc_dev_cat="";
 String euc_dev_info="";
 String euc_dev_start="";
 String euc_dev_end="";
 String euc_enduser ="";
 
 
 
               
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
                                
                              sql = "select id,euc_name,euc_desc,euc_purpose,euc_type,euc_status,euc_userpic,euc_dev_cat,euc_dev_info,euc_dev_start,euc_dev_end,euc_enduser "
                              + " from v_euc "
                              + "  where id="+id;
                                   
         
                          
                          //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                        
                        
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                euc_name = resultSet.getString("euc_name");
                                euc_desc = resultSet.getString("euc_desc");
                                euc_purpose = resultSet.getString("euc_purpose");
                                euc_type = resultSet.getString("euc_type");                                
                                euc_status=resultSet.getString("euc_status");   
                                euc_userpic=resultSet.getString("euc_userpic");   
                                euc_dev_cat=resultSet.getString("euc_dev_cat");   
                                euc_dev_info=resultSet.getString("euc_dev_info");   
                                euc_dev_start=resultSet.getString("euc_dev_start");   
                                euc_dev_end=resultSet.getString("euc_dev_end");   
                                euc_enduser =resultSet.getString("euc_enduser");   
 
 
 
                                
                               
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
    <td>EUC Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="euc_name" name="euc_name" size="60" maxlength="100" value="<% out.println((euc_name == null) ? "" : euc_name); %>"  /></td>
    </tr>
    
    <tr>
    <td>EUC Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="euc_desc" name="euc_desc"  rows="5" cols="50" maxlength="4000"><% out.println((euc_desc == null) ? "" : euc_desc); %></textarea>
    </tr>
    
    <tr>
    <td>EUC Purpose</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="euc_purpose" name="euc_purpose"  rows="5" cols="50" maxlength="4000"><% out.println((euc_purpose == null) ? "" : euc_purpose); %></textarea>
    </tr>
    
    
    <tr>
    <td width="100" align="left">Type</td>
    <td></td>
    <td width="100" align="left"><select id="euc_type" name="euc_type">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||t_code||'] - '||t_name AS DESC "
                                                    + " FROM t_euc_type  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (euc_type.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Status</td>
    <td></td>
    <td width="100" align="left"><select id="euc_status" name="euc_status">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||t_code||'] - '||t_name AS DESC "
                                                    + " FROM t_euc_status  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (euc_status.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">User PIC</td>
    <td></td>
    <td width="100" align="left"><select id="euc_userpic" name="euc_userpic">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, case when first_name is null then 'N/A' else first_name||' '||last_name end||' ('||username||')' AS DESC, case when first_name is null then 2 else 1 end AS INORDER "
                                                    + " FROM t_user where flag=1 "
                                                    + "  ORDER BY INORDER,2 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (euc_userpic.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Development Category</td>
    <td></td>
    <td width="100" align="left"><select id="euc_dev_cat" name="euc_dev_cat">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||t_code||'] - '||t_name AS DESC "
                                                    + " FROM t_euc_devcat  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (euc_dev_cat.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td>Development Info/<br>Vendor Info/<br>Developer Name</td>
    <td></td>
    <td><textarea class="notes_info" id="euc_dev_info" name="euc_dev_info"  rows="5" cols="50" maxlength="4000"><% out.println((euc_dev_info == null) ? "" : euc_dev_info); %></textarea>
    </tr>
    
     <tr>
    <td>Development Start Time </td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="euc_dev_start" name="euc_dev_start"  size="20" maxlength="10" value="<% out.println((euc_dev_start == null) ? "" : euc_dev_start); %>"  /></div></td>
    </tr>
    
     <tr>
    <td>Development End Time</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="euc_dev_end" name="euc_dev_end"  size="20" maxlength="10" value="<% out.println((euc_dev_end == null) ? "" : euc_dev_end); %>"  /></div></td>
    </tr>
    
    <tr>
    <td>End User List </td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="euc_enduser" name="euc_enduser"  rows="5" cols="50" maxlength="4000"><% out.println((euc_enduser == null) ? "" : euc_enduser); %></textarea>
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

    
    
     $('#euc_dev_start').datetimepicker({
                     dateFormat: 'yy-mm-dd',
                     timeFormat: 'hh:mm',
                     buttonImage: '../images/date.png',
                     buttonImageOnly: true,
                     showOn:'button',
                     buttonText: 'Click to show the calendar'
                });
                
                
        $('#euc_dev_end').datetimepicker({
                     dateFormat: 'yy-mm-dd',
                     timeFormat: 'hh:mm',
                     buttonImage: '../images/date.png',
                     buttonImageOnly: true,
                     showOn:'button',
                     buttonText: 'Click to show the calendar'
                });
                
                
    
               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "etc/euc/euc_list_data.jsp",
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
            url: "etc/euc/euc_list_modify_process.jsp",
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

