$(document).on('turbolinks:load', function() {
    $('#search-input').on('input', function() {
      console.log('Input event triggered'); // Debug statement
      $.ajax({
        url: $('#search-form').attr('action'), // URL to send the AJAX request
        type: 'GET', // HTTP method
        dataType: 'script', // Expecting JavaScript response
        data: $('#search-form').serialize() // Serialized form data
      });
    });
  });
  