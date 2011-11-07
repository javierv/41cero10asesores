# 'ayuda_textile'

describe 'Ayuda Textile', ->
  beforeEach ->
    loadFixtures 'ayuda_textile.html'

  it 'pone un enlace antes del textarea', ->
    expect($('textarea').prev()).toBe '.ayuda-textile'
    expect($('a[href="/ayuda-textile"]')).toExist()
