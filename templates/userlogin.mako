## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js" ></script> -->



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

        .btnLogin {
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

        .btnLogin:hover {
        opacity: 1;
        cursor:pointer;
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

			
		return true; // submit the form

	}

</script>

<BODY>

    <title>Login</title>
   

   </div>

<br>

<form action="${url}" method="post">
    <input type="hidden" name="came_from"
           value="${came_from}"/>
  

    <fieldset style = "width:200px;margin: auto;">
            <div align="center"><b><font size="36px" color = "maroon">LOG IN</font></b> </div>  
            <br>
            <br>
        
            <div text-align = "left">
            
            <input type="text" class="input" placeholder="Username" id="login" name="login" value="" required> 
            <br><br>
            
            <input type="password" class="input" id="password" name="password" placeholder="Password" required>
            <br><br>
            </div>    <br>

            <div align="center">
        
        <input type="submit" name="form.submitted"  class="btnLogin"
           value="Log In"/>

        </fieldset>

    <br>
        <div align = "center">
            
            Don't have an account? <a target="_blank" href="http://kwa.kw04.webfactional.com/registrationPage">Click here to register!</a>

        </div>

</form>



</BODY>