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
      @pagina = Factory(:pagina, :titulo => 'Título original')
    end

    context 'sin borrador creado' do
      should 'no tener borradores' do
        assert !@pagina.has_draft?
      end

      context 'Al crear un borrador nuevo' do
        setup do
          @pagina.titulo = 'Título cambiado'
          @pagina.save_draft
        end

        should 'tener un borrador' do
          assert @pagina.has_draft?
        end

        should 'tener un borrador con las mismas características' do
          borrador = @pagina.draft
          assert_equal 'Título cambiado', borrador.titulo
          assert_equal @pagina.id, borrador.published_id
        end

        should 'poder acceder a la página original a través del borrador' do
          assert_equal @pagina, @pagina.draft.published
        end

        should 'no sobreescribir los atributos de la página en la base de datos' do
          pagina_bd = Pagina.find(@pagina.id)
          assert_equal 'Título original', pagina_bd.titulo
        end

        context 'al publicar el borrador' do
          setup do
            @pagina.draft.publish
          end

          should 'tener los títulos cambiados en la base de datos' do
            pagina_bd = Pagina.find(@pagina.id)
            assert_equal 'Título cambiado', pagina_bd.titulo
          end

          should 'borrar el borrador' do
            assert !@pagina.has_draft?
          end
        end

        context 'al publicar un borrador no válido' do
          setup do
            @draft = @pagina.draft
            @draft.titulo = ''
            @result = @draft.publish
          end

          should 'no guardar cambios en la base de datos' do
            pagina_bd = Pagina.find(@pagina.id)
            assert_equal 'Título original', pagina_bd.titulo
          end

          should 'no borrar el borrador' do
            assert @pagina.has_draft?
          end

          should 'devolver falso' do
            assert_equal false, @result
          end

          should 'añadir los errores al borrador' do
            assert !@draft.errors[:titulo].blank?
          end
        end

        context 'al publicar un borrador pasándole parámetros' do
          setup do
            @pagina.draft.publish(:titulo => 'Título en parámetro')
          end

          should 'guardar el título del parámetro en la página original' do
            pagina_bd = Pagina.find(@pagina.id)
            assert_equal 'Título en parámetro', pagina_bd.titulo
          end
        end
      end

      context 'Al crear un borrador con parámetros' do
        setup do
          @pagina.save_draft(:titulo => 'Título en parámetro')
        end

        should 'guardar el borrador con los parámetros' do
          assert_equal 'Título en parámetro', @pagina.draft.titulo
        end
      end

      context 'Al crear un borrador no válido' do
        setup do
          @pagina.titulo = ''
          @pagina.save_draft
        end

        should 'grabar el borrador' do
          assert @pagina.has_draft?
          assert_equal '', @pagina.draft.titulo
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

  context 'un nuevo borrador' do
    setup do
      Pagina.new.save_draft
    end

    should 'guardar un borrador' do
      assert Pagina.where(:titulo => '', :borrador => true)
    end

    context 'al crear otro nuevo borrador' do
      setup do
        Pagina.new.save_draft
      end

      should 'no sobreescribir el borrador existente' do
        assert_equal 2, Pagina.where(:borrador => true).count
      end
    end
  end

  context 'un borrador sin página asociada' do
    setup do
      @titulo = 'Borrador inicial'
      @draft = Factory(:pagina, :borrador => true, :titulo => @titulo)
    end

    should 'tenerse a sí mismo como borrador' do
      assert_equal @draft, @draft.draft
    end

    context 'al publicar' do
      setup do
        @draft.publish
        @published = Pagina.where(:titulo => @titulo, :borrador => false).first
      end

      should 'publicar una página nueva' do
        assert @published
      end

      should 'borrar el borrador' do
        assert !Pagina.where(:titulo => @titulo, :borrador => true).first
      end

      should 'corresponder la página publicada con la creada' do
        assert_equal @published, @draft.published
      end
    end

    context 'al guardar un borrador' do
      setup do
        @draft.save_draft(:titulo => 'Título cambiado')
      end

      should 'sobrescribirse a sí mismo' do
        assert_equal 'Título cambiado', @draft.titulo
      end
    end
  end
end
