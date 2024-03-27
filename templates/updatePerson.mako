## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<meta charset="utf-8">
  
  <title>Update Person </title>
 
<script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>

<style type="text/css">
	
		body {
		text-align: left;				/* This is a hack for older browsers to center the page */
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
		border: 0;
		height: 31px;
	}

	#container {
		margin: 0 auto; 				/* This centers the page in modern browsers */
		text-align: left; 				/* This is a hack for older browsers to center the page */
		width: 1500px; 					/* This sets our total page width */
	}

	.form-field {
		text-align: right; /* Align the labels (e.g., "First Name:") to the right */
		margin-right: 10px; /* Add some spacing between the label and the field */
		font-weight: bold; /* Make labels bold if desired */
	}

	#colOne {
		float: left; 		/* This causes the sidebar to move to the left */
		width: 35%; 		/* We need to set the width whenever we float an element */
		height: 475px;
		border-style: solid;
	  	border-width: 0px;
		margin-left: 25%;
		border-color: #ADD8E6;
	  	padding: 22px;
	  	padding-top: 1px;

	}

	#colTwoOh {
		float: right;				/* This causes the content to move to the right */
		width: 30%;				/* We need to set the width whenever we float an element */
		height: 20px;
		margin-right: 20%;
	  	margin-top: 60px;
	}

	#colTwo {
		float: right;				/* This causes the content to move to the right */
		width: 30%;				/* We need to set the width whenever we float an element */
		height: 330px;
		border-style: solid;
	  	border-width: 0px;
		border-left-width: 1px;
		margin-right: 20%;
		border-color: #ADD8E6;
		padding: 2px;
	  	padding-top:0px;
	}

	#content {
			margin-top:4px;
			padding-bottom:10px;

		}
		#content div {
			padding:10px;
			// border:0px solid #bbb;
			// border: 3px solid red;
			float:left;
		}
		#content-left {
			width:280px;
			text-align:left;
		}
		#content-main {
			margin-left:10px;
			width:2px;
		}
		#content-right {
			margin-left:10px;
			width:280px;
			border-left: 1px solid blue;
		}

		#content-full {
			
			text-align:left;
		}

	#footer {
		clear: both;  	/* This makes sure that the footer clears both the sidebar and content floats */
		width: 900px;	/* This sets the footer to stretch the full page width */
	}

	.labelEntryField {
        display: inline-block;
        width: 175px;
        text-align: right;
      }
	
	.dataEntryRow {
        margin-bottom: 10px;
      }

</style>


<script type="text/javascript" src="https://cdn.tiny.cloud/1/nshr9llbtoxwil0wrvm5hs48ap7bfdauwdvkf0fvcm26sjtv/tinymce/5/tinymce.min.js" ></script >

<script type="text/javascript">
// plugins removed: contextmenu textcolor
tinymce.init({
     selector: "textarea",
     	height:300,
     	 theme: "silver",
         content_css : "static/myTinyCme.css",     // resolved to http://domain.mine/mysite/mycontent.css
         theme_advanced_font_sizes: "10px,12px,13px,14px,16px,18px,20px",
	 font_size_style_values : "10px,12px,13px,14px,16px,18px,20px",
         plugins: [
	             "advlist autolink lists link image charmap print preview hr anchor pagebreak",
	             "searchreplace wordcount visualblocks visualchars code fullscreen",
	             "insertdatetime media nonbreaking save table  directionality",
	             "emoticons template paste  "
	         ],
	         toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
	         toolbar2: "print preview media | forecolor backcolor emoticons",
	         image_advtab: true,
	         templates: [
	             {title: 'Test template 1', content: 'Test 1'},
	             {title: 'Test template 2', content: 'Test 2'}
	    ],

	 image_title: true,
	 
	  images_upload_url: "${request.application_url}" + "/uploadFile",
	 
	   // enable automatic uploads of images represented by blob or data URIs
  	automatic_uploads: true,
   // URL of our upload handler (for more details check: https://www.tinymce.com/docs/configure/file-image-upload/#images_upload_url)
    // images_upload_url: 'postAcceptor.php',
    // here we add custom filepicker only to Image dialog
  	file_picker_types: 'image', 
  
  	file_picker_callback: function(cb, value, meta) {
	      // alert ("2");
	      var input = document.createElement('input');
	      // var input = document.getElementById('file4');
	      input.setAttribute('type', 'file');
	      input.setAttribute('accept', 'image/*');
	      input.setAttribute('id', 'input');
	      input.setAttribute('name', 'input');
	      
	      input.removeAttribute('height');
	      input.removeAttribute('width');
	      
	      
	      
	      // alert (input.name)
	      // alert(document.getElementById('input3').id);

	      // Note: In modern browsers input[type="file"] is functional without 
	      // even adding it to the DOM, but that might not be the case in some older
	      // or quirky browsers like IE, so you might want to add it to the DOM
	      // just in case, and visually hide it. And do not forget do remove it
	      // once you do not need it anymore.

	      input.onchange = function() {
	
		var file = this.files[0];

		var reader = new FileReader();
		reader.onload = function () {
		  // Note: Now we need to register the blob in TinyMCEs image blob
		  // registry. In the next release this part hopefully won't be
		  // necessary, as we are looking to handle it internally.
		  // alert ("3");

		  var id = 'blobid' + (new Date()).getTime();
		  var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
		  var base64 = reader.result.split(',')[1];
		  var blobInfo = blobCache.create(id, file, base64);
		  blobCache.add(blobInfo);
				  

		  // call the callback and populate the Title field with the file name
		  // cb(blobInfo.blobUri(), { title: file.name });
		  cb(blobInfo.blobUri(), { title: "dis is da file name"});
		  // input.setAttribute('value', file);
		  // file4b = document.getElementById("file4");
		  // file4b.setAttribute('value', file);
		  // alert (file4b);
		  // alert(document.getElementById("input"));
		  // alert ("4");
		  

		};
		reader.readAsDataURL(file);
		// alert ("5");

	      };
	      // alert ("6");
	   
 	      input.click();
 	   
 	      input.removeAttribute('height');
	      input.removeAttribute('width');
	   
 	   // alert ("7");

	}
  	
});


</script>

  <script>

    $(document).ready(function(){

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

	    // alert(pid);
	    		
		// var qspTreeID = getUrlParameter('tid');
		

		var rType = $('input[name="relativeType"]:checked').val();
		var rTypeBase = rType;

		if (rType == 'brother' || rType == 'sister')
			{rTypeBase = 'sibling';}	
		if (rType == 'daughter' || rType == 'son')
			{rTypeBase = 'child';}	
	
		// alert (rTypeBase);

		firstName02 = document.getElementById("firstName").value;
		lastName02 = document.getElementById("lastName").value;
		tid02 = document.getElementById("tid").value;

		
		// alert(rType);
		
		// var strUrl = rootUrl + rid +"&rt=" + rType;
		// alert(strUrl);
		
		
		var rootUrl = "${request.application_url}" + "/addPerson?";
				
		var strQsps = "rt=" + rTypeBase + "&rtdet=" + rType + "&rid=" + rid + "&tid=" + tid02 + "&prt=" + "0" + "&fname=" + firstName02 + "&lName=" + lastName02;  //prt=0 qsp indicates that this person is not the tree root, not the pedigree root

		var strUrl = rootUrl + strQsps; 
		// alert(strUrl);
		

		// var strUrl = rootUrl + personID + "&fname=" + firstName + "&lname=" + lastName + "&tid=" + qspTreeID.toString();
		
		// + "&fname=" + d.firstname + "&lname=" + d.lastname + "&tid=" + qspTreeId;

		// intPersDetailWidth = screen.width - 150;

		// alert (strUrl);
		// window.location.assign(strUrl)
		window.open(strUrl); 


    }

    function runit(input){
		
			
				var dateDob = document.getElementById("dob");
				var chk = isValidDate2($(dateDob).val());
		  	if (chk === false )
		       {$(dateDob).val("bad date ");
		        return false;  }
								
				var dateDod = document.getElementById("dod");
				var chk = isValidDate2($(dateDod).val());
		  	if (chk === false )
		       {$(dateDod).val("bad date ");
		        return false;  }
				
				formatDateForSQL($(dateDob).val(), "dob")
				formatDateForSQL($(dateDod).val(), "dod")
				
				
				return true; // submit the form

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
};


  </script>
	

<BODY>

<form id="updatePerson" onsubmit="return runit(alert)" action="${request.route_url('updatePersonCommit')}" id="upd3" method="post" enctype="multipart/form-data">
    
	% if items:
    
	    % for item in items:
    
	        <div id="container">
    
	            <div id="colOne">
    
	                <div> <b> <font size="+2"> Update ${item['firstName']} ${item['lastName']}'s profile </font></b> </div>	
					<br><br>

					<div class="dataEntryRow" >  <label class="labelEntryField">First Name:</label>  
						<input type="text"  placeholder="First Name (Required)" name="firstName" id="firstName" value="${item['firstName']}"> &emsp;&nbsp;
					</div>
				
					<div class="dataEntryRow" > <label class="labelEntryField">Middle Name:</label>  
						<input type="text" placeholder="Middle Name" name="middleName" value="${item['middleName']}">&emsp;
					</div>

					<div class="dataEntryRow" >	<label class="labelEntryField">Last Name:</label>  
						<input type="text" id="lastName" placeholder="Last Name (Required)" name="lastName" value="${item['lastName']}">
					</div>

					<div class="dataEntryRow">	<label class="labelEntryField">Nee:</label>  
						<input type="text" placeholder="Nee" name="nee" value="${item['nee']}">
					</div>

					<% varYob = item['dobYear']%> 

					% if varYob > 0:	
						<div class="dataEntryRow">	<label class="labelEntryField">Year of Birth:</label>  
							<input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value="${item['dobYear']}"> &nbsp;&nbsp; 
						</div>
					% else:
						<div class="dataEntryRow">	<label class="labelEntryField">Year of Birth:</label>  
							<input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value=""> &nbsp;&nbsp; 
						</div>
					% endif

					<% varDob = item['dob']%>

					% if varDob == None:
						<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Date of Birth:</label>  
							<input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" value=""> 
						</div>
					% else:
						<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Date of Birth:</label>  
							<input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" value="${item['dob']}"> 
						</div>
					% endif
					
					<div style = "padding-bottom: 11px; margin-left:98px;" >
						<input type="radio"   name="yobExactOrEst"  value="exact" >
						<label for="yobExact">Exact</label>
						<input type="radio"   name="yobExactOrEst"  value="estimated" >
						<label for="yobEstimated">Estimated</label> 
						<input class="radioBtnHide" type="radio" name="yobExactOrEst"  checked="checked" value="" >
						<label for="yobHidden"></label> 
					</div>

					<% varYod = item['dodYear']%>

					% if varYod > 0: 
						<div class="dataEntryRow">	<label class="labelEntryField">Year of Death:</label>  
							<input type="number" style="padding-top:0px; width: 7em" max="3000" id="yod" name="yod"  placeholder="" value="${item['dodYear']}"> 
						</div>
					% else:
						<div class="dataEntryRow">	<label class="labelEntryField">Year of Death:</label>  
							<input type="number" style="padding-top:0px; width: 7em" max="3000" id="yod" name="yod"  placeholder="" value=""> 
						</div>
					% endif

					<% varDod = item['dod']%>

					% if varDod == None:
						<div style="margin-bottom:0px;" class="dataEntryRow">	<label class="labelEntryField">Date of Death:</label>  			
							<input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="">
						</div>
					% else:
						<div style="margin-bottom:0px;" class="dataEntryRow">	<label class="labelEntryField">Date of Death:</label>  			
							<input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="${item['dod']}">
						</div>
					% endif
					
					
					<div style = "margin-left:98px;" >
						<input type="radio"   name="yodExactOrEst"  value="exact" >
						<label for="yodExact">Exact</label>
						<input type="radio"   name="yodExactOrEst"  value="estimated" >
						<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
						<input class="radioBtnHide" type="radio" name="yodExactOrEst"  checked="checked" value="" >
						<label for="yodHidden"></label> 
					</div>

					
					
					<div class="dataEntryRow">	<label style="padding-top:11px;" class="labelEntryField">Place of Birth:</label>  							
						<input type="text" placeholder="City, State" name="placeOfBirth" value="${item['placeOfBirth']}"> 
					</div>
					
					<div class="dataEntryRow">	<label class="labelEntryField">Place of Death:</label>  							
						<input type="text" placeholder="City, State" name="placeOfDeath" value="${item['placeOfDeath']}">
					</div>



					<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Gender:</label>
						<% genderValue = item['gender']%>
						% if genderValue=='M':
							<input type="radio" id="m" placeholder="M" name="genderB" value="M" checked="checked">
		    				<label for="m">M</label>
		    				<input type="radio" id="f" placeholder="F" name="genderB" value="F">
		    				<label for="f">F</label>
						% elif genderValue=='F':
							<input type="radio" id="m" placeholder="M" name="genderB" value="M">
							<label for="m">M</label>
							<input type="radio" id="f" placeholder="F" name="genderB" value="F" checked="checked">
							<label for="f">F</label>
						% else:
							<input type="radio" id="m" placeholder="M" name="genderB" value="M">
							<label for="m">M</label>
							<input type="radio" id="f" placeholder="F" name="genderB" value="F">
							<label for="f">F</label>
							<input class="radioBtnHide" type="radio" id="h" name="genderB" value="" checked="checked">
							<label for="h"></label>
						% endif
					</div>
					

					
					<div style="margin-bottom:0px;" class="dataEntryRow">	<label  class="labelEntryField">Gender at birth:</label>
						<% genderAtBirthValue = item['genderAtBirth']%>
						% if genderAtBirthValue=='M':					
							<input type="radio" id="m2" placeholder="M" name="genderAtBirth" checked="checked" value="M">
							<label for="m">M</label>
							<input type="radio" id="f2" placeholder="F" name="genderAtBirth" value="F">
							<label for="f">F</label>
						% elif genderAtBirthValue=='F':
							<input type="radio" id="m2" placeholder="M" name="genderAtBirth" value="M">
							<label for="m">M</label>
							<input type="radio" id="f2" placeholder="F" name="genderAtBirth" checked="checked" value="F">
							<label for="f">F</label>
						% else:
							<input type="radio" id="m2" placeholder="M" name="genderAtBirth" value="M">
							<label for="m">M</label>
							<input type="radio" id="f2" placeholder="F" name="genderAtBirth" value="F">
							<label for="f">F</label>
							<input class="radioBtnHide" type="radio" id="h" name="genderAtBirth" checked="checked" value="">
							<label for="h"></label> 
						% endif
					</div>


					<br>


					<div style="text-align:left; margin-left: 160px">
						<input type="submit" name="add"  value="SAVE" style = "width:150px;font-size:16pt; background-color:DodgerBlue" class="button">
					</div>


					<br>	


					<div style="text-align:left; margin-left: 150px">
						<label>pid: ${item['id']}</label>
						<input type="hidden"  name="pid" value="${item['id']}"> &nbsp;

						<label>tid: ${item['tid']}</label>
						<input type="hidden"  id="tid" name="tid" value="${item['tid']}"> &nbsp;

						<label>rid: ${item['rid']}</label>
						<input type="hidden"  id="rid" name="rid" value="${item['rid']}"> &nbsp;
					</div>
		
				</div> <!-- end of colOne div -->
				
			</div>  <!-- end of container div  -->
		
		% endfor

	% endif	

</form>

</BODY>
