<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%

    String act_id = request.getParameter("act_id");
    int i = 0;  
%>
           
    <script type="text/javascript">
         $(document).ready(function() {

            $("#title_box").empty();
            $('#title_box').html("<h1>Activities  </h1><p>All Jobs for today (included all pending job)</p>");
            $("#title_box").show();
  
            $('#data').show();
            $('#data_inner').show();
            $('#filter_box').show();
            $('#filter_box_data').slideUp('fast');   
            $('#icon_panel_hide_filter').fadeOut('slow');
            $('#icon_panel_show_filter').fadeIn('slow');
            
            $('#icon_panel_hide_action').hide();
            $('#icon_panel_show_action').show();
            //$('#icon_panel_hide_action').hide();
            //$('#icon_panel_show_action').hide();
            
            $('#action_box_data').empty();
            $('#action_box_data').hide();
              
            
                     
         
  
            
            
            $('#loading_filter').show();
            $.ajax({
                    type: 'POST',
                    url: "tracking/activity/activity_list_filter.jsp",
                    data: "",
                    success: function(data) {
                        $('#filter_box_data').empty();
                        $('#filter_box_data').html(data);

                    },
                    complete: function(){
                        $('#loading_filter').hide();
                    }
                });


              $('#loading_filter').show();
              $.ajax({
                    type: 'POST',
                    url: "tracking/activity/activity_list_action.jsp",
                    data: "",
                    success: function(data) {
                        
                        $('#action_box_data').empty();
                        $('#action_box_data').html(data);
                    },
                    complete: function(){
                        $('#loading_filter').hide();
                    }
                });


                        
            $('#loading_inner').show();
            $.ajax({
                    type: 'POST',
                    url: "tracking/activity/activity_list_data.jsp",
                    data: "",
                    success: function(data) {
                        
                        $('#data_inner').empty();
                        $('#data_inner').html(data);
                        $('#data_inner').show();
                    },
                    complete: function(){
                        $('#loading_inner').hide();
                    }
                });
            
            
            $.ajax({
                    type: 'POST',
                    url: "tracking/activity/activity_list_refresh.jsp",
                    data: "",
                    success: function(data) {
                        $('#refresh_page').empty();
                        $('#refresh_page').html(data);
                        //$('#data_inner').show();
                    },
                    complete: function(){
                        //$('#loading').hide();
                    }
                });
            

            //filter box
            //show
            $('#icon_panel_show_filter').click(function(){
                
            
            $('#icon_panel_hide_action').fadeOut('slow');
            $('#icon_panel_show_action').fadeIn('slow');
            $('#action_box_data').hide();
            $('#icon_panel_show_filter').fadeOut('slow');
            $('#icon_panel_hide_filter').fadeIn('slow');
            $('#filter_box_data').slideDown('fast');
            
            
            setFocusto('filter_itemname');
            
            });
            //hide
            $('#icon_panel_hide_filter').click(function(){
            $('#icon_panel_hide_filter').fadeOut('slow');
            $('#icon_panel_show_filter').fadeIn('slow');
            $('#filter_box_data').slideUp('fast');
            });

            //action box
            //show
           $('#icon_panel_show_action').click(function(e){
        
            e.stopPropagation();
            e.preventDefault();
           
            $('#icon_panel_hide_filter').fadeOut('slow');
            $('#icon_panel_show_filter').fadeIn('slow');
            $('#filter_box_data').hide();
            $('#icon_panel_show_action').fadeOut('slow');
            $('#icon_panel_hide_action').fadeIn('slow');
            $('#action_box_data').slideDown('fast');
            setFocusto('filter_itemname');
            });
            //hide
            $('#icon_panel_hide_action').click(function(e){  
           
            e.stopPropagation();
            e.preventDefault();
            $('#icon_panel_hide_action').fadeOut('slow');
            $('#icon_panel_show_action').fadeIn('slow');
            $('#action_box_data').slideUp('fast');
            });
            
           });


    </script>


