<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="record";
    String id="0";
    String tableName="t_report_group";
    String tableNameSeq=tableName+"_seq";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String group_code=request.getParameter("group_code");
    String group_name=request.getParameter("group_name");
    String group_description=request.getParameter("group_description");
    String record_stat=request.getParameter("record_stat");
 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (group_code.equals("")){
    group_code="NULL";
    validate = false;
    errorMessage += "- Field group_code tidak boleh null <br>";
    }
    
    if (group_name.equals("")){
    group_name="NULL";
    validate = false;
    errorMessage += "- Field group_name tidak boleh null <br>";
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
                    +"id, group_code,group_name,group_description,record_stat) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + "'"+group_code+"',"
                        + "'"+group_name+"',"
                        + "'"+group_description+"',1)";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"group_code='"+group_code+"',"
                    +"group_name='"+group_name+"', "
                    +"group_description='"+group_description+"' "
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
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/report_management/report_group/report_group_list_data.jsp",
                        data: "id=<%=id%>",
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

