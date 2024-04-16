<%@page import="Models.Equipe"%>
<%@page import="Models.Dev"%>
<%@page import="Models.Technologie"%>
<%@page import="Models.Projet"%>
<%@page import="Models.Client"%>
<%@page import="Models.Methodologie"%>
<%@page import="Models.Chef"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Project Chef</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

</head>
<body>

<% Projet project = (Projet) request.getAttribute("Projet");
List<Methodologie> methodologies = (List<Methodologie>) request.getAttribute("Methods");
List<Technologie> Technologies = (List<Technologie>) request.getAttribute("technologies");
List<Integer> projetTechsIds = (List<Integer>) request.getAttribute("projetTechsIds");
List<Dev> devs=(List<Dev>) request.getAttribute("Devs");
Boolean isDevsVisible =(Boolean) request.getAttribute("isDevsVisible");
Boolean isDateReunionVisible =(Boolean) request.getAttribute("isDateReunionVisible");
Equipe equipe = (Equipe) request.getAttribute("equipe");


Chef chef=(Chef) request.getAttribute("chef");

%>

<!-- component -->
<%if(project !=null){ %>


<div class="min-h-screen p-6 bg-gray-100 flex items-center justify-center">
<form action="EditProjectChef" method="post">
  <div class="container max-w-screen-lg mx-auto">
    <div>
      <h2 class="font-semibold text-xl text-gray-600">page de modification du projet pour le chef</h2>
      <p class="text-gray-500 mb-6">Form is mobile responsive. Give it a try.</p>

      <div class="bg-white rounded shadow-lg p-4 px-4 md:p-8 mb-6">
        <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
          <div class="text-gray-600">
            <p class="font-medium text-lg">Détails du projet</p>
          </div>
			<input type="hidden" name="projectId" value="<%=project.getId() %>" >
			<input type="hidden" name="idChef" value="<%=chef.getId() %>" >
          <div class="lg:col-span-2">
            <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 md:grid-cols-5">
              <div class="md:col-span-5">
                <label for="full_name">Nom du projet</label>
                <input type="text" name="nomProject" id="full_name" value="<%=project.getNom() %>" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" value="" disabled="disabled"/>
              </div>

              <div class="md:col-span-5">
                <label for="description" >Description du projet</label>
                <input type="text" name="projectDescription" value="<%=project.getDescription() %>" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" value="test" disabled="disabled"/>
              </div>

              <div class="md:col-span-3">
                <label for="date_demarrage">Date de démarrage</label>
                <input type="date" name="dateDemarrage" value="<%=project.getDateDemarage() %>" id="address" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" disabled="disabled"/>
              </div>

              <div class="md:col-span-2">
                <label for="date_livraison">Date de livraison</label>
                <input type="date" name="dateLivraison" value="<%=project.getDateLivraison() %>" id="date_livraison" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" disabled="disabled"/>
              </div>
	
              
         
             <div class="md:col-span-2">                
    <label for="methodologies" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Choisir une methodologie</label>
    <select id="methodologies" name="selectedMethodology" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
        <% for (Methodologie meth : methodologies) { %>
            <option <%if(project.getMethodologie()!=null && project.getMethodologie().getNom().equals(meth.getNom())){ %> selected <%} %> value="<%= meth.getId() %>"><%= meth.getNom() %></option>
            
        <% } %>
    </select>                                
</div> 

<div class="md:col-span-2">                
    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Choisir une ou des technologies</label>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
    <% for (Technologie tech : Technologies) { %>
        <label class="flex items-center">
            <input type="checkbox" name="selectedTechnologies" value="<%= tech.getId() %>" class="rounded border-gray-300 text-blue-500 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
                <% 
                for(Integer idTech : projetTechsIds){
                	if(idTech.equals(tech.getId())){
                
         
                        
                    
                %> checked="checked"<% }} %>
            />
            <span class="ml-2"><%= tech.getNom() %></span>
        </label>
    <% } %>
</div>

</div>


                               
</div>
                               
              </div> 
      			
              <div class="md:col-span-5 text-right">
                <div class="inline-flex items-end">
				<!-- infos client -->
                  <input type="submit" value="Submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"/>
                </div>
              </div>

            </div>
          </div>
        </div>
        
  </form>     
        
        
     <% if (isDevsVisible != null && isDevsVisible && devs != null && !devs.isEmpty()) { %>
    <!-- devs shown start here -->
   <form action="creerEquipeServlet" method="post" id="secondForm">
    <div class="bg-white rounded shadow-lg p-4 px-4 md:p-8 mb-6">
        <div class="gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
            <div class="text-gray-600">
                <p class="font-medium text-lg">Liste des développeurs convenables</p>
            </div>
            <input type="hidden" name="idproject" value="<%=project.getId() %>">
            <input type="hidden" name="idChef" value="<%=chef.getId() %>" >
            <% for (Dev dev : devs) { %>
                <% 
                boolean hasMatchingTech = false;
                for (Technologie tech : dev.getTechnologies()) {
                    if (projetTechsIds.contains(tech.getId())) {
                        hasMatchingTech = true;
                        break;
                    }
                }
                if (hasMatchingTech) { %>
                    <div class="flex items-center justify-between">
                        <div>
                            <p><%= dev.getUsername() %></p>
                        </div>
                        <div class="flex text-gray-400" >
                            <p>Technologies:</p>
                            <% for (Technologie tech : dev.getTechnologies()) { %>
                                <p><%= tech.getNom() %></p>
                               
                            <% } %>
                        </div>
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="selectedDevs" value="<%=dev.getId() %>" class="form-checkbox">
                            <span class="ml-2">Select</span>
                        </label>
                    </div>
                <% } %>
            <% } %>
            <div class="md:col-span-5 text-right">
                <div class="inline-flex items-end">
                    <input type="submit" value="Créer Equipe" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="submitForms(event)"/>
                </div>
            </div>
            
            
           
        </div>
       
        
    </div>
</form>





    <!-- devs shown end here -->
<% } %>


     <% if (isDateReunionVisible != null && isDateReunionVisible) { %>
    <!-- devs shown start here -->
    <form action="ajouterDateReunionServlet" method="post" id="thirdForm">
        <div class="bg-white rounded shadow-lg p-4 px-4 md:p-8 mb-6">
            <div class="gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
                <div class="text-gray-600">
                    <p class="font-medium text-lg">Choisir une date de reunion</p>
                </div>
                <input type="hidden" name="idproject" value="<%=project.getId() %>">
                <input type="hidden" name="idChef" value="<%=chef.getId() %>">
                
                <input type="date" name="dateReunion" id="address" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required />
                
                <div class="md:col-span-5 text-right">
                    <div class="inline-flex items-end">
                        <input type="submit" value="Enregistrer Projet" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="submitForms(event)" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- devs shown end here -->
<% } %>

        
        
        
        
        
        
      </div>
    </div>
 
  </div>
  
</div>
</div>

</div>





<!-- <form action="EditProjectChef" method="post" >
 
 <h1>devs are shown</h1>


</form> -->




<% }else{ %>
<h1>Project est null</h1>
<% } %>

<script>
function submitForms(event) {
    event.preventDefault(); // Prevent the default form submission

    document.getElementById('secondForm').submit(); // Submit second form
    document.getElementById('thirdForm').submit(); // Submit third form
}

</script>

</body>
</html>