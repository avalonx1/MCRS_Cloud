<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_user_group_access_matrix";
    String seqTableName=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String group_master_id=request.getParameter("group_master_id");
    String group_child_id=request.getParameter("group_child_id");

 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
   
    
       if (group_master_id.equals("") || group_child_id.equals("")){
    validate = false;
    errorMessage += "- Field group_name tidak boleh null <br>";
    } else if (group_master_id.equals(group_child_id)) {
    validate = false;
    errorMessage += "- Field group master and child sama (sudah terisi secara default) <br>";
        
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
                    +"id, group_master_id,group_child_id ) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + ""+group_master_id+","
                    + ""+group_child_id+" "
                    + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"group_master_id="+group_master_id+","
                    +"group_child_id="+group_child_id+" "
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
                        url: "administration/user_management/user_group_access_matrix/user_group_access_matrix_list.jsp",
                        data: "id=<%=id%>",
                        success: function(data) {
                            $("#data").empty();
                            $('#data').html(data);
                            $("#data").show();
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

