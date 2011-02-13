# encoding: utf-8

require 'spec_helper'

describe Caja do
  it { should validate_presence_of(:titulo) }
  it { should allow_mass_assignment_of(:titulo) }
  it { should validate_presence_of(:cuerpo) }
  it { should allow_mass_assignment_of(:cuerpo) }
  it { should have_many(:sidebars).dependent(:destroy) }

  it 'ordenar las cajas teniendo en cuenta las de una página' do
    pagina = Factory(:pagina)
    cajas = [Factory(:caja), Factory(:caja)]
    sidebars = [Factory(:sidebar, caja: cajas[1], pagina: pagina, orden: 1),
                Factory(:sidebar, caja: cajas[0], pagina: pagina, orden: 2)]

    Caja.al_final_las_de_pagina(pagina).should == [cajas[1], cajas[0]]
  end

  it 'ordenar las cajas por orden alfabético en página nueva' do
    cajas = [Factory(:caja, titulo: 'al principio'),
              Factory(:caja, titulo: 'zal final'),
              Factory(:caja, titulo: 'mal medio')]
    Caja.al_final_las_de_pagina(Pagina.new).should == [cajas[0], cajas[2], cajas[1]]
  end
end
