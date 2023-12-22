<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_menu_matrix";
    String seqTableName=tableName+"_seq";
    String id="0";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String menu_id=request.getParameter("menu_id");
    String user_level_id=request.getParameter("user_level_id");
    String user_group_id=request.getParameter("user_group_id");
    String modul=request.getParameter("modul");
    String status=request.getParameter("status_matrix");
    
    
   
    
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
  boolean valBulkGroup = false;
        
    
    if (user_group_id.equals("0")){
        valBulkGroup = true;
        
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
                 
                   
                   if (valBulkGroup) {
                       
                       sql = "delete from "+tableName+" where menu_id="+menu_id+" and user_level_id="+user_level_id+" and modul="+modul+" "
                           + "and user_group_id in (select id from t_user_group where branch_flag=1) ";
                       
                       db.executeUpdate(sql);
                       
                       sql = "insert into "+tableName+" ("
                            +"id, menu_id,user_level_id, modul, user_group_id, status) "
                            +"select nextval('"+seqTableName+"'),"+menu_id+","+user_level_id+","+modul+",id as user_group_id,"+status+" "
                            +"from t_user_group where branch_flag=1 ";
                       
                       
                   }else {
                   
                   sql = "delete from "+tableName+" where menu_id="+menu_id+" and user_level_id="+user_level_id+" "
                           + "and modul="+modul+" and status="+status+" ";
                       
                       db.executeUpdate(sql);
                       
                 
                sql = "insert into "+tableName+" ("
                    +"id, menu_id,user_level_id, modul, user_group_id, status) "
                    +"values (nextval('"+seqTableName+"'),"
                        + "'"+menu_id+"',"
                        + "'"+user_level_id+"',"
                        + "'"+modul+"',"
                        + ""+user_group_id+","
                        + ""+status+" )";
                    
                   }
                   
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"menu_id="+menu_id+","
                    +"user_level_id="+user_level_id+","
                    +"modul="+modul+","
                    +"user_group_id="+user_group_id+","
                    +"status="+status+" "
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
                    filter_modul= document.getElementById("filter_modul").value;
                    filter_usergroup= document.getElementById("filter_usergroup").value;
                    filter_userlevel= document.getElementById("filter_userlevel").value;
                   
 
                     $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_data.jsp",
                        data: {id:<%=id%>,
                                 filter_itemname:filter_itemname,
                                 filter_modul:filter_modul,
                                 filter_usergroup:filter_usergroup,
                                 filter_userlevel:filter_userlevel},
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

