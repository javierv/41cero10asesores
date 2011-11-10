describe 'Autocomplete form', ->
  beforeEach ->
    loadFixtures "autocomplete_form"
    $("form").autocompleteForm()

  it "calls autocomplete on the input", ->
    expect($("form input")).toHaveClass "ui-autocomplete-input"
    # Lo ideal sería hacer un spyOn sobre el input
    # pero no parece posible por no ser el mismo
    # objeto en los tests que al ejecutarse.
    # En jQuery:
    # jQuery(jQuery(this)[0]) != jQuery(this)
    # expect(input.autocomplete).toHaveBeenCalled(), with url...
