# encoding: utf-8

require 'spec_helper'

define_match :have_draft do |actual|
  actual.has_draft?
end

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
      pagina = Factory(:pagina)
      cajas = [Factory(:caja), Factory(:caja), Factory(:caja)]
      pagina.ids_cajas = [cajas[0].id]
      expect { pagina.update_attributes caja_ids: [cajas[0].id] }.to_not raise_error
    end
  end

  describe 'guardar con cajas asignadas' do
    let(:pagina) { Factory(:pagina) }
    let(:cajas) { [Factory(:caja), Factory(:caja), Factory(:caja)] }

    before(:each) do
      pagina.ids_cajas = [cajas[1].id, cajas[0].id, cajas[2].id]
      pagina.save
    end

    it 'ordena las cajas' do
      {1 => 1, 0 => 2, 2 => 3}.each do |caja, orden|
        Sidebar.where(pagina_id: pagina.id, caja_id: cajas[caja].id, orden: orden).first.should be_true
      end
    end

    it { pagina.cajas_con_orden.map(&:id).should == [cajas[1].id, cajas[0].id, cajas[2].id] }

    it 'borra las cajas si ya tenía' do
      pagina.ids_cajas = []
      pagina.save
      Sidebar.where(pagina_id: pagina.id).first.should be_false
    end

    it 'pasa de las IDs vacías' do
      pagina.ids_cajas = ["", "", cajas[2].id, "", ""]
      pagina.save
      Sidebar.where(pagina_id: pagina.id).should have(1).item
      Sidebar.where(pagina_id: pagina.id, caja_id: cajas[2].id, orden: 1).first.should be_true
    end

    it 'no borra las cajas si no se graba' do
      pagina.stubs(:valid?).returns(false)
      pagina.ids_cajas = [cajas[1].id]
      pagina.save
      Sidebar.where(pagina_id: pagina.id).should have(3).items
    end

    context 'al editar' do
      before(:each) do
        pagina.ids_cajas = [cajas[2].id, cajas[1].id]
        pagina.save
      end
      
      it 'sustituye el orden al editar' do      
        Sidebar.where(pagina_id: pagina.id, caja_id: cajas[2].id, orden: 1).first.should be_true
        Sidebar.where(pagina_id: pagina.id, caja_id: cajas[1].id, orden: 2).first.should be_true
      end
      
      it 'borra el orden anterior' do
        Sidebar.where(pagina_id: pagina.id, caja_id: cajas[2].id).should have(1).item
      end
    end
  end

  describe 'Borradores' do
    context 'Al crear una nueva página' do
      let(:pagina) { Factory(:pagina) }

      it 'guarda como borrador falso si no se define borrador' do
        pagina.borrador = nil
        pagina.save
        pagina.borrador.should == false 
      end

      it 'guarda como lo que venga si se define borrador' do
        pagina.borrador = true
        pagina.save
        pagina.borrador.should == true 
      end
    end

    context 'Creando borradores' do
      let(:pagina) { Factory(:pagina, titulo: 'Título original') }

      context 'sin borrador creado' do
        it { pagina.should_not have_draft }

        context 'Al crear un borrador nuevo' do
          before(:each) do
            pagina.titulo = 'Título cambiado'
            pagina.save_draft
          end

          it { pagina.should have_draft }

          it 'tiene un borrador con las mismas características' do
            borrador = pagina.draft
            borrador.titulo.should == 'Título cambiado'
            borrador.published_id.should == pagina.id
          end

          it { pagina.draft.published.should == pagina }

          it 'no sobreescribe los atributos de la página en la base de datos' do
            pagina_bd = Pagina.find(pagina.id)
            pagina_bd.titulo.should == 'Título original'
          end

          context 'al publicar el borrador' do
            subject do
              pagina.draft.publish
              pagina.reload
              pagina
            end

            its(:titulo) { should == 'Título cambiado' }
            it { should_not have_draft }
          end

          context 'al publicar un borrador no válido' do
            let(:draft) { pagina.draft }
            before(:each) do
              draft.titulo = ''
              @result = draft.publish
            end

            it 'no guarda cambios en la base de datos' do
              pagina_bd = Pagina.find(pagina.id)
              pagina_bd.titulo.should == 'Título original'
            end

            it { pagina.should have_draft }
            it { @result.should == false }
            it { draft.errors[:titulo].blank?.should be_false }
          end

          context 'al publicar un borrador pasándole parámetros' do
            before(:each) { pagina.draft.publish(titulo: 'Título en parámetro') }

            it 'guarda el título del parámetro en la página original' do
              pagina_bd = Pagina.find(pagina.id)
              pagina_bd.titulo.should == 'Título en parámetro'
            end
          end
        end

        context 'Al crear un borrador con parámetros' do
          before(:each) { pagina.save_draft(titulo: 'Título en parámetro') }
          it { pagina.draft.titulo.should == 'Título en parámetro' }
        end

        context 'Al crear un borrador no válido' do
          before(:each) do
            pagina.titulo = ''
            pagina.save_draft
          end

          it 'graba el borrador' do
            pagina.should have_draft
            pagina.draft.titulo.should be_nil
          end
        end
      end

      context 'con borrador creado' do
        before(:each) { pagina.save_draft }

        context 'Al grabar otro borrador' do
          let(:titulo) {'Borrador sobreescribe'}
          before(:each) do
            pagina.titulo = titulo
            pagina.save_draft
          end

          it { pagina.draft.titulo.should == titulo }
        end
      end
    end

    context 'un nuevo borrador' do
      let(:nueva) { Pagina.new }
      before(:each) { nueva.save_draft }

      it 'guarda un borrador' do
        Pagina.where(titulo: '', borrador: true).should be_true
      end

      it { nueva.draft.should == nueva }

      context 'al crear otro nuevo borrador' do
        before(:each) { Pagina.new.save_draft }

        it 'no sobreescribe el borrador existente' do
          Pagina.where(borrador: true).should have(2).items
        end
      end

      context 'al crear un nuevo borrador indicando que ya existía' do
        let(:draft) { Pagina.new }
        before(:each) do
          draft.titulo = 'Cambiado'
          draft.save_draft(borrador_id: nueva.draft.id)
        end

        it 'reemplaza el borrador existente' do
          Pagina.where(borrador: true).should have(1).item
          nueva.draft.should == draft.draft
        end
      end
    end

    context 'un borrador sin página asociada' do
      let(:titulo) {'Borrador inicial'}
      let(:draft) { Factory(:pagina, borrador: true, titulo: titulo) }

      it { draft.should_not have_draft }
      it { draft.draft.should == draft }

      context 'al publicar' do
        before(:each) { draft.publish }
        let(:published) { Pagina.where(titulo: titulo, borrador: false).first }

        it { published.should be_true }

        it 'borra el borrador' do
          Pagina.where(titulo: titulo, borrador: true).first.should be_false
        end

        it { draft.published.should == published }
      end

      context 'al guardar un borrador' do
        before(:each) { draft.save_draft(titulo: 'Título cambiado') }

        it 'se sobrescribe a sí mismo' do
          draft.titulo.should == 'Título cambiado'
        end
      end
    end
  end

  describe 'Al final las de la navegación' do
    let(:navegables) { [Factory(:pagina), Factory(:pagina), Factory(:pagina)] }
    let(:otras) { [Factory(:pagina), Factory(:pagina), Factory(:pagina)] } 
    before(:each) do
      navegables.reverse.each.with_index do |pagina, index|
        Factory(:navegacion, pagina_id: pagina.id, orden: index + 1)
      end
    end

    it 'encuentra al final las navegables, y en orden' do
      paginas = Pagina.al_final_las_de_navegacion
      paginas[-1].should == navegables[0] 
      paginas[-3].should == navegables[2] 
    end
  end

  describe 'siguiente página' do
    let(:paginas) { [] }
    before(:each) do
      11.times { paginas << Factory(:pagina)}
      Pagina.stubs(:default_per_page).returns(3)
    end

    it { Pagina.next(page: 1).should == paginas[2] }
    it { Pagina.next(page: 4).should be_nil }
  end

  describe "search" do
    let(:busqueda) { "primero" }
    let(:nada) { "segundo" }
    before(:each) do
      Factory :pagina, titulo: busqueda, cuerpo: nada
      Factory :pagina, titulo: nada, cuerpo: nada
      Factory :pagina, titulo: nada, cuerpo: busqueda
      Factory :pagina, titulo: busqueda, cuerpo: busqueda
      Pagina.rebuild_xapian_index
    end
    let(:paginas) { Pagina.search busqueda }

    it "da prioridad al título" do
      paginas.should have(3).items
      paginas[0].titulo.should == busqueda
      paginas[0].cuerpo.should == busqueda
      paginas[1].titulo.should == busqueda
      paginas[2].cuerpo.should == busqueda
    end
  end

  describe "versiones" do
    it "guarda versiones de una nueva página" do
      pagina = Factory :pagina
      pagina.update_attribute(:titulo, "cambio")
      pagina.versions.count.should == 2
    end

    it "guarda versiones de un borrador sin página publicada" do
      pagina = Factory :pagina, borrador: true
      pagina.update_attribute(:titulo, "cambio")
      pagina.versions.count.should == 2
    end

    it "no guarda versiones de un borrador con página pubilcada" do
      pagina = Factory :pagina
      pagina.save_draft
      borrador = pagina.draft
      borrador.update_attribute(:titulo, "cambio")
      borrador.versions.count.should == 0
    end
  end
end
