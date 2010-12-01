$(document).ready(function()
{
  setInterval(function()
  {
    $('form.simple_form').ajaxSubmit(
    {
      target: '#actualizado',
      data: {draft: true}
    })
  }, 120000);
});