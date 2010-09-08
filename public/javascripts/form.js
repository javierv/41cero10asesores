$(document).ready(function()
{
  $('textarea').markItUp(markitup_settings);

  $('<div id="preview"></div>').insertAfter('form.simple_form')

  $('input[name=preview]').click(function()
  {
    $(this).parents('form').ajaxSubmit({
      target: '#preview',
      data: { preview: true }
    });
    return false;
  })
});