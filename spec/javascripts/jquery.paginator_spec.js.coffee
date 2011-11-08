describe "Paginator", ->
  beforeEach ->
    loadFixtures "paginator"
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
      request.response success('<p>Success!</p>')
      expect($('#list')).toHaveHtml request.responseText

    it "updates the browser's address bar", ->
      if history && history.pushState
        expect(location.href).toEqual link[0].href

    afterEach ->
      if history && history.pushState
        history.replaceState null, null, '/'
