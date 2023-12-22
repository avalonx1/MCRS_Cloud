<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
                     
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
         
         
    
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
           
            <tr><td width="80px">Navigation Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            <tr><td width="80px">Parent </td><td>:
                <select id="parent_menu" name="parent_menu">
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
                                                    +"ORDER BY name_fullname  ) a where stat=1 ";
                                            
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
    </select></td> </tr>
            
     <tr><td width="80px">Leaf </td><td>:
                <select id="leaf" name="leaf">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT -1 ID, '-All-' AS DESC,1 AS ORD UNION ALL SELECT 1 ID, 'Yes' AS DESC,2 AS ORD UNION ALL SELECT 0 ID,'No' AS DESC,3 AS ORD ) a"
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (leaf.equalsIgnoreCase(resultSet.getString(1))) {
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
    </select></td></tr>
    
      <tr><td width="80px">status </td><td>:
                <select id="stat" name="stat">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT -1 ID, '-All-' AS DESC,1 AS ORD UNION ALL SELECT 1 ID, 'Active' AS DESC,2 AS ORD UNION ALL SELECT 0 ID,'Not Active' AS DESC,3 AS ORD ) a"
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (stat.equalsIgnoreCase(resultSet.getString(1))) {
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
    </select></td></tr>
      
     
             <tr><td colspan="2"><button type="submit">GO</button></td></tr>
        </table>
    </form>
</div>
<script type="text/javascript">



    $('#filter_form').submit(function(){
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/menu_navigation/tree_master/tree_master_list_data.jsp",
            data: $(this).serialize(),
            success: function(data) {
                $("#data_inner").empty();
                $('#icon_panel_show_filter').fadeIn('slow');
                $('#icon_panel_hide_filter').fadeOut('slow');
                $('#filter_box_data').slideUp();
                $("#data_inner").html(data);
                $("#data_inner").show();
            },
            complete: function(){
                $('#loading').hide();
            }
                        
        });
        return false;
    });

    
</script>

