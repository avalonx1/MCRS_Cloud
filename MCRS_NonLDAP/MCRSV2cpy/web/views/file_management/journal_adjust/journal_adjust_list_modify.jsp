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
 
 String journal_name="";
 String journal_desc="";
 String reverse_flag="";
 String trn_dt="";
 String adj_flag="";
 
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Add Additional Information";
     id  = request.getParameter("id");
     
     

 
     String denom="999,999,999,999,999.99";
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                            sql = "SELECT id,journal_name,journal_desc,reverse_flag,trn_dt,'FASD' AS adj_flag "
                                 +" from v_journal_adjust_file where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                journal_name = resultSet.getString("journal_name");
                                journal_desc = resultSet.getString("journal_desc");
                                reverse_flag = resultSet.getString("reverse_flag");
                                adj_flag = resultSet.getString("adj_flag");
                                trn_dt = resultSet.getString("trn_dt");
                                
                                
                               
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
    <td>Journal Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="journal_name" name="journal_name" size="30" maxlength="50" value="<% out.println((journal_name == null) ? "" : journal_name); %>"  /></td>
    </tr>
    
        
     <tr>
    <td>Journal Desc</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="journal_desc" name="journal_desc"  rows="10" cols="50" maxlength="200"><% out.println((journal_desc == null) ? "" : journal_desc); %></textarea>
    </tr>
    
    
    <tr>
    <td>Transaction date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="trn_dt" name="trn_dt"  size="30" maxlength="10" value="<% out.println((trn_dt == null) ? "" : trn_dt); %>"  /></div></td>
    </tr>
    
     <tr>
    <td width="100" align="left">Adj Flag</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="adj_flag" name="adj_flag">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 'PSAK' AS ID, '-PSAK-' AS DESC, 1 AS ORD UNION ALL SELECT 'FASD' AS ID, '-FASD-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (adj_flag.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Reverse Flag</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="reverse_flag" name="reverse_flag">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 AS ID, '-Yes-' AS DESC, 1 AS ORD UNION ALL SELECT 0 AS ID, '-No-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (reverse_flag.equalsIgnoreCase(resultSet.getString(1))) {
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
</form>

<script type="text/javascript">

      $('#trn_dt').datepicker({
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
                            url: "file_management/journal_adjust/journal_adjust_list_data.jsp",
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
            url: "file_management/journal_adjust/journal_adjust_list_modify_process.jsp",
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

