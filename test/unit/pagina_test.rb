# encoding: utf-8

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
      @pagina.ids_cajas = [@cajas[1].id, @cajas[0].id, @cajas[2].id]
      @pagina.save
    end

    should 'ordenar las cajas' do
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[1].id, :orden => 1).first
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[0].id, :orden => 2).first
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 3).first
    end

    should 'devolver las cajas en orden' do
      assert_equal [@cajas[1].id, @cajas[0].id, @cajas[2].id], @pagina.cajas_con_orden.map(&:id)
    end

    should 'borrar las cajas si ya tenía' do
      @pagina.ids_cajas = []
      @pagina.save
      assert !Sidebar.where(:pagina_id => @pagina.id).first
    end

    should 'pasar de las IDs vacías' do
      @pagina.ids_cajas = ["", "", @cajas[2].id, "", ""]
      @pagina.save
      assert_equal 1, Sidebar.where(:pagina_id => @pagina.id).count
      assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 1).first
    end

    should 'no borrar las cajas si no se graba' do
      @pagina.stubs(:valid?).returns(false)
      @pagina.ids_cajas = [@cajas[1].id]
      @pagina.save
      assert_equal 3, Sidebar.where(:pagina_id => @pagina.id).count
    end

    context 'al editar' do
      setup do
        @pagina.ids_cajas = [@cajas[2].id, @cajas[1].id]
        @pagina.save
      end
      
      should 'sustituir el orden al editar' do      
        assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 1).first
        assert Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[1].id, :orden => 2).first
      end
      
      should 'borrar el orden anterior' do
        assert_equal 1, Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id).count
      end
    end
  end
end
