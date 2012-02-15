if(($('input[formaction]').length > 0) && !('formAction' in document.createElement('input'))) {
  $('<div id="error_formaction">¡Atención! <strong>¡Tu navegador no es compatible con la edición de este formulario!</strong> Puedes usar navegadores compatibles, como Firefox (versión 4 o más reciente), Chrome (versión 10 o más reciente) o versiones recientes de Opera</div>').insertBefore("#content")
}
