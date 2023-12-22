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
 
 String name="";
 String value="";
 
               
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
                                
                            sql = "SELECT id,name, value "
                                 +" from t_param where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                name = resultSet.getString("name");
                                value = resultSet.getString("value");
                                
                               
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
    <td>Nama</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="name" name="name" size="40" maxlength="100" value="<% out.println((name == null) ? "" : name); %>"  /></td>
    
    </tr>
    <tr>
    <td>Value</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="value" name="value" size="80" maxlength="200" value="<% out.println((value == null) ? "" : value); %>"  /></td>
    
    </tr>
</table></td>  
            </tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            <tr><td> <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">

   
    $(".datePicker").datepicker({
        dateFormat: 'yy/mm/dd'
    });

    $(".monthPicker").datepicker({
        dateFormat: 'yy/mm',
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        onClose: function (dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).val($.datepicker.formatDate('yy/mm', new Date(year, month, 1)));
        }
    });

    $(".monthPicker").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });



   // $('#persenImbalan').priceFormat({prefix: '', centsSeparator: '.', thousandsSeparator: ','});
    //$('#jumlah').priceFormat({prefix: '', centsSeparator: '.', thousandsSeparator: ','});
    
    //hidealll lable desc
   // $('.formdesclabel').hide();

   /// $('#persenImbalan').on("click", function () {
    //    $('.formdesclabel').hide();
    //    $('#NotifPersenImbalan').show();
   // });
    
   // $('#jumlah').on("click", function () {
   //     $('.formdesclabel').hide();
   //     $('#NotifJumlah').show();
   // });
    
               $('#back').click(function() {
                   
                   filter_itemname= document.getElementById("filter_itemname").value;
                   
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/app_parameter/app_param_list_data.jsp",
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
            url: "administration/app_parameter/app_param_list_modify_process.jsp",
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

