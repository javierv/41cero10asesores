# encoding: utf-8

require 'spec_helper'

describe Pagina do
  it { should validate_presence_of(:titulo) }
  it { should allow_mass_assignment_of(:titulo) }
  it { should validate_presence_of(:cuerpo) }
  it { should allow_mass_assignment_of(:cuerpo) }

  it { should have_one(:navegacion).dependent(:destroy) }
  it { should have_many(:cajas).through(:sidebars) }
  it { should allow_mass_assignment_of(:caja_ids) }

  describe "actualizar con mass_assignment de cajas" do
    it 'no da errores' do
      @pagina = Factory(:pagina)
      @cajas = [Factory(:caja), Factory(:caja), Factory(:caja)]
      @pagina.ids_cajas = [@cajas[0].id]
      lambda { @pagina.update_attributes :caja_ids => [@cajas[0].id] }.should_not raise_error
    end
  end

  describe 'guardar con cajas asignadas' do
    before(:each) do
      @pagina = Factory(:pagina)
      @cajas = [Factory(:caja), Factory(:caja), Factory(:caja)]
      @pagina.ids_cajas = [@cajas[1].id, @cajas[0].id, @cajas[2].id]
      @pagina.save
    end

    it 'ordena las cajas' do
      {1 => 1, 0 => 2, 2 => 3}.each do |caja, orden|
        Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[caja].id, :orden => orden).first.should be_true
      end
    end

    it 'devuelve las cajas en orden' do
      @pagina.cajas_con_orden.map(&:id).should == [@cajas[1].id, @cajas[0].id, @cajas[2].id]
    end

    it 'borra las cajas si ya tenía' do
      @pagina.ids_cajas = []
      @pagina.save
      Sidebar.where(:pagina_id => @pagina.id).first.should be_false
    end

    it 'pasa de las IDs vacías' do
      @pagina.ids_cajas = ["", "", @cajas[2].id, "", ""]
      @pagina.save
      Sidebar.where(:pagina_id => @pagina.id).count.should == 1
      Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 1).first.should be_true
    end

    it 'no borra las cajas si no se graba' do
      @pagina.stubs(:valid?).returns(false)
      @pagina.ids_cajas = [@cajas[1].id]
      @pagina.save
      Sidebar.where(:pagina_id => @pagina.id).count.should == 3
    end

    context 'al editar' do
      before(:each) do
        @pagina.ids_cajas = [@cajas[2].id, @cajas[1].id]
        @pagina.save
      end
      
      it 'sustituye el orden al editar' do      
        Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id, :orden => 1).first.should be_true
        Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[1].id, :orden => 2).first.should be_true
      end
      
      it 'borra el orden anterior' do
        Sidebar.where(:pagina_id => @pagina.id, :caja_id => @cajas[2].id).count.should == 1
      end
    end
  end

  describe 'Borradores' do
    context 'Al crear una nueva página' do
      before(:each) do
        @pagina = Factory(:pagina)
      end

      it 'guarda como borrador falso si no se define borrador' do
        @pagina.borrador = nil
        @pagina.save
        @pagina.borrador.should == false 
      end

      it 'guarda como lo que venga si se define borrador' do
        @pagina.borrador = true
        @pagina.save
        @pagina.borrador.should == true 
      end
    end

    context 'Creando borradores' do
      before(:each) do
        @pagina = Factory(:pagina, :titulo => 'Título original')
      end

      context 'sin borrador creado' do
        it 'no tiene borradores' do
          @pagina.has_draft?.should be_false
        end

        context 'Al crear un borrador nuevo' do
          before(:each) do
            @pagina.titulo = 'Título cambiado'
            @pagina.save_draft
          end

          it 'tiene un borrador' do
            @pagina.has_draft?.should be_true
          end

          it 'tiene un borrador con las mismas características' do
            borrador = @pagina.draft
            borrador.titulo.should == 'Título cambiado'
            borrador.published_id.should == @pagina.id
          end

          it 'puede acceder a la página original a través del borrador' do
            @pagina.draft.published.should == @pagina
          end

          it 'no sobreescribe los atributos de la página en la base de datos' do
            pagina_bd = Pagina.find(@pagina.id)
            pagina_bd.titulo.should == 'Título original'
          end

          context 'al publicar el borrador' do
            before(:each) do
              @pagina.draft.publish
            end

            it 'tiene los títulos cambiados en la base de datos' do
              pagina_bd = Pagina.find(@pagina.id)
              pagina_bd.titulo.should == 'Título cambiado'
            end

            it 'borra el borrador' do
              @pagina.has_draft?.should be_false
            end
          end

          context 'al publicar un borrador no válido' do
            before(:each) do
              @draft = @pagina.draft
              @draft.titulo = ''
              @result = @draft.publish
            end

            it 'no guarda cambios en la base de datos' do
              pagina_bd = Pagina.find(@pagina.id)
              pagina_bd.titulo.should == 'Título original'
            end

            it 'no borra el borrador' do
              @pagina.has_draft?.should be_true
            end

            it 'devuelve falso' do
              @result.should == false
            end

            it 'añade los errores al borrador' do
              @draft.errors[:titulo].blank?.should be_false
            end
          end

          context 'al publicar un borrador pasándole parámetros' do
            before(:each) do
              @pagina.draft.publish(:titulo => 'Título en parámetro')
            end

            it 'guarda el título del parámetro en la página original' do
              pagina_bd = Pagina.find(@pagina.id)
              pagina_bd.titulo.should == 'Título en parámetro'
            end
          end
        end

        context 'Al crear un borrador con parámetros' do
          before(:each) do
            @pagina.save_draft(:titulo => 'Título en parámetro')
          end

          it 'guarda el borrador con los parámetros' do
            @pagina.draft.titulo.should == 'Título en parámetro'
          end
        end

        context 'Al crear un borrador no válido' do
          before(:each) do
            @pagina.titulo = ''
            @pagina.save_draft
          end

          it 'graba el borrador' do
            @pagina.has_draft?.should be_true
            @pagina.draft.titulo.should == ''
          end
        end
      end

      context 'con borrador creado' do
        before(:each) do
          @pagina.save_draft
        end

        context 'Al grabar otro borrador' do
          before(:each) do
            @titulo = 'Borrador sobreescribe'
            @pagina.titulo = @titulo
            @pagina.save_draft
          end

          it 'Sobreescribe el borrador antiguo' do
            @pagina.draft.titulo.should == @titulo
          end
        end
      end
    end

    context 'un nuevo borrador' do
      before(:each) do
        @nueva = Pagina.new
        @nueva.save_draft
      end

      it 'guarda un borrador' do
        Pagina.where(:titulo => '', :borrador => true).should be_true
      end

      it 'devuelve la página nueva como borrador' do
        @nueva.draft.should == @nueva
      end

      context 'al crear otro nuevo borrador' do
        before(:each) do
          Pagina.new.save_draft
        end

        it 'no sobreescribe el borrador existente' do
          Pagina.where(:borrador => true).count.should == 2
        end
      end
    end

    context 'un borrador sin página asociada' do
      before(:each) do
        @titulo = 'Borrador inicial'
        @draft = Factory(:pagina, :borrador => true, :titulo => @titulo)
      end

      it 'dice que no tiene borrador' do
        @draft.has_draft?.should be_false
      end

      it 'se devuelve a sí mismo como borrador' do
        @draft.draft.should == @draft
      end

      context 'al publicar' do
        before(:each) do
          @draft.publish
          @published = Pagina.where(:titulo => @titulo, :borrador => false).first
        end

        it 'publica una página nueva' do
          @published.should be_true
        end

        it 'borra el borrador' do
          Pagina.where(:titulo => @titulo, :borrador => true).first.should be_false
        end

        it 'corresponde la página publicada con la creada' do
          @draft.published.should == @published
        end
      end

      context 'al guardar un borrador' do
        before(:each) do
          @draft.save_draft(:titulo => 'Título cambiado')
        end

        it 'se sobrescribe a sí mismo' do
          @draft.titulo.should == 'Título cambiado'
        end
      end
    end
  end

  describe 'Al final las de la navegación' do
    before(:each) do
      @navegables = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]
      @otras = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]

      @navegables.reverse.each_with_index do |pagina, index|
        Factory(:navegacion, :pagina_id => pagina.id, :orden => index + 1)
      end
    end

    it 'encuentra al final las navegables, y en orden' do
      paginas = Pagina.al_final_las_de_navegacion
      paginas[-1].should == @navegables[0] 
      paginas[-3].should == @navegables[2] 
    end
  end

  describe 'siguiente página' do
    before(:each) do
      @paginas = []
      11.times { @paginas << Factory(:pagina)}
      Pagina.stubs(:per_page).returns(3)
    end

    it 'devuelve la primera que no está en la página actual' do
      Pagina.siguiente(:page => 1).should == @paginas[2]
    end

    it 'no devuelve nada si no hay siguiente página' do
      Pagina.siguiente(:page => 4).should be_nil
    end
  end
end
