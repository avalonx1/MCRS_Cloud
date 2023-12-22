<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String recstat=request.getParameter("recstat");
    String tableName="t_journal_adjust_file";
    String statusColumn="record_status";
    String recstatname="";
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                
                
                String filename = "";
                sql = "select doc_path_key from "+tableName+" where id="+id+" ";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                filename = resultSet.getString("doc_path_key");
                }
                
                sql = "delete from "+tableName+" where ID=" + id + " ";
                
                recstatname="delete";

                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                
                //remove file system
                
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql> filename deleted :"+filename+" </div>");
                        }
                        
                
                 String execScript="";
                 auth runScript = new auth(v_clientIP);
                    try { 

                     execScript=runScript.execDeleteFile(filename); 

                     } catch (SQLException Sqlex) {
                     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                     } 
                    catch (IOException ioex) {
                     out.println("<div class=sql>" + ioex.getMessage() + "</div>");
                     }
                    finally {
                     runScript.close();
                     }

        
                
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
 
    
    $.ajax({
        type: 'POST',
        url: "file_management/journal_adjust/journal_adjust_list_data.jsp",
        data: "",
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