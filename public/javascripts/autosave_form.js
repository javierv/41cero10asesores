$(document).ready(function()
{
  $('input[name=draft]').click(function()
  {
    $('form.simple_form').ajaxSubmit(
    {
      target: '#actualizado',
      data: {draft: true}
    })

    return false;
  });
});