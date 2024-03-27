
## -*- coding: utf-8 -*- 

<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.1.min.js" ></script>


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Josefin Sans" />
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Tinos" />
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Playfair Display" />
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=EB Garamond" />

<SCRIPT LANGUAGE = "Javascript">

var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);


</SCRIPT>

<style>

html, body {
	padding:0px;
    margin:0px;
    background-color: #d9bfa6; 
}  
  
svg {
	background-color:#d9bfa6;
	padding:30px;
	margin:30px;
}

.textStyle {
    stroke: black;
    fill:black;
    font-family:'EB Garamond';
    font-weight:normal;
    font-size:18px;
}

.hidePersonIcon {
    stroke: #D1D2D8;
    fill: #D1D2D8;
    font-family:'EB Garamond';
    font-weight:normal;
    font-size:8px;
}

.loggedInUser {
	color:gray;
	position: absolute;
  	top: 12px;
  	right: 6px;
}

.parent {
    stroke: none;
    fill: white;
}

.node {
    stroke: none;
    fill:white;
    font-family:Tinos;
    font-style:bold;
    font-weight:normal;
	z-index:2;
}

.nodeOlder{
	text-decoration: none;
	stroke: blue;
}

.nodeName {
    text-decoration: none;
	stroke: black;
}

.nodeBlood {
    stroke: #5D6494;
    stroke-width: 3;
}

.hiddenPedGens {
    stroke: #5D6494;
    stroke-width:4;
    fill:#ACE2BF;
}

.olderPedGens {
	stroke: red;
}

.nodeRoot {
    stroke: #5D6494;
    stroke-width:4;
    fill:#ABC1F6;
}

.spouses {
    fill: none;
    stroke: #4682B4;
	stroke-width:2;
	z-index:1;

}

.siblings {
    fill: none;
    stroke: #4682B4;
	stroke-width:2;
	z-index:1;

}


.ancestors {
    fill: none;
    stroke: green;
}

.genLine {
    fill: none;
    stroke: blue;
}

.link {
	fill: none;
	stroke: #ccc;
	stroke-width: 1px;
}

.topMenu {
    margin: 10 0 0 150;
    font-family:'EB Garamond';
    font-weight:normal;
    font-size:18px;
}

.topMenuMobile {   
    margin: 10 0 0 100;
    font-family:'EB Garamond';
    font-weight:normal;
    font-size:58px;
}

a:link {
	color: maroon;
}

a:visited {
	color: maroon;
}

.personToolTip {
	display: none; /* Hidden by default */
}

.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 375px;
  height: 270px;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}


#colOne {
	float: left; 		/* This causes the sidebar to move to the left */
	width: 160px; 		/* We need to set the width whenever we float an element */
	font-size: 11px;
    height: 100px;
	border-style: solid;
	border-width: 0px;
	border-color: #ADD8E6;
	padding: 22px;
	padding-top: 1px;
}


#colTwo {
	float: right;				/* This causes the content to move to the right */
	width: 160px;				/* We need to set the width whenever we float an element */
	font-size: 11px;
    height: 100px;
	border-style: solid;
	border-width: 0px;
	border-color: #ADD8E6;
	padding: 2px;
	padding-top: 1px;
}

.drillDownLinks {
  	color:#2A6C69;
	font-size: 18px;
}


</style>


<head>

<title> small Tree </title>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>


<body>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content" >
    <span class="close">&times;</span>
    <div id="personName" style="text-align:center;font-weight:bold;font-size: 18px;"> </div>
	<div id="colOne" style="font-weight:normal;font-size: 15px;" >
        <p id="linkEditPerson">  </p>
		<br>
        <p id="linkAddRelative">  </p>
		<br>
		<p id="linkDeletePerson">  </p>
	</div>
    <div id="colTwo" style="font-weight:normal;font-size: 15px;">
        <p id="linkViewAlbums">  </p>
		<br>
		<p id="linkSetAsRoot">  </p>
    </div>
    
  </div>

</div>


<div class= "personToolTip" id="personNameToolTip">
	allo yes
</div>

<script> 

	var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);

	var qspTreeID = getUrlParameter('tid');
	var qspPersonID = getUrlParameter('pid');
		
	var strRootUrl = "${request.application_url}"
	var strUrl = "${request.application_url}"
	

	// var strUrl02 = strRootUrl + "/viewTreeAsList?pid="  + qspPersonID ;
	var strUrl02 = strRootUrl + "/viewTreeAsList?pid="  + qspPersonID + "&tid=" + qspTreeID;
	var strUrl03 = strRootUrl + "/viewTrees"

	var menuLabel = " Pedigree Root";
	var menuLabel02 = "View Tree as List";
	var menuLabel03 = "View all trees";
	
	var strTopMenuClass = "topMenu";
	
	document.write("<br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl02  + "' style='font-color:navy;font-size:18px;' > " + menuLabel02 +  "</a>" )

	document.write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl03  + "' style='font-color:navy;font-size:18px;' > " + menuLabel03 +  "</a> " )

	if (ismobile !== null)
		{
			strTopMenuClass = "topMenuMobile";
			// document.write ("<div class='" + strTopMenuClass + "' > <--  <a href='" + strUrl + qspTreeID.toString() + "' style='font-color:navy;font-size:38px;' >" + menuLabel +  "</a>" + "</div>");
			document.write ("<div class='" + strTopMenuClass + "' > ")

			document.write("<--  <a href='" + strUrl + qspTreeID.toString() + "' style='font-color:navy;font-size:18px;' >" + menuLabel +  "</a>" )

			// document.write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl02  + "' style='font-color:navy;font-size:18px;' > " + menuLabel02 +  "</a>" )

			// document.write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl03  + "' style='font-color:navy;font-size:18px;' > " + menuLabel02 +  "</a>" )

			document.write("</div>");
		}
	else
		{
			document.write ("<div class='" + strTopMenuClass + "' > ")

			// document.write("<--  <a href='" + strUrl + qspTreeID.toString() + "' style='font-color:navy;font-size:18px;' >" + menuLabel +  "</a>" )

			// document.write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl02  + "' style='font-color:navy;font-size:18px;' > " + menuLabel02 +  "</a>" )

			// document.write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--  <a href='" + strUrl03  + "' style='font-color:navy;font-size:18px;' > " + menuLabel03 +  "</a>" )

			document.write("</div>");
		}

//	document.write ("<div class='topMenu' > <--  <a href='" + strUrl + qspTreeID.toString() + "' style='font-color:navy;font-size:20px;' >" + menuLabel +  "</a>" + "</div>");

	
	function getUrlParameter(name) {
		    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
		    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
		    var results = regex.exec(location.search);
		    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
		};

	function toggleFullNameDisplay(personID, toggleFlag)
		{
			// alert (toggleFlag);
			// alert (document.getElementById(personID).innerHTML.trim());
			var nameToShow = document.getElementById(personID); 
			var shortNameAttrID = 's' + personID;
			var shortNameAttr = document.getElementById(shortNameAttrID); 
			

			if (toggleFlag == "show")
				{
					nameToShow.style.visibility = "visible";
					shortNameAttr.style.visibility = "hidden";
					// nameToShow.style.backgroundColor = "red";
					// nameToShow.style.fill = "red";
					// nameToShow.style.height = 100;
					
					
				}

			if (toggleFlag == "hide")
				{
					nameToShow.style.visibility = "hidden";
					shortNameAttr.style.visibility = "visible";
				}

			// alert(personID);
			// var nameToShow = document.getElementById("ptt");  // .innerHTML.trim();
			// .innerHTML.trim();
			// alert(nameToShow);
			
			// nameToShow.style.display="block";
			
			// alert (fullName);
		}

</script> 


% if items:

	% for item in items:

		<div class="loggedInUser">  ${item['authUser']} <br>
		<a style="color:gray;font-size:11px;" href="/logout">logout</a>

		</div>

		<div  style="text-align:center;color:blue; font-weight:bold;margin:20px;">  
			
			<% varRootName = item['rootPersonName'] %>  
			% if varRootName == '':
				## <% varRootName = item['lastName'] %>  
				${item['firstName']}  ${item['lastName']}'s Tree
			
			% else:
				${varRootName}'s Tree
			
			% endif
			<div  style="font-size:10px; color:black; font-weight:normal;"> Tree ID: ${item['tid']}   </div> 
			
			<span hidden="hidden" id="rootPersonID02">${item['rootID']}</span>
			<span hidden="hidden" id="treeID">${item['tid']}</span>

		</div > 
		
		<% break %> 

	% endfor

% endif

<button style="display:inline-block;margin-left:8%; margin-bottom:-20px;" id="zoom_in">+</button>
<button id="zoom_out">-</button>
<!-- <button id="zoom_init">Reset</button>  -->
<button id="set_to_root">Back to root</button>


<svg>  </svg>

<script src="//cdnjs.cloudflare.com/ajax/libs/d3/4.3.0/d3.min.js"></script>    


% if items:
	
	% for item in items:

		<script>

			
			// var strUrl = website_root + "personProfileView?idp=";
			
			// var strUrl = "https://vagrantvectors.com/personProfileViewC?idp=";
			var strUrl =  '${item['rootUrl']}' + '/personProfileViewC?idp=';
			var strPersonID = ${item['personID']};
			var strTreeID = ${item['tid']};


			strUrl += ${item['personID']} + '&tid=' + ${item['tid']};
			// alert(strUrl);
			// alert (${item['tid']});
			
		    $.getJSON(strUrl, function(dataAll) {

		    	// alert (dataAll);
	          	// process(data.chart);		        
	          	process(dataAll);

		    })   // ;
			// .done(function() { alert("second success"); })
			 //.fail(function() { alert("error"); });
			.fail(function(jqXHR, textStatus, errorThrown) { alert('getJSON request failed! ' + textStatus); });
			// .always(function() { alert("complete"); });


			function process (dataAll){

			   	// document.write ("hello there...");	
			
			   	spouseLinks = dataAll.spouses  // dataAll.spouses contains the data to link spouses  
			   
	  			var d7 = JSON.stringify(dataAll.spouses);
				var parsed = JSON.parse(d7);
				// var objSpouses = parsed;
				var objRelatives = parsed;
				
				// children
				var d8 = JSON.stringify(dataAll.children);
				var parsed8 = JSON.parse(d8);
				var objChildren = parsed8;

				// siblings
				var d8b = JSON.stringify(dataAll.siblings);
				var parsed8b = JSON.parse(d8b);
				var objSiblings = parsed8b;


				// non spouses: siblings, etc. 
				var d9 = JSON.stringify(dataAll.nonSpouses);
				var parsed9 = JSON.parse(d9);
				var objNonSpouses = parsed9;

				// pedigree ancestors from the root
				var d10 = JSON.stringify(dataAll.ancestors);
				var parsed10 = JSON.parse(d10);
				var objAncestors = parsed10;
			
				// dataAll.chart contains the data for the person nodes 	
			   	data = dataAll.chart;			
			   
				
				var treeLayout = d3.tree()
			    // .size([1200, 700])
			  	.size([1200, 2700])
			  
			    var root = d3.hierarchy(data)

			    treeLayout(root)

	

			var svg = d3.select("svg")
			  .attr("width", 1200)
			  .attr("height", 700)
			  .attr("style", "outline: thin solid blue;");
			 // .text("hello dere")
			
			svg.append("foreignObject")
				.attr("width", 480)
				.attr("height", 500)
				.attr('x', 500)
				.attr("y", 300)
				
				.append("xhtml:div")
				.attr("id", "ptt")
				.style("display", "none")
				
				.style("font", "10px 'Helvetica Neue'")
				.html("<h3>An HTML Foreign Object in SVG</h3>") 

			d3.selectAll('button').on('click', function() {
			  if (this.id === 'zoom_in') {
			    // svg.call(zoom7.scaleBy, 1.01);
			    
			    // zoom7.scaleTo(svg, 0.75);

				
				zoom7.scaleBy(svg.transition().duration(750), 1.2);
				// alert ( transform.k);
				// zoom7.translateExtent([[200, 500 ], [1000, 1000]])  
				// zoom7.scaleBy(svg, 1.1);
				
				// svg.scaleTo(svg, 0.75);
				// svg.call(zoom7.scaleBy(svg, 1.2)); 
				
				  
			  }
			  if (this.id === 'zoom_out') {
			    svg.call(zoom7.scaleBy, 0.8);
			    //alert('z out');
			    // zoom7.scaleTo (svg, 0.25);  //.75		
			    // transition(0.8); // deacrease on 0.2 each time
			  }
			  if (this.id === 'zoom_init') {
			    svg.call(zoom7.scaleTo, 0.6);
			    /* svg.transition()
			        .delay(100)
			        .duration(700)
			        .call(zoom.scaleTo, 1); */ // return to initial state
			  }

				if (this.id === 'set_to_root') {
					// alert ("ya");
					var rootPersonID = document.getElementById("rootPersonID02").innerHTML.trim();
					var treeID = document.getElementById("treeID").innerHTML.trim();
				
					var strRootUrl = "${request.application_url}"
					var strUrlSuffix = "/smallTreeView?pid=" + rootPersonID + "&tid=" + treeID + "&rid=" + rootPersonID;
					var strUrl = strRootUrl + strUrlSuffix;
					
					window.open(strUrl, "_self");
			  	}



			});

			var zoomLayer  = svg.append("g");
			
			/* zoomLayer.append("foreignObject")
				.attr("width", 480)
				.attr("height", 500)
			.append("xhtml:div")
				.style("font", "14px 'Helvetica Neue'")
				.html("<h1> n other HTML Foreign Object in SVG</h1>")
			*/

			var nodes;

			// var color = d3.scaleOrdinal(d3.schemeCategory10);

			    var intX = 25;
			    var intY = 0;
			    var intX2 = 25;
			    var intY2 = 80;
				var intY3 = 80;
		
		      var rowNum = 1;
			  var prevRowNum = 1;
			  var rowNum2 = 1;
			  var prevRowNum2 = 1;

			  var rowNum20 = 1;
			  var prevRowNum20 = 1;
			  var hiddenGens = -2;

	

			// create the rectangles
			zoomLayer.selectAll("rect.node")
			  .data(data)
			  .enter()
			  .append("rect")
			  .classed('node', true)


			.classed('nodeBlood', function(d) { if (d.blood > 0 ) return true ;else return false})
			.classed('nodeRoot', function(d) { if (d.rootFlag == 1 ) return true; else return false})
			.classed('hiddenPedGens', function(d) { if (d.rowNum == d.countOfPedGens - 2) if (d.motherID > 0 || d.fatherID > 0) return true; else return false})
		
			  .attr('width', 130)
			  .attr('height', 130)
			  
			  // .attr('x', function(d){return d.rectCoordX})	
			  .attr('x', function(d){intX = d.rectCoordX; return intX;})	
			  // .attr("y", function(d) { rowNum = d.rowNum; intY = calcRectCoordinates(d, prevRowNum, intY); if (rowNum > prevRowNum) {prevRowNum = rowNum;} return intY;})
			  .attr("y", function(d) { rowNum = d.rowNum; intY = calcRectCoordinates(d, prevRowNum, intY); if (rowNum > prevRowNum) {prevRowNum = rowNum;} console.log(intY); return intY;})
		    
  				.on("click", function(d) {
						// alert(d.treeID);
						
						viewAlbumForPerson (d.treeID, d.personID, intX, intY, d.firstName, d.lastName);
						// showSmallTree(d.personID, 7); //
						// personView(d.personID); 
						 // showSmallTree(d.personID, 7); //
						 d3.event.stopPropagation();
			       		})

		    // create the  text for the rectangle 
			// var text2 = zoomLayer.selectAll("text.node")
			var text2 = zoomLayer.selectAll("foreignObject")
     			.data(data)
			  	.enter()

			// show some metrics about the data being shown
			var rootPersonID = document.getElementById("rootPersonID02").innerHTML.trim();
			var textMetrics = text2.append('text');
			textMetrics
				.append('tspan')
				.attr('x', -200)
				.attr("y", 0)
				.text(function(d){if (d.countOfPedGens > 0) { return "# of ancestor gens: " + d.countOfPedGens}}) 

				.append('tspan')
				.attr('x', -200)
				.attr("y", 30)
				// .text(function(d){if (d.countOfPedGens > 0) { return "# of pedigree gens hidden: "  }})
				// .text(function(d){if (d.countOfPedGens > 0) { return "# of pedigree gens hidden: " + (d.countOfPedGens - 4)  }})
				// .text(function(d){if (d.countOfPedGens > 4) { hiddenGens = d.countOfPedGens ; } else { hiddenGens = 0;} return "# of pedigree gens hidden: ".concat( hiddenGens.toString());})
				.text(function(d){if (d.countOfPedGens > 4) { return "# of ancestor gens hidden:  " + (d.countOfPedGens - 4)}}) 

				.append('tspan')
				.attr('x', -200)
				.attr("y", 60)
				// .text(function(d){if (d.firstName == 'Sam' && d.lastName == 'Robins') { return "Sam Robins is here"}})
		
				// insert a hamburger icon for person's menu options  
	  			.append('tspan') //show tree for the person clicked
				  .attr('x', function(d){return d.rectCoordX + 100;})  // + 20
				 .attr("y", function(d) { rowNum20 = d.rowNum; intY3 = calcRectCoordinates(d, prevRowNum20, intY3); if (rowNum20 > prevRowNum20) {prevRowNum20= rowNum20;} return intY3 - 61;})  // -91 - 57

				   .attr("class", "fa") //for font-awesome  // 18 font 
	   				.attr("fill", "#2E4A7D")
					.style('font-size', '18px')
			
				    .text(function (d) {
       				return "\uf6ff" ;    // \uf2b9 specify the font-awesome icon
  						})
  					.on("click", function(d) {
						 iconClicked = $(this).attr("fill");  
						 // showSmallTree(d.personID, 7); //
						 viewAlbumForPerson (d.treeID, d.personID, intX, intY, d.firstName, d.lastName);
						 d3.event.stopPropagation();
			       		}) 

			// create the older gens links where needed  
 			  rowNum2 = 1;
			  prevRowNum2 = 1;
			  rowNum20 = 1;
			  prevRowNum20 = 1;
			  intY3 = 80;
			  // strRootUrl = ""; 
			  strRootUrl = "${request.application_url}"
			
			var rootPersonID = document.getElementById("rootPersonID02").innerHTML.trim();
			var text4 = text2.append('text');
			text4
				.append('tspan')
					// .style('stroke', 'blue')
					.style('text-decoration', 'underline')
					.style('font-size', '20px')
					
					.classed('nodeOlder', true) 

					.attr('x', function(d){return d.rectCoordX + 7;}) 
					// .attr("y", 10)
					.attr("y", function(d) { rowNum20 = d.rowNum; intY3 = calcRectCoordinates(d, prevRowNum20, intY3); if (rowNum20 > prevRowNum20) {prevRowNum20= rowNum20;} return intY3 - 91;})  // - 57
										
					.html(function (d) {var earlierGens = ""; var olderGenLink = strRootUrl + "/smallTreeView?pid=" + d.personID + "&tid=" + d.treeID + "&rid=" + rootPersonID + "&br=" + d.personID ; if (d.rowNum == d.countOfPedGens - 2) if (d.motherID > 0 || d.fatherID > 0) {earlierGens = "see older gens..";} else {earlierGens = "";} 
						if (earlierGens != "") {earlierGens = "<a href='" + olderGenLink + "'>see older gens...</a> <span>afcadfs</span>";}		
						 var rootViewLink = strRootUrl + "/smallTreeView?pid=" + rootPersonID + "&tid=" + d.treeID + "&rid=" + rootPersonID + "&br=" + d.personID
						 if (earlierGens == "" & d.personID == 599 ) {earlierGens = "<span>af</span><a href='" + rootViewLink + "'>see younger gens...</a>";}		
					
							return earlierGens; 
						})
			
			  // create the first line of text inside the rectangle 
			var text3 = text2.append('text');
			var earlierGens = "";
			 text3

				.classed('textStyle', true) 
	    		 // show older gens where applicable 
			
					.append('tspan')
					// .style('stroke', 'blue')
					// .style('text-decoration', 'underline')
					.classed('nodeOlder', true) 

					.attr('x', function(d){return d.rectCoordX + 7;}) 
					.attr("y", function(d) { rowNum2 = d.rowNum; intY2 = calcRectCoordinates(d, prevRowNum2, intY2); if (rowNum2 > prevRowNum2) {prevRowNum2 = rowNum2;} return intY2 - 91;})  // - 57
									
					.on("click", function(d) {
							// alert ("allo " + d.firstName + "!");  
							var hold = 0;
							// viewAlbumForPerson (d.treeID, d.personID);
							viewAlbumForPerson (d.treeID, d.personID, intX, intY, d.firstName, d.lastName);
						})
				  
				  // display first and last name
				  .append('tspan')

				  .attr('id', function(d){var attrID = 's' + d.personID; return attrID;})
				  
				  // .style('text-decoration-line', 'none')
				  // .style('stroke', 'black' )
				  .classed('nodeName', true) 
				  
				  .attr('x', function(d){return d.rectCoordX + 7;})
				
				  .attr("dy", 55)  // 35 20
				  .text(function (d)  {
							var fullName =  d.firstName + " " +  d.lastName; 
							if (fullName.length > 15) {fullName = fullName.substring(0,14) + ".." };
							//fullName2 = fullName.substring(0,14);
							return fullName; 
						})
						.on("mouseover", function(d) {
							var fullName =  d.firstName + " " +  d.lastName;
							if (fullName.length > 15) 
							{ toggleFullNameDisplay(d.personID, "show"); }
							
							return "ya"
						})

						
				  // hidden section to show further details re person
				  .append('tspan')

					.attr('id', function(d){return d.personID;})
					.style('stroke', 'black' )
					
					  
					.style('visibility', 'hidden' )
					.style('fill', 'red')
				 				
					.attr('x', function(d){return d.rectCoordX - 28;}) // 7
					.attr("dy", 0)  // 35 20
					.text(function (d)  {
								var fullName =  d.firstName + " " +  d.lastName; 
								// if (fullName.length > 15) {fullName = fullName.substring(0,14) + ".."};
								//fullName2 = fullName.substring(0,14);
								// var bbox = this.getBBox();
								// bbox.color = "green";hiddenPedGens
								return fullName; 
							})
					.on("mouseout", function(d) {
							var fullName =  d.firstName + " " +  d.lastName;
							// toggleFullNameDisplay(d.personID, "hide");
							if (fullName.length > 15) 
								{ toggleFullNameDisplay(d.personID, "hide"); }
							return "ya"
						})
					

				  // dob and dod 
				  .append('tspan')
				  
				  // .style('display', 'block' )
				  .style('visibility', 'visible' )
				  .style('stroke', 'black')
				  .style('fill', 'black')
				  
				  .style ('text-decoration', 'none')
				  .attr('x', function(d){return d.rectCoordX + 7;})
				
				  .attr("dy", 20)   //30
				  .text(function (d) {
				        // var moreInfo = d.relation + " (" + d.personID + ")";
				        // moreInfo = -1;
				        if (d.dobYear > 0)
				        	{moreInfo = d.dobYear.toString() + ''} else moreInfo = '';
				        // var moreInfo = d.dobYear.toString() +  '-' + d.dodYear.toString(); // + '-' d.dodYear ;
				        if (d.dodYear > 0)
							{moreInfo+= "-" + d.dodYear.toString()};  //else moreInfo = '';
				        // moreInfo += ' ' + d.personID;
						var fullName =  d.firstName + " " +  d.lastName; 
						// if (fullName.length > 15) {moreInfo = d.lastName};

				        return moreInfo; 
				       })


				
				 
//*******************************************************************************
// 		ADD ICONS inside of each person rectangle
//*******************************************************************************
			/*	
				  .append('tspan') //show tree for the person clicked
				  .attr('x', function(d){return d.rectCoordX + 90;})  // + 20
				  .attr("dy", -25)  // .attr("dy", 40) 
				   .attr("class", "fa") //for font-awesome  // 18 font 
	   				.attr("fill", "#2E4A7D")
				
				    .text(function (d) {
       				return "\uf6ff" ;    // \uf2b9 specify the font-awesome icon
  						})
  					.on("click", function(d) {
						
						 iconClicked = $(this).attr("fill");  
						 						 
						 showSmallTree(d.personID, 7); //
						 d3.event.stopPropagation();
						 
			       		}) 
		
  				.append('tspan') //append the add person icon
				  .attr('x', function(d){return d.rectCoordX + 35;})
				  .attr('z', function(d) { return 16;})
				  
				  .attr("dy", 0)
				 
				   .attr("class", "fa") //for font-awesome  // 18 font 
	   				.attr("fill", "#407B57")
				
				    .text(function (d) {
       				return "\uf2b9" ;   //  \uf500
  						})

  					.on("click", function(d) {
				
						 iconClicked = $(this).attr("fill");
						
						viewAlbumForPerson (d.treeID, d.personID); 
						// personView(d.personID, 7); 
						// viewPerson(d.personID, d.firstName, d.lastName, iconClicked,-1); 
						// addPerson(d.personID, d.firstName, d.lastName, iconClicked,-1);
						d3.event.stopPropagation();

						 
			       		})

			     .append('tspan') //append the update person icon
				 .attr('x', function(d){return d.rectCoordX + 63;})
				  
				   .attr("dy", 0)

				   .attr("class", "fa") //for font-awesome  // 18 font 
	   				.attr("fill", "#DAA520")
				
				    .text(function (d) {
       				return "\uf044" ;
  						})
  					.on("click", function(d) {
						iconClicked = $(this).attr("fill");

						updatePerson(d.personID, iconClicked, ctr77);
						d3.event.stopPropagation();

			       		})  


			       .append('tspan') //append delete person icon
				   .attr('x', function(d){return d.rectCoordX + 114;})
				   .attr("dy", 9)
				 
				    .attr("class", "hidePersonIcon") //
	   				.attr("fill", "hide")

				    .text(function (d) {
       				return "__" ;
  						})

  					.on("click", function(d) {
						leftPos = $(this).position().left;
						 iconClicked = $(this).attr("fill");
						 						 
						 hidePerson(d.personID, ${item['personID']}, iconClicked);
						 d3.event.stopPropagation();
												 
			       		})

	*/

//	*******************************************************************************
// 		END OF ADDING  ICONS inside of each person rectangle
//

			/* svg.append("foreignObject")
				.attr("width", 480)
				.attr("height", 500)
				.attr('x', 100)
				.attr('y', 400)
				.append("xhtml:div")
				.style("font", "14px 'Helvetica Neue'")
				.html("<h1>Another sorry  HTML Foreign Object in SVG</h1>")
			*/

			var zoomed = function() {
			   zoomLayer.attr("transform",  d3.event.transform.translate(0, -150));
			   // zoomLayer.attr("transform",  d3.event.transform.translate(60, -400));
			   // zoomLayer.attr("transform",  d3.event.transform.translate(500, 500));
			   // zoomLayer.attr("transform",  d3.event.transform);
			   // alert ( d3.event.transform.k);
			  
			}
				
			var zoom7 = d3.zoom()
				.scaleExtent([0.5 / 5, 1])  // [0.5 / 5, 3]   [0.5 / 5, 1]
				//.translateExtent([[function(d){return 300}, 292], [0, 0]])  
				
				.on("zoom", zoomed);

 			 svg.call(d3.zoom()
			  .scaleExtent([1 / 5, 1]) //  1 / 5, 3   [1 / 5, 1]
			  // .translate(150, 100)
			  .on("zoom", zoomed)); 
			
			zoom7.scaleTo (svg, 0.65);  //.75		0.6
			// zoom7.translate(300, 300);

			
//*******************************************************************************END OF ADDICONS

		// Function 1
		// draw horiz spouse link with blue line
		// insert horiz line between all blood and non blood spouses, incl. multiple non blood spouses
		var spouses = objRelatives;
		zoomLayer.selectAll("spouses")
		    .data(spouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", spouseLine)
			// .attr("stroke-width", 3.5)
			
			// .attr("stroke-width", function(d) { spouseNum = d.source.name; alert(spouseNum); if (spouseNum == 1) {return 1.5;} else {return 3.5;}})  
			
			.lower();
			// .walk;
		
		// Function 2
		// draw line up for multiple spouses from blood spouse and second and beyond non-blood spouses
		//var spouses = objRelatives;
		//zoomLayer.selectAll("spouses")
		//    .data(spouses)
		//    .enter().append("path")
		//    .attr("class", "spouses")
		//    .attr("d", multipleSpousesLineUp);

		// Function 3
		// draw line up from second and greater non-blood sppuses 
		/* var spouses = objRelatives;
		zoomLayer.selectAll("spouses")
		    .data(spouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", multiSpouseNonBlood);
		*/

		// Function 4  
		// draw lines up from blood spouse for linking to second and greater non-blood sppuses 
		var spouses = objRelatives;
		zoomLayer.selectAll("spouses")
		    .data(spouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", multiSpouseBlood);

		// Function 5
		// drop vert line between spouses if they have kids
		// to do clean up 
		var spouses = objRelatives;  
		zoomLayer.selectAll("spouses")
		    .data(spouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", spouseLineVertical)
			.lower();

		
		// Function 6
		// draw lines up from children to parents for root gens and younger
		var children = objChildren;		
		
		zoomLayer.selectAll("children")
		    .data(children)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", childLineUp);
		
				
		// Function 7
		// draw lines up from children to parents for pedigree ancestors
		var ancestors = objAncestors;		
		zoomLayer.selectAll("ancestors")
		    .data(ancestors)
		    .enter().append("path")
		    .attr("class", "ancestors")
		    .attr("d", ancestorLineUp);
		

		// Function 8 
	    // draw a horiz line below when there are children with the first spouse
		// also connects sibs younger than root gen
		
		var children = objChildren;		
		
		zoomLayer.selectAll("spouses")
		    .data(spouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", siblingsLineHoriz);
		

	// Function 8-b
	    // draw a horiz line connecting full siblings
			
		var siblings  = objSiblings;		
		zoomLayer.selectAll("siblings")
		    .data(siblings)
		    .enter().append("path")
		    .attr("class", "siblings")
		    .attr("d", siblingsConnectLineHoriz);
		

		// Function 9
		// draw horiz lines connecting siblings of root  
		var nonSpouses = objNonSpouses;		
		/* zoomLayer.selectAll("nonSpouses")
		    .data(nonSpouses)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", rootSiblingsLineHoriz);
		*/
		
		/*
		// Function 10
		// draw lines down from parents to children for root gens and younger
		var children = objChildren;		
		zoomLayer.selectAll("children")
		    .data(children)
		    .enter().append("path")
		    .attr("class", "spouses")
		    .attr("d", childLineDown);
		*/
		}

		//Function 1
		function spouseLine(d, i){
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            return true;
					} else 
					{
		              return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // does this for one line and then does the fun below and then to next line
		            return true;
		        } 
		        else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
			        // x: start[0].x,
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					rectCoordX: start[0].rectCoordX,
			        relatedColNum:end[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: start[0].spouseNumber,
			        otherSpouseNum: end[0].spouseNumber,
			        relationType: start[0].relation,
			        linePoint: 0,
			        lowRowNumOfTree: start[0].lowRowNumOfTree,
					maritalStatus: 'married',
					countOfPedGens: start[0].countOfPedGens 
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        rectCoordX: end[0].rectCoordX,
			        relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: end[0].spouseNumber,
			        otherSpouseNum: start[0].spouseNumber,
			        relationType: end[0].relation,
			        linePoint: 1,
			        lowRowNumOfTree: end[0].lowRowNumOfTree,
					maritalStatus: 'married',
					countOfPedGens: start[0].countOfPedGens 
			        // y: end[0].y
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
	        	

	        	if (d.relatedColNum > d.colNum ) // insert horiz line between all blood and non blood spouses
	        	 	{ 					  
	        	 		intX_Offset = 100 + d.rectCoordX + 29; // 29
						
						if (d.relationType == 'spouse' && d.spouseNum > 1)
		 					intX_Offset -=  0; // intX_Offset;
						else if (d.relationType != 'spouse' && d.otherSpouseNum > 1)
							intX_Offset -=  d.otherSpouseNum * 12;  // intX_Offset;
							// intX_Offset -=  40;  // intX_Offset;
						// else	
							// intX_Offset = -200;

	        	 	}
	        	 else if (d.relatedColNum < d.colNum  )  // insert horiz line between spouses
	        	 	{
				  		intX_Offset = d.rectCoordX;
 						
						if (d.relationType == 'spouse' && d.spouseNum > 1)
		 					intX_Offset += 70; // intX_Offset;
						else if (d.relationType != 'spouse' && d.otherSpouseNum > 1)
							intX_Offset += 70;  // intX_Offset;
						// else
							// intX_Offset = -200;

	        		}	
				return intX_Offset;

		    }).y(function (d) {
				
				rowNum = d.rowNum;
				adjust = 0;
				// alert (d.countOfPedGens);
				if (d.countOfPedGens > 4)
					{ // rowNum5 -= d.countOfPedGens - 4;
					adjust = d.countOfPedGens - 5;  //4
					rowNum = rowNum - adjust;
					}
				
				if (d.rowNum == 1 )  // insert line between spouses
				{ 
					// intY_Offset = d.rowNum * 30;
					intY_Offset = d.rowNum * 25;  // 25
				}  
				else if (rowNum > 1 )   // line between spouses
				{ 
					// intY_Offset = 35 + ((d.rowNum - 1) * 176);  // 30  / 165
					intY_Offset = 25 + ((rowNum - 1) * 178);  // intY_Offset = 25 + //   30  / 165
					
					if (d.lowRowNumOfTree > 2)
						// intY_Offset = 35 + ((d.rowNum - (d.lowRowNumOfTree - 1)) * 176);  // 30  / 165
						intY_Offset = 25 + ((rowNum - 1) * 178);   // intY_Offset = 25 +
		
				}  

				if (d.relationType == 'spouse' && d.spouseNum > 1)
 					intY_Offset -= 20 + (d.spouseNum * -20);		//  -=8	intY_Offset -= 12 + (d.spouseNum * -27); -= 12 +14   60;
 					// intY_Offset = 0;
	        	
				if (d.relationType != 'spouse' && d.otherSpouseNum > 1)
					// intY_Offset = 0;
					intY_Offset -= 20 + (d.otherSpouseNum * -20);		// intY_Offset -= 12 + (d.otherSpouseNum * -27); +14   60;
					// intY_Offset -= 60;

				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear

		    return fun(linedata);
		}







		//Function 2
		function multipleSpousesLineUp(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            return true;
					} else 
					{
		              return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // does this for one line and then does the fun below and then to next line
		            return true;
		        } 
		        else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					rectCoordX: start[0].rectCoordX,
			        relatedColNum:end[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: start[0].spouseNumber,
			        otherSpouseNum: end[0].spouseNumber,
			        relationType: start[0].relation,
			        linePoint: 0,
			        lowRowNumOfTree: start[0].lowRowNumOfTree
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        // rectCoordX: end[0].rectCoordX,
			        rectCoordX: start[0].rectCoordX,
			        relatedColNum:start[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: end[0].spouseNumber,
			        otherSpouseNum: start[0].spouseNumber,
			        relationType: end[0].relation,
			        linePoint: 1,
			        lowRowNumOfTree: end[0].lowRowNumOfTree
			        // y: end[0].y
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
	        	
				  		intX_Offset = d.rectCoordX;
 						if (d.relationType == 'spouse' && d.spouseNum > 1)
		 					{// intX_Offset += d.spouseNum * 57; // intX_Offset;
		 					intX_Offset += ((d.colNum - 2) * 180) + (d.spouseNum * 30); // intX_Offset;
		 					// alert(intX_Offset); 
		 					}
						else if (d.relationType != 'spouse' && d.otherSpouseNum > 1)
							intX_Offset += d.otherSpouseNum * 57 ;// 105;  // intX_Offset;
						else 
							intX_Offset = d.rectCoordX;
	        		
	        		
				 return intX_Offset;

		    }).y(function (d) {
				
				if (d.rowNum == 1)  // insert line between spouses
					{ 
						intY_Offset = d.rowNum * 30;
					}  
				else if (d.rowNum > 1 )   // line between spouses
					{ 
					intY_Offset = 35 + ((d.rowNum - 1) * 176);  // 30  / 165
					if (d.lowRowNumOfTree > 2)
						intY_Offset = 35 + ((d.rowNum - (d.lowRowNumOfTree - 1)) * 176);  // 30  / 165
		
					}  

				// intY_Offset += 22;
				if (d.stepNum == 1)
 					intY_Offset -= 32 + (d.spouseNum * 7);		// 60;
 				else 
 					intY_Offset -= 32 + (d.spouseNum * 7);		// 60;
 				
 	

				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear
		  
		    return fun(linedata);
		}







		// Function 3
		function multiSpouseNonBlood (d, i) {

		  // Handle all of the greater than first non blood spouses by checking for that in rows 1 and 2 and drawing a line up // from each non blood spouse ya 

			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            return true;
					} else 
					{
		              return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // does this for one line and then does the fun below and then to next line
		            return true;
		        } 
		        else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		    //define the start coordinate and end coordinate
		    var linedata = [{
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					relatedColNum:end[0].orderNum, 
			        rectCoordX: start[0].rectCoordX,
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: start[0].spouseNumber,
			        otherSpouseNum: end[0].spouseNumber,
			        relationType: start[0].relation,
			        linePoint: 0,
			        lowRowNumOfTree: start[0].lowRowNumOfTree
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        relatedColNum:start[0].orderNum, 
			        // rectCoordX: end[0].rectCoordX,
			        rectCoordX: start[0].rectCoordX,
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: end[0].spouseNumber,
			        otherSpouseNum: start[0].spouseNumber,
			        relationType: end[0].relation,
			        linePoint: 1,
			        lowRowNumOfTree: end[0].lowRowNumOfTree
			        // y: end[0].y
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
	        	
				  		intX_Offset = d.rectCoordX;
 						if (d.relationType == 'spouse' && d.spouseNum > 1)
		 					{
		 					intX_Offset += ((d.colNum - 2) * 180) +  130 - (d.spouseNum * 20); // intX_Offset;
		 					}
						else if (d.relationType == 'spouse') // first non blood spouse
							intX_Offset = 0; 
						else if (d.relationType != 'spouse' && d.otherSpouseNum == 1)// blood spouse of 1st nonBlood 
							intX_Offset = 0; 
						else if (d.relationType != 'mother' && d.relationType != 'father')   // blood spouse
							// intX_Offset += ((d.colNum - 2) * 180) + (d.spouseNum * 30); // intX_Offset;
							
							intX_Offset += ((d.relatedColNum - 2) * 180) + 130 - (d.otherSpouseNum * 20); 
							// intX_Offset = 0; // d.rectCoordX;
	        		
				 return intX_Offset;

		    }).y(function (d) {
				
				// if (d.relationType == 'spouse' && d.spouseNum > 1)
				// {
					if (d.rowNum == 1)  
						{ 
							intY_Offset = d.rowNum * 30;
						}  
					else if (d.rowNum > 1 )   
						{ 
						intY_Offset = -5 + ((d.rowNum - 1) * 176);  // 35  30  / 165
						if (d.lowRowNumOfTree > 2)
							intY_Offset = 35 + ((d.rowNum - (d.lowRowNumOfTree - 1)) * 176);  // 30  / 165
						}  
				// }

				// intY_Offset += 22;
				if (d.relationType == 'spouse' && d.spouseNum > 1) {
					// alert (d.spouseNum);
					// alert ('step num: ' + d.stepNum.toString());
					if (d.stepNum == 1)
		 				// intY_Offset = 200;
		 				// alert ("fad");
		 				// intY_Offset -= 2 + (d.spouseNum * 3);		// 7 32  60;
						intY_Offset -= (-8 + (d.spouseNum * 8));	//2 3	// 60;
		 			else 
		 				// intY_Offset = 200;
		 				// intY_Offset -= -8 + (d.spouseNum * 8);	//2 3	// 60;
		 				// intY_Offset -= -8 + (d.spouseNum * 8);	//2 3	// 60;
		 				intY_Offset -= (-15 + (d.spouseNum * 8));	//2 3	// 60;
		 				// intY_Offset = intY_Offset;
				}
				else if (d.relationType == 'spouse')  // first non blood spouse
					intY_Offset = 0;
				else if (d.relationType != 'spouse' && d.otherSpouseNum == 1)// blood spouse of first non blood spouse
					intY_Offset = 0;
				else  // blood spouse 
					// intY_Offset = 100; // -= -32 + (d.spouseNum * 7);		// 60;
					{ 
						intY_Offset += 7; // + (d.otherSpouseNum * 3);
						// intY_Offset += 20;
						// intY_Offset = 80
						
					//intY_Offset -= -10 + (d.otherSpouseNum * 3);
					  // alert (d.relationType);
					}
				
				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear
		  
		    return fun(linedata);
		}







		// Function 4
		function multiSpouseBlood (d, i) {

		   // Handle the blood spouse by checking for that in rows 1 and 2 and drawing a line up from blood spouse 
		   // for each non blood spouse ya 

		   // alert ("multi spouse blood");
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            return true;
					} else 
					{
		              return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // does this for one line and then does the fun below and then to next line
		            return true;
		        } 
		        else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		    //define the start coordinate and end coordinate
		    var linedata = [{
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					relatedColNum:end[0].orderNum, 
			        rectCoordX: start[0].rectCoordX,
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: start[0].spouseNumber,
			        otherSpouseNum: end[0].spouseNumber,
			        relationType: start[0].relation,
			        linePoint: 0,
			        lowRowNumOfTree: start[0].lowRowNumOfTree
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        relatedColNum:start[0].orderNum, 
			        // rectCoordX: end[0].rectCoordX,
			        rectCoordX: start[0].rectCoordX,
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        spouseNum: end[0].spouseNumber,
			        otherSpouseNum: start[0].spouseNumber,
			        relationType: end[0].relation,
			        linePoint: 1,
			        lowRowNumOfTree: end[0].lowRowNumOfTree
			        // y: end[0].y
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
	        	
				  		intX_Offset = d.rectCoordX;
 						if (d.relationType == 'spouse' && d.spouseNum > 1)
		 					{
		 					// intX_Offset += ((d.relatedColNum - 1) * 180) +  180 - (d.spouseNum * 20); // intX_Offset;
		 					intX_Offset += (d.relatedColNum  * 180)  - (d.spouseNum * 12) - 52 ; // intX_Offset;
		 					// alert ("'spouse' && d.spouseNum > 1");
		 					}
						else if (d.relationType == 'spouse') // first non blood spouse
							intX_Offset = 0; 
						else if (d.relationType != 'spouse' && d.otherSpouseNum == 1)// blood spouse of 1st nonBlood 
							{
							intX_Offset = 0; 
							// alert ("d.relationType != 'spouse' && d.otherSpouseNum == 1");
							}
						else if (d.relationType != 'mother' && d.relationType != 'father')  // just else,  blood spouse
							// intX_Offset += ((d.colNum - 2) * 180) + (d.spouseNum * 30); // intX_Offset;
							{
							
							intX_Offset += (d.colNum * 180) - (d.otherSpouseNum * 12) - 52 ; 
							// alert ("blood spouse 8");
							// alert (d.relationType + ' ' + d.spouseNum.toString());
							}

				 return intX_Offset;

		    }).y(function (d) {
				
				// if (d.relationType == 'spouse' && d.spouseNum > 1)
				// {
					if (d.rowNum == 1)  
						{ 
							intY_Offset = d.rowNum * 30;
						}  
					else if (d.rowNum > 1 )   
						{ 
						intY_Offset = -5 + ((d.rowNum - 1) * 176);  // 35  30  / 165
						if (d.lowRowNumOfTree > 2)
							intY_Offset = 35 + ((d.rowNum - (d.lowRowNumOfTree - 1)) * 176);  // 30  / 165
						}  
				// }

				// intY_Offset += 22;
				if (d.relationType == 'spouse' && d.spouseNum > 1) 
					{
						// alert (d.spouseNum);
						// alert ('step num: ' + d.stepNum.toString());
						if (d.stepNum == 1)
		 					// intY_Offset = 200;
		 					// alert ("fad");
		 					// intY_Offset -= 2 + (d.spouseNum * 3);		// 7 32  60;
							intY_Offset -= (-8 + (d.spouseNum * 8));	//2 3	// 60;
		 				else 
		 					// intY_Offset = 200;
		 					// intY_Offset -= -8 + (d.spouseNum * 8);	//2 3	// 60;
		 					// intY_Offset -= -8 + (d.spouseNum * 8);	//2 3	// 60;
		 					intY_Offset -= (-28 + (d.spouseNum * 14));	//2 3	// 60;  -15
		 					// intY_Offset = intY_Offset;
					} 
				else if (d.relationType == 'spouse')  // first non blood spouse
					intY_Offset = 0;
				else if (d.relationType != 'spouse' && d.otherSpouseNum == 1)// blood spouse of first non blood spouse
					intY_Offset = 0;
				else  // blood spouse 
					// intY_Offset = 100; // -= -32 + (d.spouseNum * 7);		// 60;
					{ 
						intY_Offset += 7; // + (d.otherSpouseNum * 3);
						// intY_Offset += 20;
						// intY_Offset = 80
						
					//intY_Offset -= -10 + (d.otherSpouseNum * 3);
					  // alert (d.relationType);
					}
				
				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear
		  
		    return fun(linedata);
		}


		//Function 5
function spouseLineVertical(d, i) {

			//this function drops vertical blue lines between spouses if they have kids (from root and below)
			// data only for descendants

			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           // alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			        // alert (v.lastname);  // alert ("match start: " + v.personID) ;
			        return true;
					} else {
		            // alert (d.source.id);
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          // does this for one line and then does the fun below and then to next line
		            return true;

		        } else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [
			    {
			        x: 0, 
			        stepNum: 1,
			        colNum: end[0].orderNum,
			        rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
					rectCoordXSpouse: end[0].rectCoordX,
			        relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			        childrenCount: start[0].childrenCount,
					spouseChildrenCount: end[0].childrenCount,
					blood: start[0].blood,
			        linePoint: 1,
			        lowRowNumOfTree: start[0].lowRowNumOfTree,
					countOfPedGens: start[0].countOfPedGens
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
			        rectCoordXSpouse: end[0].rectCoordX,
					relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			     	childrenCount: end[0].childrenCount,
					spouseChildrenCount: start[0].childrenCount,
					blood: end[0].blood,
			        linePoint: 1, 
			        lowRowNumOfTree: end[0].lowRowNumOfTree,
					countOfPedGens: start[0].countOfPedGens
			    }
	
		    ];

			
		    var fun = d3.line().x(function (d) {
		    	
				var intX_Offset = -300;
				 
				if (d.childrenCount > 0 && d.spouseChildrenCount > 0 && d.spouseNumber < 2 )
					{
						intX_Offset = d.rectCoordX + 65;
					}
				else if (d.childrenCount > 0 && d.spouseChildrenCount > 0 && d.spouseNumber > 1 )
					{
						intX_Offset = d.rectCoordXSpouse + 65;
					}
				
				else
					{
						intX_Offset = -300;
					}

				return intX_Offset;

		    }).y(function (d) {
				
				rowNum = d.rowNum;
				adjust = 0;
				// alert (d.countOfPedGens);
				
				if (d.countOfPedGens > 4) //4
					{ 
					adjust = d.countOfPedGens - 5;  //4 5
					rowNum = rowNum - adjust;
					}

				if (d.stepNum == 1)  // drop vert line between spouses if they have kids, bottom of line
					{ 
						if (d.childrenCount > 0 && d.spouseChildrenCount > 0)
							{
								// intY_Offset = (35 + ((rowNum - 1) * 176)) + 125;  // 125  d.rowNum
								intY_Offset = ((rowNum - 1) * 178) + 155;
							 }
						else
							{ intY_Offset = -300; // 0
							}
					} 
				else if (d.stepNum == 2)  // drop vert line between spouses if they have kids, top of line
					{ 
						if (d.childrenCount > 0 && d.spouseChildrenCount > 0)
							{
								// intY_Offset = (35 + ((rowNum - 1) * 176)) + 0;  // 125 
								intY_Offset = ((rowNum - 1) * 178) + 24;  // 125 
							 }
						else
							{ intY_Offset = -300;  // 0
							}
					} 
			
				return intY_Offset;
		       
		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		    return fun(linedata);
		}


		// Function 6
		function childLineUp(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
					// alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           	// alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			        // alert (v.lastname);  // alert ("match start: " + v.personID) ;
			        return true;
				}
				else {
					// alert (d.source.id);
		            return false;
				}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		        	// does this for one line and then does the fun below and then to next line
		            return true;
		        }
				else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   	// alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
			        // x: start[0].x,
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					rectCoordX: start[0].rectCoordX,
			        relatedColNum:end[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
					siblings: start[0].siblings,
					siblingOrder: start[0].siblingOrder,
				    relation: start[0].relation,
			        linePoint: 0,
					countOfPedGens: start[0].countOfPedGens  // + 5		
			    }, 
			    {
			        x: end[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        rectCoordX: end[0].rectCoordX,
			        relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
			        childrenCount: start[0].childrenCount,
					siblings: start[0].siblings,
					siblingOrder: end[0].siblingOrder,
			        relation: start[0].relation,
			        linePoint: 1,
					motherID: start[0].motherID,
					fatherID: start[0].fatherID,
					countOfPedGens: start[0].countOfPedGens

			        // y: end[0].y
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
	        	
	        	if (d.stepNum < 3){ // run vert line up from person 	
	        	 	// alert ('step num for x: ' + d.stepNum);

					intX_Offset = d.rectCoordX + 65; 
	        	}

				if (d.relation == 'root'){
					intX_Offset = d.rectCoordX + 65 ; // + 0
				}
			    	
				return intX_Offset;

		    }).y(function (d) {
				
				rowNum = d.rowNum;
				adjust = 0;
							
				if (d.countOfPedGens > 4) //4
					{ 
					adjust = d.countOfPedGens - 5;  //4 5
					rowNum = rowNum - adjust;
					}
				else	
					rowNum = d.rowNum;	
				
				
				if (d.relation == 'spouse' || d.relation == 'root'){
					intY_Offset = 0;					
				}
				else if (d.stepNum == 1)  // run vert line up from child to line from parents 
				    // stepNum 1 starts right at the top of child rect
					// intY_Offset = ((rowNum - 1) * 176) + (rowNum + 2)  //  +2    5  d.rowNum + 2
					intY_Offset = ((rowNum - 1) * 178);
				else if (d.stepNum == 2 && d.motherID > 0 && d.fatherID > 0)  // child has both parents in the treee 
					// stepNum 2 is the top of the line ending halfway up to the next older gen
					// intY_Offset = ((rowNum - 1) * 176) - 17 // 17
					intY_Offset = ((rowNum - 1) * 178) - 24;
					//intY_Offset = ((d.rowNum - 1) * 176) - (42 - d.rowNum)
				else if (d.stepNum == 2 && d.siblingOrder == 1)  // child has only one parent in the tree and is first sib
					intY_Offset = ((rowNum - 1) * 178) - 48;
				else if (d.stepNum == 2 && d.siblingOrder > 1)  // child has only one parent in the tree and is younger sib
					intY_Offset = ((rowNum - 1) * 178) - 24;
				// else // child has only one parent in the tree
					// intY_Offset = ((rowNum - 1) * 176) - 35//  35 17   45 for rafael freedman
					//	intY_Offset = ((rowNum - 1) * 178) - 48;

				// alert (d.siblingOrder);	
				return intY_Offset;

		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		    return fun(linedata);
		}
	

		// Function 7
		function ancestorLineUp(d, i) {
			// green lines going up to ancestors
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
					// alert (d.source.id + ' ' + v.personID);
		        	return true;
				} 
				else {
		            // alert (d.source.id);
		            return false;
				}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          	// does this for one line and then does the fun below and then to next line
		            return true;
		        } 
		        else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   	// alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
			        // x: start[0].x,
			        stepNum: 1,
			        x: start[0].orderNum,
					colNum: start[0].orderNum,
					rectCoordX: start[0].rectCoordX,
			        relatedColNum:end[0].orderNum, 
			        parentColNumStart: start[0].parentColOrder,
			        parentColNumEnd: end[0].parentColOrder,
			        rowNum: start[0].rowNum,
			        lowRowNumOfTree: start[0].lowRowNumOfTree,
			        relation: start[0].relation
			        // childrenCount: start[0].childrenCount,
			        // linePoint: 0
			    }, 
			    {
			        // x: start[0].orderNum,
			        stepNum: 2,
			        colNum: end[0].orderNum,
					rectCoordX: start[0].rectCoordX,
			        relatedColNum:start[0].orderNum, 
			        parentColNumStart: start[0].parentColOrder,
			        parentColNumEnd: end[0].parentColOrder,
			        rowNum: start[0].rowNum,
			        lowRowNumOfTree: end[0].lowRowNumOfTree,
			        relation: start[0].relation
			        
			        // linePoint: 1
			        // y: end[0].y
			    }
		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
				
		        var intColManager = -1;
	        	
	        	if (d.stepNum == 1) // run vert line up from child to pedigree parents
	        	{
		    	 	if (d.relation != 'root'){
						if (d.relation == 'mother'){
							intX_Offset = d.rectCoordX + 65;
						}
						else{
							intX_Offset = d.rectCoordX + 66;  //66
						}
					}
	    	 		else { // move vert line up to left for root and low row
						if (d.lowRowNumOfTree == 1 && d.colNum < 2 )
						{
							// alert ((d.colNum).toString() + ' ' + d.parentColNumStart.toString() + ' ' + d.rowNum.toString() + ' ' + d.relation);
							// intX_Offset = d.rectCoordX + 73;  // 73 6 //95 
							if (d.rowNum < 3) 
								intX_Offset = d.rectCoordX + 65;    // 6
							else
								intX_Offset = d.rectCoordX + 65;  //   85 73
						}
						else // this is what changes the first step of green line going up from root
							intX_Offset = d.rectCoordX + 65; // 73 66;
					}
					
	        	}
				
			    else if (d.stepNum == 2)
				{
					var intY_Offset = 0;
					if (d.relation != 'root')
					{
						if (d.relation == 'father'){
							intX_Offset = d.rectCoordX + 66;
						}
						else{
							intX_Offset = d.rectCoordX + 66; //66
							// alert ((d.colNum).toString() + ' ' + d.parentColNumStart.toString() + ' ' + d.parentColNumEnd.toString() + ' ' + d.relation);
						}					  
		        	}
	        	 	else {// move vert lineUp to the left for root node  
	        			if (d.lowRowNumOfTree == 1 && d.colNum < 2 )
						{
	    	 				// alert ((d.colNum).toString() + ' ' + d.parentColNumStart.toString() + ' ' + d.rowNum.toString() + ' ' + d.relation);
	    	 				// intX_Offset = d.rectCoordX + 73;  // 73 6 //95 
	        	 			if (d.rowNum < 3) 
	        	 				intX_Offset = d.rectCoordX + 65;   //6
	        				else
	         					intX_Offset = d.rectCoordX + 65;  // 85 73
	        	 		}
	        	 		else // this is what changes the second step of green line going up from root
	        	 			intX_Offset = d.rectCoordX + 65; // 73 66;
					}
					
	        	}
				return intX_Offset;

				
				}).y(function (d) {
					
					if (d.stepNum == 1) {  // run vert line up from child to line from parents
						if (d.relation == 'sibling')
							intY_Offset = 0;  
						else if (d.lowRowNumOfTree != 1)
							intY_Offset = ((d.rowNum - (d.lowRowNumOfTree - 1)) * 177);  // 30  / 165
						else
							// intY_Offset = ((d.rowNum - 1) * 177) + 0;
							intY_Offset = ((d.rowNum - 1) * 178) + 0;
					}
					else if (d.stepNum == 2) {
						if (d.relation == 'sibling')
							intY_Offset = 0;  
						else if (d.lowRowNumOfTree != 1)
							intY_Offset = ((d.rowNum - (d.lowRowNumOfTree - 1)) * 177) - 163;  // 143 138 // 30  / 165
						else
							intY_Offset = ((d.rowNum - 1) * 177) -  150;  //  145 (d.rowNum * 20);   // 176 + 5 70
					}
					if (d.relation != 'root')
					{
						var a = 0;
		        	}
					return intY_Offset;

				}).curve(d3.curveStepAfter);  // curveLinear  After
				
				// alert('just before return fun...')
				return fun(linedata);
		}


		// draw a horiz line below when there are children with the first spouse
		//Function 8		
		function siblingsLineHoriz(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           // alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			        // alert (v.lastname);  // alert ("match start: " + v.personID) ;
			        return true;
					} else {
		            // alert (d.source.id);
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          // does this for one line and then does the fun below and then to next line
		            return true;

		        } else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [
		        {
			        x: 0, 
			        stepNum: 1,
					personID: start[0].personID,
					relatedPersonID: end[0].personID,
					relation: start[0].relation,
					relatedRelation: end[0].relation,
					colNum: start[0].orderNum,
			        relatedColNum:end[0].orderNum, 
					// colNum: end[0].orderNum,
			        // relatedColNum:start[0].orderNum, 
					rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			        childrenCount: start[0].childrenCount,
					childrenCountSpouse: end[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol,
			        relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: end[0].nukeFamilyEndCol,
					countOfPedGens: start[0].countOfPedGens 
					// countOfPedGens: 9
			     },
				{
			        x: 0, 
			        stepNum: 2,
					personID: end[0].personID,
					relatedPersonID: start[0].personID,
					relation: end[0].relation,
					relatedRelation: start[0].relation,
			        colNum: end[0].orderNum,
					relatedColNum:start[0].orderNum, 
			        rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			        childrenCount: start[0].childrenCount,
					childrenCountSpouse: end[0].childrenCount,
			        nukeFamStartCol: end[0].nukeFamilyStartCol,
			        nukeFamEndCol: end[0].nukeFamilyEndCol, 
				    // nukeFamStartCol: start[0].nukeFamilyStartCol,
			        // nukeFamEndCol: start[0].nukeFamilyEndCol, 
					relatedNukeFamStartCol: start[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: start[0].nukeFamilyEndCol,
			        // relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        // relatedNukeFamEndCol: end[0].nukeFamilyEndCol,
			        blood: end[0].blood,
					countOfPedGens: start[0].countOfPedGens 
					// countOfPedGens: 9
			     }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
				// alert (childrenCountSpouse);

				if (d.spouseNumber > 1)
					return false;
				if (d.childrenCountSpouse == 0)
					{
						// alert (childrenCountSpouse);
						return false;
					}
	        	if (d.stepNum == 1) // insert horiz line connecting siblings 
	        	 	{
	        			
						if (d.nukeFamStartCol > -1 && d.childrenCount > 0)
							{intX_Offset = (d.rectCoordX + 65) - 80 ;  // right point 
							// alert (d.personID);
							// alert (d.relatedPersonID);
							// alert(intX_Offset);
							}
						else
							{intX_Offset = d.rectCoordX + 65; // essentially do not draw a line 
							}
					}
				 else if (d.stepNum == 2) // insert horiz line connecting siblings to right to youngest sibling
	        	 	{
	        				intX_Offset = (d.rectCoordX + 65) ; // essentially do not draw a line 
					}

										
				 // alert (intX_Offset);
				 return intX_Offset;

		    }).y(function (d) {

				rowNum = d.rowNum;
				adjust = 0;
				// alert (d.countOfPedGens);
				if (d.countOfPedGens > 4)
					{ // rowNum5 -= d.countOfPedGens - 4;
					adjust = d.countOfPedGens - 5;  //4
					rowNum = rowNum - adjust;
					}
		
				if (d.childrenCount > 0)
					{
						// intY_Offset = (35 + ((rowNum - 1) * 176)) + 125;  //35 left off need to also adjust childlineUp
						// intY_Offset = ((rowNum - 1) * 160) + 169;
						// intY_Offset = ((rowNum - 1) * 178) - 24 ;
						intY_Offset = ((rowNum ) * 178) - 24 ;
						
						// intY+= 178; 

						// intY_Offset = (35 + (rowNum * 1.2) + ((rowNum - 1) * 176)) + 125;  //35
					}
				else
					intY_Offset = (35 + ((rowNum - 1) * 176)) ;  
		

				return intY_Offset;
		        // return d.y;
		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		  	// alert ("done --");
		    return fun(linedata);
		}

		// draw a horiz line below between siblings
		//Function 8 b		
		function siblingsConnectLineHoriz(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		             return true;
					} else 
					{
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		           // does this for one line and then does the fun below and then to next line
		            return true;
		        } else 
				{
		          return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [
		        {
			        x: 0, 
			        stepNum: 1,
					personID: start[0].personID,
					relatedPersonID: end[0].personID,
					relation: start[0].relation,
					relatedRelation: end[0].relation,
					colNum: start[0].orderNum,
			        relatedColNum:end[0].orderNum, 
					// colNum: end[0].orderNum,
			        // relatedColNum:start[0].orderNum, 
					// rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
					rectCoordX: start[0].rectCoordX,
					rectCoordXRelated: end[0].rectCoordX,
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			        childrenCount: start[0].childrenCount,
					childrenCountSpouse: end[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol,
			        relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: end[0].nukeFamilyEndCol,
					countOfPedGens: start[0].countOfPedGens 
					// countOfPedGens: 9
			     },
				{
			        x: 0, 
			        stepNum: 2,
					personID: end[0].personID,
					relatedPersonID: start[0].personID,
					relation: end[0].relation,
					relatedRelation: start[0].relation,
			        colNum: end[0].orderNum,
					relatedColNum:start[0].orderNum, 
			        // rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
					rectCoordX: end[0].rectCoordX,
					rectCoordXRelated: start[0].rectCoordX,
			        rowNum: end[0].rowNum,
					spouseNumber: end[0].spouseNumber,
			        childrenCount: start[0].childrenCount,
					childrenCountSpouse: end[0].childrenCount,
			        nukeFamStartCol: end[0].nukeFamilyStartCol,
			        nukeFamEndCol: end[0].nukeFamilyEndCol, 
				    // nukeFamStartCol: start[0].nukeFamilyStartCol,
			        // nukeFamEndCol: start[0].nukeFamilyEndCol, 
					relatedNukeFamStartCol: start[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: start[0].nukeFamilyEndCol,
			        // relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        // relatedNukeFamEndCol: end[0].nukeFamilyEndCol,
			        blood: end[0].blood,
					countOfPedGens: start[0].countOfPedGens 
					// countOfPedGens: 9
			     }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		   	
	        	if (d.stepNum == 1) // insert horiz line connecting siblings 
	        	 	{
	        			// alert (d.personID);
						// intX_Offset = (d.rectCoordX + 65) - 80 ;  // right point 
						intX_Offset = (d.rectCoordX + 65)  ;  // right point 
					}
				 else if (d.stepNum == 2) // insert horiz line connecting siblings to right to youngest sibling
	        	 	{
							// alert (d.personID);
						// intX_Offset = (d.rectCoordX + 145) ; // 65
						intX_Offset = (d.rectCoordX + 65)  ;  // right point 
					} 
					
				// alert (intX_Offset);
				return intX_Offset;

		    }).y(function (d) {

				rowNum = d.rowNum - 1;
				adjust = 0;
				// alert (d.countOfPedGens);
				if (d.countOfPedGens > 4)
					{ // rowNum5 -= d.countOfPedGens - 4;
					adjust = d.countOfPedGens - 5;  //4
					rowNum = rowNum - adjust;
					}

				// alert (intY_Offset);
				intY_Offset = ((rowNum ) * 178) - 24 ;
						
				// alert (intY_Offset);
				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear
		    		  	
		    return fun(linedata);
		}

		// Function 9
		function rootSiblingsLineHoriz(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert ("bing");
		            return true;
					} else {
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		          // does this for one line and then does the fun below and then to next line
		            // alert (v.personID);
		            return true;

		        } else {
		            return false;
		        }
		    });

		    //define the start coordinate and end coordinate
		    var linedata = [
		        {
			        x: 0, 
			        stepNum: 1,
			        colNum: start[0].orderNum,
			        // rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
			        rectCoordX: start[0].rectCoordX, 
			        relationType: start[0].relation,
			        otherRelationType: end[0].relation,
			        relatedColNum:start[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol
			     },
				{
			        x: 0, 
			        stepNum: 2,
			        colNum: end[0].orderNum,
			        // rectCoordX: (start[0].rectCoordX + end[0].rectCoordX) / 2,
			        rectCoordX: end[0].rectCoordX, 
			        relationType: end[0].relation,
			        otherRelationType: start[0].relation,
			        relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol, 
			        blood: end[0].blood
			     }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
		        // alert (v.firstName); 
	        	
		       
	        	if (d.stepNum == 1) // insert horiz line connecting siblings 
	        	 	{
	        			
	        			// alert (d.relationType);
	        			intDrawLine = 0;
	        	 		if (d.relationType == 'root' && d.otherRelationType == 'sibling')  // sibling
	        	 			{
	        					intDrawLine = 1;
	        	 			}
	        			else if (d.relationType == 'sibling' && d.otherRelationType == 'root')
	        	 			{
	        					intDrawLine = 1;
	        	 			}
	        			else
							intDrawLine = 0;

					}
				 else if (d.stepNum == 2 ) // insert horiz line connecting siblings to right to youngest sib 
	        	 	{

						if (d.relationType == 'sibling' && d.otherRelationType == 'root')
	        				{
		        				intDrawLine = 1;
	        				}
						else if (d.relationType == 'root' && d.otherRelationType == 'sibling')
	        				{
		        				intDrawLine = 1;
	        				}
						else
							intDrawLine = 0;

					} 
				

				if (intDrawLine == 1)
					{intX_Offset = d.rectCoordX + 65;
					// alert (d.rectCoordX);
					}
				else
					intX_Offset = 0;	

				 return intX_Offset;

		    }).y(function (d) {
	
		    	if (d.stepNum == 1) // insert horiz line connecting siblings 
	        	 	{
	        			intDrawLine = 0;
	        	 		if (d.relationType == 'root' && d.otherRelationType == 'sibling') 
							intDrawLine = 1;
	        	 		else if (d.relationType == 'sibling' && d.otherRelationType == 'root') 
							intDrawLine = 1;
	        			else
							intDrawLine = 0;
					}
				 else if (d.stepNum == 2 ) // insert horiz line connecting siblings to right to youngest sib 
	        	 	{
						if (d.relationType == 'sibling' && d.otherRelationType == 'root')
	        				intDrawLine = 1;
						else if (d.relationType == 'root' && d.otherRelationType == 'sibling')
	        				intDrawLine = 1;
						else
							intDrawLine = 0;

					} 
				
				if (intDrawLine == 1)
					// intY_Offset = (-25 + ((d.rowNum - 1) * 176)) ;  // d.rowNum - 1
					intY_Offset = ((d.rowNum - 1) * 176) - 19;
				else
					intY_Offset = 0;
				
				return intY_Offset;
		        
		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		    return fun(linedata);
		}
		
		/*
		// Function 10
		function childLineDown(d, i) {
		
			//start point
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
			        return true;
				}
				else {
		            return false;
				}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            return true;
		        }
				else {
		            return false;
		        }
		    });

		    //define the start coordinate and end coordinate
		    var linedata = [{
			        x: start[0].orderNum, 
			        stepNum: 1,
					personID: start[0].personID,
					relatedPersonID: end[0].personID,
					relation: start[0].relation,
					relatedRelation: end[0].relation,
					colNum: start[0].orderNum,
			        rectCoordX: start[0].rectCoordX
			        relatedColNum: end[0].orderNum, 
			        rowNum: start[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol,
			        relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: end[0].nukeFamilyEndCol
					siblings: start[0].siblings,
			        linePoint: 0
			    }, 
			    {
			        x: end[0].orderNum, 
			        stepNum: 2,
					personID: end[0].personID,
					relatedPersonID: start[0].personID,
					relation: start[0].relation,
					relatedRelation: start[0].relation,
			        colNum: end[0].orderNum,
			        rectCoordX: end[0].rectCoordX
			        relatedColNum:start[0].orderNum, 
			        rowNum: end[0].rowNum,
			        childrenCount: start[0].childrenCount,
			        nukeFamStartCol: start[0].nukeFamilyStartCol,
			        nukeFamEndCol: start[0].nukeFamilyEndCol, 
			        relatedNukeFamStartCol: end[0].nukeFamilyStartCol,
			        relatedNukeFamEndCol: end[0].nukeFamilyEndCol,
			        blood: end[0].blood
					siblings: start[0].siblings,
			        linePoint: 1
			    }

		    ];

		    var fun = d3.line().x(function (d) {
		    	
		        var intX_Offset = 0;
		        var intColManager = -1;
	        	
	        	if (d.stepNum < 3){ // run vert line up from person 	
					intX_Offset = d.rectCoordX + 65; 
	        	}

				if (d.relation == 'root'){
					intX_Offset = d.rectCoordX;
				}
			    	
				return intX_Offset;

		    }).y(function (d) {
				
				if (d.relation == 'spouse' || d.relation == 'root'){
					intY_Offset = 0;					
				}
				else if (d.stepNum == 1)  // run vert line up from child to line from parents
					
					intY_Offset = ((d.rowNum - 1) * 176) - 17 - 19
			    else if (d.stepNum == 2){
					intY_Offset = ((d.rowNum - 1) * 176) + (d.rowNum + 2)
					//intY_Offset = ((d.rowNum - 1) * 176) - (42 - d.rowNum)
				}					

				// alert ('y offset: ' + intY_Offset);
				return intY_Offset;

		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		    return fun(linedata);
		}
		*/

		function relationLines(d, i) {

			//start point
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           // alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			      // alert (v.relation + v.firstName + ": " + v.rowNum + ":" + v.orderNum);  // alert ("match start: " + v.personID) ;
			        return true;
					} else {
		            // alert (d.source.id);
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          //  alert ("match end: " + v.personID);
		            return true;

		        } else {
		            // alert (v.firstName);
		            return false;
		        }
		    });
		   
   		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
				colNum: start[0].orderNum,
		        rowNum: start[0].rowNum,
		        linePoint: 0
		    }, {
		        colNum: end[0].orderNum,
		        rowNum: end[0].rowNum, 
		        linePoint: 1
		    }
	    	];
	
		   // alert ("line data: " + linedata[0].x);
		  //  alert ("fname: " + end[0].lastName);
		    // var fun = d3.svg.line().x(function (d) {
		    var fun = d3.line().x(function (d) {
		    	
		  		var intX_Offset = -100;
				if (d.colNum == 1)
					intX_Offset = 225;
				else
					intX_Offset = 225 + ((d.colNum - 1) * 160);

		        /* if (d.colNum > 0)
		        	{var intX_Offset = 0;
	        		intX_Offset = 262	 + (42); }
	        	else if (d.colNum == -1)
	        		intX_Offset = 200;
	        	else if (d.colNum == -2)
	        		intX_Offset = 700;
				*/

				return intX_Offset;

		    }).y(function (d) {
				
				var intY_Offset = 0;
				if (d.linePoint == 0 )
				 	intY_Offset = (d.rowNum - 1) * 177;
				 else
				 	intY_Offset = ((d.rowNum - 1) * 177) - 18;
				 	
				return intY_Offset;
		        // return d.y;
		    }).curve(d3.curveLinear);  //   curveStepBefore
		  
		    return fun(linedata);
		}


		function spouseVerticalLine(d, i) {
			
			//start point	    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           // alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			        // alert (v.lastname);  // alert ("match start: " + v.personID) ;
			        return true;
					} else {
		            // alert (d.source.id);
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          //  alert ("match end: " + v.personID);
		            return true;

		        } else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
		        // x: start[0].orderNum,
				stepNum: 1, 
				colNum: start[0].orderNum,
				parentColNum: start[0].parentColOrder,
		        rowNum: start[0].rowNum,
		        childrenCount: start[0].childrenCount
		    }, {
		        // x: end[0].orderNum,
		        stepNum: 2, 
		        colNum: end[0].orderNum,
		        parentColNum: end[0].parentColOrder,
		        rowNum: end[0].rowNum, 
		        childrenCount: end[0].childrenCount
		        // y: end[0].y
		    }, {
		        // x: end[0].orderNum,
		        stepNum: 3, 
		        colNum: start[0].orderNum,
		        parentColNum: start[0].parentColOrder,
		        rowNum: start[0].rowNum,
		        childrenCount: start[0].childrenCount
		    }, {
		        // x: end[0].orderNum,
		        stepNum: 4, 
		        colNum: end[0].orderNum,
		        parentColNum: end[0].parentColOrder,
		        rowNum: end[0].rowNum,
		        childrenCount: end[0].childrenCount
		    }
	    	];
	
		   // alert ("line data: " + linedata[0].x);
		  //  alert ("fname: " + end[0].lastName);
		    var fun = d3.line().x(function (d) {
		    	
		    	var intX_Offset = 0;
				var multiplier = -5;
				var chkCol = -5;

		        // if (d.colNum > 0)
		        if (d.stepNum == 1)
		        	{
	        		 if (d.colNum < 3)
	        		 	intX_Offset = 304; 
	        		 else
	        		 	{
	        		 	intX_Offset = 624; 
	        		 	// alert (d.colNum);
	        		 	}
	        		 }
	        		// intX_Offset =  d.colNum * 304;
	        	else if (d.stepNum == 2)
	        		{
	        		 if (d.colNum < 3)
	        		 	intX_Offset = 304; 
	        		 else
	        		 	{
	        		 	intX_Offset = 624; 
	        		 	// alert (d.colNum);
	        		 	}
	        		 }
	        		// intX_Offset = 304; 
	        	else if (d.stepNum == 3)
					{	        		
	        		multiplier = -5;
	        		chkCol = d.colNum % 2;
	        		// alert ("colNum: " + d.colNum + "; chkcol: " + chkCol);
	        		if (chkCol == 1)
	        			multiplier = d.colNum;
	        		else 
	        			multiplier = d.colNum - 1;
	        		
	        		intX_Offset = 160 * multiplier ;
	        		// alert ("3:" + intX_Offset);
	        		// intX_Offset = 200;
	        		// * by children count 
	        		}
	        	else if (d.stepNum == 4)
	        		{
	        		multiplier = -5;
	        		chkCol = d.colNum % 2;
	        		// alert ("colNum: " + d.colNum + "; chkcol: " + chkCol);
	        		if (chkCol == 1)
	        			{
	        			multiplier = parseInt(d.colNum) + 1;
	        			// alert ("sha: " + multiplier);
	        			}

	        		else 
	        			multiplier = d.colNum;
	        		
	        		intX_Offset = (160 * multiplier) + (250 * (d.childrenCount - 1));
	        		// alert ("4:" + intX_Offset);
	        		// intX_Offset = 700;
					// * by children count 

					}

				return intX_Offset;

		    }).y(function (d) {
				
				 if (d.stepNum < 3)
				   // if (d.rowNum == 1)
				 	intY_Offset = 31 + ((d.rowNum - 1) * 177);
				 	// intY_Offset = 30 + ((d.y - 1) x 175);
				 	// intY_Offset =  (d.colNum  * 30) + (d.y * 0);  // 30 (d.colNum  * 175);
				 else
					intY_Offset = 160 + ((d.rowNum - 1) * 177);
					// intY_Offset =  (d.colNum  * 80) + (d.y * 0);  // 160  (d.colNum  * 175);

				return intY_Offset;
		        // return d.y;
		    }).curve(d3.curveStepBefore);  // curveLinear
		  
		    return fun(linedata);
		}




		
		

		function childrenLine(d, i) {
		
			//start point    
		    var start = data.filter(function (v) {
		        if (d.source.id == v.personID) {
		            // alert (d.source.id);  // alert ("start: " + v.genNum + ":" + v.colNum);
		           // alert ("start: " + v.rowNum + ":" + v.orderNum +  " x: " + v.x);
			        // alert (v.lastname);  // alert ("match start: " + v.personID) ;
			        // alert (v.personID);
			        return true;
					} else {
		            // alert (d.source.id);
		            return false;
					}
		    });

		    //end point
		    var end = data.filter(function (v) {
		        if (d.target.id == v.personID) {
		            // alert ("end: " + v.genNum + ":" + v.colNum);
		          // does this for one line and then does the fun below and then to next line
		            return true;

		        } else {
		            // alert (v.firstName);
		            return false;
		        }
		    });

		   // alert ("s: " + start[0].orderNum + "cn: " + start[0].orderNum + "y: " + start[0].rowNum )
		    //define the start coordinate and end coordinate
		    var linedata = [{
		        // x: start[0].x,
		        x: start[0].orderNum,
				colNum: start[0].orderNum,
				rectCoordX: start[0].rectCoordX,
				// rectCoordY: start[0].y,
		        relatedColNum:end[0].orderNum, 
		        rowNum: start[0].rowNum,
		        childrenCount: start[0].childrenCount,
		        linePoint: 0
		    }, {
		        x: end[0].orderNum,
		        colNum: end[0].orderNum,
		        rectCoordX: start[0].rectCoordX,
		        // rectCoordY: end[0].y,
		        relatedColNum:start[0].orderNum, 
		        rowNum: end[0].rowNum,
		        childrenCount: start[0].childrenCount,
		        linePoint: 1
		        // y: end[0].y
		    }];

		    var fun = d3.line().x(function (d) {
		    	
		        intX_Offset = d.rectCoordX + 145;
		     	//  alert ("x offset: " + intX_Offset);
				 return intX_Offset;

		    }).y(function (d) {
				
				 	
	        	if (d.relatedColNum > d.colNum)
	        	 	{ // intColOrderOffset = 1;
					  intY_Offset =  (d.rowNum * 160) + 40 ; // d.rowNum * 160;  // + d.rectCoordX + 29; // 29
					  // intY_Offset = 100 ; // ( d.rowNum * 160) ; // d.rowNum * 160;  // + d.rectCoordX + 29; // 29
	        	 	}
	        	 else if (d.relatedColNum < d.colNum)
	        	 	{
	        		intY_Offset =  (d.rowNum * 160) - 100; // (d.rowNum * 160) + 50; // 200 ; // d.rectCoordX
	        		// intY_Offset = 200; //  (d.rowNum * 160) // (d.rowNum * 160) + 50; // 200 ; // d.rectCoordX
	        		}

	        	// alert ("y offset: " + intY_Offset);
				
				return intY_Offset;
		        // return d.y;
		    }).curve(d3.curveStepAfter);  // curveLinear
		    
		  //  alert ("done --");
		    return fun(linedata);
		}


		function calcRectCoordinates(d, prevRowNum, intY) {
			if (d.rowNum > prevRowNum)
			{
			    intY+= 178; //165
			}
			return intY;
		}


		function getUrlParameter(name) {
			name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
			var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
			var results = regex.exec(location.search);
			return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
		};

			
		function showSmallTree(personID, ctr) {
			// alert (ctr);	
				
			if (ctr == 7) {
				var qspTreeID = getUrlParameter('tid');

				var rootUrl = "${request.application_url}" + "/smallTreeView?pid="
				
				var treeParam = "";
				if (qspTreeID > "") 
				{ treeParam = "&tid=" + qspTreeID.toString() }
				// var strUrl = rootUrl + personID  + "&tid=" + qspTreeID.toString();
				var strUrl = rootUrl + personID  + treeParam;
				// alert (strUrl);
				
				intPersDetailWidth = screen.width - 150;

				window.open(strUrl, "_self");
			}	
		}

			function viewAlbumForPerson (treeID, personID, intX, intY, firstName, lastName) {
				
					// alert("x: " + intX.toString() + "; y: " + intY.toString());
					// Get the modal
					var modal = document.getElementById("myModal");
					// modal.style.paddingTop = "200px"; 
					intY = 200;
					modal.style.paddingTop = intY.toString() + "px"; 
					
					// Get the <span> element that closes the modal
					var span = document.getElementsByClassName("close")[0];

					modal.style.display = "block";
					//person's name as heading
					var personName = document.getElementById("personName");
					personName.innerHTML = firstName + " " + lastName + "<br><br>";

				

					//link to edit person
					var linkEditPerson = document.getElementById("linkEditPerson");
					// var qspTreeID = getUrlParameter('tid');
					
					var rootUrlEditPerson = "${request.application_url}" + "/updatePerson?pid="
					var strUrlEditPerson = rootUrlEditPerson + personID  + "&tid=" + treeID + "&rid=" +  "999";  
					strUrlEditPerson = "<span style='font-size:18px;color:#D6D42B;' class='fa' > \uf044 &nbsp; </span>" + "<a style='color:#77787B;' class='drillDownLinks' href='" + strUrlEditPerson + "'>" + "Edit person "  + "</a>" ;
					linkEditPerson.innerHTML = strUrlEditPerson; // personID.toString();

					// link to view albums person
					var linkViewAlbums = document.getElementById("linkViewAlbums");
					
					var rootUrl = "${request.application_url}" + "/viewAlbum?fg=3&pid=";
					var strUrl = rootUrl + personID;
					var strUrl2 = strUrl + '&tid=' + treeID;
					strUrl2 = "<span style='font-size:18px;color:#2443AD ;' class='fa' > \uf02D &nbsp;  </span>" + "<a style='color:#2443AD ;' class='drillDownLinks' href='" + strUrl2 + "'>" + "View albums "  + "</a>" ;
					linkViewAlbums.innerHTML = strUrl2; // personID.toString();

					// link to add relative
					var linkAddRelative = document.getElementById("linkAddRelative");
					var rootUrlAddPerson = "${request.application_url}" + "/addPerson02?pid=";
					// var rootUrlAddPerson = "${request.application_url}" + "/selectRelTypeToAdd?pid=";
					var strUrlAddPerson = rootUrlAddPerson + personID  + "&tid=" + treeID + "&rid=" + personID;  // "999"; 
					strUrlAddPerson = "<span style='font-size:18px;color:#511B7B;' class='fa' > \uf007 &nbsp;  </span>" + "<a style='color:#511B7B;' class='drillDownLinks' href='" + strUrlAddPerson + "'>" + "Add relative "  + "</a>" ;
					linkAddRelative.innerHTML = strUrlAddPerson; // personID.toString();

					// link to set as root of tree
					var linkSetAsRoot = document.getElementById("linkSetAsRoot");
					
					var rootUrlSetRoot = "${request.application_url}" +  "/smallTreeView?pid="
					var strUrlSetRoot = rootUrlSetRoot + personID  + "&tid=" + treeID + "&rid=" + personID;
					strUrlSetRoot = "<span style='font-size:18px;color:#0B7141;' class='fa' > \uf6ff &nbsp; </span>" + "<a style='color:#0B7141;' class='drillDownLinks' href='" + strUrlSetRoot + "'>" + "Set as root "  + "</a>" ;
					linkSetAsRoot.innerHTML = strUrlSetRoot; // personID.toString();

					// link to delete person
					var linkDeletePerson = document.getElementById("linkDeletePerson");
					
					var rootUrlDeletePerson = "${request.application_url}" +  "/deletePerson?pid="
					var strUrlSetRoot = rootUrlDeletePerson + personID  + "&tid=" + treeID + "&rid=" + personID;
					strUrlDeletePerson = "<span style='font-size:18px;color:red;' class='fa' > \uf0c4 &nbsp; </span>" + "<a style='color:red;' class='drillDownLinks' href='" + strUrlSetRoot + "'>" + "Delete person "  + "</a>" ;
					linkDeletePerson.innerHTML = strUrlDeletePerson; // personID.toString();

					// When the user clicks on <span> (x), close the modal
					span.onclick = function() {
						modal.style.display = "none";
					}

					// When the user clicks anywhere outside of the modal, close it
					window.onclick = function(event) {
						if (event.target == modal) {
							modal.style.display = "none";
						}
					}
			}

			function personView (personID, ctr) {
				
				if (ctr == 7) 
					{
					
						var qspTreeID = getUrlParameter('tid');
						
						var rootUrl = "${request.application_url}" +  "/personView?pid="
						// var rootUrl = "http://vagrantvectors.com/personView?pid="

						var strUrl = rootUrl + personID  + "&tid=" + qspTreeID.toString();
						intPersDetailWidth = screen.width - 150;

						window.open(strUrl, "_self");
					}
			}


			
			function hidePerson(personID, rootID, iconClicked) {
				
				var rootUrl = "${request.application_url}" + "/togglePersonVisibility"
				// var rootUrl = "http://vagrantvectors.com/togglePersonVisibility"
				
				strUrl = rootUrl + "?pid=" + personID + "&st=0" + "&view=tree" +  "&root=" + rootID;
				// http://kwa.kw04.webfactional.com/togglePersonVisibility?pid=599&st=0&rootUrl=574
				
				window.location.href = strUrl;
				// window.open(strUrl);
				
			}

			function viewPerson(personID, firstName, lastName, iconClicked, ctr)
			{
				if (iconClicked == "#407B57") //  && ctr == 1		
					{
					var qspTreeID = getUrlParameter('tid');

					
					var rootUrl = "${request.application_url}" + "/addRelativeSelection?pid="
					// var rootUrl = "http://vagrantvectors.com/addRelativeSelection?pid="

					var strUrl = rootUrl + personID + "&fname=" + firstName + "&lname=" + lastName + "&tid=" + qspTreeID.toString();
					
					// + "&fname=" + d.firstname + "&lname=" + d.lastname + "&tid=" + qspTreeId;

					intPersDetailWidth = screen.width - 150;

					window.location.href = strUrl;
					// window.open(strUrl); 
					// updateP.close(); 
					}
			}



			function addPerson(personID, firstName, lastName, iconClicked, ctr)
			{
				if (iconClicked == "#407B57") //  && ctr == 1		
				{
					var qspTreeID = getUrlParameter('tid');

					var rootUrl = "${request.application_url}" + "/addRelativeSelection?pid="
					// var rootUrl = "http://vagrantvectors.com/addRelativeSelection?pid="

					var strUrl = rootUrl + personID + "&fname=" + firstName + "&lname=" + lastName + "&tid=" + qspTreeID.toString();
					
					// + "&fname=" + d.firstname + "&lname=" + d.lastname + "&tid=" + qspTreeId;

					intPersDetailWidth = screen.width - 150;

					window.location.href = strUrl;
					// window.open(strUrl); 
					// updateP.close(); 
				}

			}


			function updatePerson(personID, iconClicked, ctr)
			{
				// alert ("update: " + iconClicked);
				if (iconClicked == "#DAA520") // && ctr == 1	
				{
					var qspTreeID = getUrlParameter('tid');

					// var rootUrl = "http://vagrantvectors.com/updatePerson?pid="
					var rootUrl = "${request.application_url}" + "/updatePerson?pid=";

					var qspRootID = getUrlParameter('pid');
					var strUrl = rootUrl + personID  + "&tid=" + qspTreeID.toString() + "&rid=" + qspRootID.toString();
					// var strUrl = rootUrl + personID  + "&tid=" + qspTreeID.toString();
					
					intPersDetailWidth = screen.width - 150;
					
					// window.location.assign(strUrl)
					window.location.href = strUrl;
					// window.open(strUrl); 
				}	
			}


			function DisplayFullProfile(personID)
			{
				alert("personID: "+personID);

				// open album page 


				intPersDetailWidth = screen.width - 150;

				$('#personDetail').css({ "position": "absolute", "width": intPersDetailWidth, "height": 500, "top": 160, "background-color": 'beige'});

				$('#personSummary').hide()

				if (screen.width < 1200)
				$('#CloseAlbum').css({ "position": "absolute", "color":"maroon","font-size": 32, "left": $('#personDetail').width() -32, "top": 200, "z-index": 5});

				//if (screen.width > 1199)
				$('#CloseAlbum').css({ "position": "absolute", "color":"maroon","font-size": 24, "left": $('#personDetail').width() -24, "top": 200, "z-index": 5});

				$('#CloseAlbum').show();

	 			$('#personDetail').attr("src", "/listAlbum?tag=" + "0" + "&idp=" + personID + "&srt=chrna");

				$('#personDetail').show();
			}

		var rootPersonID = document.getElementById("rootPersonID");
		// alert (rootPersonID.innerHTML);	
		
		</script> 

	% endfor		

% endif

</body>