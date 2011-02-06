describe "Paginator", ->
  beforeEach ->
    loadFixtures('paginator.html')

  it "has a paginator", ->
    expect($('body')).toBeVisible()
