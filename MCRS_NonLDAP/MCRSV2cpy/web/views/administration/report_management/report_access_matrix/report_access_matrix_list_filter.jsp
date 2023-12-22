<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
                     
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_report_id = request.getParameter("filter_report_id");
      String filter_group_master_id = request.getParameter("filter_group_master_id");
      String filter_group_child_id = request.getParameter("filter_group_child_id");
      String filter_userlevel_id = request.getParameter("filter_userlevel_id");
      
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_report_id==null) {
           filter_report_id="0";
         }
         
         if (filter_group_master_id==null) {
           
           try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "select id "
                                                    + " FROM t_user_group where id="+v_userGroup+" "
                                                    + "  ORDER BY 1";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                               
                                                filter_group_master_id=resultSet.getString("ID");
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
           
         }
         
          if (filter_group_child_id==null) {
           filter_group_child_id="0";
         }
          
             if (filter_userlevel_id==null) {
           filter_userlevel_id="0";
         }
      
         
    
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
           
            <tr><td width="80px">Report Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            <tr><td width="80px">Report  </td><td>:
                <select id="filter_report_id" name="filter_report_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from (SELECT 0 ID,'-All-' AS DESC, 1 ORD UNION ALL SELECT id ID, report_code||' - '||report_name||' ('||report_extension||')' AS DESC, 2 ORD "
                                                    + " FROM t_report_item WHERE report_status=1 ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_report_id.equalsIgnoreCase(resultSet.getString(1))) {
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
            
     <tr><td width="80px">Group Master </td><td>:
                <select id="filter_group_master_id" name="filter_group_master_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD,-1 AS BRNFL UNION ALL SELECT id ID,group_code||' - '||group_name AS DESC, 2 ORD,branch_flag "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_group_master_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    
             
     <tr><td width="80px">Group Child </td><td>:
                <select id="filter_group_child_id" name="filter_group_child_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD,-1 AS BRNFL UNION ALL SELECT id ID,group_code||' - '||group_name AS DESC, 2 ORD,branch_flag "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_group_child_id.equalsIgnoreCase(resultSet.getString(1))) {
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
                <select id="filter_userlevel_id" name="filter_userlevel_id">
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
                                                if (filter_userlevel_id.equalsIgnoreCase(resultSet.getString(1))) {
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
            url: "administration/report_management/report_access_matrix/report_access_matrix_list_data.jsp",
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

