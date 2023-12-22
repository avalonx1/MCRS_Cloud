<%@include file="../../../includes/check_auth_layer3.jsp"%>

<div id="stylized" class="myform">
    <form class="cmenu" id="createItemForm" method="post" action="#">

        <h1>Create Item</h1>
        <p>This form is used to create item</p>

        <label>Item Name *
            <span class="small"></span>
        </label>
        <input type="text" id="itemname" name="itemname"  maxlength="100" />
        <label>Item grouping label
            <span class="small"></span>
        </label>
        <input type="text" id="itemgrouping" name="itemgrouping"  maxlength="30"  />
        <label>Item Category
            <span class="small"></span>
        </label>
        <select id="itemCat" name="itemCat"> 

            <%
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,CAT_CODE||' - '||CAT_NAME FROM t_itemcat ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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

        </select>
        <label>Item Group
            <span class="small"></span>
        </label>
        <select id="itemgroup" name="itemgroup">

            <%
                 
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,GROUP_CODE||' - '||GROUP_NAME FROM t_itemgroup ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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

        </select>    
        <label>Item Group Unit
            <span class="small"></span>
        </label>
        <select id="itemgroupunit" name="itemgroupunit">

            <%
                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,T_CODE||' - '||T_NAME FROM T_ITEMGROUPUNIT "
                                + "WHERE ID in  (select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER where ITEMGROUP2USER="+v_userID+" ) "
                                + "ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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

        </select>
        <label>Item Type
            <span class="small"></span>
        </label>
        <select id="itemtype" name="itemtype">

            <%
                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "SELECT ID,TYPE_CODE||' - '||TYPE_NAME FROM t_itemtype ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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

        </select> 

        <label>Machine Name
            <span class="small"></span>
        </label>
        <input type="text" name="itemmachine"  maxlength="50"/>
        <label>IP Address
            <span class="small"></span>
        </label>
        <input type="text" name="ipaddr"  maxlength="20"/>

        <label>Login Machine User Info
            <span class="small"></span>
        </label>
        <input type="text" name="loginuser"   maxlength="50"/>
        <label>Login Machine Password Info
            <span class="small"></span>
        </label>
        <input type="text" name="loginpass"  maxlength="50"/>
        <label>Source Path
            <span class="small"></span>
        </label>
        <input type="text" name="sourcepath"  maxlength="200"/>
        <label>Script Name
            <span class="small"></span>
        </label>
        <input type="text" name="scriptname"  maxlength="100"/>

        <label>Document Handover
            <span class="small"></span>
        </label>
        <select id="docstatus" name="docstatus">
            <option value="Yes" >Provided</option>
            <option value="No" >Not Provided</option>          
        </select> 

        <label>Handover Date
            <span class="small"></span>
        </label>
        <input id="handoverdate" name="handoverdate" type="text" />

        <label>Handover PIC
            <span class="small"></span>
        </label>
        <input type="text" name="handoverpic"  maxlength="50"/>


        <label >launch Date
            <span class="small"></span>
        </label>
        <input id="launchdate" name="launchdate" type="text" />

        <label id="sla_timelabel">SLA Time (HH)
            <span class="small">leave blank if there is no SLA</span>
        </label>
        <label id="sla_datelabel">SLA Date (DAY)
            <span class="small">leave blank if there is no SLA</span>
        </label>
        <input id="sla_time" name="sla_time" type="text" />
        <input id="sla_date" name="sla_date" type="text" />


        <label id="item_showtimelabel">Show every time
            <span class="small"></span>
        </label>
        <input id="item_showtime" name="item_showtime" type="text" />
        <label id="item_showdatelabel">Show every date
            <span class="small"></span>
        </label>
        <input id="item_showdate" name="item_showdate" type="text" />
        <label>Inorder
            <span class="small"></span>
        </label>
        <input id="inorder" name="inorder" type="text" />

        <label>Report D-x
            <span class="small"></span>
        </label>
        <select id="report_day" name="report_day">
            <option value="0" >N/A</option>
            <option value="1" >D-1</option>
            <option value="2" >D-2</option>
            <option value="3" >D-3</option>
            <option value="4" >D-4</option>

        </select> 

        <label>Status Item
            <span class="small"></span>
        </label>
        <select id="itemStatus" name="itemStatus">
            <option value="1" >Active</option>

        </select> 

        <span class="small">*) mandatory</span>
        <button type="submit">Submit</button>
        <div class="spacer"></div>
        <!--<button type="reset">Reset</button> -->
        <div class="spacer_form"></div>

    </form>
</div>
<script type="text/javascript">
    
    $(document).ready(function() {
    
               
        var widthform = $(".myform").css("width");
        var widthfill=widthform.substr(0, widthform.length-2)-300;
        //alert(widthfill);
    
        $("#stylized input").css("width",widthfill);   
        $("#stylized select").css("width",widthfill);    
        $("#stylized textarea").css("width",widthfill);    
      

        $( "#handoverdate" ).datepicker({dateFormat: 'yy/mm/dd'});
        $( "#launchdate" ).datepicker({dateFormat: 'yy/mm/dd'});
                
        $( "#sla_time" ).timepicker(
        {  
            duration: '',  
            timeOnlyTitle:'Choose Time(HH)',
            hourText:'Hour',
            showTime: true,  
            constrainInput: false,  
            showMinute:false,
            stepMinutes: 1,  
            stepHours: 1,  
            altTimeField: '',  
            time24h: true,   
            timeFormat: 'h'
        }).focus(function() { $(".ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current").remove();
        });
                
        $( "#sla_date" ).timepicker(
        {  
            duration: '',  
            timeOnlyTitle:'Choose X-DAY',
            hourText:'DAY',
            showTime: true,  
            constrainInput: false,  
            showMinute:false,
            stepMinutes: 1,  
            stepHours: 1,  
            altTimeField: '',  
            time24h: true,   
            timeFormat: 'h'
        }).focus(function() { $(".ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current").remove();
        });
                
                
          
          
        $( "#item_showtime" ).timepicker(
        {  
            duration: '', 
            timeOnlyTitle:'Choose Time(HH)',
            hourText:'Hour',
            showTime: true,  
            constrainInput: false,  
            showMinute:false,
            stepMinutes: 1,  
            stepHours: 1,  
            altTimeField: '',  
            time24h: true,   
            timeFormat: 'h'
        }).focus(function() { $(".ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current").remove();
        });
                
        $( "#item_showdate" ).datepicker({
            changeMonth: false,
            changeYear: false,
            stepMonths: 0,
            dateFormat: 'dd'
        }).focus(function() {
            $(".ui-datepicker-prev, .ui-datepicker-next").remove();
        });
            
       
       if ( $('#itemCat').val()===1   )
            { 
                
                $('#sla_date').hide(); 
                $('#sla_datelabel').hide();
                $('#item_showdate').hide();
                $('#item_showdatelabel').hide(); 
                $('#sla_time').show();
                $('#sla_timelabel').show();
                $('#item_showtime').show();
                $('#item_showtimelabel').show();
                
            }else{
                
                $('#sla_date').show();
                $('#sla_datelabel').show();
                $('#item_showdate').show();
                $('#item_showdatelabel').show();
                $('#sla_time').hide();
                $('#sla_timelabel').hide();
                $('#item_showtime').hide();
                $('#item_showtimelabel').hide();
            }
            
        
            
           
        $('#itemCat').change(function() {
            var str = "";
         
            if($('#itemCat').val()===1) {
                $('#sla_date').hide(); 
                $('#sla_datelabel').hide();
                $('#item_showdate').hide();
                $('#item_showdatelabel').hide(); 
                $('#sla_time').show();
                $('#sla_timelabel').show();
                $('#item_showtime').show();
                $('#item_showtimelabel').show();
            
            }else{
                $('#sla_date').show();
                $('#sla_datelabel').show();
                $('#item_showdate').show();
                $('#item_showdatelabel').show();
                $('#sla_time').hide();
                $('#sla_timelabel').hide();
                $('#item_showtime').hide();
                $('#item_showtimelabel').hide();
            }
        
        });


        $('#createItemForm').submit(function(){
            $('#loading').show();
            $.ajax({
                type: 'POST',
                url: "tracking/items/add_item_process.jsp",
                data: $(this).serialize(),
                success: function(data) {
                    $("#status_msg").empty();
                    $("#status_msg").html(data);
                    $("#status_msg").show();
                },
                complete: function(){
                    $('#loading').hide();
                }
                        
            });
            return false;
        });
    
    

    });
</script>

