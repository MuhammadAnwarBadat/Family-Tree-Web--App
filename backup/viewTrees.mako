## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">

<SCRIPT LANGUAGE = "Javascript">

var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);

</SCRIPT>


<style>

#wrapper{
    width:97%;
 #   height:2400px;
    text-align:center;
}


.leftTreesList{
    width: 35%;
    display:block;
    float:left;
    text-align:left;
    margin-left: 25%;
	padding-left:0%;
}

.rightCol{
    width:30%;
    display:block;
    float:right;
    text-align:left;
	margin-right: 6%;
	margin-top: 0px;
}

.top_nav
{
	position:absolute;
	left:25px;
	top:7px;
	// width:300px;
	// height:125px;
	// overflow-y:scroll;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	border-bottom-color: gray;
	margin-bottom: 40px;
	border-top-style: solid;
	border-top-width: 1px;
	border-top-color: gray;
	font-size:12px;
}

.menu-cat {
	font-weight:bold;
	background-color:#D6EAF8  ;
	margin-right:7px;
	margin-left:18px;
	padding:3px;

}

.left_nav3
{
position:absolute;
left:25px;
top:25px;
width:175px;
height:400px;
overflow-y:scroll;
margin-top:27px;
border-bottom-style: solid;
border-bottom-width: 1px;
border-bottom-color: gray;

}

.left_nav3_mobile
{
position:absolute;
left:15%;
right:15%;
top:125px;
width:275px;
height:400px;
overflow-y:scroll;
margin-top:27px;
border-bottom-style: solid;
border-bottom-width: 1px;
border-bottom-color: gray;

}


.content
{


position:absolute;
margin-left:100px;
top:15px;
height:600px;
overflow:scroll;

}

</style>


<script type="text/javascript">

	var deviceType = "init";
	
	// jquery
	$(document).ready(function(){
				
		var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i)

		$("#left_nav").show();
		
		var varWidth = Math.max(window.screen.width, window.innerWidth);
		
		
		if(ismobile != null && ismobile  != '') {
		   varWidth -= 650; 
		}	
		else
		   varWidth -= 200;			
				
		// alert (width3);
		$(".content").css('width', varWidth );
		
 });
	

</script>


<BODY>

	
	<% varFirstPage = '' %>
	<% varDeviceType = deviceType %>
	
		
	<div style="text-align:center;">
		
		 <IMG src= "${request.application_url}/static/siteGraphics/kinWheellogocanva3.png" width="140px">
	</div>

	
	<div id="wrapper">
	
	  <div class="leftTreesList" style="font-size:36px;text-decoration:none;">
	  
		Trees 
		
		<img style="margin-left:0px;width:60px;" src= "${request.application_url}/static/siteGraphics/treeGraphic01.png" >

		
	  </div>

	  	  
	  <div class="rightCol" style="font-size:36px;text-decoration:none;"> 
	  
	 	 Albums 
		
		<img style="margin-left:0px;width:60px;" src= "${request.application_url}/static/siteGraphics/albumGraphic01.png" >
			  
	  </div>
	   

	% if items:
		
		<% ctr = 1 %> 
		
		% for item in items:
	
			<div style="position:absolute; text-align:right;right:60px; top:12px; "> user: ${item['userID']} <br>
			 <a href="${request.application_url}/logout">Logout</a> </span> 

			 </div>
	
			<% break %> 
		% endfor	

		<br> <br><br>
		
		% for item in items:
	
			<% varUrl = '/smallTreeView?tid=' + str(item['treeID']) %> 
			<% varUrl04 = '/tallWideTreeView?tid=' + str(item['treeID']) %> 
			<% varUrl05 = '/treeViewDetermine?tid=' + str(item['treeID']) %> 
			
			<% varEditUrl = '/treeUpdate?tid=' + str(item['treeID']) %> 
			

			<br><br>
			<div class="leftTreesList" style="padding-top:0px;" >
				&nbsp;&nbsp;&nbsp;		
				<a  style="font-size:18px;" href=${varUrl}   target='_blank' >  ${item['treeName']} </a> &nbsp;&nbsp; 
				<a  style="font-size:12px;" href=${varUrl04}   target='_blank' >  ${item['treeName']} </a> &nbsp;&nbsp; 
				<a  style="font-size:12px;" href=${varUrl05}   target='_blank' >  determ view - ${item['treeName']} </a> &nbsp;&nbsp; 
				
				<a  style="font-size:18px;" href=${varEditUrl} >  <i class="fa fa-edit" style="font-size:14px;color:tan;" aria-hidden="true"></i> </a> &nbsp;
				<span style="font-size:14px;"> (${item['peopleInTreeCount']} people) </span>
	
			</div>

		% endfor

		<br><br><br>
		<div class="leftTreesList" >
			<a style="color:green;" href="${request.application_url}/addTree"   target='_blank' >  Add a new tree </a>
		</div>

	% else:
		## <a id="1160" href= "${varRootUrl}InsertAlbumPage?pid=" + "7" > Add a page... </a> &nbsp;&nbsp;
	% endif

	% if itemsAlbums:
		
		% for album in itemsAlbums:
	
			<% varUrlAlbum = '${request.application_url}/smallTreeView?aid=' + str(album['albumID']) %>
		
			<br><br>
			<div class="rightCol" style="padding-top:0px;" >
						
				<!-- <a  style="font-size:18px;" href=${varUrlAlbum}   target='_blank' >  ${album['albumTitle']} </a>  -->
							
			</div>
		
		% endfor
	
	% endif
		
	
  </div>   <!--  closing tag for wrapper -->

</BODY>
