<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    
    String tableName="t_dwhreff_item";
    String tableNameSeq=tableName+"_seq";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
 
 String reff_code=request.getParameter("reff_code");
 String reff_name=request.getParameter("reff_name");
 String reff_desc=request.getParameter("reff_desc");
 String flag_start_pos=request.getParameter("flag_start_pos");
 String flag_stop_pos=request.getParameter("flag_stop_pos");
 String groupid=request.getParameter("groupid");
 String file_format=request.getParameter("file_format");
 String etljob_name=request.getParameter("etljob_name");
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (reff_code.equals("")){
    reff_code="NULL";
    validate = false;
    errorMessage += "- Field reff code tidak boleh null <br>";
    }
    
    if (reff_name.equals("")){
    reff_name="NULL";
    validate = false;
    errorMessage += "- Field reff name tidak boleh null <br>";
    }
    
    if (reff_desc.equals("")){
    reff_desc="NULL";
    validate = false;
    errorMessage += "- Field reff description tidak boleh null <br>";
    }
    
    if (etljob_name.equals("")){
    etljob_name="NULL";
    validate = false;
    errorMessage += "- Field ETL Job Name tidak boleh null <br>";
    }
    
    
    if (validate) {
        
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                      +" id,reff_code, reff_name, reff_desc, flag_start_pos,flag_stop_pos,groupid,"
                      +" created_time,created_userid,record_status,file_format,etljob_name ) " 
                      +" values (nextval('"+tableNameSeq+"'),"
                      + "'"+reff_code+"',"
                      + "'"+reff_name+"',"
                      + "'"+reff_desc+"',"
                      + "'"+flag_start_pos+"',"
                      + "'"+flag_stop_pos+"',"
                      + ""+groupid+","  
                      + "CURRENT_TIMESTAMP,"
                      + " "+v_userID+","
                      + "1,"
                      + "'"+file_format+"', "
                      + "'"+etljob_name+"' "
                      + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +" reff_code="  +"'"+reff_code+"',"
                    +" reff_name="  + "'"+reff_name+"',"
                    +" reff_desc="  + "'"+reff_desc+"',"
                    +" flag_start_pos="  + "'"+flag_start_pos+"',"
                    +" flag_stop_pos="  + "'"+flag_stop_pos+"',"
                    +" file_format="  + "'"+file_format+"',"
                    +" etljob_name="  + "'"+etljob_name+"',"
                    +" groupid="  + " "+groupid+" "  
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
               }
               
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                 %>
                <script type="text/javascript">
                    
                     filter_itemname= document.getElementById("filter_itemname").value; 
                     filter_groupid= document.getElementById("filter_groupid").value;
                     filter_record_status= document.getElementById("filter_record_status").value;
                     
                     
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "report/dwhreff/reff_item/reff_item_list_data.jsp",
                        data: {id:<%=id%>,filter_itemname:filter_itemname,filter_groupid:filter_groupid,filter_record_status:filter_record_status},
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
                    <%
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

    

    
    
%>

