# 'seleccion_diferencias'

describe 'Selección diferencias', ->
  beforeEach ->
    preloadFixtures 'seleccion_diferencias.html'

  it 'selecciona el primer botón de versión a mirar', ->
    expect($('#version_id_36')).toBeChecked()

  it 'selecciona el segundo botón de versión de referencia', ->
    expect($('#ref_id_35')).toBeChecked()

  it 'hace desaparecer el primer botón de referencia', ->
    expect($('#ref_id_36')).not.toBeVisible()

  it 'hace desaparecer los demás botones de versión a mirar', ->
    expect($('#version_id_35')).not.toBeVisible()

  describe 'Seleccionando otra versión de referencia', ->
    beforeEach ->
      $('#ref_id_34').click().change()

    it 'hace aparecer versión a mirar posterior', ->
      expect($('#version_id_35')).toBeVisible()

    describe 'Seleccionando otra versión a mirar', ->
      beforeEach ->
        $('#version_id_35').click().change()

      it 'hace desaparecer versión de referencia posterior', -> 
        expect($('#ref_id_35')).not.toBeVisible()
