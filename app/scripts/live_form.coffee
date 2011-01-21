$(document).ready ->
  $('#main').prepend('<div id="preview"></div>');

  $('input[name=preview]').remove();

  $('input[type=text], textarea', $('form.pagina')).typeWatch(
    callback: ->
      $('form.pagina').ajaxSubmit(
        target: '#preview',
        data: { preview: true }
      )
    wait: 1000,
    captureLenght: 1
  )