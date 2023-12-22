<%@page import="java.nio.file.Files"%>
<%@include file="../../includes/check_auth_layer1.jsp"%>
<%  
        
String vkeysecret = request.getParameter("keysecret"); 
          
String SWFFilename="";
String SWFDocRoot="";
String keysecret="";

        
        auth checkFile = new auth(v_clientIP);
        try { 
         SWFDocRoot=checkFile.getParamValue("SWFNTF_DOCROOT_RELATIVE");
         SWFFilename=checkFile.getParamValue("SWF_NTF_DEFAULT");
         keysecret=checkFile.getParamValue("KEYSECRET");
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         checkFile.close();
         }
        
        
        boolean vCheckEligible = false;
        if (vkeysecret.equals(keysecret)) {
            vCheckEligible=true;
        }
        
        
        
  if (vCheckEligible) {

    String SWFFilefull=SWFDocRoot+"/"+SWFFilename;     
                        
    //File Notif : <%=SWFFilefull
%>

<div style="position:relative;left:10px;top:10px;">

<div id="documentViewer" class="flexpaper_viewer" style="width:770px;height:500px"></div>
<script type="text/javascript">
$(document).ready(function() {
    
    
    var wind_adj_height=$("#content").height()-100;
    var wind_adj_width=$("#content").width()-30;
    
    $('.flexpaper_viewer').css({'height' : wind_adj_height});
    $('.flexpaper_viewer').css({'width' : wind_adj_width});
    
    var startDocument = "Paper";

    $('#documentViewer').FlexPaperViewer(
            { config : {

                SWFFile : '<%=SWFFilefull%>',

                Scale : 0.6,
                ZoomTransition : 'easeOut',
                ZoomTime : 0.5,
                ZoomInterval : 0.2,
                FitPageOnLoad : true,
                FitWidthOnLoad : false,
                FullScreenAsMaxWindow : false,
                ProgressiveLoading : false,
                MinZoomSize : 0.2,
                MaxZoomSize : 5,
                SearchMatchAll : false,
                InitViewMode : 'Portrait',
                RenderingOrder : 'flash',
                StartAtPage : '',

                ViewModeToolsVisible : true,
                ZoomToolsVisible : true,
                NavToolsVisible : true,
                CursorToolsVisible : true,
                SearchToolsVisible : true,
                WMode : 'window',
                localeChain: 'en_US'
            }}
    );


     }); 
</script>

</div>
               
                <%
               
                 } else { 
            
            response.sendRedirect("insufficient.jsp");
            
        };
        
        
        %>
