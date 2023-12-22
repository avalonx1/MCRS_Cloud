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
 
 String db_name="";
 String db_username="";
 String pic_nik_1="";
 String pic_name_1="";
 String pic_email_1="";
 String pic_nik_2="";
 String pic_name_2="";
 String pic_email_2="";
 String is_4eyes="N";
 String tujuan_akses="";
 
 
               
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
                                
                            sql = "SELECT id,db_name,db_username,is_4eyes,pic_nik_1,pic_name_1,pic_email_1,pic_nik_2,pic_name_2,pic_email_2,tujuan_akses "
                                 +" from t_dwh_dbmgmt_user_pic where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                db_name = resultSet.getString("db_name");
                                db_username = resultSet.getString("db_username");
                                is_4eyes = resultSet.getString("is_4eyes");
                                pic_nik_1 = resultSet.getString("pic_nik_1");
                                pic_name_1 = resultSet.getString("pic_name_1");
                                pic_email_1 = resultSet.getString("pic_email_1");
                                pic_nik_2 = resultSet.getString("pic_nik_2");
                                pic_name_2 = resultSet.getString("pic_name_2");
                                pic_email_2 = resultSet.getString("pic_email_2");
                                tujuan_akses = resultSet.getString("tujuan_akses");
                               
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
    <td>DB Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="db_name" name="db_name" size="50" maxlength="150" value="<% out.println((db_name == null) ? "" : db_name); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>DB Username</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="db_username" name="db_username" size="30" maxlength="50" value="<% out.println((db_username == null) ? "" : db_username); %>"  /></td>
    </tr>
    

    <tr>
    <td width="100" align="left">2 Person Auth</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left" axis="radio"><div class="radioborder"> <table>
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 'Y' ID, ' Yes' AS DESC,1 AS ORD UNION ALL SELECT 'N' ID, ' No' AS DESC,2 AS ORD ORDER BY 3,2";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (is_4eyes.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<tr><td width='15px' ><input type='radio' id='is_4eyes_"+resultSet.getString(1)+"' name='is_4eyes' value=" + resultSet.getString(1) + " checked='checked'></td><td width='50px'>  " + resultSet.getString(2) + "</td></tr>");
                                                } else {
                                                    out.println("<tr><td width='15px'><input type='radio' id='is_4eyes_"+resultSet.getString(1)+"'' name='is_4eyes' value=" + resultSet.getString(1) + " ></td><td width='50px'>  " + resultSet.getString(2) + "</td></tr> ");
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
    </table></div></td>
  </tr>
  
    <tr>
    <td>PIC NIK 1</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_nik_1" name="pic_nik_1" size="30" maxlength="150" value="<% out.println((pic_nik_1 == null) ? "" : pic_nik_1); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>PIC Name 1</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_name_1" name="pic_name_1" size="30" maxlength="150" value="<% out.println((pic_name_1 == null) ? "" : pic_name_1); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>PIC Email 1</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_email_1" name="pic_email_1" size="30" maxlength="150" value="<% out.println((pic_email_1 == null) ? "" : pic_email_1); %>"  /></td>
    </tr>
    
    <tr class="PIC2SECTION"><td colspan="3"> -----------------------------------------------------  </td></tr>
    <tr class="PIC2SECTION">
    <td colspan="3" >Please input PIC 2 Info For 2 Person Authentication </td>
    </tr>
    
    <tr class="PIC2SECTION">
    <td>PIC NIK 2</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_nik_2" name="pic_nik_2" size="30" maxlength="150" value="<% out.println((pic_nik_2 == null) ? "" : pic_nik_2); %>"  /></td>
    </tr>
    
    <tr class="PIC2SECTION">
    <td>PIC Name 2</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_name_2" name="pic_name_2" size="30" maxlength="150" value="<% out.println((pic_name_2 == null) ? "" : pic_name_2); %>"  /></td>
    </tr>
    
    
    
    <tr class="PIC2SECTION">
    <td>PIC Email 2</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="pic_email_2" name="pic_email_2" size="30" maxlength="150" value="<% out.println((pic_email_2 == null) ? "" : pic_email_2); %>"  /></td>
    </tr>
    
    
    </div>
    
    
    <tr>
    <td>Tujuan Akses</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="tujuan_akses" name="tujuan_akses"  rows="10" cols="50" maxlength="4000"><% out.println((tujuan_akses == null) ? "" : tujuan_akses); %></textarea>
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

  $(document).ready(function() {
      

    $(".PIC2SECTION").hide();

    $("input[type=radio][name='is_4eyes']").change(function() {
      if (this.value == 'Y') {
            $(".PIC2SECTION").fadeIn(500);
        }
        else if (this.value == 'N') {
            $(".PIC2SECTION").fadeOut(200)();
        }
    });
        
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
                     
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_data.jsp",
                            data: {filter_itemname:filter_itemname},
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
            url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_modify_process.jsp",
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

});

</script>

