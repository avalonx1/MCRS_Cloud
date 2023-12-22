<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_modul = request.getParameter("filter_modul");
      String filter_usergroup = request.getParameter("filter_usergroup");
      String filter_userlevel = request.getParameter("filter_userlevel");
      

    if (id == null) {
            id = "0";
        }

     if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_modul==null) {
           filter_modul="0";
         }
         
         if (filter_usergroup==null) {
           filter_usergroup=v_userGroup;
         }
         
          if (filter_userlevel==null) {
           filter_userlevel=v_userLevel;
         }
      
          
    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Action</th>
                <th>Module</th>
                <th>User group</th>
                <th>User level</th>
                <th>Tree Name</th>
                <th>Tree url</th>
                <th>Order</th>
                <th>Tree ID</th>
                <th>Parent ID</th>
                <th>Leaf status</th>
                <th>Menu status</th>
                <th>Record status</th>
                
            </tr>
        </thead>

        <tbody>

            <%

                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                         sql = "SELECT  a.id, a.menu_id,a.name, a.url, a.urutan, a.parent_menu,"
                             + "a.level_code||' - '||a.level_name user_level_name,a.user_level_id,"
                             + "a.group_code||' - '||a.group_name user_group_name,a.user_group_id,"
                             + "a.modul,a.module_name, a.leaf, a.stat,a.status_matrix, b.name_fullname "
                               + "FROM v_menu_matrix a left join ( WITH RECURSIVE tree AS "
                                                    +"(SELECT id, name, parent_menu, CAST(name As varchar(1000)) As name_fullname,url,urutan,leaf,stat "
                                                    +"FROM t_menu "
                                                    +"WHERE parent_menu=0 "
                                                    +"UNION ALL "
                                                    +"SELECT si.id,si.name, "
                                                    +" si.parent_menu, "
                                                    +" CAST(sp.name_fullname || '->' || si.name As varchar(1000)) As name_fullname,si.url,si.urutan,si.leaf,si.stat "
                                                    +" FROM t_menu as si "
                                                    +"	INNER JOIN tree as sp "
                                                    +"	ON (si.parent_menu = sp.id) "
                                                    +") "
                                                    +"SELECT id, name_fullname,url,urutan,leaf,stat,parent_menu "
                                                    +"FROM tree " 
                                                    +"ORDER BY name_fullname ) b on a.menu_id=b.id "
                                                    +" where 1=1 ";
                                 
                        /*
                        sql = "select id, menu_id,name, url, urutan, parent_menu,case when parent_menu=0 then 'Root' else parent_menu_name end parent_menu_name, "
                             + "level_code||' - '||level_name user_level_name,user_level_id,"
                             + "group_code||' - '||group_name user_group_name,user_group_id,"
                             + "modul,module_name, leaf, stat,status_matrix "
                             + " from v_menu_matrix "
                             + " where 1=1 ";
                        */
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and upper(name_fullname) like upper('%"+filter_itemname+"%')";
                        } 
                    
                        if (filter_modul.equals("0")) {
                        sql += " ";
                        }
                        else {
                        sql += " and modul = "+filter_modul+" ";
                        } 
                    
                        if (filter_usergroup.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and user_group_id = "+filter_usergroup+" ";
                        }
                        
                        if (filter_userlevel.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and user_level_id = "+filter_userlevel+" ";
                        }
               
                        sql += " order by name_fullname";
                      

                        //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString("ID")+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
                      
                      <td>
                        
                                <div class="action_menu_wrap">
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="edit this items ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                                <% 
                                 
                                 String recStat= resultSet.getString("status_matrix");
                                 String recStatName="";
                                 
                                if ( recStat.equals("1")) {
                                    recStatName="Deactivate";
                                
                                %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="deactivate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } else { recStatName="Activate";  %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="activate_icon" title="activate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } %>
                                
                                
                                <script type="text/javascript">
                                    
                                         <%if (id!=null) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_modify.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,action:2},
                                        success: function(data) {
                                            $('#data_inner').empty();
                                            $('#data_inner').html(data);
                                            $('#data_inner').show();

                                        },
                                        complete: function(){
                                            $('#loading').hide();
                                        }
                                        });
                                        
                                    return false;
                                    });
            
                                    $('#recstat_<%=resultSet.getString(1)%>').click(function() {
                                    var answer = confirm('Are You Sure want to <%=recStatName%> ID <%=resultSet.getString("ID")%> ?');
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_recstat_process.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,recstat:<%=recStat%>},
                                        success: function(data) {
                                            $('#status_msg').empty();
                                            $('#status_msg').html(data);
                                            $('#status_msg').show();

                                        },
                                        complete: function(){
                                           $('#loading').hide();
                                        }
                                        });
                                        
                                     }
                                        
                                    return false;
                                    });
                                    
                               </script>
                       
                      </td>

                      <% 
                        
                         out.println("<td> " + resultSet.getString("module_name") + " </td>"); 
                         out.println("<td> " + resultSet.getString("user_group_name") + " </td>"); 
                         out.println("<td> " + resultSet.getString("user_level_name") + " </td>");
                         out.println("<td> " + resultSet.getString("name_fullname") + " </td>");
                         out.println("<td> " + resultSet.getString("url") + " </td>");
                         out.println("<td> " + resultSet.getString("urutan") + " </td>");
                         out.println("<td> " + resultSet.getString("id") + " </td>");
                         out.println("<td> " + resultSet.getString("parent_menu") + " </td>");
                         out.println("<td> " + resultSet.getString("leaf") + " </td>"); 
                         out.println("<td> " + resultSet.getString("stat") + " </td>");
                         out.println("<td> " + resultSet.getString("status_matrix") + " </td>");
                         

                         out.println("</tr> ");
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

            %>
        </tbody>
        <tfoot>
            <tr>
                <td>-</td>
                <td> <%=i%> Record(s)</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
              <td>-</td>
              <td>-</td>
              <td>-</td>
            </tr>
        </tfoot>
    </table>
        
    <script type="text/javascript">
         $(document).ready(function() {
           
 
 

 
 
              $('#refresh_data').click(function() {
                  
 filter_itemname= document.getElementById("filter_itemname").value;   
 filter_modul= document.getElementById("filter_modul").value;
 filter_usergroup= document.getElementById("filter_usergroup").value;
 filter_userlevel= document.getElementById("filter_userlevel").value;
 
 
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_data.jsp",
                            data: {
                                 filter_itemname:filter_itemname,
                                 filter_modul:filter_modul,
                                 filter_usergroup:filter_usergroup,
                                 filter_userlevel:filter_userlevel
                            },
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
             
             $('#addRecord').click(function() {
                 
                  filter_itemname= document.getElementById("filter_itemname").value;   
 filter_modul= document.getElementById("filter_modul").value;
 filter_usergroup= document.getElementById("filter_usergroup").value;
 filter_userlevel= document.getElementById("filter_userlevel").value;
 
 
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_modify.jsp",
                            data: {filter_itemname:filter_itemname,
                                 filter_modul:filter_modul,
                                 filter_usergroup:filter_usergroup,
                                 filter_userlevel:filter_userlevel},
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
             
            <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
           });
    </script>
</div>


