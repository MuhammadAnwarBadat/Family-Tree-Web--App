## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>


<SCRIPT LANGUAGE = "Javascript">

var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);

var website_root="http://kwa.kw04.webfactional.com";

</SCRIPT>


<style>

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

	
	<% varRootUrl = 'http://kwa.kw04.webfactional.com/' %>
	<% varFirstPage = '' %>
	<% varDeviceType = deviceType %>
	
	% if items:
		
		<% ctr = 1 %> 
		
			
		<script>
		
			// alert ("body 2"); 
		
		
		</script>
	
		<img style="margin-left:20px;" src= "${request.application_url}/static/kwLogo_2010_1012_a.png" width="160px">


		% for item in items:
	
			<div style="text-align: center; font-weight:bold;"> 

				Viewing the Tree as a List with Root as Person: ${item['rootID']} 
				
			 </div>
	
			<% break %> 
		% endfor	

		<br><br><br>

	<table style="margin-left:5%; text-align:left;">
		  	<tr>
    			<th>ID</th>
    			<th>Last Name</th>
    			<th>First Name</th>
    			<th>Relation in Tree</th>
    			<th>Status</th>
    			<th>List View</th>
    			<th>Tree View</th>
    			<th style="padding-left:7px;
    			 ">Visibility</th>


      		</tr>

		% for item in items:
			<tr>
    			<td style="padding-right:5px; ">
    				${item['personID']} 
    			</td>
    			<td> ${item['lastName']} </td>
    			<td> ${item['firstName']} </td>
				<td> ${item['relationType']} </td>
				## status
					<% status = item['status']%>
					<% statusB  = 'nada' %>
					<% toggleVisibility  = -1 %>
					<% toggleVisibilityLinkLabel  = 'nada' %>

					% if status == 1:
						<% statusB  = 'Active' %>
						<% toggleVisibility = 0 %>
						<% toggleVisibilityLinkLabel  = 'Hide in tree' %>
					% elif status == 0:		
						<% statusB  = 'Hidden' %>
						<% toggleVisibility = 1 %>
						<% toggleVisibilityLinkLabel  = 'Display in tree' %>
					% endif
				   <td> ${statusB} </td>
				## end status
				<td>  
				<a href=${request.application_url}/viewTreeAsList?pid=${item['personID']}> view as root </a> 
				</td>

				<td> <a href=${request.application_url}/smallTreeView?pid=${item['personID']} >
				  view as root in tree </a> 
				</td>


				## visibility
					
					<td style="padding-left:7px; "> 
					<a href=${request.application_url}/togglePersonVisibility?pid=${item['personID']}&st=${ toggleVisibility}&root=${item['rootID']} > ${toggleVisibilityLinkLabel} </a> 
					</td>
				## end visibility
			


			</tr>
			
			##<br>
			 
			## <% break %> 
		% endfor

		</table>
	
	% else:
		## <a id="1160" href= "${varRootUrl}InsertAlbumPage?pid=" + "7" > Add a page... </a> &nbsp;&nbsp;
	% endif


</BODY>
