<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_menu";
    String seqTableName=tableName+"_seq";
    String id="0";
    
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
 String name=request.getParameter("name");
 String url=request.getParameter("url");
 String urutan=request.getParameter("urutan");
 String parent_menu=request.getParameter("parent_menu");
 String leaf=request.getParameter("leaf");
 String stat=request.getParameter("stat");
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
   if (name.equals("")){
    validate = false;
    errorMessage += "- Field nama tidak boleh null <br>";
    }
    
    if (url.equals("")){
    validate = false;
    errorMessage += "- Field url Path tidak boleh null <br>";
    }
    
     if (urutan.equals("")){
    validate = false;
    errorMessage += "- Field order menu tidak boleh null <br>";
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
                   
                   sql = "update "+tableName+" set leaf=0 where id="+parent_menu;
                   
                   db.executeUpdate(sql);
                   
                   
               sql = "insert into "+tableName+" ("
                    +"id, name, url, urutan, parent_menu, leaf, stat) "
                    +"values (nextval('"+seqTableName+"'),"
                       + "'"+name+"',"
                       + "'"+url+"',"
                       + ""+urutan+","
                       + ""+parent_menu+","
                       + "1,1)";
               
                actionDesc="Add";
                        
               }else {
                   
                   sql = "update "+tableName+" set leaf=0 where id="+parent_menu;
                   db.executeUpdate(sql);
                   
                 sql = "update "+tableName+" SET "
                    +"name='"+name+"',"
                    +"url='"+url+"',"
                    +"urutan="+urutan+", "
                    +"parent_menu="+parent_menu+" "
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
                        url: "administration/menu_navigation/tree_master/tree_master_list_data.jsp",
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

