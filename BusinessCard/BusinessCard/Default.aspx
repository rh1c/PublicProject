﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BusinessCard.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<meta charset="utf-8">--%>
    <title>Business Card Designer</title>

    <!-- style sheets -->
    <link rel="stylesheet" type="text/css" media="screen" href="<%=ResolveUrl("~/css/index.css") %>" />
    <link rel="stylesheet" type="text/css" media="screen" href="<%=ResolveUrl("~/css/prettify.css") %>" />
    <link rel="stylesheet" type="text/css" media="screen" href="<%=ResolveUrl("~/css/styleicons.css") %>" />
    <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet"/>

    <!-- jquery libraries -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/scripts/jquery.hotkeys.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/scripts/prettify.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/scripts/bootstrap/bootstrap.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/scripts/bootstrap/bootstrap-wysiwyg.js") %>"></script>

</head>
<body class="bodyBackground">
    <form id="form1" runat="server">
    <div class="container">

	    <h2 class="non-layout">Business Card Designer<br/></h2>
	    <h5 class="non-layout">(Click on the business card text to edit content.)<br/></h5>

	    <div id="alerts non-layout"></div>
	
	    <div id="popOverContent" class="non-layout">
			    <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor">
			      <div class="btn-group">
				    <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font"><i class="icon-font"></i><b class="caret"></b></a>
				      <ul class="dropdown-menu">
				      </ul>
				    </div>
			      <div class="btn-group">
				    <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font Size"><i class="icon-text-height"></i>&nbsp;<b class="caret"></b></a>
				      <ul class="dropdown-menu">
				      <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li>
				      <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li>
				      <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li>
				      </ul>
			      </div>
			      <div class="btn-group">
				    <a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i></a>
				    <a class="btn" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
				    <a class="btn" data-edit="strikethrough" title="Strikethrough"><i class="icon-strikethrough"></i></a>
				    <a class="btn" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="icon-underline"></i></a>
			      </div>
			      <div class="btn-group">
				    <a class="btn" data-edit="insertunorderedlist" title="Bullet list"><i class="icon-list-ul"></i></a>
				    <a class="btn" data-edit="insertorderedlist" title="Number list"><i class="icon-list-ol"></i></a>
				    <a class="btn" data-edit="outdent" title="Reduce indent (Shift+Tab)"><i class="icon-indent-left"></i></a>
				    <a class="btn" data-edit="indent" title="Indent (Tab)"><i class="icon-indent-right"></i></a>
			      </div>
			      <div class="btn-group">
				    <a class="btn" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)"><i class="icon-align-left"></i></a>
				    <a class="btn" data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i class="icon-align-center"></i></a>
				    <a class="btn" data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i class="icon-align-right"></i></a>
				    <a class="btn" data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i class="icon-align-justify"></i></a>
			      </div>
			      <!--<div class="btn-group">
				      <a class="btn dropdown-toggle" data-toggle="dropdown" title="Hyperlink"><i class="icon-link"></i></a>
					    <div class="dropdown-menu input-append">
						    <input class="span2" placeholder="URL" type="text" data-edit="createLink"/>
						    <button class="btn" type="button">Add</button>
				    </div>
				    <a class="btn" data-edit="unlink" title="Remove Hyperlink"><i class="icon-cut"></i></a>

			      </div>-->
			  
			      <!--<div class="btn-group">
				    <a class="btn" title="Insert picture (or just drag & drop)" id="pictureBtn"><i class="icon-picture"></i></a>
				    <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
			      </div>-->
			      <div class="btn-group">
				    <a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i></a>
				    <a class="btn" data-edit="redo" title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
			      </div>
			      <input type="text" data-edit="inserttext" id="voiceBtn" x-webkit-speech="">
			    </div>

			 
			
		    <!--JS for rich text-->
		    <script>
		        $(function () {
		            function initToolbarBootstrapBindings() {
		                var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                              'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                              'Times New Roman', 'Verdana'],
                              fontTarget = $('[title=Font]').siblings('.dropdown-menu');
		                $.each(fonts, function (idx, fontName) {
		                    fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
		                });
		                $('a[title]').tooltip({ container: 'body' });
		                $('.dropdown-menu input').click(function () { return false; })
                            .change(function () { $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle'); })
                        .keydown('esc', function () { this.value = ''; $(this).change(); });

		                $('[data-role=magic-overlay]').each(function () {
		                    var overlay = $(this), target = $(overlay.data('target'));
		                    overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
		                });
		                if ("onwebkitspeechchange" in document.createElement("input")) {
		                    var editorOffset = $('#editor').offset();
		                    $('#voiceBtn').css('position', 'absolute').offset({ top: editorOffset.top, left: editorOffset.left + $('#editor').innerWidth() - 35 });
		                } else {
		                    $('#voiceBtn').hide();
		                }
		            };
		            function showErrorAlert(reason, detail) {
		                var msg = '';
		                if (reason === 'unsupported-file-type') { msg = "Unsupported format " + detail; }
		                else {
		                    console.log("error uploading file", reason, detail);
		                }
		                $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
                         '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
		            };
		            initToolbarBootstrapBindings();
		            $('#editor').wysiwyg({ fileUploadError: showErrorAlert });
		            window.prettyPrint && prettyPrint();
		        });
		    </script>	
	    </div>
		
	    <br><br>
    
	    <!--pop over-->
        <div class="container">
            <div id="divBCLayout" class="BClayout">
	            <h3 id="editor">Your Name</h3>
	        </div>
            <div id="divButton" class="divButton non-layout">
                <asp:LinkButton id="btnPublish" runat="server" class="btn btn-primary" Text="Publish To PDF" OnClick="btnPublish_Click"></asp:LinkButton>
            </div>
        </div>

	    <script type="text/javascript">
	        $(document).ready(function () {
	            $('#editor').popover({
	                orientation: "left",
	                html: true,
	                title: 'Customize your business card<a class="close" href="#");">&times;</a>',
	                content: $('#popOverContent').html(),
	            });
	            $('#editor').click(function (e) {
	                e.stopPropagation();
	            });
	            $(document).click(function (e) {
	                /*if (($('.popover').has(e.target).length == 0) || $(e.target).is('.close')) {*/
	                if ($(e.target).is('.close')) {
	                    $('#editor').popover('hide');
	                }
	            });
	        });

	    </script>

    </div>
    </form>
</body>
</html>