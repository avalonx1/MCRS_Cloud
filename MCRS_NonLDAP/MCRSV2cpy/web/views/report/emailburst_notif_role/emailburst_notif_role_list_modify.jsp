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
 
 String t_code="";
 String t_name="";
 String t_desc="";
 String inorder="0";
 
 
 
               
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
                                
                            sql = "SELECT id,t_code,t_name,t_desc,inorder "
                                 +" from t_notif_role where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                t_code = resultSet.getString("t_code");
                                t_name = resultSet.getString("t_name");
                                t_desc = resultSet.getString("t_desc");
                                inorder = resultSet.getString("inorder");
                             
                                
                               
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
    <td>Role Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="t_code" name="t_code" size="30" maxlength="30" value="<% out.println((t_code == null) ? "" : t_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Role Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="t_name" name="t_name" size="30" maxlength="100" value="<% out.println((t_name == null) ? "" : t_name); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>Role Desc</td>
    <td><div class="markMandatory"></div></td>
    <td><textarea class="notes_info" id="t_desc" name="t_desc"  rows="10" cols="50" maxlength="4000"><% out.println((t_desc == null) ? "" : t_desc); %></textarea>
    </tr>
    
     
    <tr>
    <td>Order Number</td>
    <td><div class="markMandatory">*</div></td>
     <td><input type="text" class="number" d="inorder" name="inorder" size="10" maxlength="100" value="<% out.println((inorder == null) ? "" : inorder); %>"  /></td>
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




  $("input.number").keydown(function (e) {
                    // Allow: backspace, delete, tab, escape, enter and .
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                         // Allow: Ctrl+A, Command+A
                        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
                         // Allow: home, end, left, right, down, up
                        (e.keyCode >= 35 && e.keyCode <= 40)) {
                             // let it happen, don't do anything
                             return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });
    
       $('input.numberwithseparator').keyup(function(event) {

                    // skip for arrow keys
                    if(event.which >= 37 && event.which <= 40) return;

                    // format number
                    $(this).val(function(index, value) {
                      return value
                      .replace(/\D/g, "")
                      .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                      ;
                    });
                  });
                  
    
    
               $('#back').click(function() {
                   
                        filter_itemname= document.getElementById("filter_itemname").value;   
                     filter_status= document.getElementById("filter_status").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/emailburst_notif_role/emailburst_notif_role_list_data.jsp",
                            data: {filter_itemname:filter_itemname,filter_status:filter_status},
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
            url: "report/emailburst_notif_role/emailburst_notif_role_list_modify_process.jsp",
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

