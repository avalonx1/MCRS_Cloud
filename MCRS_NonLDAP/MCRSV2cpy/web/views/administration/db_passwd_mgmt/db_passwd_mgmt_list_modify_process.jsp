<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String tableName="t_dwh_dbmgmt_user_pic";
    String tableNameSeq=tableName+"_seq";
    String formName="Record";
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    
    
    String db_name=request.getParameter("db_name");
    String db_username=request.getParameter("db_username");
    String is_4eyes=request.getParameter("is_4eyes");
    String pic_nik_1=request.getParameter("pic_nik_1");
    String pic_name_1=request.getParameter("pic_name_1");
    String pic_email_1=request.getParameter("pic_email_1");
    String pic_nik_2=request.getParameter("pic_nik_2");
    String pic_name_2=request.getParameter("pic_name_2");
    String pic_email_2=request.getParameter("pic_email_2");
    String tujuan_akses=request.getParameter("tujuan_akses");
 
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (db_name.equals("")){
    db_name="NULL";
    validate = false;
    errorMessage += "- Field db name tidak boleh null <br>";
    }
    
    if (db_username.equals("")){
    db_username="NULL";
    validate = false;
    errorMessage += "- Field db username tidak boleh null <br>";
    }
 
    if (is_4eyes.equals("")){
    is_4eyes="NULL";
    validate = false;
    errorMessage += "- Field 2 person auth tidak boleh null <br>";
    }
 
    if (pic_nik_1.equals("")){
    pic_nik_1="NULL";
    validate = false;
    errorMessage += "- Field pic NIK 1 tidak boleh null <br>";
    }
    
    if (pic_name_1.equals("")){
    pic_name_1="NULL";
    validate = false;
    errorMessage += "- Field pic name 1 tidak boleh null <br>";
    }
 
    if (pic_email_1.equals("")){
    pic_email_1="NULL";
    validate = false;
    errorMessage += "- Field pic email 1 tidak boleh null <br>";
    }
 
    if (is_4eyes.equals("Y")) {
    
    if (pic_nik_2.equals("")){
    pic_nik_2="NULL";
    validate = false;
    errorMessage += "- Field pic NIK 2 tidak boleh null <br>";
    }
    
     
    if (pic_name_2.equals("")){
    pic_name_2="NULL";
    validate = false;
    errorMessage += "- Field pic name 2 tidak boleh null <br>";
    }
 
    if (pic_email_2.equals("")){
    pic_email_2="NULL";
    validate = false;
    errorMessage += "- Field pic email 2 tidak boleh null <br>";
    }
    
    }
    
    
    if (tujuan_akses.equals("")){
    tujuan_akses="NULL";
    validate = false;
    errorMessage += "- Field Tujuan Akses tidak boleh null <br>";
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
                    +"id, db_name,db_username,is_4eyes,pic_nik_1,pic_name_1,pic_email_1,pic_nik_2,pic_name_2,pic_email_2,"
                    + "maker_userid,maker_dt_stamp,maker_tag,checker_userid,checker_dt_stamp,auth_stat,last_modified_dt_stamp,tujuan_akses "    
                        + "  ) "
                    +"values (nextval('"+tableNameSeq+"'),'"+db_name+"','"+db_username+"','"+is_4eyes+"',"
                        + "'"+pic_nik_1+"','"+pic_name_1+"','"+pic_email_1+"','"+pic_nik_2+"','"+pic_name_2+"','"+pic_email_2+"',"
                        + " "+v_userID+",CURRENT_TIMESTAMP,'APPLICATION',"+v_userID+",CURRENT_TIMESTAMP,'A',CURRENT_TIMESTAMP,$$"+tujuan_akses+"$$ "
                        + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"db_name='"+db_name+"',"
                    +"db_username='"+db_username+"', "
                    +"is_4eyes='"+is_4eyes+"', "
                    +"pic_nik_1='"+pic_nik_1+"', "
                    +"pic_name_1='"+pic_name_1+"', "
                    +"pic_email_1='"+pic_email_1+"', "
                    +"pic_nik_2='"+pic_nik_2+"', "
                    +"pic_name_2='"+pic_name_2+"', "
                    +"pic_email_2='"+pic_email_2+"', "  
                    +"tujuan_akses=$$"+tujuan_akses+"$$,"
                    +"last_modified_dt_stamp=CURRENT_TIMESTAMP "
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
                     
                     
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_data.jsp",
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

