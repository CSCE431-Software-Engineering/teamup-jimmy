document.addEventListener('turbolinks:load', function() {
    var searchInput = document.getElementById('search-input');
    if (searchInput) {
      searchInput.addEventListener('input', function() {
        var query = searchInput.value.trim(); // Get the value of the search input and trim any leading/trailing whitespace
  
        // Perform AJAX request only if query is not empty
        if (query !== '') {
          $.ajax({
            url: pages_browse_path, // Replace with the correct URL for your controller action
            type: 'GET',
            dataType: 'script',
            data: { query: query }, // Pass the query parameter to the server
            success: function(response) {
              // Handle successful response here (e.g., update search results section)
              console.log('AJAX request successful');
            },
            error: function(xhr, status, error) {
              // Handle error response here
              console.error('AJAX request failed:', error);
            }
          });
        }
      });
    }
  });
  