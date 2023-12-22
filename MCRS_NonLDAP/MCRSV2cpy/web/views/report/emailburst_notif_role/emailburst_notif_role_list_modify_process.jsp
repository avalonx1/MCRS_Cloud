<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String tableName="t_notif_role";
    String tableNameSeq=tableName+"_seq";
    String formName="Record";
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String t_code=request.getParameter("t_code");
    String t_name=request.getParameter("t_name");
    String t_desc=request.getParameter("t_desc");
    String inorder=request.getParameter("inorder");

 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (t_code.equals("")){
    t_code="NULL";
    validate = false;
    errorMessage += "- Field t_code tidak boleh null <br>";
    }
    
    if (t_name.equals("")){
    t_name="NULL";
    validate = false;
    errorMessage += "- Field t_name tidak boleh null <br>";
    }
 
    
    if (inorder.equals("")){
    inorder="99";
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
                    +"id, t_code,t_name,t_desc,inorder,record_stat) "
                    +"values (nextval('"+tableNameSeq+"'),'"+t_code+"','"+t_name+"','"+t_desc+"',"+inorder+",1 )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"t_code='"+t_code+"',"
                    +"t_name='"+t_name+"', "
                    +"t_desc='"+t_desc+"', "
                    +"inorder="+inorder+" "
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
                     //filter_status= document.getElementById("filter_status").value;
                     
                     
                    $("#data").empty();
                    $('#loading').show();
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

