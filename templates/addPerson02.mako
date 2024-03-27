
## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<meta charset="utf-8">
  
  <title> Add a relative  </title>
 
<script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>

<script  src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  crossorigin="anonymous"></script>


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
		width: 380px; 		/* We need to set the width whenever we float an element */
		height: 680px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 2px;
	  	padding-top: 1px;
	}


	#colTwo {
		float: right;					/* This causes the content to move to the right */
		width: 600px;					/* We need to set the width whenever we float an element */
		height: 100px;
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
		// width:250px;
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
		float: right; 		/* This causes the sidebar to move to the left */
		width: 250px; 		/* We need to set the width whenever we float an element */
		height: 680px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 2px;
	  	padding-top: 1px;
	  	text-align:left;
		overflow: hidden;
	}


	#colTwoTwo {
		float: right;					/* This causes the content to move to the right */
		width: 400px;					/* We need to set the width whenever we float an element */
		height: 680px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 2px;
	  	padding-top: 1px;
		text-align:left;
	}


	#footer {
		clear: both;  	/* This makes sure that the footer clears both the sidebar and content floats */
		width: 900px;	/* This sets the footer to stretch the full page width */
	}

	.SiblingOrNot {
		color:black;
	}

	.labelEntryField {
        display: inline-block;
        width: 100px;
        text-align: right;
      }
	
	.dataEntryRow {
        margin-bottom: 10px;
      }



</style>


<script type="text/javascript" src="https://cdn.tiny.cloud/1/nshr9llbtoxwil0wrvm5hs48ap7bfdauwdvkf0fvcm26sjtv/tinymce/5/tinymce.min.js" >
</script >

  <script>

    $(function() {

     	// alert ("fdas");

 			// $("#dob").val() = "01/12/1926";

	     $("#dob").focusout(function(){
		      validateDate("#dob");
		  });

		$("#dod").focusout(function(){
		      validateDate("#dod");
		  });

    });

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

	
    function addNewPerson(rid)
    {

	    // alert(rid);
	    		
		// var qspTreeID = getUrlParameter('tid');
		

		var rType = $('input[name="relativeType"]:checked').val();
		var rTypeBase = rType;

		if (rType == 'brother' || rType == 'sister')
			{rTypeBase = 'sibling';}	
		if (rType == 'daughter' || rType == 'son')
			{rTypeBase = 'child';}	
	
		// alert (rTypeBase);

		firstName02 = document.getElementById("firstName");
		lastName02 = document.getElementById("lastName").value;
		tid02 = document.getElementById("tid").value;

		
		// alert(rType);
		// var rootUrl = "http://kwa.kw04.webfactional.com/addPerson?rid=" 

		// var strUrl = rootUrl + rid +"&rt=" + rType;
		// alert(strUrl);
		
		var rootUrl = "http://vagrantvectors.com/addPerson?";
		
		// alert(rootUrl);
		var strQsps = "rt=" + rTypeBase + "&rtdet=" + rType + "&rid=" + rid + "&tid=" + tid02 + "&prt=" + "0" + "&fname=" + firstName02 + "&lName=" + lastName02;  //prt=0 qsp indicates that this person is not the tree root, not the pedigree root

		var strUrl = rootUrl + strQsps; 

		window.open(strUrl); 


    }


		function formatDateForSQL(dateString, elementID)
			{

				// alert (dateString);
				if (dateString == "")
						return true;

				var date7 = document.getElementById(elementID);

				//var dateC = $(date7).val();
				var dateD = new Date (dateString);
				dateF = dateD.getMonth() + 1;
				var dateE = dateD.getFullYear() + "-"  + dateF + "-" + dateD.getDate();
				// alert (dateE);
				
				$(date7).val(dateE);
		
			}

function isValidDate2(dateString)
	{
    
		
		if (dateString == "")
				return true;

    // First check for the pattern
    if(!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString))
        return false;

    // Parse the date parts to integers
    var parts = dateString.split("/");
    var day = parseInt(parts[1], 10);
    var month = parseInt(parts[0], 10);
    var year = parseInt(parts[2], 10);

    // Check the ranges of month and year
    if(year < 1000 || year > 3000 || month == 0 || month > 12)
        return false;

    var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    // Adjust for leap years
    if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        monthLength[1] = 29;

    // Check the range of the day
		if (day < 0 || day > monthLength[month - 1])
				return false    

    return true;

    // return day > 0 && day <= monthLength[month - 1];
}


function calcAndDisplayOtherRelsToBeAdded(relTypeToBeAdded)
{
	
	var elemPageHeading = document.getElementById('relativeTypePageHeading');
	elemPageHeading.textContent = relTypeToBeAdded;

	// var elemTextAdditRelsToAdd = document.getElementById("AdditRelsToAdd");
			
	document.getElementById("fatherspouse").style.display = 'none';
	document.getElementById("sibkid").style.display = 'none';
	document.getElementById("motherspouse").style.display = 'none';
	document.getElementById("childrenkid").style.display = 'none';
	document.getElementById("mothermother").style.display = 'none';
	document.getElementById("fatherfather").style.display = 'none';
	document.getElementById("sibsib").style.display = 'none';
	document.getElementById("spousesmom").style.display = 'none';
	document.getElementById("spousesdad").style.display = 'none';
	document.getElementById("childrensib").style.display = 'none';
	document.getElementById("idInputAllRelatives").style.display = 'none';
	document.getElementById("idInputAllRelativesLbl").style.display = 'none';

	$("#idInputAllRelatives").val('');
	$("#idInputAllRelativesLbl").text('');

	$("#AdditRelsToAdd").hide();


	if (relTypeToBeAdded == 'mother')	
		{
			$("#relationType").val('mother');
			
			document.getElementById("fatherspouse").style.display = 'block';
			document.getElementById("sibkid").style.display = 'block';

			// var spouses =  document.getElementById("allDads88").textContent;
			var spouses = '';
			try{ spouses = document.getElementById("dadsspouse88").textContent.substring(2).trim() + ';';}
			catch { spouses = ''; };
						
			var kids = '';
			try{ kids =  document.getElementById("sibskid88").textContent.substring(2).trim() + ';' ; }
			catch { kids = ''; };
			
			if (kids !== '' ||  spouses !== '' )
			{
				$("#AdditRelsToAdd").show();
				
			}
			
			var additionalRelativesToAdd = spouses + kids;
	
			// this is the paydirt sent to sql for adding more relatives 
			$("#idInputAllRelatives").val(additionalRelativesToAdd);
			$("#idInputAllRelativesLbl").text(additionalRelativesToAdd);
			
		}
	
	if (relTypeToBeAdded == 'father')	
		{
		
			$("#relationType").val('father');

			document.getElementById("motherspouse").style.display = 'block';
			document.getElementById("sibkid").style.display = 'block';

			// var spouses =  document.getElementById("allMoms88").textContent;
			// var spouses =  document.getElementById("momsspouse88").textContent;
			var spouses = '';
			try{spouses =  document.getElementById("momsspouse88").textContent.substring(2).trim() + ';'; }
			catch { spouses = ''; };

			// var kids =  document.getElementById("allSibs88").textContent;
			var kids =  '';
			try {kids =  document.getElementById("sibskid88").textContent.substring(2).trim() + ';'; }
			catch { kids = ''; };

			if (kids !== '' || spouses !== '' )
			{
				$("#AdditRelsToAdd").show();
			}
			
			var additionalRelativesToAdd = spouses + kids;
	
			// this is the paydirt sent to sql for adding more relatives 
			$("#idInputAllRelatives").val(additionalRelativesToAdd);
			$("#idInputAllRelativesLbl").text(additionalRelativesToAdd);
			
		}
	
	if (relTypeToBeAdded == 'spouse')	
		{

			$("#relationType").val('spouse');

			document.getElementById("childrenkid").style.display = 'block';
			
			// var kids =  document.getElementById("kidskid88").textContent.substring(2).trim() + ';';
			var kids = '';
			try {kids =  document.getElementById("kidskid88").textContent.substring(2).trim() + ';'; }
			catch { kids = ''; };
			
			if (kids !== ''  )
			{
				$("#AdditRelsToAdd").show();
				
			}
	
			var additionalRelativesToAdd = kids;
				
			$("#AdditRelsToAdd").show();
			
			// this is the paydirt sent to sql for adding more relatives 
			$("#idInputAllRelatives").val(additionalRelativesToAdd);
			$("#idInputAllRelativesLbl").text(additionalRelativesToAdd);
						
		}
	
	if (relTypeToBeAdded == 'sister - old')
		{
			elemTextAdditRelsToAdd.style.display = 'block';
			sib45.style.display = 'block';
			kidsToAdd.style.display = 'block';
		}

	if (relTypeToBeAdded == 'brother' || relTypeToBeAdded == 'sister' )
		{
			$("#relationType").val('sibling');

			document.getElementById("mothermother").style.display = 'block';
			document.getElementById("fatherfather").style.display = 'block';
			document.getElementById("sibsib").style.display = 'block';

			var mothers = '';
			var fathers = '';
			var siblings = '';
						
			try{ mothers =  document.getElementById("momsmom88").textContent.substring(2).trim() + ';'; }
			catch {mothers = '';};
			try{ fathers =  document.getElementById("dadsdad88").textContent.substring(2).trim() + ';'; }
			catch {fathers = '';};
			try{ siblings =  document.getElementById("sibssib88").textContent.substring(2).trim() + ';'; }
			catch {siblings = '';};

			if (mothers !== '' ||  fathers !== '' || siblings !== '' )
			{
				$("#AdditRelsToAdd").show();
			}
	
			var additionalRelativesToAdd = mothers + fathers + siblings;
	
			// this is the paydirt sent to sql for adding more relatives 
			$("#idInputAllRelatives").val(additionalRelativesToAdd);
			$("#idInputAllRelativesLbl").text(additionalRelativesToAdd);
		}

	if (relTypeToBeAdded == 'son' || relTypeToBeAdded == 'daughter' )
		
		{
		
			$("#relationType").val('child');

			var genderOfBasePersonToWhomRelBeingAdded = document.getElementById("genderOfBasePersonToWhomRelBeingAdded").value;

			var mothers = '';
			var fathers = '';
			var siblings = '';

			if (genderOfBasePersonToWhomRelBeingAdded == 'F')
				{ document.getElementById("spousesdad").style.display = 'block'; }
			else if	(genderOfBasePersonToWhomRelBeingAdded == 'M')
				{ document.getElementById("spousesmom").style.display = 'block'; }

			document.getElementById("childrensib").style.display = 'block';

			if (genderOfBasePersonToWhomRelBeingAdded == 'M')			
				{
					// alert ('mother');
					try{ mothers =  document.getElementById("spousesmom88").textContent.substring(2).trim() + ';'; }
					catch {mothers = '';};
				}
			if (genderOfBasePersonToWhomRelBeingAdded == 'F')			
				{
					// alert ('father');	
					try{ fathers =  document.getElementById("spousesdad88").textContent.substring(2).trim() + ';'; }
					catch {fathers = '';};
				}

			try{ siblings =  document.getElementById("kidssib88").textContent.substring(2).trim() + ';'; }
			catch {siblings = '';};

			if (mothers !== '' ||  fathers !== '' || siblings !== '' )
			{
				$("#AdditRelsToAdd").show();
			}

			var additionalRelativesToAdd = mothers + fathers + siblings;
			
			$("#AdditRelsToAdd").show();
			
			// this is the paydirt sent to sql for adding more relatives 
			$("#idInputAllRelatives").val(additionalRelativesToAdd);
			$("#idInputAllRelativesLbl").text(additionalRelativesToAdd);

			// alert (genderOfBasePersonToWhomRelBeingAdded);

		}
}



function getRelatives() {

		// var elemName = "#sib0";
			
		var allRelatives = "";
		
		allRelatives = getRelativesForType(allRelatives, 'mom');
		allRelatives = getRelativesForType(allRelatives, 'dad');
		allRelatives = getRelativesForType(allRelatives, 'sib');
		allRelatives = getRelativesForType(allRelatives, 'spouse');
		allRelatives = getRelativesForType(allRelatives, 'kid');


		// $("#idInputAllRelatives").val(allRelatives);
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
		  
		 // alert (str);
		  if ((str===null) || (str===''))
		       return false;
		 else
			   str = str.toString();
		  
		  return str.replace(/[^\x20-\x7E]/g, '');
	
	}

function addOrRemoveRelative(hiddenInputTagID, tagIdToClear, idOfInOutLink) {
		
		// from element with id of ctrH which stores the relatives to  be added   
		// alert (hiddenInputTagID);	
		// var elemName = "#" + relType + "H" + i;
		var elemName = "#" + hiddenInputTagID;
		// alert ('value in input before cleared: ' + $(elemName).val());
		
		var relativeID = $(elemName).val();
		// alert (relativeID);

		// update the relative ID to indicate whether or not it should be included  
		// minus means no
		
		idOfInOutLink02 = "#" + idOfInOutLink;
		// alert (idOfInOutLink02);
		var valueOfInOutLink = remove_non_ascii( $(idOfInOutLink02).text()); 
		// alert (valueOfInOutLink);

		if (valueOfInOutLink == 'x')
			$(elemName).val('x' + relativeID);
			// $(elemName).val('-' + relativeID);
		else if (valueOfInOutLink == '+')
			$(elemName).val(relativeID.substring(1));

		tagIdToClear02 = "#" + tagIdToClear;
		tagIdToClear02 = tagIdToClear02.trim();
		// alert (tagIdToClear02);

		// toggle the plus or minus to include or exclude the relative  
		idOfInOutLink02 = "#" + idOfInOutLink;
		var valueOfInOutLink = remove_non_ascii( $(idOfInOutLink02).text()); 
		valueOfInOutLink = valueOfInOutLink.trim();
		   
		var strRelsToAdd = '';
		if (valueOfInOutLink == "x")
			{ 
				inOutLink = "+";
				// alert (tagIdToClear02);
				$(tagIdToClear02).css("text-decoration", "line-through");
				// alert ($("#idInputAllRelatives").val());
			}
		else if (valueOfInOutLink == "+")
			{
				inOutLink = "x";
				// alert ('io link x');
				$(tagIdToClear02).css("text-decoration", "none");
			}
		
		// update the input control 
		// stripOutX = $("#idInputAllRelatives").val().replace('x','');
		// $("#idInputAllRelatives").val(stripOutX)

		arrRelsToAdd  = ($("#idInputAllRelatives").val()).split(';');
		for (let i = 0; i < arrRelsToAdd.length - 1; i++) 
			{
				let rid3 = relativeID.replace('x', '');
				relativeID = rid3;
				let result = arrRelsToAdd[i].includes(relativeID);
				// alert ('a ' + relativeID);				
				if (result)
					{
						let update = arrRelsToAdd[i].replace('x', '');
						// alert('b ' +update);										
						arrRelsToAdd[i] = update;
						
						if (valueOfInOutLink == 'x')
							arrRelsToAdd[i] = valueOfInOutLink + arrRelsToAdd[i];
						if (valueOfInOutLink == '+')
							{
								let update = arrRelsToAdd[i].replace('x', '');
								// alert('c ' + update);										
								arrRelsToAdd[i] = update;

							}

					}

			} 

		for (let i = 0; i < arrRelsToAdd.length - 1; i++) 
			{
					strRelsToAdd += arrRelsToAdd[i] + ';';
			} 

		// alert(strRelsToAdd);

		$("#idInputAllRelatives").val(strRelsToAdd);
		$(idOfInOutLink02).text(inOutLink);

	

		// end  toggle the plus or minus to include or exclude the relative 

		// alert ($("#allKids").text()); 

	}

	function validateFormData(){

		var formState = 0;
	
		// alert (document.getElementById('relativeTypePageHeading').textContent);

		if (document.getElementById('relativeTypePageHeading').textContent == 'relative')
			{
			formState = 0;
			alert ("Please select the type of relative to add...")
			}
		else
			formState = 1;
		
		return formState;

	}

    function runit(input)
		{

			formState = validateFormData();
			if (formState == 0)
				{
					// alert ("nyet");
					return false;
				}
				
			var dateDob = document.getElementById("dob");
			var chk = isValidDate2($(dateDob).val());
			if (chk === false )
				{$(dateDob).val("bad date ");
				return false;  }
								
			var dateDod = document.getElementById("dod");
			var chk = isValidDate2($(dateDod).val());

			if (chk === false )
				{ $(dateDod).val("bad date ");
				return false;  }
				
			formatDateForSQL($(dateDob).val(), "dob")
			formatDateForSQL($(dateDod).val(), "dod")
				
			return true; // submit the form

		}

		function cancelAndCloseForm(personAndTreeID)
		{

			arrPT = personAndTreeID.split("_");
			
			personID = arrPT[0];
			treeID = arrPT[1];
			
			// strUrl = "http://vagrantvectors.com/smallTreeView?tid=" + treeID; 
			strUrl = "${request.application_url}/smallTreeView?tid=" + treeID; 
			// "${request.application_url}"

			// strUrl = "http://vagrantvectors.com/smallTreeView?pid=" + personID + "&tid=" + treeID; 
			// alert(strUrl);
			
			window.open(strUrl, "_self");

		}

</script>
	

<BODY>


<form onsubmit="return runit()"  action="${request.route_url('addPersonCommit')}"  id="addPCommt" method="post" enctype="multipart/form-data">

	% if items:
		% for item in items:

			<br>
			
			<div align = "center"><b> <font size="+2">Add a <span id="relativeTypePageHeading"> relative </span> of ${item['firstName']} ${item['lastName']} </font></b> </div>	
			<br><br>

			<div id="container">

			<div id="colOne">
					
				<h3 style="text-align:center;"> Profile of New Relative </h3>

						<% mothers =  item['mothers']%>  
						<% fathers =  item['fathers']%>  
						<% siblings =  item['siblings']%>  
						<% spouses =  item['spouses']%>  
						<% children =  item['children']%>  

						<div style="margin-left:25px;margin-top:0px;font-size:14px;" >
				
						</div>
						

						<!-- <h2 style="text-align:center;" >Add a relative:</h2> -->

				
				<br>
				<div class="dataEntryRow" >  <label class="labelEntryField">First Name:</label>  
				<input type="text"  placeholder="First Name (Required)" name="firstName" id="firstName" value=""> &emsp;&nbsp;
				</div>
				
				<div class="dataEntryRow" > <label class="labelEntryField">Middle Name:</label>  
				<input type="text" placeholder="Middle Name" name="middleName" value="">&emsp;
				</div>

				<div class="dataEntryRow" >	<label class="labelEntryField">Last Name:</label>  
					 <input type="text" id="lastName" placeholder="Last Name (Required)" name="lastName" value="">
				</div>

				<div class="dataEntryRow">	<label class="labelEntryField">Nee:</label>  
					<input type="text" placeholder="Nee" name="nee" value="">
				</div>

				<div class="dataEntryRow">	<label class="labelEntryField">Year of Birth:</label>  
					 <input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value=""> &nbsp;&nbsp; 
				</div>

				<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Date of Birth:</label>  
					<input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" > 
				</div>
				
				<div style = "padding-bottom: 11px; margin-left:98px;" >
					<input type="radio"   name="yobExactOrEst"  value="exact" >
		    		<label for="yobExact">Exact</label>
					<input type="radio"   name="yobExactOrEst"  value="estimated" >
					<label for="yobEstimated">Estimated</label> 
					<input class="radioBtnHide" type="radio" name="yobExactOrEst"  checked="checked" value="" >
					<label for="yobHidden"></label> 
				</div>

				<div class="dataEntryRow">	<label class="labelEntryField">Year of Death:</label>  
					 <input type="number" style="padding-top:0px; width: 7em" max="3000" id="yod" name="yod"  placeholder="" value=""> 
				</div>

				<div style="margin-bottom:0px;" class="dataEntryRow">	<label class="labelEntryField">Date of Death:</label>  			
					<input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="">
				</div>
				
				<div style = "margin-left:98px;" >
					<input type="radio"   name="yodExactOrEst"  value="exact" >
		    		<label for="yodExact">Exact</label>
					<input type="radio"   name="yodExactOrEst"  value="estimated" >
					<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
					<input class="radioBtnHide" type="radio" name="yodExactOrEst"  checked="checked" value="" >
					<label for="yodHidden"></label> 
				</div>

				<div class="dataEntryRow">	<label style="padding-top:11px;" class="labelEntryField">Place of Birth:</label>  							
					  <input type="text" placeholder="City, State" name="placeOfBirth" value=""> 
				</div>
				
				<div class="dataEntryRow">	<label class="labelEntryField">Place of Death:</label>  							
					<input type="text" placeholder="City, State" name="placeOfDeath" value="">
				</div>

				<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Gender:</label>  
					
		   			<input type="radio" id="m" placeholder="M" name="genderB"  value="M"> 
		   			<label for="m">M</label> &nbsp;
		    		<input type="radio"  id="f" name="genderB" placeholder="F" value="F">
		    		<label for="f">F</label> 
					<input class="radioBtnHide" type="radio"  id="h" name="genderB" checked="checked" value="">
		    		<label for="h"></label> 
				</div>
				
				<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="">Gender at birth:</label>  
					<input type="radio" id="m" name="genderAtBirth"  value="M"> 
		   			<label for="m">M</label> &nbsp;
		    		<input type="radio"  id="f" name="genderAtBirth"  value="F">
		    		<label for="f">F</label> 
		    		<input class="radioBtnHide" type="radio"  id="h" name="genderAtBirth" checked="checked" value="">
		    		<label for="h"></label> 
				</div>

				<br><br><br><br><br><br><br>
				
			
				<label>pid: ${item['id']}</label>
				<input type="hidden"  name="pid" value="${item['id']}"> &nbsp;

				<input type="hidden"  name="upsertType" value="insert"> &nbsp;
				
				
				<label>tid: ${item['tid']}</label>
				<input type="hidden"  id="tid" name="tid" value="${item['tid']}"> &nbsp;


			</div> <!-- end of colOne div -->

				<div id="colTwoTwo" style="visibility: visible;" >

				   	<h3 style="margin-left:8px;text-align:center;" >New Relationships</h3>

					<div style="margin-left:20px;margin-bottom:-11px;font-size:16px;">
					Select a relation type to be added for ${item['firstName']} ${item['lastName']}.
					</div>
				
				<br>
				
			<div style="margin-top:0px;margin-left:42px; font-size:18px;"> 
						
						<input type="radio"  id="father" name="relativeType" value="father" 
						onclick="calcAndDisplayOtherRelsToBeAdded('father')" >
						<label for="father">father &nbsp;</label>
						
						<input type="radio"  id="mother" name="relativeType" value="mother" 
						onclick="calcAndDisplayOtherRelsToBeAdded('mother')" >
						<label for="mother">mother &nbsp;</label>

						<br>
							
						<input type="radio" id="brother" name="relativeType" value="brother" onclick="calcAndDisplayOtherRelsToBeAdded('brother')" >
						<label for="brother">brother </label>
						
						<input type="radio"  id="sister" name="relativeType"  value="sister" onclick="calcAndDisplayOtherRelsToBeAdded('sister')" >
						<label for="sister">sister &nbsp;</label>
				
				</div>
				
				<div style="margin-top:0px;margin-left:42px; font-size:18px;"> 		
				
						<input type="radio" id="son" name="relativeType" value="son" onclick="calcAndDisplayOtherRelsToBeAdded('son')" >
						<label for="son">son &nbsp; &nbsp; &nbsp;</label>	
						
						<input type="radio" id="daughter" name="relativeType" value="daughter" onclick="calcAndDisplayOtherRelsToBeAdded('daughter')" >
						<label for="daughter">daughter &nbsp; </label>	
					
						<input type="radio" id="spouse" name="relativeType" value="spouse" onclick="calcAndDisplayOtherRelsToBeAdded('spouse')" >
						<label for="spouse">spouse </label>

				</div>
			
				</div>

				<div id="colTwoOne" style="display:block;">
				
					<h3 style="margin-left:8px;text-align:center;" >Existing Relationships</h3>

						<br> 
						${insertRelationNamesCol01(item)} 

					
						<div id="AdditRelsToAdd" style="margin-left:15px;margin-bottom:-11px;display:none;" >
							The following additional relatives may be added: <br><br>
							<!--  for the new relative of: 
							of ${item['firstName']} ${item['lastName']}.  -->
	    		
			    		</div>

						<% mothers =  item['mothers']%>  
						<% fathers =  item['fathers']%>  
						<% children =  item['children']%>  
						<% siblings =  item['siblings']%>  
						<% spouses =  item['spouses']%>  

					
						<!-- create div with id of motherSpouse which is  
						mother plus item.relType  -->										
						${showMothers(item, "spouse")}

						<!-- create div with id of motherMother which is  
						mother plus item.relType  -->
						${showMothers(item, "mother")}
					
						${showFathers(item, "spouse")}
						${showFathers(item, "father")}

						<!-- create div with id of sibkid which is  
						sib plus item.relType  -->	
						${showSiblings(item, "kid")}  
						${showSiblings(item, "sib")} 
					
						<!-- create div with id of childrenKid which is  
						children plus item.relType  -->
						${showChildren(item, "kid")}

						<!-- create div with id of childrensib which is  
						children plus item.relType  -->
						${showChildren(item, "sib")}
						
						<!-- create div with id of spousemom which is  
						spouse plus item.relType  -->
						${showSpouses(item, "mom")}
						${showSpouses(item, "dad")}
					
						<br><br>
						<label  +  id="idInputAllRelativesLbl" ></label>
						<br><br>
					
						<input type="input"  id="idInputAllRelatives" name="nameInputAllRelatives" style="display:none;" value="">
						
				</div> <!-- end of col Two div -->
			

			
			<div style="text-align:center;padding-top:18px;clear:both;">
					<p> </p> 
					<input type="submit" name="add"  value="Add relative" style = "width:150px;font-size:16pt" class="button">
			
					&nbsp;&nbsp;&nbsp;&nbsp;
			
					<input type="button"  value="Cancel" style = "width:100px;font-size:16pt; background-color:gray;" onclick="varTreeID='${item['tid']}';varPersonID='${item['id']}';varPersonAndTree=varPersonID + '_' + varTreeID; ;cancelAndCloseForm(varPersonAndTree)" class="button">
			

				</div>

				</div>


			
				<%def name="showSpouses(item,relType)">

						<div id="spouses${relType}" style="margin-left:28px; display: none;" >
						<% allSpouses = "" %>  
						<% allRelatives = "" %>  
					
						% if len(spouses) > 0:
								
								<br>
								<b>${relType}: </b>
								
								<% relString = relType %>	
								<br>
								<% spouses02 =  item['spouses'] %>
								
								  	<% ctr =  0 %>  
						    		% while ctr < len(spouses02):
										
										<% spouse = item['spouses'][ctr]['name'] %>  
										<% spouseId = item['spouses'][ctr]['pid'] %>  
										
								 	 	<% allRelatives = allRelatives + ";" + spouseId %>

										<% idCtr = "spouse" + relType + str(ctr) %>  
										<% ctrH = "spouse" + relType + "H" + str(ctr) %>  

										<% toggleInOut = "spouse" + relType + "T" + str(ctr) %>  

										<% allSpouses = allSpouses + ";" + relType + '|' + spouseId %>  
										 
										<span id="${idCtr}"> ${spouse} </span> 

										<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> <span id="${toggleInOut}">x</a>
										</span> 

										<br>
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${spouseId}"> 

										<% ctr =  ctr + 1 %>  

									% endwhile

									<% spanName = "spouses" + relString + "88" %>  
									<span id="${spanName}"  style="display: none;" > ${allSpouses}  </span> 
								
							% endif
						
						</div>
				</%def>
				
				<%def name="showChildren(item,relType)">

						
						<div id="children${relType}" style="margin-left:28px; display: none;" >
						<% allKids = "" %>  
						<% allRelatives = "" %>  
						<% relString2 = "" %>  
											
						% if len(children) > 0:
								
							% if relType == 'sib':
								<% relString2 =  'Siblings' %>	
							% endif	
							
								 <b>${relString2}  </b>
								
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

											<% allKids = allKids + ";" + relType + '|' +kidId %>  
										
										<span id="${idCtr}" "> ${kid} </span> 
										
										<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> 
										
										<span id="${toggleInOut}">x</a>
										</span>  

										 <br>
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${kidId}"> 

										<% ctr =  ctr + 1 %>  

									% endwhile

									<% spanName = "kids" + relString + "88" %>  
									<span id="${spanName}"  style="display: none;"> ${allKids}  </span> 
							
						% endif
	
					</div>
				</%def>

				<%def name="showSiblings(item,relType)">
					
					<div id="sib${relType}" style="margin-left:28px; display: none;" >
						
						<% allSibs = "" %>  
						<% allSibsShow = "" %>  
						<% allRelatives = "" %>  
				    	% if len(siblings) > 0:
								 <br>
								 
								 <b>${relType}s: </b>
							
								<% sibs =  item['siblings'] %>				

								<% ctr =  0 %>  
						    		% while ctr < len(sibs):
									
										<% sib = item['siblings'][ctr]['name'] %>  
										<% sibId = item['siblings'][ctr]['pid'] %>  
										
								 	 	<% allRelatives = allRelatives + ";" + sibId %>
										<% idCtr = "sib" + relType + str(ctr) %>  
										<% ctrH = "sib" + relType + "H" + str(ctr) %>  
										
										<% toggleInOut = "sib" + relType + "T" + str(ctr) %>  
										
										<% allSibs = allSibs + ";" + relType + '|' +sibId %>  
										<% allSibsShow = allSibsShow + ";" + sib + '|' + sibId %>  
										<span id="${idCtr}"> ${sib} </span> 
										<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> 

										<span id="${toggleInOut}">x</a>  </span>  
										<br>										
										<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${sibId}"> 
										
										<% ctr =  ctr + 1 %>  
									% endwhile

									<% spanName = "sibs" + relType + "88" %>  
									<span id="${spanName}" > ${allSibs}  </span> 
							
						% endif
				
					</div>
				</%def>

				<%def name="showMothers(item, relType)">
	
						<div id="mother${relType}" style="margin-left:28px; display: none;" >
				    	
						<% allMoms = "" %>  
						
						% if len(mothers) > 0:
							
							<br>
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
								
								<% allMoms = allMoms + ";" + relString + '|' + momId %>  
								
								<% idCtr = 'mom' + relString + str(ctr) %>  
								<% ctrH = 'mom' + relString +"H" + str(ctr) %>  
								<% toggleInOut = 'mom' + relString +"T" + str(ctr) %>  
								
								<span id="${idCtr}"> ${mom}  </span> 

								<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> 
								<span id="${toggleInOut}">x</a> </span>  <br>

								<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${momId}"> 
								<% ctr =  ctr + 1 %>  

							% endwhile

							<% spanName = "moms" + relString + "88" %>  
							<span id="${spanName}"  style="display: none;" > ${allMoms}  </span> 
					
						% endif
				
					</div>
				</%def>

				<%def name="showFathers(item, relType)">
					
						<div id="father${relType}" style="margin-left:28px; display: none;" >

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
								
								<% allDads = allDads + ";" + relString + '|' + dadId %>  

								<% idCtr = 'dad' + relString + str(ctr) %>  
								<% ctrH = 'dad' + relString +"H" + str(ctr) %>  
								<% toggleInOut = 'dad' + relString +"T" + str(ctr) %>  
								
								<span id="${idCtr}"> ${dad}  </span> 
			
								<a href="#" style="text-decoration:none; color:crimson;" onclick="addOrRemoveRelative('${ctrH}', '${idCtr}', '${toggleInOut}'  )" style="color:red;font-size:17px;"> 
								<span id="${toggleInOut}">x</a> </span>  <br>
		
								<input type="hidden"  id="${ctrH}" name="${ctrH}" value="${dadId}"> 
	
								<% ctr =  ctr + 1 %>  

							% endwhile
							
							<% spanName = "dads" + relString + "88" %>  
							<span id="${spanName}" > ${allDads}  </span> 
					
						% endif

					</div>
				</%def>

				<%def name="insertRelationNamesCol01(item)">
					<div style="margin-left:8px;font-size:14px; " >
							
						% if len(mothers) > 0:
							<span style="margin-left:7px;" >	
								<b> Mother: </b> 	
								<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;						
								<% moms =  item['mothers'] %>
								<% ctr =  0 %>  
								% while ctr < len(moms):
									<% mom = item['mothers'][ctr]['name'] %>  
									${mom} 
									<% ctr =  ctr + 1 %>  
								% endwhile
							</span>
							<p> </p>
						% endif
						
						% if len(fathers) > 0:
								<span style="margin-left:7px;" >	
									<b>Father: </b> 
									<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
									<% dads =  item['fathers'] %>
										<% ctr =  0 %>  
										% while ctr < len(dads):
											<% dad = item['fathers'][ctr]['name'] %>  
											${dad} 
											<% ctr =  ctr + 1 %>  
										% endwhile
								</span>	
								<p> </p>
							% endif
												
						% if len(siblings) > 0:
							<div id="siblings2" style="margin-left:7px;" >
								<b>Siblings: </b> 
								<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
								<% sibs =  item['siblings'] %>				
						
								<% ctr =  0 %>  
								<% allSibsTxt =  "" %>  
								
								% while ctr < len(sibs):
									
									## <% sib = str(ctr) + "|" + item['siblings'][ctr]['name'] + "|" + item['siblings'][ctr]['pid'] %>  
									## <% sib = item['siblings'][ctr]['pid'] %>  
									<% sib = item['siblings'][ctr]['name'] %>  
									${sib};  
									<% ctr =  ctr + 1 %>  
									<% allSibsTxt = allSibsTxt + sib + "; " %>  
								% endwhile
								<div hidden="hidden" id="siblingsList" > ${allSibsTxt}  </div>
								<div id = "siblings" >  </div>

							</div>
							<p> </p>
						% endif

						% if len(spouses) > 0:

								<div style="margin-left:7px;" >
								<b>Spouse(s): </b> 
								<br> &nbsp;&nbsp;&nbsp;
								
								<% spouses02 =  item['spouses'] %>
								
									<% ctr =  0 %>  
									% while ctr < len(spouses02):
										
										<% spouse = item['spouses'][ctr]['name'] %>  
										${spouse} 
										<br> &nbsp;&nbsp;&nbsp;
										<% ctr =  ctr + 1 %>  

									% endwhile
								</div>
								<p> </p>
						% endif

						% if len(children) > 0:

								<div style="margin-left:7px;" >
								<b>Children: </b> 
								<br> &nbsp;&nbsp;&nbsp;
								
								<% kids =  item['children'] %>
								
									<% ctr =  0 %>  
									<% allKidsTxt =  "" %>  
									% while ctr < len(kids):
										
										<% kid = item['children'][ctr]['name'] %>  
										${kid} 
										<br> &nbsp;&nbsp;&nbsp;
										<% ctr =  ctr + 1 %>  
										<% allKidsTxt = allKidsTxt + kid + "; " %>  

									% endwhile
									<div hidden "kidsList" > ${allKidsTxt}  </div>
									<div id = "kids">   </div>
								</div>
								<p> </p>
						% endif
					
					</div>
				</%def>


				
					
			<input type="hidden"  name="relationID" value="${item['relationID']}"> &nbsp;
			<input type="hidden"  id="genderOfBasePersonToWhomRelBeingAdded" name="genderOfBasePersonToWhomRelBeingAdded" value="${item['genderOfBaseRelative']}"> 
			<input type="hidden"  id="relationType" name="relationType" value="blah"> &nbsp;
					
			 <input type="hidden"  name="pedigreeRoot" value="0"> &nbsp;

			<div  id="relationTypeTxt"  value="blah"> &nbsp; 			</div>
	
		% endfor
	% endif

			

</form>




</BODY>
