<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_popup_notif";
    String seqTableName=tableName+"_seq";
    
    String tableName2="t_view_menu";
    String seqTableName2=tableName2+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
     
 String notif_code=request.getParameter("notif_code");
 String notif_title=request.getParameter("notif_title");
 String notif_desc=request.getParameter("notif_desc");
 String image_file=request.getParameter("image_file");
 String img_width=request.getParameter("img_width");
 String img_height=request.getParameter("img_height");
 String stat_swfntf=request.getParameter("stat_swfntf");
 

    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
     boolean cimgwidth = Pattern.matches("[0-9]+", img_width);
     boolean cimgheight = Pattern.matches("[0-9]+", img_height);
   
    
    if (notif_code.equals("")){
    notif_code="NULL";
    validate = false;
    errorMessage += "- Field notif_code tidak boleh null <br>";
    }
    
    if (notif_title.equals("")){
    notif_title="NULL";
    validate = false;
    errorMessage += "- Field notif_title tidak boleh null <br>";
    }
    
    if (notif_desc.equals("")){
    notif_desc="NULL";
    validate = false;
    errorMessage += "- Field notif_desc tidak boleh null <br>";
    }
    
    if (image_file.equals("")){
    image_file="NULL";
    validate = false;
    errorMessage += "- Field image_file tidak boleh null <br>";
    }
      
    
     if (!cimgwidth) {
        img_width="NULL";
        validate = false;
        errorMessage += "-Field img_width must be add with number<br>";
    }
     
      if (!cimgheight) {
        img_height="NULL";
        validate = false;
        errorMessage += "-Field img_height must be add with number<br>";
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
                    +"id, notif_code,notif_title,notif_desc,image_file,img_width,img_height,created_userid,created_time,stat_swfntf) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+notif_code+"',"
                    + "'"+notif_title+"', "
                    + "'"+notif_desc+"', "
                    + " '"+image_file+"', "
                    + " "+img_width+", "
                    + " "+img_height+", "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " "+stat_swfntf+" " 
                    + " )";
                    
                actionDesc="Add";
                        
              
                 db.executeUpdate(sql);
                 
                 
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"notif_code='"+notif_code+"',"
                    +"notif_title='"+notif_title+"', "
                    +"notif_desc='"+notif_desc+"', "
                    +"image_file='"+image_file+"', "
                    +"img_width="+img_width+", "
                    +"img_height="+img_height+", "
                    +"created_userid="+v_userID+", "
                    +"created_time=CURRENT_TIMESTAMP, "
                    +"stat_swfntf="+stat_swfntf+" "
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
                        url: "etc/popup_notification/notification_list_data.jsp",
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

