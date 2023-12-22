<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String username_full = v_userFullName;

    String id = request.getParameter("id");
    
    String tableName="t_dwh_dbmgmt_user_pic";
    String tableNameSeq=tableName+"_seq";

    String db_username="";
    String is_4eyes="";
    String pic_name_1="";
    String pic_email_1="";
    String pic_name_2="";
    String pic_email_2="";
    String msg="";
    
    String sql="";
    
       try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                 sql = "SELECT id,db_name, db_username,is_4eyes, pic_name_1,pic_email_1,pic_name_2,pic_email_2 "
                         + "from t_dwh_dbmgmt_user_pic where id="+id;
                 
                 resultSet = db.executeQuery(sql);
                 while (resultSet.next()) {
                   db_username=resultSet.getString("db_username");
                   is_4eyes=resultSet.getString("is_4eyes");  
                   pic_name_1=resultSet.getString("pic_name_1");
                   pic_email_1=resultSet.getString("pic_email_1");
                   pic_name_2=resultSet.getString("pic_name_2");
                   pic_email_2=resultSet.getString("pic_email_2");
                       
                 }
                
                out.println("<div class=sukses> Password for user "+db_username+" has been reset </div>");
                   
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                    if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
       
       
                       

                         String msgForm="";
                         auth mail = new auth(v_clientIP);
                         try {
                             msgForm=mail.execSendMailResetPasswordDBToPIC(db_username, is_4eyes, pic_email_1,pic_name_1, pic_name_2,pic_email_2, msg);
                             
                             //out.println("<div class=info>Sending Mail to "+db_username+" ("+user_email+") ... </div>");
                             
                             } catch (SQLException Sqlex) {
                          out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                          } finally {
                          mail.close();
                          }
                         

    
    
                 %>
                <script type="text/javascript">
             
             
        
            filter_itemname= document.getElementById("filter_itemname").value;
         
                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_data.jsp",
                            data: {
                                filter_itemname:filter_itemname
                            },
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                                $("#status_msg").delay(5000).hide(400);
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });       
                        
             
             
                </script>
                    <%
                   

    

    
    
%>

