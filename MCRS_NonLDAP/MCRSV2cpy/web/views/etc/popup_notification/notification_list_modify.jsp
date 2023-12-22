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
 
 String notif_code="";
 String notif_title="";
 String notif_desc="";
 String image_file="";
 String img_width="";
 String img_height="";
 String stat_swfntf="";
 
               
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
                                
                            sql = "SELECT id,notif_code,notif_title,notif_desc,image_file,img_width,img_height,stat_swfntf "
                                 +" from t_popup_notif where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                notif_code = resultSet.getString("notif_code");
                                notif_title = resultSet.getString("notif_title");
                                notif_desc = resultSet.getString("notif_desc");
                                image_file =  resultSet.getString("image_file");
                                img_width =  resultSet.getString("img_width");
                                img_height =  resultSet.getString("img_height");
                                stat_swfntf =  resultSet.getString("stat_swfntf");
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
    <td>Notif Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="notif_code" name="notif_code" size="50" maxlength="50" value="<% out.println((notif_code == null) ? "" : notif_code); %>"  /></td>
    </tr>
    
      <tr>
    <td>Notif Title</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="notif_title" name="notif_title" size="50" maxlength="100" value="<% out.println((notif_title == null) ? "" : notif_title); %>"  /></td>
    </tr>
    
      <tr>
    <td>Notif Description</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="notif_desc" name="notif_desc"  rows="10" cols="50" maxlength="4000"><% out.println((notif_desc == null) ? "" : notif_desc); %></textarea>
    </tr>    
      <tr>
    <td>Image Filename</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="image_file" name="image_file" size="80" maxlength="150" value="<% out.println((image_file == null) ? "" : image_file); %>"  /></td>
    </tr>
    
    
      <tr>
    <td>Size - Width</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="img_width" name="img_width" size="30" maxlength="10" value="<% out.println((img_width == null) ? "" : img_width); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Size - Height</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="img_height" name="img_height" size="30" maxlength="10" value="<% out.println((img_height == null) ? "" : img_height); %>"  /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">SWF Notif Status</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="stat_swfntf" name="stat_swfntf">
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
                                                if (stat_swfntf.equalsIgnoreCase(resultSet.getString(1))) {
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

    
    
               $('#back').click(function() {
                   
                       filter_itemname= document.getElementById("filter_itemname").value;
                    
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "etc/popup_notification/notification_list_data.jsp",
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
            url: "etc/popup_notification/notification_list_modify_process.jsp",
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

