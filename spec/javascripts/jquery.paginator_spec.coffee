require = (file) -> 
  document.write('<script type="text/javascript" src="/public/javascripts/' + file + '"></script>')

require 'jquery.history.js'
require 'jquery.paginator.js'

describe "Paginator", ->
  beforeEach ->
    loadFixtures('paginator.html')

  describe 'clicking a link', ->
    link = null

    beforeEach ->
      $('#list').ajaxPaginator({paginator: '.pagination'})
      link = $('.pagination a:first')
      link.click()

    it "calls the link via AJAX", ->
      expect(ajaxRequests.length).toEqual 1
      expect(ajaxRequests[0].url).toEqual link[0].href

    afterEach ->
      if history && history.pushState
        history.replaceState(null, null, '/')
      else
        location.hash = null 
