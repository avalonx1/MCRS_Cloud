<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%        
    String user_id = (String) session.getAttribute("session_userid");
    String level_id = (String) session.getAttribute("session_level");
    String id = request.getParameter("id");
    String item_name = request.getParameter("item_name");
    String sql;

        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                   sql = "SELECT ACT2USER,PICKUP_STAT,ACT2ACTSTATUS from T_ACT_HIS where id="+id+" ";
                   resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {
                        
                        if (level_id.equals("1") ){
                         sql = "update T_ACT_HIS set PICKUP_STAT=1,LAST_UPDATE_TIME=CURRENT_TIMESTAMP,act2user="+v_userID+" where id=" + id + "  ";
                                db.executeUpdate(sql);
                                out.println("<div class=info> Pickup "+id+"("+item_name+") Success..</div>");
                        }
                        else if (resultSet.getString(2).equals("0") || (resultSet.getString(2).equals("1") && !resultSet.getString(2).equals("3")) ) {
                                sql = "update T_ACT_HIS set ACT2USER=" + user_id + ",ACT2ACTSTATUS=3,PICKUP_STAT=1,LAST_UPDATE_TIME=CURRENT_TIMESTAMP where id=" + id + "  ";
                                db.executeUpdate(sql);
                                out.println("<div class=info> Pickup "+id+"("+item_name+") Success..</div>");
                                

                            }else{
                                             
                                out.println("<div class=sql>this id is already pickup by "+resultSet.getString(1).toString()+" </div>");
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
<script type="text/javascript">
    //$("#status_msg").slideDown(0);
    
    filter_itemname= document.getElementById("filter_itemname").value;
    filter_status= document.getElementById("filter_status").value;
    filter_actDate_start= document.getElementById("filter_actDate_start").value;
    filter_actDate_end= document.getElementById("filter_actDate_end").value;
    filter_groupName= document.getElementById("filter_groupName").value;
    filter_userName= document.getElementById("filter_userName").value;
    filter_SLA= document.getElementById("filter_SLA").value;
    filter_priority= document.getElementById("filter_priority").value;
    filter_act_auth= document.getElementById("filter_act_auth").value;
    
    
    $("#data_inner").hide();
    
    $.ajax({
        type: 'POST',
        url: "tracking/activity/activity_list_data.jsp",
        data: { id:0,
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
            $('#data_inner').html(data);
            $("#data_inner").show();
            
            //$("#status_msg").delay(1000).hide(0);                                
        },
        complete: function(){
            $('#loading').hide();
        }
    });
    
</script>