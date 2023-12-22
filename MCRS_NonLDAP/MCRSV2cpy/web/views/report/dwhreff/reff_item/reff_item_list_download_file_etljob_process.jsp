<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String tableName="t_dwhreff_item_file";
    
    String sql;
    String fileid = "0";
                
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                
                String etljob_name = "";
                sql = "select etljob_name,fileid from v_dwhreff_item_file where id="+id+" ";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                etljob_name = resultSet.getString("etljob_name");
                fileid = resultSet.getString("fileid");
                }
                
              
                sql = "update "+tableName+" SET "
                    +"status_process=1, "
                    +"status_info='Connecting to ETL Job..' "
                    +"where id="+id;
                 
                 db.executeUpdate(sql);
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>SQL : "+sql+" </div>");
                        out.println("<div class=sql> execute DS Job :"+etljob_name+" ID:"+id+" </div>");
                        }
                
               //runjob Dwh Reff  
                      auth runScriptReff = new auth(v_clientIP);
                    try {
                     runScriptReff.execRunDsJobReff(id,etljob_name);
                     
                     System.out.println(runScriptReff);
                     } catch (SQLException Sqlex) {
                     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                     } 
                    catch (IOException ioex) {
                     out.println("<div class=sql>" + ioex.getMessage() + "</div>");
                     }
                    finally {
                     runScriptReff.close();
                     }
                    
                out.println("<div class=info> Run ETL "+etljob_name+" ID "+id+" success..</div>");
                    
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
        url: "report/dwhreff/reff_item/reff_item_list_download_file.jsp",
        data: {id:<%=fileid%>},
        success: function(data) {
            ("#data_inner").empty(); 
            $('#data_inner').html(data);
            $("#data_inner").show();
            $("#status_msg").delay(5000).hide(400);                
        },
        complete: function(){
            $('#loading').hide();
        }
    });
    
</script>