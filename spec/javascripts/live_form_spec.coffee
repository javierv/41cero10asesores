require 'jquery.form'
require 'typewatch'

describe 'Live form', ->
  beforeEach ->
    loadFixtures 'live_form.html'
    waits(30)
    load 'live_form'

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
      request.response status: 200, responseText: '<p>My preview text</p>'
      expect($('#preview')).toHaveHtml request.responseText
