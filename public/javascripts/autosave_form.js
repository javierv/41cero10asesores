/* DO NOT MODIFY. This file was compiled Wed, 05 Jan 2011 00:39:47 GMT from
 * /home/javi/programas/work/calesur/app/javascripts/autosave_form.coffee
 */

(function() {
  $(document).ready(function() {
    return setInterval(function() {
      return $('form.simple_form').ajaxSubmit({
        target: '#actualizado',
        data: {
          draft: true
        },
        success: function() {
          return $('#actualizado time').effect("highlight", {}, 3000);
        }
      });
    }, 120000);
  });
}).call(this);
