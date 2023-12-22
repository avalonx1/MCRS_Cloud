<%@include file="../../../includes/check_auth_layer_notif.jsp"%>
<%
    String notifcode = request.getParameter("notifcode");
    String act = request.getParameter("act");
    String notifcolumn = request.getParameter("notifcolumn");
    String addlinfo = request.getParameter("addlinfo");
    
    String pattern = "[[var1]]";
    
    if (addlinfo==null) {
        addlinfo=pattern;
    }
    
    
    int i = 0;
    
    
    String notifTitle = "";
    String notifDesc = "";
    String imageFile = "";
    String imageFileDefault ="";
    String imageFileDefaultheight ="";
    String imageFileDefaultwidth ="";
    int stat_swfntf=0;
    
    String keysecret="";
    
    int img_height = 0;
    int img_width = 0;
    
    int vCheckEligible = 0;
    String imgNtfDocRoot ="";
    
        auth checkFile = new auth(v_clientIP);
        try { 
         
         
         imgNtfDocRoot=checkFile.getParamValue("IMG_DOCROOT_RELATIVE");
         imageFileDefault=checkFile.getParamValue("IMG_NTF_DEFAULT");
         imageFileDefaultwidth=checkFile.getParamValue("IMG_NTF_DEFAULT_HEIGHT");
         imageFileDefaultheight=checkFile.getParamValue("IMG_NTF_DEFAULT_WIDTH");
         keysecret=checkFile.getParamValue("KEYSECRET");
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         checkFile.close();
         }
                 

            
                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select Notif_title,Notif_desc,image_file,fullname,created_time,img_height,img_width,stat_swfntf "
                                + " from v_popup_notif where Notif_code='"+notifcode+"' ";    

                       
                        //out.println(sql);
                        
                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }

                            notifTitle = resultSet.getString("Notif_title");
                            notifDesc = resultSet.getString("Notif_desc");
                            imageFile = resultSet.getString("image_file");
                            img_height = resultSet.getInt("img_height");
                            img_width = resultSet.getInt("img_width");
                            stat_swfntf = resultSet.getInt("stat_swfntf");

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

                
                
                String notifDescDisp = notifDesc.replace(pattern, addlinfo);
                
                
                String imagefullpath = imgNtfDocRoot+"/"+imageFile;
                
                String imagefullpathdefault = imgNtfDocRoot+"/"+imageFileDefault;
       
            
%>
  <script type="text/javascript">
       $(document).ready(function() {
           
    var wind_browser_height=$(window).height();
    var wind_browser_width=$(window).width();
    var wind_adj_height=wind_browser_height-280;
    var wind_adj_width=wind_browser_width-310;
    
     $('#image_notif_box').css({'height' : <%=img_height%>});
     $('#image_notif_box').css({'width' : <%=img_width%>});
     
    
            $('#loading').show();
            $.ajax({
                type: 'POST',
                url: "../../file_management/docviewer_notif.jsp",
                data: {keysecret:'<%=keysecret%>'},
                success: function(data) {
                    $('#popup_notif_swf').empty();
                    $('#popup_notif_swf').html(data);
                    $('#popup_notif_swf').show();
                },
                complete: function(){
                    $('#loading').hide();
                }
                });

     
     
                $('#buttonconfirm').click(function() {
                
                $.ajax({
                    type: 'POST',
                    url: "home_base_data_process.jsp",
                    data: "notifcode=<%=notifcode%>&act=<%=act%>&notifcolumn=<%=notifcolumn%>&addlinfo=<%=addlinfo%>",
                    cache:false,
                    success: function(d) {
                        $("#data").empty();
                        $("#data").html(d);
                        $("#data").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                    }	});
                
                
                 });
          
     
          }); 
      </script>
      
      
<div class="popup_notif">      
<div class="popup_notif_icon"></div>
<div class="popup_notif_title"><b>Notification :</b> <%=notifTitle%></div>
<div id="popup_notif_confirm">
        <table class="wrap_notif">
            <tr><td width="20px">Click OK untuk menutup notification ini
                    <button id="buttonconfirm" type="submit">OK</button>
                </td>
            </tr>
            </table>
</div>
<div id="popup_notif_content">
    <div class="popup_notif_desc"><%=notifDescDisp%></div>
    
    <div class="popup_notif_image"><img id="image_notif_box" src="<%=imagefullpath%>" onerror="if (this.src != '<%=imagefullpathdefault%>') this.src = '<%=imagefullpathdefault%>'; this.style='width:<%=imageFileDefaultwidth%>px;height:<%=imageFileDefaultheight%>px;'  " alt="Image Notification" style="width:<%=imageFileDefaultwidth%>px;height:<%=imageFileDefaultheight%>px;"></div>
    
    <% if(stat_swfntf==1) { %>
    <div id="popup_notif_swf"></div>
    <% } %>
</div>

</div>
