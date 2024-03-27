## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>



<style type="text/css">
	
		body {
		text-align: center;				/* This is a hack for older browsers to center the page */
	}

	ta {
	 width: 300px;
	 height: 100px;
	 background-color: yellow;
	 font-size: 1em;
	 font-weight: bold;
	 font-family: Verdana, Arial, Helvetica, sans-serif;
	 border: 4px solid black;
	}

	.radioBtnHide{
    display: none;
	}

	.button{
		font-size: 18px;
		background-color: #10af0a;
		font-family: "Times New Roman", Times, serif;
	}

	#container {
		margin: 0 auto; 				/* This centers the page in modern browsers */
		text-align: left; 				/* This is a hack for older browsers to center the page */
		width: 1100px; 					/* This sets our total page width */
	}


	#colOne {
		float: left; 		/* This causes the sidebar to move to the left */
		width: 400px; 		/* We need to set the width whenever we float an element */
		height: 430px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 22px;
	  	padding-top: 1px;

	}


	#colTwo {
		float: right;					/* This causes the content to move to the right */
		width: 600px;					/* We need to set the width whenever we float an element */
		height: 430px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 2px;
	  	padding-top: 1px;
	}

	#content {
			margin-top:10px;
			padding-bottom:10px;
		}
		#content div {
			padding:10px;
			border:0px solid #bbb;
			float:left;
		}
		#content-left {
			width:250px;
			text-align:left;
		}
		#content-main {
			margin-left:10px;
			width:120px;
		}
		#content-right {
			margin-left:10px;
			width:200px;
		}


	#colTwoOne {
		float: left; 		/* This causes the sidebar to move to the left */
		width: 100px; 		/* We need to set the width whenever we float an element */
		height: 50px;
		border-style: solid;
	  	border-width: 0px;
		border-color: #ADD8E6;
	  	padding: 0px;
	  	padding-top: 1px;
	  	text-align:right;

	}


	#colTwoTwo {
		float: right;					/* This causes the content to move to the right */
		width: 200px;					/* We need to set the width whenever we float an element */
		height: 50px;
		border-style: solid;
	  	border-width: 0px;
		border-color: #ADD8E6;
	  	padding: 0px;
	  	padding-top: -0px;
	  	margin-top: -20px;
		text-align:left;

	}


	#footer {
		clear: both;  	/* This makes sure that the footer clears both the sidebar and content floats */
		width: 900px;	/* This sets the footer to stretch the full page width */
	}

	@nameOfPersonBeingAddedB {
		color:green;
	}

	@bioHalfStep {
		color:green;
	}

	.SiblingOrNot {
		color:black;
	}

}
</style>

<SCRIPT LANGUAGE = "Javascript">

	var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i)

</SCRIPT>

<script type="text/javascript">


	// jquery
	$(document).ready(function(){

		
		 // $("#idInputAllRelatives").val("yayy yaa");
		 // alert ("on load: " + $("#idInputAllRelatives").val());

	     $("#dob").focusout(function(){
		      validateDate("#dob");
		  });

		   $("#dod").focusout(function(){
		      validateDate("#dod");
		  });

		   $("#firstName").focusout(function(){
		      // varName = $("#firstName").val() + " " + $("#lastName").val(); 
			  varName = $("#firstName").val() ; 
		      $(".nameOfPersonBeingAddedB").html(varName + "'s");
		      // $(".nameOfPersonBeingAddedB").html(varName);
		  });

		   $("#lastName").focusout(function(){
		      // varName = $("#firstName").val() + " " + $("#lastName").val(); 

		     // $(".nameOfPersonBeingAddedB").html(varName);
		  });

		   $("#lastName").focusout(function(){
		     //  varName = $("#firstName").val() + " " + $("#lastName").val(); 
		    //  $(".nameOfPersonBeingAddedB").html(varName);
		  });

		   $(".bioHalfStep").focusout(function(){
		        // alert("fdsa");
			    var relationTypeGeneticB = $("input[name='relationTypeGenetic']:checked").val();
	            // alert("Relation Genetic type is: " + relationTypeGenetic);
	            if (relationTypeGeneticB == 'bio')
	            	{
	            		alert("bio");
	            		$("#siblingRships").css("visibility", "visible" ); 
	            	}
	            else
	            	$("#siblingRships").css("visibility", "hidden" ); 
		  });


		   $(".SiblingOrNot").focusin(function(){
		        // alert("fdsa");
		           var siblingOrNotChk = $("input[name='SiblingOrNot']:checked").val();
		           if (siblingOrNotChk == 'No Relation')
	            	{
	            		// alert("bio 2");
	            		 $("#sibBioOrStep").css("visibility", "visible" ); 
	            	}
	            else
	            	$("#sibBioOrStep").css("visibility", "hidden" ); 
		  });


		  if (window.ismobile) {
			// alert(ismobile);
			document.getElementById('body_not_mobile').style.display= "none";
		   }
		   else {
				document.getElementById('body_mobile').style.display= "none";
		   }

	});// 
	   if (siblingOrNotChk == 'No Relation')
	            	{
	            		// alert("bio 2");
	            		 $("#sibBioOrStep").css("visibility", "hidden" ); 
	            	}
	            else
	            	$("#sibBioOrStep").css("visibility", "visible" ); 
     
	function getRelatives() {

		// var elemName = "#sib0";
			
		var allRelatives = "";
		
		allRelatives = getRelativesForType(allRelatives, 'mom');
		allRelatives = getRelativesForType(allRelatives, 'dad');
		allRelatives = getRelativesForType(allRelatives, 'sib');
		allRelatives = getRelativesForType(allRelatives, 'spouse');
		allRelatives = getRelativesForType(allRelatives, 'kid');


		$("#idInputAllRelatives").val(allRelatives);
		// alert ("de: " + $("#idInputAllRelatives").val());
		
	}
     
	function getRelativesForType(allRelatives, relType) {
			
		for (i=0; i<12; i++)
		{
			// var elemName = "#" + relType + i;
			var elemName = "#" + relType + "H" + i;
			
			// alert (elemName);			
			var valChk = $(elemName).val();		
			
			if (valChk > '')			
				if (valChk.substring(0,1) !== '-')
					{allRelatives +=  relType + "|" + $(elemName).val() + ";";
					// alert (relType + ' ' + valChk );
					}

			
			// if (valChk > '')
			//	allRelatives +=  relType + "|" + $(elemName).val() + ";";
		}
		
		// alert (allRelatives);
		return allRelatives;
		
	}

	function remove_non_ascii(str) {
		  
		  alert (str);
		  if ((str===null) || (str===''))
		       return false;
		 else
			   str = str.toString();
		  
		  return str.replace(/[^\x20-\x7E]/g, '');
	
	}

	function addOrRemoveRelative(hiddenInputTagID, tagIdToClear, idOfInOutLink) {
		
		// from element with id of ctrH which stores the relatives to  be added   
		
		alert (hiddenInputTagID + " " + tagIdToClear + " " + idOfInOutLink);
		
		// var elemName = "#" + relType + "H" + i;
		var elemName = "#" + hiddenInputTagID;
		// alert ('value in input before cleared: ' + $(elemName).val());
		
		var relativeID = $(elemName).val();

		// update the relative ID to indicate whether or not it should be included  
		// minus means no
		
		idOfInOutLink02 = "#" + idOfInOutLink;
		var valueOfInOutLink = remove_non_ascii( $(idOfInOutLink02).text()); 

		if (valueOfInOutLink == 'x')
			{ $(elemName).val('-' + relativeID);
				// alert(relativeID);
				//alert($(elemName).val());
			}
		else if (valueOfInOutLink == '+')
			$(elemName).val(relativeID.substring(1));

		// $(elemName).val('');
		
		// alert ('value in input After cleared: ' + $(elemName).val());

		tagIdToClear02 = "#" + tagIdToClear;
		// $("#kid0").hide(); 

		
		// $(tagIdToClear02).css("color", "purple");
		// $(tagIdToClear02).hide(); 

		// toggle the plus or minus to include or exclude the relative  
		idOfInOutLink02 = "#" + idOfInOutLink;
		var valueOfInOutLink = remove_non_ascii( $(idOfInOutLink02).text()); 
		
		
		if (valueOfInOutLink == 'x')
			{ inOutLink = '+';
			 $(tagIdToClear02).css("text-decoration", "line-through");
			}
		else if (valueOfInOutLink == '+')
			{inOutLink = 'x';
			 $(tagIdToClear02).css("text-decoration", "none");
			// alert ("allo?");
			}
		
		$(idOfInOutLink02).text(inOutLink);

		// end  toggle the plus or minus to include or exclude the relative 

		// alert ($("#allKids").text()); 

	}


     function validateDate(tboxElem) {

     		var tboxDate = tboxElem;
     		var dateb = new Date ($(tboxDate).val());
		    var chk = isValidDate(dateb);
		    var dv = $(tboxDate).val();

		 if (chk === false && dv !== "")
		       {
		        $(tboxDate).val("Invalid date ");
		        $(tboxDate).focus();
		       }
     }

   function isValidDate(d) {

      return d instanceof Date && ! isNaN(d);

    }


   function validateFormData(d) {

   		
		var genderValue = $("input[name='genderB']:checked").val();
        if(genderValue){
                return 1;
            }
        else
        	{
				alert("Please indicate the gender of the person being added.");
				return 0;
        	}

    }


	function runit(input){
		
		formState = validateFormData();
		if (formState == 1)
			{
				getRelatives();
				return true; // submit the form
			}
		else
			{
				return false;

			}

		// return true; // submit the form

	}


</script>


<BODY>

<br>

<form onsubmit="return runit()"  action="${request.route_url('updateG30Person')}"  id="upd3" method="post" enctype="multipart/form-data">
		
	% if items:
		% for item in items:

			<div align = "center"><b> <font size="+2">Add a ${item['relationType']} of ${item['firstName']} ${item['lastName']} </font></b> </div>	
			<br><br>
			
			<div id="container">
			
	  			<div id="colOne">

	  				<h3 style="text-align:center;"> Profile of ${item['relationType']} </h3>

					First Name: <input type="text"  placeholder="First Name (Required)" font-size: 34px name="firstName" id="firstName" value=""> &emsp;&nbsp;
					<br>

					Middle Name: <input type="text" placeholder="Middle Name" name="middleName" value="">&emsp;
					<br>
					
					Last Name: <input type="text" id="lastName" placeholder="Last Name (Required)" name="lastName" value="">
					<br>
					
					Nee:<input type="text" placeholder="Nee" name="nee" value="">
					<br><br>

					Year of Birth: <input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value=""> &nbsp;&nbsp; 
					<br>

					Date of Birth: <input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" > &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 

			<br>

					<input type="radio"   name="yobExactOrEst"  value="exact" >
		    		<label for="yobExact">Exact</label>
					<input type="radio"   name="yobExactOrEst"  value="estimated" >
					<label for="yobEstimated">Estimated</label> 
					<input class="radioBtnHide" type="radio" name="yobExactOrEst"  checked="checked" value="" >
					<label for="yobHidden"></label> 
					
					<br><br>

					Year of Death: <input type="number" style="width: 7em" max="3000" id="yod" name="yod"  placeholder="" value=""> &nbsp;&nbsp; 

			<br>
					
					Date of Death: <input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 

					<br>

					<input type="radio"   name="yodExactOrEst"  value="exact" >
		    		<label for="yodExact">Exact</label>
					<input type="radio"   name="yodExactOrEst"  value="estimated" >
					<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
					<input class="radioBtnHide" type="radio" name="yodExactOrEst"  checked="checked" value="" >
					<label for="yodHidden"></label> 

					<br><br>
					
					Place of Birth:  <input type="text" placeholder="City, State" name="placeOfBirth" value=""> 
					&emsp;&emsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
			<br>
					
					Place of Death: <input type="text" placeholder="City, State" name="placeOfDeath" value="">&emsp;&emsp;&emsp;&nbsp;&thinsp;&nbsp;

					<br><br>

					Gender <font size = "1"></font>:&nbsp;
		   			<input type="radio" id="m" placeholder="M" name="genderB"  value="M"> &nbsp;&nbsp;
		   			<label for="m">M</label>
		    		<input type="radio"  id="f" name="genderB" placeholder="F" value="F">
		    		<label for="f">F</label> 
					<input class="radioBtnHide" type="radio"  id="h" name="genderB" checked="checked" value="">
		    		<label for="h"></label> 
					
					<br>
					Gender at Birth <font size = "1">(Optional)</font>:&nbsp;

		   			<input type="radio" id="m" name="genderAtBirth"  value="M"> &nbsp;&nbsp;
		   			<label for="m">M</label>
		    		<input type="radio"  id="f" name="genderAtBirth"  value="F">
		    		<label for="f">F</label> 
		    		<input class="radioBtnHide" type="radio"  id="h" name="genderAtBirth" checked="checked" value="">
		    		<label for="h"></label> 
					
				</div>
	  		
	  			<div id="colTwo"  >
	    		

   				<h3 style="margin-left:8px;text-align:center;" >Additional Relationships to be Added</h3>

	    		<div style="margin-left:28px;margin-bottom:-11px;" >
	    		The following additional relationships may be added for the new ${item['relationType']} 
	    		of ${item['firstName']} ${item['lastName']}. 
	    		
	    		</div>

				<% rType =  item['relationType']%>  
				<% mothers =  item['mothers']%>  
				<% fathers =  item['fathers']%>  
				<% children =  item['children']%>  
	    		<% siblings =  item['siblings']%>  
	    		<% spouses =  item['spouses']%>  
	    		<% genderOfBaseRelative =  item['genderOfBaseRelative']%>  
	    		

			<div id="content">

				<div id="content-left">

					% if rType =='mother':

						${showFathers(item, "Spouse:")}
						<!-- ${showSiblings(item, "Children:")} -->

					% endif

					% if rType =='father':

						${showMothers(item, "Spouse:")}
						<!-- ${showSiblings(item, "Children:")}  -->

					% endif

					% if rType =='sibling':

						${showMothers(item, "mother")}
						${showFathers(item, "father")}
						${showSiblings(item, "Siblings:")} 

					% endif

					% if rType =='spouse':

						${showChildren(item, "kid")}
						
					% endif

					% if rType =='child':

						% if genderOfBaseRelative =='M': 
							${showSpouses(item, "mom")}
							${showChildren(item, "sib")}
						% endif
						
						% if genderOfBaseRelative =='F': 
							${showSpouses(item, "dad")}
							${showChildren(item, "sib")}
						% endif
						
					% endif
				
 					${insertRelationNamesCol01_add(item)}


				</div>


			  </div>
		
				<%def name="showMothers(item, relType)">
					
						<div style="margin-left:28px; margin-bottom:-14px;margin-top:-14px;" >
				    	<% allMoms = "" %>  
						
						% if len(mothers) > 0:
								
							<b>${relType}: </b>
							
							% if relType == 'mother':
								<% relString =  'mom' %>	
							% else:
								<% relString =  'spouse' %>	
							% endif

							<% moms =  item['mothers'] %>
							<% ctr =  0 %>  

				    		% while ctr < len(moms):
																
								<% mom = item['mothers'][ctr]['name'] %>  
								<% momId = item['mothers'][ctr]['pid'] %>  
								<% idCtr = relString + str(ctr) %>  
								<% ctrH = relString +"H" + str(ctr) %>  
								<% allMoms = ";" + momId %>  
								<span id="${idCtr}"> ${mom}  

								<a href="#" onclick="getRelatives()" style="color:red;"> X </a>
							 	</span> <br>
								<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${momId}"> 
								<% ctr =  ctr + 1 %>  

							% endwhile
					
						% endif
					<!--
						<br> 
						all moms: ${allMoms}
						<br>  -->
					</div>
				</%def>
		
				<%def name="showFathers(item, relType)">
					
						<div style="margin-left:28px; " >
				    	<% allDads = "" %>  
						% if len(fathers) > 0:
								
							<b>${relType}: </b>
		
							% if relType == 'father':
								<% relString =  'dad' %>	
							% else:
								<% relString =  'spouse' %>	
							% endif
							
							<% dads =  item['fathers'] %>
							<% ctr =  0 %>  

				    		% while ctr < len(dads):
																
								<% dad = item['fathers'][ctr]['name'] %>  
								<% dadId = item['fathers'][ctr]['pid'] %>  
								<% idCtr = relString + str(ctr) %>  
								<% ctrH = relString +"H" + str(ctr) %>  
								<% allDads = ";" + dadId %>  
								<span id="${idCtr}"> ${dad}  

								<a href="#" onclick="getRelatives()" style="color:red;"> X </a>
							 	</span> <br>
								<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${dadId}"> 
								<% ctr =  ctr + 1 %>  

							% endwhile
					
						% endif
					<!--
						<br> 
						all dads: ${allDads}
						<br>   -->
					</div>
				</%def>

				<%def name="showSiblings(item,relType)">
					
						<div style="margin-left:28px; " >
						<% allSibs = "" %>  
						<% allRelatives = "" %>  
				    	% if len(siblings) > 0:
								 <br>
								 
								 <b>${relType} </b>
								 
								 <br>
								<% sibs =  item['siblings'] %>				

								<% ctr =  0 %>  
						    		% while ctr < len(sibs):
									
										<% sib = item['siblings'][ctr]['name'] %>  
										<% sibId = item['siblings'][ctr]['pid'] %>  
										
								 	 	<% allRelatives = allRelatives + ";" + sibId %>
										<% idCtr = "sib" + str(ctr) %>  
										<% ctrH = "sibH" + str(ctr) %>  
										<% allSibs = allSibs + ";" + sibId %>  
										<span id="${idCtr}"> ${sib} </span> <br>
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${sibId}"> 

										<% ctr =  ctr + 1 %>  
									% endwhile
							
						% endif
						<!-- <br> 
						all sibs: ${allSibs}
						<br>  -->
					</div>
				</%def>

				<%def name="showSpouses(item,relType)">

						<div style="margin-left:28px; " >
						<% allSpouses = "" %>  
						<% allRelatives = "" %>  
					
						% if len(spouses) > 0:

								<div style="margin-left:7px;" >
								<b>${relType} </b>
								
								<% relString = relType %>	
								
								</div>

								<% spouses02 =  item['spouses'] %>
								
								<div style="margin-left:12px;" >
								  	<% ctr =  0 %>  
						    		% while ctr < len(spouses02):
										
										<% spouse = item['spouses'][ctr]['name'] %>  
										<% spouseId = item['spouses'][ctr]['pid'] %>  
										
								 	 	<% allRelatives = allRelatives + ";" + spouseId %>
										<% idCtr = relString + str(ctr) %>  
										<% ctrH = relString +"H" + str(ctr) %>  
										<% toggleInOut = relString +"T" + str(ctr) %>  
										
										<% allSpouses = allSpouses + ";" + spouseId %>  
										<span id="${idCtr}"> ${spouse} </span> 

										<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> <span id="${toggleInOut}">x</a>
										</span> 


										<br>
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${spouseId}"> 

										<% ctr =  ctr + 1 %>  

									% endwhile
								
							% endif
							<br> 
							all spouses: ${allSpouses}
							<br> 
						</div>
				</%def>

				<%def name="showChildren(item,relType)">

						<div style="margin-left:28px; " >
						<% allKids = "" %>  
						<% allRelatives = "" %>  
						
						% if len(children) > 0:
								
								<b>${relType} </b>
								<% relString =  relType %>	
								<br>
								<% kids =  item['children'] %>
								
								  	<% ctr =  0 %>  
						    		% while ctr < len(kids):
										
										<% kid = item['children'][ctr]['name'] %>  
										
										<% kidId = item['children'][ctr]['pid'] %>  
										
								 	 	<% allRelatives = allRelatives + ";" + kidId %>
										
										<% idCtr = relString + str(ctr) %>  
										<% ctrH = relString +"H" + str(ctr) %>  
										<% toggleInOut = relString +"T" + str(ctr) %>  
																				
										<% allKids = allKids + ";" + kidId %>  
										<span id="${idCtr}" "> ${kid} </span> 
										
										<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> <span id="${toggleInOut}">x</a>
										</span>  

										 <br>
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${kidId}"> 

										<% ctr =  ctr + 1 %>  

									% endwhile
							
						% endif
						<br> 
						<span id="allKids" > allKids: ${allKids} </span>
						<br> 
					</div>
				</%def>

				<input type="hidden"  name="genderOfRelation" value=${item['genderOfBaseRelative']}> 


				<%def name="insertRelationNamesCol01_add(item)">
					
					<% allRelatives = '' %>  

					<div style="margin-left:28px; " >
				   					
					
						<br><br>
						<input type="hidden"  id="idInputAllRelatives" name="nameInputAllRelatives">
						<br> 
						${allRelatives}
						<br><br>

						<!-- <a href="#" onclick="getRelatives()">getRelatives</a>  -->
						
					</div>
				</%def>


				<%def name="insertRelationDataCol03(item, rType)">
						 
					% if rType =='child':

						<input type="radio"   name="childType"  value="biological" checked="checked">
			    		<label for="biological">Biological</label> 
						<input type="radio"   name="childType"  value="adopted" >
						<label for="adopted">Adopted</label> <br>
						<input type="radio"   name="childType"  value="step" >
			    		<label for="step">Step</label> 
						<input type="radio"   style="margin-left:44px;" name="childType"  value="foster" >
						<label  for="foster">Foster</label> 
						
						% if len(spouses) > 0:
							<br><br><br><br>
							<input type="radio"   name="childType"  value="biological" checked="checked">
				    		<label for="biological">Biological</label> 
							<input type="radio"   name="childType"  value="adopted" >
							<label for="adopted">Adopted</label> <br>
							<input type="radio"   name="childType"  value="step" >
				    		<label for="step">Step</label> 
							<input type="radio"   style="margin-left:44px;" name="childType"  value="foster" >
							<label  for="foster">Foster</label> 
							
						% endif
					
						% if len(children) > 0:
							
								<% kids =  item['children'] %>
					
								<br><br><br><br>
							  	<% ctr =  0 %>  
					    		% while ctr < len(kids):
									<% sibling = item['children'][ctr]['name'] %>  
									<br><br>
									${insertRelationship('sibling', ctr, 'BioOrStep')}
									
									<% ctr =  ctr + 1 %>  
								% endwhile

						% endif
					% endif

				</%def>

				<%def name="insertRelationDataCol02(rshipBeingAdded, item)">

					% if rshipBeingAdded =='child':

						% if item['genderOfBaseRelative'] == 'F':
							<% parentType =  'Mother' %>  
							<% otherParentType =  'Father' %>  
						% elif item['genderOfBaseRelative'] == 'M':
							<% parentType =  'Father' %>
							<% otherParentType =  'Mother' %>    
						% else:
							<% parentType =  'Parent' %>
							<% otherParentType =  'Parent' %>    
						% endif

						${parentType}

						<input type="hidden"  name="mother03" value="0"> &nbsp;
						<input type="hidden"  name="father03" value="0"> &nbsp;
						<input type="hidden"  name="spouse03" value="0"> &nbsp;
						<input type="hidden"  name="sibling03" value="0"> &nbsp;
						<input type="hidden"  name="children03" value="0"> &nbsp;

						<br><br>

						% if len(spouses) > 0:
							<br><br><br><br>
							## is the child's <br> 
							is 
							<span class="nameOfPersonBeingAddedB" > the child's </span> <br> 
							<input type="radio"   name="parentOrNot"  value=${otherParentType}  checked="checked">
				    		<label for=${otherParentType}> ${otherParentType}</label> <br>
							<input type="radio"   name="parentOrNot"  value="noRelation" >
							<label for="noRelation">No Relation</label> 
						% endif

						% if len(children) > 0:
							
								<% kids =  item['children'] %>
								<br><br>

							  	<% ctr =  0 %>  
					    		% while ctr < len(kids):
									<% sibling = item['children'][ctr]['name'] %>  

									<br><br>
									% if item['children'][ctr]['gender'] == 'M':
										<% siblingGender = 'Brother' %>  
									% elif item['children'][ctr]['gender'] == 'F':
										<% siblingGender = 'Sister' %>  
									% else:
										<% siblingGender = 'Sibling' %>  
									% endif

									<input type="radio"   class="SiblingOrNot" name="SiblingOrNot"  value=${siblingGender} checked="checked">
				    				<label for=${siblingGender}>${siblingGender}</label> <br>
									
									<input type="radio"  class="SiblingOrNot"  name="SiblingOrNot"  value="No Relation"  >
									<label for="No Relation" >No Relation</label> 
						
									## ${insertRelationship('sibling', ctr, 'SisOrBro')}
									
									<% ctr =  ctr + 1 %>  
								% endwhile

						% endif
					% endif

				</%def>

				<%def name="insertRelationNamesCol01(rshipBeingAdded, item)">

					% if rshipBeingAdded =='child':

						${item['firstName']} ${item['lastName']} is <span class="nameOfPersonBeingAddedB" > the child's </span>
						<br><br><br><br> 
					
						% if len(spouses) > 0:
							## spouses08
							## <% spouses =  item['spouses'] %>
													
							 ## ${spouses[0]['name']} 

							<% ctr =  0 %>  
							% while ctr < len(spouses):
								
								<% spouse  = item['spouses'][ctr]['name'] %>  
								## ${spouse} <br>
								<% ctr =  ctr + 1 %>  

								<input type="radio"   name = "spouse"  value="spouse" >
				    			<label for="spouse">${spouse}</label> <br>

							% endwhile

								<input type="radio"   name = "spouse"  value="spouse" >
				    			<label for="spouse">Other</label> <br>


							 ## is <span class="nameOfPersonBeingAddedB" > the child's </span>
					
						% endif

						<br> <br> 
						% if len(children) > 0:
							
								<% kids08 =  item['children'] %>
								<% print (kids08[0]['name']) %>
								<br>
			
							  	<% ctr =  0 %>  
					    		% while ctr < len(kids08):
									
									<% child07 = item['children'][ctr]['name'] %>  
									 ${child07} is <span class="nameOfPersonBeingAddedB" > the child's </span>

									<br><br><br>
									<% ctr =  ctr + 1 %>  

								% endwhile
						% endif
					% endif


					% if rshipBeingAdded =='parent':

						${item['firstName']} ${item['lastName']} 
						<br><br><br><br> 
					
						% if len(spouse) > 0:
							<% spouses08 =  item['spouses'] %>
													
							 ${spouses08[0]['name']}
					
						% endif
						<br> <br> 
						% if len(children) > 0:
							
								<% kids08 =  item['children'] %>
								<% print (kids08[0]['name']) %>
								<br>
			
							  	<% ctr =  0 %>  
					    		% while ctr < len(kids08):
									
									<% child07 = item['children'][ctr]['name'] %>  
									${child07} <br><br><br>
									<% ctr =  ctr + 1 %>  

								% endwhile
						% endif
					% endif
					
				</%def>
					
				<%def name="insertRelationship(rshipBeingAdded, ctr, type)">
				    				    
					## ${rshipBeingAdded} 

					% if rshipBeingAdded == 'sibling': 
						% if type == 'SisOrBro': 
							
							<% rbName = "SisOrBro" + str(ctr) %>  
											
							<input type="radio"   name = ${rbName}  value="sister" >
				    		<label for="sister">Sister</label> <br>
							<input type="radio"   name = ${rbName}  value="brother" >
							<label for="brother">Brother</label> 
						% endif	
						
						% if type == 'BioOrStep': 
							
							<% rbName = "BioOrStep" + str(ctr) %>  
											
							<div id='sibBioOrStep'>
							<input type="radio"   name = ${rbName}  value="whole" >
				    		<label for="sister">Whole</label> 
							<input type="radio"   name = ${rbName}  value="half" >
				    		<label for="sister">Half</label> 

				    		<br>
							<input type="radio"   name = ${rbName}  value="step" >
							<label for="brother">Step</label> 
							</div>

						% endif	
					% endif	

				</%def>

		
				<br>		

				% if rType =='mother' or rType =='father' :


		    		<span  class="nameOfPersonBeingAddedB"> This </span>
		    		 is ${item['firstName']} ${item['lastName']}'s: <br> 

		    		<input type="radio" id="bio" name="relationTypeGenetic" value="biological">
					<label for="male">Biological ${rType} </label>
					<input type="radio" id="step" name="relationTypeGenetic" value="step">
					<label for="female">Step ${rType} </label>
					<input type="radio" id="foster" name="relationTypeGenetic" value="foster">
					<label for="other">Foster ${rType}  </label>

					<br><br>

	    			% if rType =='mother' and father != '':
						
						 <%doc>
						 ${father} is ${item['firstName']} ${item['lastName']}'s father.   <br>
				    	Is ${father} married to
				    		<span class="nameOfPersonBeingAddedB"> ${item['firstName']}'s mother </span>?
				    	     <br>

				    		<input type="radio" id="yes" name="spouse" value="yes">
							<label for="yes">Yes</label> &nbsp;&nbsp;
							<input type="radio" id="no" name="spouse" value="no">
							<label for="no">No</label>&nbsp;&nbsp;
						</%doc>
					% endif

					<%doc>
					% if rType =='father' and mother != '':
						${mother} is ${item['firstName']} ${item['lastName']}'s mother.   <br>
					% endif
					
					</%doc>

				% endif


				% if rType =='child':

					<br><br><br>					
	
				% endif


	  			</div>


				<div id="footer">
					 
				</div>


	  		</div>

			<br><br>

			<input type="hidden"  name="upsertType" value="insert"> &nbsp;
			<input type="hidden"  name="tid" value="${item['tid']}"> &nbsp;
			
			% if rType =='mother' or rType =='father' :
				<input type="hidden"  name="pedigreeRoot" value="0"> &nbsp;
			% else:
				<input type="hidden"  name="pedigreeRoot" value="0"> &nbsp;
			% endif

			<input type="hidden"  name="relationID" value="${item['relationID']}"> &nbsp;
			<input type="hidden"  name="relationType" value="${item['relationType']}"> &nbsp;
			<div style="text-align:center;">
	
	<input type="submit" name="add"  value="SAVE" style = "width:150px;font-size:16pt" class="button">
	
			</div>

			<br><br>Tree ID: ${item['tid']} || Pedigree Root: 

			% if rType =='mother' or rType =='father':
				Pedigree root: 0
			% else:
				Pedigree root: 0
			% endif


			 ||  Relation Type: ${item['relationType']} || Relation ID: ${item['relationID']} 	
			<br> 

			Name of Tree: ________________________________ 

		% endfor
	
	% endif

	

</form>


</BODY>	