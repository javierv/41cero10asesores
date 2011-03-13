jQuery.fn.addCargando = ->
  this.each -> $(this).addClass("cargando").append('<p class="loading"><strong>Cargando...</strong></p>')

jQuery.fn.removeCargando = ->
  this.each -> $(this).removeClass("cargando").children(".loading").remove()
