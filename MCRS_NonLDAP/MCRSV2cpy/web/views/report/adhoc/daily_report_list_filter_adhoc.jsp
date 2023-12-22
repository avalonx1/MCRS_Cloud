<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
                   
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_tanggal = request.getParameter("filter_tanggal");  
      String filter_group_child_id = request.getParameter("filter_group_child_id");  
      String report_extension = request.getParameter("report_extension"); 
      String report_fileexist = request.getParameter("report_fileexist");  
      String report_group_id = request.getParameter("report_group_id"); 
      
      String sorting_column = request.getParameter("sorting_column"); 
      String sorting_type = request.getParameter("sorting_type"); 
      
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_tanggal==null) {
             filter_tanggal=v_currWorkDay;
         }
         
         if (report_extension==null) {
           report_extension="0";
         }
         
          if (report_group_id==null) {
           report_group_id="0";
         }
         
        if (report_fileexist == null) {
            report_fileexist = "-1";
        }
       
        
         
         
          if (filter_group_child_id==null) {
            try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id "
                                                    + " FROM t_user_group where id="+v_userGroup+" "
                                                    + "  ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                               filter_group_child_id=resultSet.getString("id"); 
                                                
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
          
         if (sorting_column==null) {
           sorting_column="0";
         }
          
        if (sorting_type == null) {
            sorting_type = "ASC";
        }
            
    
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td>EOD Date </td><td >:<input readonly=true id="filter_tanggal" type="text" name="filter_tanggal" value="<%=filter_tanggal%>" size="20" maxlength="20" /></td></tr>
            <tr><td width="80px">Report Name </td><td >:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            <tr><td width="80px">Group Access </td><td >:
                <select id="filter_group_child_id" name="filter_group_child_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT distinct group_child_id id, group_code_child||' - '||group_name_child AS DESC,branch_flag "
                                                    + " FROM v_user_group_access_matrix where group_master_id="+v_userGroup+" and user_level_id="+v_userLevel+"  "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            System.out.println(sql);
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
     
            <tr><td width="80px">Report Ext </td><td>:
                <select id="report_extension" name="report_extension">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from (SELECT '0' ID,'-All-' AS DESC, 1 AS ORD UNION ALL SELECT distinct report_extension ID, report_extension AS DESC, 2 AS ORD "
                                                    + " FROM v_report_item where report_status=1 and freq_code IN ('ADHOC') ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_extension.equalsIgnoreCase(resultSet.getString(1))) {
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
    
             
             <tr><td width="80px">Report Group </td><td>:
                <select id="report_group_id" name="report_group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC,1 AS ORD UNION ALL SELECT id, group_code||' - '||group_name AS DESC, 2 AS ORD "
                                                    + " FROM t_report_group where record_stat=1) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_group_id.equalsIgnoreCase(resultSet.getString(1))) {
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
             
    <tr><td width="80px">File Report </td><td>:
                <select id="report_fileexist" name="report_fileexist">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT '-1' ID,'-All-' AS DESC, 0 AS ORD UNION ALL SELECT '1' ID,'File Exist' AS DESC, 1 AS ORD UNION ALL SELECT '0' ID,'File Not Exist' AS DESC, 2 AS ORD ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_fileexist.equalsIgnoreCase(resultSet.getString(1))) {
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
     
    <p></p>
    
    <tr><td width="80px">Order by </td><td>:
                <select id="sorting_column" name="sorting_column">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ("
                                                    + "SELECT '0' ID,'None' AS DESC, 1 AS ORD UNION ALL "
                                                    + "SELECT 'report_code' ID,'Report Code' AS DESC, 2 AS ORD UNION ALL " 
                                                    + "SELECT 'report_name' ID,'Report Name' AS DESC, 3 AS ORD UNION ALL "
                                                    + "SELECT 'report_group_name' ID,'Report Group' AS DESC, 4 AS ORD UNION ALL "
                                                    + "SELECT 'report_extension' ID,'Report Extension' AS DESC, 5 AS ORD UNION ALL "
                                                    + "SELECT 'report_owner_div_name' ID,'Report Division' AS DESC, 6 AS ORD UNION ALL "
                                                    + "SELECT 'report_popularity' ID,'Popularity' AS DESC, 7 AS ORD "
                                                    + " ) a ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (sorting_column.equalsIgnoreCase(resultSet.getString(1))) {
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
    </select><select id="sorting_type" name="sorting_type">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ("
                                                    + "SELECT 'ASC' ID,'Ascending' AS DESC, 1 AS ORD UNION ALL "
                                                    + "SELECT 'DESC' ID,'Descending' AS DESC, 2 AS ORD " 
                                                    + " ) a ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (sorting_type.equalsIgnoreCase(resultSet.getString(1))) {
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
    </td></tr>
    
    
    
    
             <tr><td colspan="2"><button type="submit">GO</button></td></tr>
        </table>
  
    </form>
</div>
<script type="text/javascript">



 var dateToday = new Date();
 
$('#ui-datepicker-div').css('display','none');
$("#filter_tanggal").datepicker({
    dateFormat: 'yymmdd',
    buttonImage: '../images/date_15.png',
    buttonImageOnly: true,
    showOn:'button',
    buttonText: 'Click to show the calendar',
    maxDate:dateToday
});



    
 filter_tanggal= document.getElementById("filter_tanggal").value;
    
    
    $('#filter_form').submit(function(){
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "report/adhoc/daily_report_list_data_adhoc.jsp",
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

