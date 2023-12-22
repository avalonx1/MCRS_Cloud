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
 
 String file_extension="";
 String case_sensitive="";
 String tag_code="";

 
 
 
 
               
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
                                
                              sql = "select a.id,a.file_extension, case when a.case_sensitive=1 then 'Yes' else 'No' end case_sensitive, tag_code "
                              + " from t_file_extension a  "
                              + "  where a.id="+id;
                                   
         
                          
                          //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                        
                        
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                file_extension = resultSet.getString("file_extension");
                                case_sensitive = resultSet.getString("case_sensitive");
                                tag_code = resultSet.getString("tag_code");
                                
                                
                                
                               
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
    <td>File Ext</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="file_extension" name="file_extension" size="10" maxlength="10" value="<% out.println((file_extension == null) ? "" : file_extension); %>"  /></td>
    
    </tr>
    
        
    
    
    
    <tr>
    <td width="100" align="left">Case Sensitive</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="case_sensitive" name="case_sensitive">
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
                                                if (case_sensitive.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td>Tag Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="tag_code" name="tag_code" size="30" maxlength="100" value="<% out.println((tag_code == null) ? "" : tag_code); %>"  /></td>
    
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
                            url: "file_management/extension/ext_list_data.jsp",
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
            url: "file_management/extension/ext_list_modify_process.jsp",
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

