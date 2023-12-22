<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
      String action_status = request.getParameter("action_status");
 
         if (action_status==null) {
             action_status="1";
         }    
%>
<div  class="myformfilter">
    <form  id="action_form" method="post" action="#">

        <table border="0">
            <tr><th colspan="4">Bulk Action </th></tr>
            
            <tr><td width="80px" >Set Status to </td><td width="150px">:
            <select id="action_status" name="action_status">

            <%
              
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,T_NAME FROM t_actstatus where id<>1 ORDER BY inorder";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            
                            if (action_status != null) {
                                    if (action_status.equalsIgnoreCase(resultSet.getString(1))) {
                                        out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                    } else {
                                        out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                    }
                                } else {
                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                }
                            
                          
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

        </select>
           </td><td width="100px" colspan="2"> 
               <div id="slatime_show" >Complete Time * :<input readonly="true" id="action_send_time" name="action_send_time" type="text" /></div>
            </td></tr>
            <tr><td>Notes *</td><td colspan="3">:
                    <textarea class="notes_info" id="action_notes" name="action_notes" rows="4" cols="50" maxlength="2000"></textarea>
                   </td></tr>
                   <tr><td <th colspan="4"><button type="submit">GO</button></td></tr>
        </table>
  
    </form>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        
       var dateToday = new Date();
       
       
       var mindateToday = new Date();
       mindateToday.setDate(dateToday.getDate() - 5);
        
         $( "#action_send_time" ).datetimepicker({
                    dateFormat: 'yy-mm-dd',
                     timeFormat: 'hh:mm',
                     buttonImage: '../images/date.png',
                     buttonImageOnly: true,
                     showOn:'button',
                     buttonText: 'Click to show the calendar'
         });
                 
         $("#action_send_time").datetimepicker('option', 'minDate', mindateToday); 
         $('#ui-datepicker-div').css('display','none');
         $("#action_send_time").datetimepicker('option', 'maxDate', dateToday);
              
                
        
        $('#slatime_show').hide();
        $('#action_status').change(function() {
            $('#action_send_time').attr('value','');
            $('#action_notes').attr('value','');
            
            if($('#action_status option:selected').val()==4) {
                $('#slatime_show').show();
                $("#action_send_time").show();
            }else{
                $('#slatime_show').hide();
                $("#action_send_time").hide();
            }
        });
        
        $('#action_form').submit(function(){
            
            action_status= document.getElementById("action_status").value;
            action_send_time= document.getElementById("action_send_time").value;
            action_notes= document.getElementById("action_notes").value;
            filter_itemname= document.getElementById("filter_itemname").value;
            filter_status= document.getElementById("filter_status").value;
            filter_actDate_start= document.getElementById("filter_actDate_start").value;
            filter_actDate_end= document.getElementById("filter_actDate_end").value;
            filter_groupName= document.getElementById("filter_groupName").value;
            filter_userName= document.getElementById("filter_userName").value;
            filter_SLA= document.getElementById("filter_SLA").value;
            filter_priority= document.getElementById("filter_priority").value;
            filter_act_auth= document.getElementById("filter_act_auth").value;    
            
            //alert(action_status.toString());
            
            if (action_notes.toString()===""  ) {
                $("#status_msg").html("<div class=alert>Notes is mandatory and must be filled with alphanumeric</div>");
                $("#status_msg").show();
            }else if (action_status.toString()==="4" && action_send_time.toString()===""  ) {
                $("#status_msg").html("<div class=alert>For action status='DONE', you must input complete time field</div>");
                $("#status_msg").show();
            }else {
            var lastid="1";
            var i= 0;
            
            $(".checkboxSelect_act:checked").each(function()
            {
                
                
                i +=1;
                var id=this.value;
                lastid= id;
                
                //alert(id);

                $("#data_inner").hide();
                $("#status_msg").empty();
                $("#status_msg").hide();
                $("#data_inner").hide();
                $('#loading').show();
                
                var data_save = $('#action_form').serializeArray();
                data_save.push({ name: "id", value: id });
                
                $.ajax({
                    type: 'POST',
                    url: "tracking/activity/activity_list_action_process.jsp",
                    data : data_save ,
                    success: function(data) {
                        $('#status_msg').empty();
                        $('#status_msg').html(data);
                        $("#status_msg").show();
                       
                    },
                    complete: function(){
                        
                       if (action_status.toString()==="4" || action_status.toString()==="6") {
                           id=0;
                       }
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/activity/activity_list_data.jsp",
                            data: {id:0,
                                filter_itemname:filter_itemname,
                                filter_status:filter_status,
                                filter_actDate_start:filter_actDate_start,
                                filter_actDate_end:filter_actDate_end,
                                filter_groupName:filter_groupName,
                                filter_userName:filter_userName,
                                filter_SLA:filter_SLA,
                                filter_priority:filter_priority,
                                filter_act_auth:filter_act_auth
                            },
                            success: function(data) {
                                $("#data_inner").empty();
                                $("#data_inner").html(data);
                                $("#data_inner").show();
                                
                            },
                            complete: function(){
                                $('#loading').hide();
                            }
                        });
                    }
                });
            });
                
           
                
                if (i==0) {
                $("#status_msg").html("<div class=alert>Please select Checkbox on activity items first</div>");
                $("#status_msg").show();
                }
             
                $('#action_box_data').slideUp();
                $('#icon_panel_show_filter').fadeIn('slow');
                $('#icon_panel_hide_filter').fadeOut('slow');
                $('#icon_panel_show_action').fadeIn('slow');
                $('#icon_panel_hide_action').fadeOut('slow');
                
                $("#status_msg").delay(5000).hide(400);  
 
            }
              
            return false;
        });
        
    });
</script>

