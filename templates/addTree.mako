## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>  -->



<style type="text/css">
	ta {
	 width: 300px;
	 height: 100px;
	 background-color: yellow;
	 font-size: 1em;
	 font-weight: bold;
	 font-family: Verdana, Arial, Helvetica, sans-serif;
	 border: 4px solid black;
	}

	.button{
		font-size: 18px;
		background-color: #10af0a;
		font-family: "Times New Roman", Times, serif;
	}

	.fieldLabels
	{

		font-weight:bold;
		padding-right:7px;
	}

	.dataEntry
	{
	 margin-left:20%; // 0
	 margin-right:10%;
	 width:70%; 
	 text-align:left;  // right
	}

	.radioBtnHide{
    display: none;
	}

</style>

<SCRIPT LANGUAGE = "Javascript">

	var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i)

</SCRIPT>


<script type="text/javascript">

	// jquery
	$(document).ready(function(){

		if (window.ismobile) {
			// alert(ismobile);
			document.getElementById('body_not_mobile').style.display= "none";
			}
		else {
			document.getElementById('body_mobile').style.display= "none";
		}

		Start_Rotate();

	});


	function runit(input){

		 // alert ("The person has been created.");	
		formState = validateFormData();
		if (formState == 1)
			{
				return true; // true  // submit the form
			}
		else 
			{
				return false;
			}
		
		// return true; // submit the form

	}


	function isValidDate(dateString) {
		var regEx = /^\d{4}-\d{2}-\d{2}$/;
		return dateString.match(regEx) != null;
	}

		
   function validateFormData(d) {

		var genderValue = $("input[name='genderB']:checked").val();
        if(genderValue){
                // alert("thanks for gender!");
				return 1;  // 1
            }
        else
        	{
				alert("Please indicate the gender of the person being added.");
				return 0;
        	}

    }

</script>

<BODY style="border:1;">

<br>

<form onsubmit="return runit(alert)"  action="${request.route_url('addTreeInsert')}"  id="upd3" method="post" enctype="multipart/form-data">
		
	% if items:
		% for item in items:

			<div style="text-align:center; font-weight:bold; font-size:24px;color:blue;">Describe your New Tree</font></b> </div>	
			<br><br>
		
			<div class="dataEntry" >
		
			<span class="fieldLabels" > Tree Name: </span> <input type="text" size=64 placeholder="Tree Name (Required)" font-size: 34px name="treeName" value= "${item['firstName']} ${item['lastName']}'s Tree" >
			<br><br>						
			
			<span class="fieldLabels" > Tree Description:</span> <input type="text" size=64 placeholder="Enter a brief description of your new tree (Optional)" name="treeDescrip" value="">
			<br><br><br>

			<span class="fieldLabels" > First person to added to the tree: </span> (By default, this is you. This can be changed.)
			
			<br>

			First Name: <input type="text"  placeholder="First Name (Required)" font-size: 34px name="firstName" value="${item['firstName']}"> &emsp;&nbsp;
				
			Last Name: <input type="text" placeholder="Last Name (Required)" name="lastName" value="${item['lastName']}">

			<br>

			&emsp;&emsp; Gender <font size = "1"></font>:&nbsp;
			<input type="radio" id="m" placeholder="M" name="genderB"  value="M"> 
			<label for="m">M</label>
			<input type="radio"  id="f" name="genderB" placeholder="F" value="F">
			<label for="f">F</label> 
			<input class="radioBtnHide" type="radio"  id="h" name="genderB" checked="checked" value="">
			<label for="h"></label> 

			<br><br>
		
			</div>

			<br><br>
			
		
			
			<div style="text-align:center;">
			<input type="submit" name="add"  value="Create Tree" style = "width:150px;font-size:16pt; color:white; " class="button">
			</div>

			<br><br><br>

			<div style="margin-left:19%">

	User Name: ${item['uid']} 
	<input type="hidden"  name="placeholder" value=""> 

				
			</div>

			
		% endfor
	% endif

	

</form>


</BODY>