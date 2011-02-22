require 'borrar_ajax'

describe 'Destroy with AJAX', ->
  beforeEach ->
    loadFixtures 'borrar_ajax.html'

  describe 'clicking a link', ->
    beforeEach ->
      $('a.destroy:first').click()

    it 'makes an AJAX request', ->
      expect(ajaxRequests).toHaveLength 1

    it 'shows a loading message', ->
      expect($('#flash')).toHaveHtml '<p class="cargando">Cargando...</p>'

    describe 'after succeeding', ->
      beforeEach ->
        request = mostRecentAjaxRequest()
        request.response
          status:  200
          responseText: '<div><div class="flash">New flash</div></div>' +
            '<table><tbody><tr id="third_post">' +
            '<td>Third title</td>' +
            '<td><a href="/posts/3" class="destroy">Destroy</a></td>' +
            '</tr></tbody></table>'

        waits 500 # Tiempo del fadeOut

      it 'deletes the row clicked', ->
        expect($('#first_post')).not.toExist()

      it 'inserts the received row', ->
        expect($('#third_post')).toExist()
        expect($('#listado tbody tr')).toHaveLength 2

      it 'updates the flash', ->
        expect($('#flash')).toHaveHtml '<div class="flash">New flash</div>'

     
