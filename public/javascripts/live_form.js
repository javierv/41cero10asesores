/* DO NOT MODIFY. This file was compiled Wed, 05 Jan 2011 00:39:47 GMT from
 * /home/javi/programas/work/calesur/app/javascripts/live_form.coffee
 */

(function() {
  $(document).ready(function() {
    $('#main').prepend('<div id="preview"></div>');
    $('input[name=preview]').remove();
    return $('input[type=text], textarea', $('form.simple_form')).typeWatch({
      callback: function() {
        return $('form.simple_form').ajaxSubmit({
          target: '#preview',
          data: {
            preview: true
          }
        });
      },
      wait: 1000,
      captureLenght: 1
    });
  });
}).call(this);
