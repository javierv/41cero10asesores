require = (file) -> 
  document.write('<script type="text/javascript" src="/public/javascripts/' + file + '"></script>')

require 'jquery.history.js'
require 'jquery.paginator.js'

describe "Paginator", ->
  beforeEach ->
    loadFixtures('paginator.html')

  it "has a paginator", ->
    expect($('body')).toBeVisible()
