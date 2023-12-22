<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_report_permission_matrix";
    String seqTableName=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String user_group_id=request.getParameter("user_group_id");
    String user_group_child_id=request.getParameter("user_group_child_id");
    String user_level_id=request.getParameter("user_level_id");
    String report_id=request.getParameter("report_id");
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    String valBulkGroup = "0";
    
    if ( (user_group_id.equals("0") && !user_group_child_id.equals("0")) )
    {
        validate = false;
        errorMessage += "- jika Group -All Branch- maka Child Group harus -All Branch- <br>";
    }
    
    
    
    if (user_group_id.equals("0") && user_group_child_id.equals("0")){
        valBulkGroup = "1";  
    }
   
    if (!user_group_id.equals("0") && user_group_child_id.equals("0")){
        valBulkGroup = "2";
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
                
                   
                   if (valBulkGroup.equals("1")) {
                   
                       sql = "delete from "+tableName+" where report_id="+report_id+" and user_level_id="+user_level_id+" "
                           + "and user_group_id||'-'||user_group_child_id in (select id||'-'||id from t_user_group where branch_flag=1) ";
                       
                       db.executeUpdate(sql);
                       
                       if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                       
                       sql = "insert into "+tableName+" ("
                            +"id, report_id,user_group_id,user_group_child_id,user_level_id ) "
                            +"select nextval('"+seqTableName+"'),"+report_id+",id as user_group_id,id as user_group_child_id,"+user_level_id+" as user_level_id "
                            +"from t_user_group where branch_flag=1 ";
                       
                       
                   } else if (valBulkGroup.equals("2")) {
                   
                       
                       sql = "delete from "+tableName+" where report_id="+report_id+" and user_level_id="+user_level_id+" "
                           + "and user_group_id="+user_group_id+" and user_group_child_id in (select id from t_user_group where branch_flag=1) ";
                       
                       db.executeUpdate(sql);
                       
                       if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                       
                       sql = "insert into "+tableName+" ("
                            +"id, report_id,user_group_id,user_group_child_id,user_level_id ) "
                            +"select nextval('"+seqTableName+"'),"+report_id+","+user_group_id+" as user_group_id,id as user_group_child_id,"+user_level_id+" as user_level_id "
                            +"from t_user_group where branch_flag=1 ";
                       
                       
                       
                   }else {
                       
                       sql = "delete from "+tableName+" where report_id="+report_id+" and user_level_id="+user_level_id+" "
                           + "and user_group_id="+user_group_id+" and  user_group_child_id="+user_group_child_id+" ";
                       
                       
                       db.executeUpdate(sql);
                       
                       if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                       
                        sql = "insert into "+tableName+" ("
                            +"id, report_id,user_group_id,user_group_child_id,user_level_id ) "
                            +"values ( "
                            + "nextval('"+seqTableName+"'),"
                            + " "+report_id+","
                            + " "+user_group_id+","
                            + " "+user_group_child_id+", "
                            + " "+user_level_id+" "
                            + " )";

                 
                   }
                   
                   
                
                
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"user_group_id="+user_group_id+","
                    +"user_group_child_id="+user_group_child_id+","
                    +"user_level_id="+user_level_id+", "
                    +"report_id="+report_id+" "
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
                    filter_report_id = document.getElementById("filter_report_id").value;
                    filter_group_master_id = document.getElementById("filter_group_master_id").value;
                    filter_group_child_id = document.getElementById("filter_group_child_id").value;
                    filter_userlevel_id = document.getElementById("filter_userlevel_id").value;
                    
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/report_management/report_access_matrix/report_access_matrix_list_data.jsp",
                        data: {id:<%=id%>,
                            filter_itemname:filter_itemname,
                            filter_report_id:filter_report_id,
                            filter_group_master_id:filter_group_master_id,
                            filter_group_child_id:filter_group_child_id,
                            filter_userlevel_id:filter_userlevel_id
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

