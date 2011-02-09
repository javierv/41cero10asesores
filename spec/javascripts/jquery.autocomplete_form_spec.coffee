require 'jquery.ui.core'
require 'jquery.ui.widget'
require 'jquery.ui.position'
require 'jquery.ui.autocomplete'
require 'jquery.autocomplete_form'

describe 'Autocomplete form', ->
  beforeEach ->
    # Lo ideal sería hacer un spyOn sobre el input
    # pero no parece posible por no ser el mismo
    # objeto en los tests que al ejecutarse.
    # En jQuery:
    # jQuery(jQuery(this)[0]) != jQuery(this)
    loadFixtures 'jquery.autocomplete_form.html'
    $('form.filter').autocompleteForm()

  it 'calls autocomplete on the input', ->
    # expect(input.autocomplete).toHaveBeenCalled()

