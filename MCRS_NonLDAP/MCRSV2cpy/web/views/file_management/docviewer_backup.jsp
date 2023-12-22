<%@include file="../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    
    String filenamefull="file_management/RPT_EOD019_A_20160212_000_LABARUGI_RINCI_KONS.pdf.swf";
    String sql;
    
    
%>
<div>Report name : Laporan Laba Rugi Rinci </div>
<div style="position:relative;left:10px;top:10px;">

<div id="documentViewer" class="flexpaper_viewer" style="width:700px;height:400px"></div>
<script type="text/javascript">

    var startDocument = "Paper";

    $('#documentViewer').FlexPaperViewer(
            { config : {

                SWFFile : '<%=filenamefull%>',

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
</script>

</div>
