require = (file) -> 
  document.write('<script type="text/javascript" src="/public/javascripts/' + file + '"></script>')

require 'jquery.history.js'
require 'jquery.paginator.js'

describe "Paginator", ->
  beforeEach ->
    loadFixtures('paginator.html')
    $('#list').ajaxPaginator({paginator: '.pagination'})

  describe 'clicking a link', ->
    link = null

    beforeEach ->
      link = $('.pagination a:first')
      link.click()

    it "calls the link via AJAX", ->
      expect(ajaxRequests.length).toEqual 1
      expect(ajaxRequests[0].url).toEqual link[0].href

    it "fills the element with the response", ->
      request = mostRecentAjaxRequest()
      request.response status: 200, responseText: '<p>Success!</p>'
      expect($('#list').html()).toEqual request.responseText

    afterEach ->
      if history && history.pushState
        history.replaceState(null, null, '/')
      else
        location.hash = null 
