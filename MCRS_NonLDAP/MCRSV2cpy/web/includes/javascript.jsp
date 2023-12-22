<link rel="Stylesheet" type="text/css" href="../js_file/jquery/theme/ui.all.css"  />
<link rel="stylesheet" type="text/css" href="../style/jquery.treeview.css" />
<link rel="stylesheet" type="text/css" href="../style/mbContainer.css" title="style"  media="screen"/>



<script type="text/javascript" src="../js_file/jquery/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../js_file/jquery/jquery.timer.js"></script>
<script type="text/javascript" src="../js_file/jquery-ui/js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="../js_file/jquery-ui/js/jquery-ui-timepicker-addon.js"></script>


<script type="text/javascript" src="../js_file/fileupload/gistfile1.js"></script>
<script type="text/javascript" src="../js_file/fileupload/Gruntfile.js"></script>
<script type="text/javascript" src="../js_file/fileupload/jquery-fileupload.js"></script>
<script type="text/javascript" src="../js_file/fileupload/jquery-fileupload.min.js"></script>





<!-- CSS -->
<link rel="stylesheet" href="../style/styles.css" type="text/css" />
<link rel="stylesheet" href="../style/flexpaper.css" type="text/css" />


<script type="text/javascript" src="../js_file/tree/jqueryfiletree.js" ></script>
<script type="text/javascript" src="../js_file/jquery/jquery.li-scroller.1.0.js"></script>
<script type="text/javascript" src="../js_file/jquery/jquery.marquee.js"></script>
<script type="text/javascript" src="../js_file/jquery/jquery.marquee.min.js"></script>
<link  rel="stylesheet" type="text/css" href="../js_file/tree/jqueryFileTree.css" media="screen" />

<!--  HIGHCHART  -->
<!-- 1. Add these JavaScript inclusions in the head of your page -->	
<script type="text/javascript" src="../js_file/Highcharts/js/highcharts.js"></script>		
<!-- 1a) Optional: add a theme file -->	
<script type="text/javascript" src="../js_file/Highcharts/js/themes/custom_eoam.js"></script>	
<!-- 1b) Optional: the exporting module -->
<script type="text/javascript" src="../js_file/Highcharts/js/modules/exporting.js"></script>


    <script type="text/javascript" src="../js_file/flexpaper.js"></script>
    <script type="text/javascript" src="../js_file/flexpaper_handlers.js"></script>
                


<script type="text/javascript">
$(document).ready(function() {
    var wind_pc_height=window.screen.height;
    var wind_pc_width=window.screen.width;
    var wind_browser_height=$(window).height();
    var wind_browser_width=$(window).width();
    var wind_adj_height=wind_browser_height-250;
    var wind_adj_width=wind_browser_width-300;
    
     $('#content').css({'height' : wind_adj_height});
     $('#utility').css({'height' : wind_adj_height+50});
     
     $('#running_text').css({'height' : 20});
     
     
     
     
     $('#stat_window').html("Best view in <a href='https://www.google.com/intl/en/chrome/browser/' >google chrome</a> and <a href='https://www.mozilla.org/en-US/firefox/new/' >firefox</a> (current browser size : "+wind_browser_width+"x"+wind_browser_height+" px)");
     
     
     
     
     
});


function setFocus(id){
     var focusToBottom = document.getElementById('content');
     focusToBottom.scrollTop=focusToBottom.scrollHeight;
     focusToBottom.focus();
     var focuselement = document.getElementById(id);
     focuselement.focus();
 }
 
function setFocusto(id){
     var focuselement = document.getElementById(id);
     focuselement.focus();
 }

function poponload(url,title)
{
windetail= window.open(url, title,"location=no,statusbar=no,scrollbars=yes,resizable=no,width=700,height=510");
windetail.focus();
}
function popchart(url,title)
{
windetail= window.open(url, title,"location=no,statusbar=no,scrollbars=no,resizable=0,width=650,height=450");
windetail.focus();
}
</script>
