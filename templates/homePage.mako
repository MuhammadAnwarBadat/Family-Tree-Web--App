## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script>

<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Josefin+Sans" />


<style type="text/css">
	 body{
             font-family:Playfair Display, serif;
        }
        
        .input{
            padding: 5px;
            font-size: 14pt;
            width: 300px;
            font-family:Playfair Display, serif;
            font-weight: normal;
        }

        .btnSignUp {
            padding: 5px;
            font-size: 16pt;
            width: 150px;
            font-family:Playfair Display, serif;
            background-color: #8A1108;
            border: none;
            color: white;
            text-align: center;
            opacity: 0.7;
            transition: 0.3s;
            }

        .btnSignUp:hover {
        opacity: 1;
        cursor:pointer;
        }


.colOne {
  float: left; 		/* This causes the sidebar to move to the left */
  width: 400px; 		/* We need to set the width whenever we float an element */
 
  margin-left:7%;
  border-style: solid;
  border-width: 0px;
  border-color: #ADD8E6;
  padding: 22px;
  padding-top: 1px;

}

.colTwo {
		float: right;					/* This causes the content to move to the right */
		width: 600px;					/* We need to set the width whenever we float an element */
		
		margin-top: 10px;
    margin-right: 110px;
    text-align: right;
    border-style: solid;
	  border-width: 0px;
		border-color: #ADD8E6;
	  padding: 2px;
	  padding-top: 1px;
	}

  .colOneRowTwo {
  
    float: left; 		/* This causes the sidebar to move to the left */
    width: 46%; 		/* We need to set the width whenever we float an element */
    margin-top: 25px;
    margin-left:4%;
    text-align: center;
  }

  .colTwoRowTwo {
		float: right;		
		width: 46%;		
    margin-top: 25px;
    margin-right:4%;
    text-align: center;
  }

  .colTwoRowTwo {
		float: right;		
		width: 46%;		
    margin-top: 25px;
    margin-right:4%;
    text-align: center;
  }

  .rowThree {

    text-align: center;

  }

  #sectionThree {

    clear:both;
    margin-left: 150px;
    margin-right:130px;
    font-size:26px;
    font-family: Perpetua, Baskerville, Big Caslon, Palatino Linotype, Palatino, serif;

  }

  .button {
  border: none;
  color: black;
  font-family:  Perpetua, Baskerville, Big Caslon, Palatino Linotype, Palatino, serif;
  font-size: 36px;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 16px;
}

.button1 {background-color: #f1ae38;font-size:20px;} /* Green */
.button2 {background-color: #008CBA;} /* Blue */

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

			
		return true; // submit the form

	}


	function isValidDate(dateString) {
		var regEx = /^\d{4}-\d{2}-\d{2}$/;
		return dateString.match(regEx) != null;
	}

</script>

<BODY>


    <title>Login</title>
  


% if items:

	% for item in items:

        <div style="text-align:right;font-size:15px;">
            
            User:  ${item['user']} <br><br>
           
            <% loginUrl = item['root_url'] + 'userlogin' %> 
            <% logoutUrl = item['root_url'] + 'logout' %> 
          
            <% varUser = item['user']%> 

            % if varUser:
               
                <a style="color:gray;font-size:11px;font-size:15px;" href= ${logoutUrl}>logout</a>

            % else:
                <a style="color:gray;font-size:11px;font-size:15px;" href= ${loginUrl}>login</a>
            % endif

   		</div>

      <div style="text-align:center;padding-top:34px;">
       

      <input class="button button1" type="button" onclick="location.href='${request.application_url}/viewTrees'" value="View your trees" />

     
    		</div>

 

		
		<% break %> 

	% endfor

% endif


 <div class="colTwo">


<br>



</div>

<div class="rowThree">


<br><br><br>
</div>

<div id="sectionThree">


</div>

<div class="colOneRowTwo">

</div>

<div class="colTwoRowTwo">
  
</div>


</BODY>