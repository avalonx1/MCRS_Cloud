<%@include file="../../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="0";
 
 String name="";
 String url="";
 String urutan="";
 String parent_menu="";
 String leaf="";
 String stat="";
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     

 
     String denom="999,999,999,999,999.99";
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                              sql = "select id,name,url,urutan,parent_menu,parent_menu_name,leaf,stat "
                              + " from v_menu "
                              + "  where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                name = resultSet.getString("name");
                                url = resultSet.getString("url");
                                urutan = resultSet.getString("urutan");
                                parent_menu = resultSet.getString("parent_menu");
                                leaf = resultSet.getString("leaf");
                                stat = resultSet.getString("stat");
                                
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
     
     
 }
 
%>
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#">
    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> Record </h1>
        <p></p>
   <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
   

    <tr>
    <td>Nama</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="name" name="name" size="20" maxlength="100" value="<% out.println((name == null) ? "" : name); %>"  /></td>
    </tr>
    
    
    <tr>
    <td>URL Path</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="url" name="url" size="80" maxlength="200" value="<% out.println((url == null) ? "" : url); %>"  /></td>

    </tr>
    
    
    <tr>
    <td>Order menu</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="urutan" name="urutan" size="20" maxlength="10" value="<% out.println((urutan == null) ? "" : urutan); %>"  /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Parent menu</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="parent_menu" name="parent_menu">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "select * from ( WITH RECURSIVE tree AS "
                                                    +"(SELECT id, name, parent_menu, CAST(name As varchar(1000)) As name_fullname,stat "
                                                    +"FROM t_menu "
                                                    +"WHERE parent_menu=0 "
                                                    +"UNION ALL "
                                                    +"SELECT si.id,si.name, "
                                                    +"	si.parent_menu, "
                                                    +"	CAST(sp.name_fullname || '->' || si.name As varchar(1000)) As name_fullname,si.stat "
                                                    +"FROM t_menu As si "
                                                    +"	INNER JOIN tree AS sp "
                                                    +"	ON (si.parent_menu = sp.id) "
                                                    +") "
                                                    +"SELECT id, name_fullname,stat "
                                                    +"FROM tree "
                                                    +"ORDER BY name_fullname ) a where stat=1";
                                            
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (parent_menu.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
  
  
    
 
</table></td></tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left"> <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">

    
    
               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/menu_navigation/tree_master/tree_master_list_data.jsp",
                            data: "",
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });        
             });
             
             
    $('#modifyForm').submit(function () {
        $("#status_msg").empty();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/menu_navigation/tree_master/tree_master_list_modify_process.jsp",
            data: $(this).serialize(),
            success: function (data) {

                $("#status_msg").empty();
                $("#status_msg").html(data);
                $("#status_msg").show();
            },
            complete: function () {
                $('#loading').hide();
            }
        });
        return false;
    });


</script>

