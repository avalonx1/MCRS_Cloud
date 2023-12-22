<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
                     
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_modul = request.getParameter("filter_modul");
      String filter_usergroup = request.getParameter("filter_usergroup");
      String filter_userlevel = request.getParameter("filter_userlevel");
      
        
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
      
         
    
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
           
            <tr><td width="80px">Navigation Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            <tr><td width="80px">Modul </td><td>:
                <select id="filter_modul" name="filter_modul">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from (SELECT 0 ID,'-All-' AS DESC, 1 ORD UNION ALL SELECT id ID, name AS DESC, 2 ORD "
                                                    + " FROM t_module ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_modul.equalsIgnoreCase(resultSet.getString(1))) {
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
            
     <tr><td width="80px">Group </td><td>:
                <select id="filter_usergroup" name="filter_usergroup">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD, -1 AS BRANCH_FLAG UNION ALL SELECT id ID,group_code||' - '||group_name AS DESC, 2 ORD,branch_flag "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 4,3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_usergroup.equalsIgnoreCase(resultSet.getString(1))) {
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
    
     <tr><td width="80px">Level </td><td>:
                <select id="filter_userlevel" name="filter_userlevel">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD UNION ALL SELECT id ID,level_code||' - '||level_name AS DESC, 2 ORD "
                                                    + " FROM t_user_level ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_userlevel.equalsIgnoreCase(resultSet.getString(1))) {
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
            url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_data.jsp",
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

