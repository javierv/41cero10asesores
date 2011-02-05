jQuery.ajaxSetup({ 
  'error': function(xhr, status) {
    if(xhr.status == 401) {
      window.location.href = '/';
    }
  }
});
