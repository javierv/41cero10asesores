# encoding: utf-8

require 'test_helper'

class CajaTest < ActiveSupport::TestCase
  should validate_presence_of(:titulo)
  should allow_mass_assignment_of(:titulo)
  should validate_presence_of(:cuerpo)
  should allow_mass_assignment_of(:cuerpo)

  should 'ordenar las cajas teniendo en cuenta las de una página' do
    pagina = Factory(:pagina)
    cajas = [Factory(:caja), Factory(:caja)]
    sidebars = [Factory(:sidebar, :caja => cajas[1], :pagina => pagina, :orden => 1),
                Factory(:sidebar, :caja => cajas[0], :pagina => pagina, :orden => 2)]

    assert_equal [cajas[1], cajas[0]], Caja.al_final_las_de_pagina(pagina)
  end

  should 'ordenar las cajas por orden alfabético en página nueva' do
    cajas = [Factory(:caja, :titulo => 'al principio'),
              Factory(:caja, :titulo => 'zal final'),
              Factory(:caja, :titulo => 'mal medio')]
    assert_equal [cajas[0], cajas[2], cajas[1]], Caja.al_final_las_de_pagina(Pagina.new)
  end
end