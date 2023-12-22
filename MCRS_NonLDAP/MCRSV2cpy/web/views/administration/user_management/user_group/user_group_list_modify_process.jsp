<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_user_group";
    String seqTableName=tableName+"_seq";
    
    String tableName2="t_view_menu";
    String seqTableName2=tableName2+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String group_code=request.getParameter("group_code");
    String group_name=request.getParameter("group_name");
    String group_description=request.getParameter("group_description");
    String document_pathkey=request.getParameter("document_pathkey");
    String branch_flag=request.getParameter("branch_flag");

    
    
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
                    +"id, group_code,group_name,group_description,document_pathkey,branch_flag) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+group_code+"',"
                    + "'"+group_name+"',"
                    + "'"+group_description+"', "
                    + "'"+document_pathkey+"', "
                    + " "+branch_flag+" "
                    + " )";
                    
                actionDesc="Add";
                        
              
                
                 db.executeUpdate(sql);
                 
                
                 
            /*     
                  sql = "insert into "+tableName2+" ("
                    +"id,group_master_id,group_child_id ) "
                    +" select "
                    + "nextval('"+seqTableName2+"'),"
                    + " id,id "
                    + " from "+tableName+" "
                    + " where group_code='"+group_code+"' "
                    + " ";
                
                 db.executeUpdate(sql);
                 */
                 
                 
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"group_code='"+group_code+"',"
                    +"group_name='"+group_name+"', "
                    +"group_description='"+group_description+"', "
                    +"document_pathkey='"+document_pathkey+"', "
                    +"branch_flag="+branch_flag+" "
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
                  db.executeUpdate(sql);
               }
               
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
               
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                 %>
                <script type="text/javascript">
                    
                     filter_itemname= document.getElementById("filter_itemname").value;
                     
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/user_management/user_group/user_group_list_data.jsp",
                        data: {id:<%=id%>,
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

