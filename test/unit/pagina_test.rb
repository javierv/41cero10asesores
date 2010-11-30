# encoding: utf-8

require 'test_helper'

class PaginaTest < ActiveSupport::TestCase
  should validate_presence_of(:titulo)
  should allow_mass_assignment_of(:titulo)
  should validate_presence_of(:cuerpo)
  should allow_mass_assignment_of(:cuerpo)

  should have_many(:cajas).through(:sidebars)
  should allow_mass_assignment_of(:caja_ids)

  context "actualizar con mass_assignment de cajas" do
    setup do
      @pagina = Factory(:pagina)
      @cajas = [Factory(:caja), Factory(:caja), Factory(:caja)]
      @pagina.ids_cajas = [@cajas[0].id]
    end

    should 'no dar errores' do
      assert_nothing_raised do
        @pagina.update_attributes :caja_ids => [@cajas[0].id]
      end
    end
  end

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

  context 'Creando borradores' do
    setup do
      @pagina = Factory(:pagina)
    end

    context 'sin borrador creado' do
      should 'no tener borradores' do
        assert !@pagina.has_draft?
      end

      context 'Al crear un borrador nuevo' do
        setup do
          @pagina.save_draft
        end

        should 'tener un borrador' do
          assert @pagina.has_draft?
        end

        should 'tener un borrador con las mismas características' do
          borrador = @pagina.draft
          assert_equal @pagina.titulo, borrador.titulo
          assert_equal @pagina.id, borrador.published_id
        end
      end
    end

    context 'con borrador creado' do
      setup do
        @pagina.save_draft
      end

      context 'Al grabar otro borrador' do
        setup do
          @titulo = 'Borrador sobreescribe'
          @pagina.titulo = @titulo
          @pagina.save_draft
        end

        should 'Sobreescribir el borrador antiguo' do
          assert_equal @titulo, @pagina.draft.titulo
        end
      end
    end
  end
end
