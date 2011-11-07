jQuery.ajaxSetup ->
  'error': (xhr, status) ->
    if xhr.status == 401
      window.location.href = '/'
