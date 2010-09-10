$(document).ready(function()
{
  $('textarea').markItUp(markitup_settings);

  $('#main').prepend('<div id="preview"></div>');

  $('input[name=preview]').click(function()
  {
    $(this).parents('form').ajaxSubmit({
      target: '#preview',
      data: { preview: true }
    });
    return false;
  })
});