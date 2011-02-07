require 'jquery.history'
require 'jquery.paginator'

describe "Paginator", ->
  beforeEach ->
    loadFixtures 'paginator.html'
    $('#list').ajaxPaginator()

  describe 'clicking a link', ->
    link = null

    beforeEach ->
      link = $('.pagination a:first')
      link.click()

    it "calls the link via AJAX", ->
      expect(ajaxRequests).toHaveLength 1
      expect(ajaxRequests[0].url).toEqual link[0].href

    it "shows it's loading while the request is proccessed", ->
      expect($('#list')).toContain 'p.loading'

    it "fills the element with the response", ->
      request = mostRecentAjaxRequest()
      request.response status: 200, responseText: '<p>Success!</p>'
      expect($('#list')).toHaveHtml request.responseText

    it "updates the browser's address bar", ->
      if browser_supports_history()
        expect(location.href).toEqual link[0].href
      else
        expect(location.hash).toEqual link[0].href

    afterEach ->
      if browser_supports_history()
        history.replaceState null, null, '/'
      else
        location.hash = null 
