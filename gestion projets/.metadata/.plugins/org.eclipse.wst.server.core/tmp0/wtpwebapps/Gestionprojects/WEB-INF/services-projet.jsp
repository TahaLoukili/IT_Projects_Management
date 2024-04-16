<%@page import="java.util.List"%>
<%@page import="Models.Dev"%>
<%@page import="Models.Chef"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Affecter services</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<% int ProjetId = (int) request.getAttribute("ProjetId"); 

Chef chef=(Chef) request.getAttribute("chef");
List<Dev> listDevs=(List<Dev>) request.getAttribute("listDevs");
%>



 
  <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
    <a href="#" class="flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white">
        <img class="w-8 h-8 mr-2" src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/logo.svg" alt="logo">
        Espace Chef  
    </a>
  <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-3xl xl:p-0 dark:bg-gray-800 dark:border-gray-700">
    <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
        <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
            Creer les services et leurs taches correspondantes
        </h1>
        <form action="ajouterrServicesServlet" method="post" class="space-y-4 md:space-y-6 flex flex-col">
            <div class="flex flex-col">
                <label for="meth" class="mb-2 text-sm font-medium text-gray-900 dark:text-white">Description de service</label>
                <input type="text" name="description" id="description" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 mb-4" placeholder="service de..." required oninput="showHiddenDiv()">
                <label for="meth" class="mb-2 text-sm font-medium text-gray-900 dark:text-white">duree en Jour</label>
                <input type="number" name="duree" id="duree" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 mb-6" placeholder="1" required min="1" step="1" oninput="showHiddenDiv()">
                <input type="hidden" value="<%=ProjetId%>" name="ProjetId"> 
                 <input type="hidden" value="<%=chef.getId()%>" name="ChefId"> 
            </div>

           <div id="hiddenDiv" class="hidden">
    Ajouter la Tache de cette services et affecter pour un developpeur
    <div class="flex">
        <input type="text" name="nomTache_1" id="nomTache_1" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 mr-4" placeholder="Nom Tache">
        <select name="selectList_1" id="selectList_1" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
            <option value="" disabled selected hidden>Select Developer</option> 
            <% for (Dev dev : listDevs) { %>
                <option value="<%= dev.getId() %>"><%= dev.getUsername() %></option>
            <% } %>
        </select>
        <button type="button" onclick="addNewDiv()" class="bg-blue-600 text-white hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-4 py-2">Ajouter</button>
    </div>
</div>


            <div class="flex justify-end" id="enregistrerButton">
                <input name="Enregistrer" type="submit" value="Enregistrer" class="text-white bg-blue-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-4 py-2 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800" >
            </div>
        </form>
    </div>
</div>
</div>


<script>
    function showHiddenDiv() {
        var descriptionValue = document.getElementById('description').value;
        var dureeValue = document.getElementById('duree').value;
        var hiddenDiv = document.getElementById('hiddenDiv');

        if (descriptionValue !== '' && dureeValue !== '') {
            hiddenDiv.classList.remove('hidden');
        } else {
            hiddenDiv.classList.add('hidden');
        }
    }

    var counter = 2; // Initialize a counter for the divs
    

  

    function addNewDiv() {
        var hiddenDiv = document.getElementById('hiddenDiv');
        var clone = hiddenDiv.cloneNode(true);

        var deleteButton = document.createElement('button');
        deleteButton.textContent = 'Supprimer';
        deleteButton.classList.add('bg-red-600', 'text-white', 'hover:bg-red-700', 'focus:ring-4', 'focus:outline-none', 'focus:ring-red-300', 'font-medium', 'rounded-lg', 'text-sm', 'px-4', 'py-2', 'ml-2');
        deleteButton.onclick = function () {
            clone.parentNode.removeChild(clone);
        };

        clone.appendChild(deleteButton);

        var enregistrerButton = document.getElementById('enregistrerButton');
        enregistrerButton.parentNode.insertBefore(clone, enregistrerButton);

        // Find inputs in the cloned div and update their names
        var inputs = clone.querySelectorAll('input, select');
        inputs.forEach(function(input) {
            if (input.name !== '') {
            	input.value="";
            	input.name = input.name.replace("_1", '');
                input.setAttribute('name', input.name + '_' + counter);
            }
        });

        counter++; // Increment the counter for the next div
        
    }



</script>





</body>
</html>