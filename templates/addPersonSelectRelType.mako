## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<meta charset="utf-8">
  
  <title>kinWheel - Update Person  </title>
 
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>



<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>  -->


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
		height: 475px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 22px;
	  	padding-top: 1px;

	}


	#colTwo {
		float: right;				/* This causes the content to move to the right */
		width: 600px;				/* We need to set the width whenever we float an element */
		height: 630px;
		border-style: solid;
	  	border-width: 1px;
		border-color: #ADD8E6;
	  	padding: 2px;
	  	padding-top: 1px;
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
			width:220px;
			text-align:left;
		}
		#content-main {
			margin-left:10px;
			width:2px;
		}
		#content-right {
			margin-left:10px;
			width:290px;
			border-left: 1px solid blue;
		}

		#content-full {
			
			text-align:left;
		}



	#footer {
		clear: both;  	/* This makes sure that the footer clears both the sidebar and content floats */
		width: 900px;	/* This sets the footer to stretch the full page width */
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
	 
	 // images_upload_url: "http://app6.base432.webfactional.com/upd_2",
	 // images_upload_url: "http://vagrantvectors.com/uploadFile",
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

    // function addNewPerson(rid)
	function addNewPerson()
    {

	    // var qspTreeID = getUrlParameter('tid');
		
		rid = document.getElementById("rid").value;

		var rType = $('input[name="relativeType"]:checked').val();
		var rTypeBase = rType;

		if (rType == 'brother' || rType == 'sister')
			{rTypeBase = 'sibling';}	
		if (rType == 'daughter' || rType == 'son')
			{rTypeBase = 'child';}	
	
		document.getElementById("rTypeBase").value = rTypeBase;
		// alert (rTypeBase);

		firstName02 = document.getElementById("firstName").value;
		lastName02 = document.getElementById("lastName").value;
		tid02 = document.getElementById("tid").value;
		
		var rootUrl = "${request.application_url}" + "/addPerson?";
				
		var strQsps = "rt=" + rTypeBase + "&rtdet=" + rType + "&rid=" + rid + "&tid=" + tid02 + "&prt=" + "0" + "&fname=" + firstName02 + "&lName=" + lastName02;  //prt=0 qsp indicates that this person is not the tree root, not the pedigree root

		var strUrl = rootUrl + strQsps; 
		return strUrl;

		// window.open(strUrl); 


    }

    function runit(input){
		
			addNewPerson();
				
				
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


<form id = "selectRetType" onsubmit="return runit(alert)" action="${request.route_url('addPerson')}" id="addP3" method="post" enctype="multipart/form-data">


	% if items:
		% for item in items:

			<div align = "center"><b> <font size="+2">Select type of relative to add for ${item['firstName']} ${item['lastName']}</font></b> </div>	
			<br><br>

			<!--   
			Name of Tree: ________________________________ 
			 <br><br>
			 <br>
			 -->

			 <div id="container">

				<div id="colOne">
				
				<h2 style="margin-left:2px;" >Profile of </h2>

				First Name: <input type="text"  placeholder="" font-size: 34px id="firstName" name="firstName" value="${item['firstName']}"> &emsp;&nbsp;
				<br><br>
				Middle Name: <input type="text" placeholder="Middle Name" name="middleName" value="${item['middleName']}">&emsp;
				<br><br>
				Last Name: <input type="text" placeholder="Last Name (Required)" id="lastName" name="lastName" value="${item['lastName']}">
				<br>
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				Nee:<input type="text" placeholder="Nee" name="nee" value="${item['nee']}">
				<br><br>

				<% varYob = item['dobYear']%> 

					% if varYob > 0:
							Year of Birth: <input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value="${item['dobYear']}"> &nbsp;&nbsp; 
					% else:
							Year of Birth: <input type="number" style="width: 7em" max="3000" id="yob" name="yob"  placeholder="" value=""> &nbsp;&nbsp; 

					% endif

				<% yobEstExValue = item['dobExactOrEst']%> 
				
				% if yobEstExValue =='exact':
					<input type="radio"   name="yobExactOrEst"  value="exact" checked="checked">
		    		<label for="yobExact">Exact</label>
					<input type="radio"   name="yobExactOrEst"  value="estimated">
	    			<label for="yobEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
				% elif yobEstExValue =='estimated':
					<input type="radio"   name="yobExactOrEst"  value="exact" >
		    		<label for="yobExact">Exact</label>
					<input type="radio"   name="yobExactOrEst"  value="estimated" checked="checked">
	    			<label for="yobEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
				% else:
					<input type="radio"   name="yobExactOrEst"  value="exact" >
		    		<label for="yobExact">Exact</label>
					<input type="radio"   name="yobExactOrEst"  value="estimated" >
	    			<label for="yobEstimated">Estimated</label> 
					<input class="radioBtnHide" type="radio" name="yobExactOrEst"  checked="checked" value="" >
	    			<label for="yobHidden"></label> 

	    			&nbsp;&nbsp; &nbsp;&nbsp; 
	    		% endif
	    		<br><br>



	<% varDob = item['dob']%> 
			
		% if varDob == None:
				Date of Birth: <input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" value="" >
				<br><br>
		% else:
				Date of Birth: <input type="text" id="dob" name="dob" placeholder="MM/DD/YYYY" value="${item['dob']}">
				<br><br>
		% endif

	<% varYod = item['dodYear']%> 

		% if varYod > 0:
				Year of Death: <input type="number" style="width: 7em" max="3000" id="yod" name="yod"  placeholder="" value="${item['dodYear']}"> &nbsp;&nbsp; 
		% else:
				Year of Death: <input type="number" style="width: 7em" max="3000" id="yod" name="yod"  placeholder="" value=""> &nbsp;&nbsp; 

		% endif

		<br><br>

				
				<% yodEstExValue = item['dodExactOrEst']%> 
				
				% if yodEstExValue =='exact':
					<input type="radio"   name="yodExactOrEst"  value="exact" checked="checked">
		    		<label for="yodExact">Exact</label>
					<input type="radio"   name="yodExactOrEst"  value="estimated">
	    			<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
				% elif yodEstExValue =='estimated':
					<input type="radio"   name="yodExactOrEst"  value="exact" >
		    		<label for="yodExact">Exact</label>
					<input type="radio"   name="yodExactOrEst"  value="estimated" checked="checked">
	    			<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
				% else:
					<input type="radio"   name="yodExactOrEst"  value="exact" >
		    		<label for="yodExact">Exact</label>
					<input type="radio"   name="yodExactOrEst"  value="estimated" >
	    			<label for="yodEstimated">Estimated</label> &nbsp;&nbsp; &nbsp;&nbsp; 
	    			<input class="radioBtnHide" type="radio" name="yodExactOrEst"  checked="checked" value="" >
	    			<label for="yodHidden"></label> 
	    		% endif
				

				<br><br>

<% varDod = item['dod']%> 
			
		% if varDod == None:
				Date of Death: <input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="" >
				<br><br>
		% else:

				Date of Death: <input type="text" id="dod" name="dod" placeholder="MM/DD/YYYY" value="${item['dod']}">
				<br><br>


		% endif

				
				<br><br>
				Place of Birth:  <input type="text" placeholder="City, State" name="placeOfBirth" value="${item['placeOfBirth']}"> 
				<br>
				
				Place of Death: <input type="text" placeholder="City, State" name="placeOfDeath" value="${item['placeOfDeath']}">&emsp;&emsp;&emsp;&nbsp;&thinsp;&nbsp;

				<br><br>

				Gender <font size = "1">(Optional)</font>:&nbsp;
				<% genderValue = item['gender']%> 
		
				% if genderValue=='M':
		    		<input type="radio" id="m" placeholder="M" name="genderB" checked="checked" value="M">
		    		<label for="m">M</label>
		    		<input type="radio"  id="f" name="genderB"  placeholder="F" value="F">
		    		<label for="f">F</label>
				% elif genderValue=='F':
		    		<input type="radio" id="m" placeholder="M" name="genderB"  value="M">
		    		<label for="m">M</label>
		    		<input type="radio"  id="f" name="genderB" checked="checked" placeholder="F" value="F">
		    		<label for="f">F</label>
				% else:
		   			<input type="radio" id="m" placeholder="M" name="genderB"  value="M"> &nbsp;&nbsp;
		   			<label for="m">M</label>
		    		<input type="radio"  id="f" name="genderB" placeholder="F" value="F">
		    		<label for="f">F</label> 
					<input class="radioBtnHide" type="radio"  id="h" name="genderB" checked="checked" value="">
		    		<label for="h"></label> 

				% endif

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				Gender at Birth <font size = "1">(Optional)</font>:&nbsp;
				<% genderAtBirthValue = item['genderAtBirth']%> 
				
				% if genderAtBirthValue =='M':
		    		<input type="radio" id="m2" name="genderAtBirth" checked="checked" value="M">
		    		<label for="m">M</label>
		    		<input type="radio"  id="f2" name="genderAtBirth"  value="F">
		    		<label for="f">F</label>
				% elif genderAtBirthValue=='F':
		    		<input type="radio" id="m2"  name="genderAtBirth"  value="M">
		    		<label for="m">M</label>
		    		<input type="radio"  id="f2" name="genderAtBirth" checked="checked" value="F">
		    		<label for="f">F</label>
				% else:
		   			<input type="radio" id="m2" name="genderAtBirth"  value="M"> &nbsp;&nbsp;
		   			<label for="m">M</label>
		    		<input type="radio"  id="f2" name="genderAtBirth"  value="F">
		    		<label for="f">F</label> 
		    		<input class="radioBtnHide" type="radio"  id="h" name="genderAtBirth" checked="checked" value="">
		    		<label for="h"></label> 

				% endif

				
				<br><br>
				
				<div style="text-align:center;">
				<input type="submit" name="add"  value="SAVE" style = "width:150px;font-size:16pt" class="button">
				</div>
				<br><br>
				<label>pid: ${item['id']}</label>
				<input type="hidden"  name="pid" value="${item['id']}"> &nbsp;

				<label>tid: ${item['tid']}</label>
				<input type="hidden"  id="tid" name="tid" value="${item['tid']}"> &nbsp;

				<label>rid: ${item['rid']}</label>
				<input type="hidden"  id="rid" name="rid" value="${item['rid']}"> &nbsp;
		


				</div> <!-- end of colOne div -->

				<div id="colTwo">

					
											
				<!-- <textarea name="photoDescrip" cols="30" rows="3" > ${item['photoDescrip']}  </textarea>   <br> -->

						<% mothers =  item['mothers']%>  
						<% fathers =  item['fathers']%>  
						<% siblings =  item['siblings']%>  
						<% spouses =  item['spouses']%>  
						<% children =  item['children']%>  


					<div id="content">
					
						<div id="content-left">

							<h3 style="margin-left:9px;" >Existing Relationships</h3>
							
							${insertRelationNamesCol01(item)}
						
						</div>
				
					<div id="content-right">

						<h3 style="margin-left:9px;" >New Relationships</h3>

					<label>rtype: </label>
					<input type="hidden"  id="rTypeBase" name="rTypeBase" value="rtype not selected"> &nbsp;
		
					<div style="margin-top:-12px;margin-left:12px; font-size:18px;" > 
					Add a: 
					<div style="margin-top:-5px;margin-left:15px; font-size:12px;" >
						<input type="radio" id="mother" name="relativeType" value="mother">
			    		<label for="mother">mother</label>
			    		<input type="radio"  id="father" name="relativeType"  value="father">
			    		<label for="father">father</label>
			    		<input type="radio" id="brother" name="relativeType" value="brother">
			    		<label for="brother">brother</label>
			    		<br>
			    		<input type="radio"  id="sister" name="relativeType"  value="sister">
			    		<label for="sister">sister</label>
						<input type="radio" id="spouse" name="relativeType" value="spouse">
			    		<label for="spouse">spouse</label>
			    		<input type="radio"  id="daughter" name="relativeType"  value="daughter">
			    		<label for="daughter">daughter</label>
						<input type="radio"  id="son" name="relativeType"  value="son">
			    		<label for="son">son</label>

		    		</div>

						<div style="margin-left:25px;margin-top:-8px;font-size:14px;" >
							
							<% addPersonFunc = "addNewPerson(" + str(item['id']) + ")" %>		
<% addPersonFunc = "addNewPerson(" + str(item['id']) + "," + ")" %>		
														

							<a href="#" onclick=${addPersonFunc}>as a new person not in tree</a>
							
							 <br><br>
							<a  href="https://google.com" > from a person already in tree </a>

						</div>
					
					</div>
					
					</div>

				<%def name="insertRelationNamesCol01(item)">
					<div style="margin-left:8px; " >
				    		
						% if len(mothers) > 0:
								
							<b>Mother:</b> 
							<br>
							<% moms =  item['mothers'] %>
							<% ctr =  0 %>  
				    		% while ctr < len(moms):
								
								<% mom = item['mothers'][ctr]['name'] %>  
								 ${mom} <br>
								<% ctr =  ctr + 1 %>  
							% endwhile
					
						% endif
						
						<br>

						% if len(fathers) > 0:
							
								<b>Father:</b> 
								<br>
								<% dads =  item['fathers'] %>
										
						    		<% ctr =  0 %>  
						    		% while ctr < len(dads):
										
										<% dad = item['fathers'][ctr]['name'] %>  
										 ${dad} 
										<% ctr =  ctr + 1 %>  
									% endwhile
							
								
						% endif
						
						<br><br>

						% if len(siblings) > 0:
								 <b>Siblings:</b>  
								 <br>
								<% sibs =  item['siblings'] %>				

								<% ctr =  0 %>  
						    		% while ctr < len(sibs):
										
										<% sib = item['siblings'][ctr]['name'] %>  
										 ${sib} <br>
										<% ctr =  ctr + 1 %>  
									% endwhile
							
						% endif



						% if len(spouses) > 0:

								<div style="margin-left:7px;" >
								<br><b>Spouse(s):</b> 
								</div>

								<% spouses02 =  item['spouses'] %>
								
								<div style="margin-left:12px;" >
								  	<% ctr =  0 %>  
						    		% while ctr < len(spouses02):
										
										<% spouse = item['spouses'][ctr]['name'] %>  
										 ${spouse} <br>
										<% ctr =  ctr + 1 %>  

									% endwhile
								</div>
						% endif

						% if len(children) > 0:

								<div style="margin-left:7px;" >
								<br><b>Children:</b> 
								</div>

								<% kids =  item['children'] %>
								
								<div style="margin-left:12px;" >
								  	<% ctr =  0 %>  
						    		% while ctr < len(kids):
										
										<% kid = item['children'][ctr]['name'] %>  
										 ${kid} <br>
										<% ctr =  ctr + 1 %>  

									% endwhile
								</div>
						% endif
					
					</div>
				</%def>

				</div>  <!-- end of colTwo div  -->
			
			</div>  <!-- end of content div  -->
		
		% endfor
	% endif



	

</form>



</BODY>
