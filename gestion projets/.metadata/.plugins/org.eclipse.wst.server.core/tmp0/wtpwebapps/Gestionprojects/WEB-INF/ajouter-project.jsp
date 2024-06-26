<%@page import="Models.Chef"%>
<%@page import="Models.Methodologie"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />
<jsp:include page="sidebar.jsp" />
<!-- 
<h1>Ajouter projet page</h1>
 -->

<% List<Methodologie> methodologies = (List<Methodologie>) request.getAttribute("methodologies"); 
List<Chef> chefs = (List<Chef>) request.getAttribute("chefs");
%>

<form action="addProjectServlet" method="post">
<div class="min-h-screen p-6 bg-gray-100 flex items-center justify-center">
  <div class="container max-w-screen-lg mx-auto">
    <div>
<!-- 
      <h2 class="font-semibold text-xl text-gray-600">Ajouter un projet</h2>
 -->

      <div class="bg-white rounded shadow-lg p-4 px-4 md:p-8 mb-6 ml-8">
        <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
          <div class="text-gray-600">
            <p class="font-medium text-lg">Détails du projet</p>
            <p>Please fill out all the fields.</p>
          </div>

          <div class="lg:col-span-2">
            <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 md:grid-cols-5">
              <div class="md:col-span-5">
                <label for="full_name">Nom du projet</label>
                <input type="text" name="nom" id="full_name" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required />
              </div>

              <div class="md:col-span-5">
                <label for="description" >Description du projet</label>
                <input type="text" name="description"  class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"  required />
              </div>

              <div class="md:col-span-3">
                <label for="date_demarrage">Date de démarrage</label>
                <input type="date" name="date_demarrage"  id="address" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required />
                <!-- <input type="date" name="date_demarrage"  id="address" onchange="convertDateFormat()" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required /> -->
              </div>

              <div class="md:col-span-2">
                <label for="date_livraison">Date de livraison</label>
                <!-- <input type="date" name="date_livraison"  id="city" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required /> -->
                <input type="date" name="date_livraison"  id="city" onchange="convertDateFormat()" class="h-10 border mt-1 rounded px-4 w-full bg-gray-50" required />
              </div>

			
				<div class="md:col-span-2">                
				<label for="chefs" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Chef du projet</label>
				<select id="chefs" name="chefs" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
    <% for (Chef chef : chefs) { %>
    <option value="<%=chef.getId() %>"> <%=chef.getUsername() %></option>
    <% } %>
</select>
                           
              </div> 

      
              <div class="md:col-span-5 text-right">
                <div class="inline-flex items-end">
                  <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Submit</button>
                 <!--  <input type="submit" value="Submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"/> -->
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>
</form>



<!-- <script>
function convertDateFormat() {
    // Get the value from the input field
    let originalDate = document.getElementById('inputDate').value;

    // Split the date into day, month, and year components
    let dateParts = originalDate.split('/');
    let year = dateParts[2];
    let month = dateParts[0];
    let day = dateParts[1];

    // Create a new date in the desired format (yyyy-mm-dd)
    let formattedDate = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;

    // Log or use the formatted date as needed
    console.log("Formatted date:", formattedDate);

    // Send the formatted date to the server or perform any other action
    // For example, you can assign the formatted date to a hidden input field
    document.getElementById('hiddenDate').value = formattedDate;
}
</script> -->

</body>
</html>