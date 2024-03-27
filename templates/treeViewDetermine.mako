## -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<SCRIPT LANGUAGE = "Javascript">

var ismobile=navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);

</SCRIPT>

<style>

</style>
  
	% if items:
		
		<% ctr = 1 %> 
		
		% for item in items:
	
				<% varNumGens = item['numGens'] %>  
				% if varNumGens < 5:
				
					<script>
						// window. location = "https://www.google.com"
						window. location = "https://buttonandknob.com/smallTreeView?pid=" + ${item['personID']} + "&tid=" + ${item['treeID']}
					</script>

				% else:

					<script>
						// window. location = "https://www.yahoo.com"
						window. location = "https://buttonandknob.com/tallWideTreeView?tid=" + ${item['treeID']}
					</script>
			
				% endif
			
		% endfor	
	
	% endif



</BODY>
