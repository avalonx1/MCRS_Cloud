<!doctype html>
<html>
<head>
    <title>Doumet Viewer</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
    <style type="text/css" media="screen">
        html, body	{ height:100%; }
        body { margin:0; padding:0; overflow:auto; }
        #flashContent { display:none; }
    </style>
    <link rel="stylesheet" type="text/css" href="../../style/flexpaper.css" />
    <script type="text/javascript" src="../../js_file/jquery.min.js"></script>
    <script type="text/javascript" src="../../js_file/flexpaper.js"></script>
    <script type="text/javascript" src="../../js_file/flexpaper_handlers.js"></script>
    
</head>
<body>
<div style="position:absolute;left:10px;top:10px;">

<div id="documentViewer" class="flexpaper_viewer" style="width:770px;height:500px"></div>
<script type="text/javascript">

    var startDocument = "Paper";

    $('#documentViewer').FlexPaperViewer(
            { config : {

                SWFFile : 'RPT_EOD019_A_20160212_000_LABARUGI_RINCI_KONS.pdf.swf',

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
</body>
</html>