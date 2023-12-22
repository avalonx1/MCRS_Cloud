<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%  
              
    String objid = request.getParameter("objid");
    String sql;


  
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                    sql = "SELECT USERNAME from T_USER where ID="+objid+" ";
                    resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {
                            if (v_userLevel.equals("1")) {
                                sql = "update T_USER set FLAG=1,CREATION_TIME=CURRENT_DATE where ID=" + objid + " ";
                                db.executeUpdate(sql);
                                out.println("<div class=info> activate User "+resultSet.getString(1).toString()+" success..</div>");
                                

                            }else{
                                             
                                out.println("<div class=sql>You're not authorize to activate this items "+resultSet.getString(1).toString()+" </div>");
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
 
    filter_itemname= document.getElementById("filter_username").value;
    filter_status= document.getElementById("filter_status").value;
  
    
    $.ajax({
        type: 'POST',
        url: "administration/user_management/user_list_data.jsp",
        data: { objid:"<%=objid%>",filter_itemname:filter_itemname,filter_status:filter_status },
        success: function(data) {
            $("#data_inner").empty();
            $('#data_inner').html(data);
            $("#data_inner").show();
            $("#status_msg").delay(3000).hide(400);                
        },
        complete: function(){
            $('#loading').hide();
        }
    })
    
</script>
