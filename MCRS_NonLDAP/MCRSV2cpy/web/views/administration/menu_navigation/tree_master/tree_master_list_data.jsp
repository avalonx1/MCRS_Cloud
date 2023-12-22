<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
    String filter_itemname = request.getParameter("filter_itemname");
    String parent_menu = request.getParameter("parent_menu");
    String leaf = request.getParameter("leaf");
    String stat = request.getParameter("stat"); 
      
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (parent_menu==null) {
           parent_menu="-1";
         }
         
         if (leaf==null) {
           leaf="-1";
         }
         
         if (stat==null) {
           stat="-1";
         }

    if (id == null) {
            id = "0";
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
                <th width="50px">Action</th>
                <th >ID Tree</th>
                <th width="100px">Nama Tree</th>
                <th width="200px">Url Path</th>
                <th>Urutan</th>
                <th>ID Parent<br/>Tree</th>
                <th>Parent Tree</th>
                <th>leaf</th>
                <th>Record Status</th>
                <th></th>
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

                        sql = "SELECT * FROM ( WITH RECURSIVE tree AS "
                                                    +"(SELECT id, name, parent_menu, CAST(name As varchar(1000)) As name_fullname,url,urutan,leaf,stat "
                                                    +"FROM t_menu "
                                                    +"WHERE parent_menu=0 "
                                                    +"UNION ALL "
                                                    +"SELECT si.id,si.name, "
                                                    +"	si.parent_menu, "
                                                    +"	CAST(sp.name_fullname || '->' || si.name As varchar(1000)) As name_fullname,si.url,si.urutan,si.leaf,si.stat "
                                                    +"FROM t_menu As si "
                                                    +"	INNER JOIN tree AS sp "
                                                    +"	ON (si.parent_menu = sp.id) "
                                                    +") "
                                                    +"SELECT id, name_fullname,url,urutan,leaf,stat,parent_menu "
                                                    +"FROM tree "
                                                    +"ORDER BY name_fullname ) a "
                              + " where 1=1 ";
                        
                         if (filter_itemname.equals("")==false) {
                        sql += " and upper(name_fullname) like upper('%"+filter_itemname+"%')";
                        } 
                    
                        if (parent_menu.equals("-1")) {
                        sql += " ";
                        }
                        else {
                        sql += " and parent_menu = "+parent_menu+" ";
                        } 
                    
                        if (leaf.equals("-1")) {
                            sql += " ";
                        } else {
                        sql += " and leaf = "+leaf+" ";
                        }
               
                        if (stat.equals("-1")) {
                            sql += " ";
                        } else {
                        sql += " and stat = "+stat+" ";
                        }
                        
                        sql += " order by name_fullname,parent_menu,urutan ";
   
                    
                        //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>" + sql + "</div>");
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
                                 
                                 String recStat= resultSet.getString("stat");
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
                                        url: "administration/menu_navigation/tree_master/tree_master_list_modify.jsp",
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
                                        url: "administration/menu_navigation/tree_master/tree_master_list_recstat_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("id") + " </td>");
                             out.println("<td> " + resultSet.getString("name_fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("url") + " </td>");
                             out.println("<td> " + resultSet.getString("urutan") + " </td>");
                             out.println("<td> " + resultSet.getString("parent_menu") + " </td>");
                             out.println("<td> " + resultSet.getString("leaf") + " </td>");
                             out.println("<td> " + resultSet.getString("stat") + " </td>");
                              out.println("<td></td>");
                              
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
            </tr>
        </tfoot>
    </table>
        
    <script type="text/javascript">
         $(document).ready(function() {
           
              $('#refresh_data').click(function() {
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
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/menu_navigation/tree_master/tree_master_list_modify.jsp",
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
             
         <% if (!id.equals("0") && Integer.parseInt(id)>10 ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
             
             
             
           });
    </script>
</div>


