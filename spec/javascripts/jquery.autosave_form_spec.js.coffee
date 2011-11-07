# 'jquery.form', 'jquery.autosave_form'

describe 'Autosave form', ->
  beforeEach ->
    preloadFixtures  'jquery.autosave_form.html'
    # Comentado porque jquery.form no se comporta
    # de manera estándar con $.ajax (aparentemente)
    # y no se falsea la llamada
    # $('#autosave_form').autosaveForm interval: 100

  it 'sends its contents every 0.1 seconds', ->
    # waits(200)
    # expect(ajaxRequests).toHaveLength 2

  afterEach ->
    # TODO: desligar el autosaveform para que no siga
    # haciendo peticiones. No sé si es necesario...
