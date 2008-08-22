<?xml version="1.0"?>
<?xul-overlay href="chrome://global/content/viewSource.xul"?>
<?xul-overlay href="chrome://viewsourceintab/content/viewSourceOverlay.xul"?>
<!DOCTYPE window [
<!ENTITY % brandDTD SYSTEM "chrome://branding/locale/brand.dtd" >
%brandDTD;
<!ENTITY % sourceDTD SYSTEM "chrome://global/locale/viewSource.dtd" >
%sourceDTD;
]>
<window id="viewSource" xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
	onload="onLoadViewSource();"
	contenttitlesetting="true"
	title="&mainWindow.title;"
	titlemodifier="&mainWindow.titlemodifier;"
	titlepreface="&mainWindow.preface;"
	titlemenuseparator ="&mainWindow.titlemodifierseparator;"
	windowtype="navigator:view-source">

<stringbundle id="viewSourceBundle"/>

<command id="cmd_savePage"/>
<command id="cmd_print"/>
<command id="cmd_printpreview"/>
<command id="cmd_pagesetup"/>
<command id="cmd_close"/>
<commandset id="editMenuCommands"/>
<command id="cmd_find"/>
<command id="cmd_findAgain"/>
<command id="cmd_findPrevious"/>
<command id="cmd_reload"/>
<command id="cmd_goToLine"/>
<command id="cmd_highlightSyntax"/>
<command id="cmd_wrapLongLines"/>
<command id="cmd_textZoomReduce"/>
<command id="cmd_textZoomEnlarge"/>
<command id="cmd_textZoomReset"/>

<keyset id="editMenuKeys"/>
<keyset id="viewSourceKeys"/>

<popup id="viewSourceContextMenu"/>

<toolbox id="viewSource-toolbox"/>
<vbox id="appcontent"/>
<statusbar id="status-bar"/>

</window>
