<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                sql = "delete from T_PARAM where ID=" + id + " ";
                //System.out.println(sql);
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info> Delete ID "+id+" success..</div>");
                    
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
 
    
    $.ajax({
        type: 'POST',
        url: "administration/app_parameter/app_param_list_data.jsp",
        data: {id:0,
        filter_itemname:filter_itemname
        },
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