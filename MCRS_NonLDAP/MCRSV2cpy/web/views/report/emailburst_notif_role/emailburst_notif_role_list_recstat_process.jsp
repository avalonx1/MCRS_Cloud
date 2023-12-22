<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String recstat=request.getParameter("recstat");
    String recstatname="";
    String tableName="t_notif_role";
    String statusColumn="record_stat";
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                
                if (recstat.equals("1")) {
                sql = "update "+tableName+" set "+statusColumn+"=0 where ID=" + id + " ";
                
                 recstatname="deactivated";

                    
                } else {
                sql = "update "+tableName+" set "+statusColumn+"=1 where ID=" + id + " ";
                
                 recstatname="activated";
                 
                }
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                
                out.println("<div class=info> "+recstatname+" record status ID "+id+" success..</div>");
                    
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
 
      filter_itemname= document.getElementById("filter_itemname").value;   
      //filter_status= document.getElementById("filter_status").value;
      
    $.ajax({
        type: 'POST',
        url: "report/emailburst_notif_role/emailburst_notif_role_list_data.jsp",
        data: {id:<%=id%>,filter_itemname:filter_itemname},
        success: function(data) {
            $("#data_inner").empty();
            $('#data_inner').html(data);
            $("#data_inner").show();
            $("#status_msg").delay(5000).hide(400);                
        },
        complete: function(){
            $('#loading').hide();
        }
    });
    
</script>