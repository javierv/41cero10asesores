$(document).ready ->
  $('#main').prepend('<div id="preview"></div>');

  $('input[name=preview]').remove();

  $('input[type=text], textarea', $('form.simple_form')).typeWatch(
    callback: ->
      $('form.simple_form').ajaxSubmit(
        target: '#preview',
        data: { preview: true }
      )
    wait: 1000,
    captureLenght: 1
  )