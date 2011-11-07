# 'jquery.form', 'typewatch', 'live_form'

describe 'Live form', ->
  beforeEach ->
    preloadFixtures 'live_form.html'

  it 'removes the preview button', ->
    expect($('input[name=preview]')).not.toExist()

  it 'adds a preview element', ->
    expect($('#preview')).toExist()

  describe 'typing in a field', ->
    beforeEach ->
      $('#post_title').val('my title').keydown()
      waits(1000)

    it 'fills the preview with the content', ->
      request = mostRecentAjaxRequest()
      request.response success(
        '<div id="response"><div id="preview"><p>My preview text</p></div></div>'
      )
      expect($('#preview')).toHaveHtml "<p>My preview text</p>"

    it 'fills the sidebar', ->
      request = mostRecentAjaxRequest()
      request.response success(
        '<div id="response"><div id="sidebar">Hola</div><div id="preview"><p>My preview text</p></div></div>'
      )
      expect($('#preview')).toHaveHtml "<p>My preview text</p>"
      expect($('#sidebar')).toHaveHtml "Hola"
