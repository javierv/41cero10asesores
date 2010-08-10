require 'test_helper'

class PaginaTest < ActiveSupport::TestCase
  should validate_presence_of(:titulo)
  should allow_mass_assignment_of(:titulo)
  should validate_presence_of(:cuerpo)
  should allow_mass_assignment_of(:cuerpo)

  should have_many(:cajas).through(:sidebars)

  context 'ordenar las cajas' do
    setup do
      @pagina = Factory(:pagina)
      @cajas = [Factory(:caja), Factory(:caja), Factory(:caja)]
      @pagina.build_sidebar([@cajas[1].id, @cajas[0].id, @cajas[2].id])
      @pagina.save
    end

    should 'ordenar las cajas' do      
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[1].id, :orden => 1).first
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[0].id, :orden => 2).first
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 3).first
    end
  end
end