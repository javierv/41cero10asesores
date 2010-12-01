$(document).ready(function()
{
  setInterval(function()
  {
    $('form.simple_form').ajaxSubmit(
    {
      target: '#actualizado',
      data: {draft: true},
      success: function()
      {
        $('#actualizado time').effect("highlight", {}, 3000);
      }
    })
  }, 120000);
});