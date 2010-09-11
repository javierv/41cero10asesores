$(document).ready(function()
{
  $('#main').prepend('<div id="preview"></div>');

  $('input[name=preview]').click(function()
  {
    preview();
    return false;
  })

  $('input[type=text], textarea', $('form.simple_form')).typeWatch({
    callback: function() {preview()},
    wait: 1000,
    captureLenght: 1
  });

  function preview()
  {
    $('form.simple_form').ajaxSubmit({
      target: '#preview',
      data: { preview: true }
    });
  }
});