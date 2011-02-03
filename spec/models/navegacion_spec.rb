# encoding: utf-8

require 'spec_helper'

describe Navegacion do
  it { should validate_presence_of(:pagina_id) }
  it { should allow_mass_assignment_of(:pagina_id) }
  it { should validate_presence_of(:orden) }
  it { should allow_mass_assignment_of(:orden) }

  it { should belong_to(:pagina) }

  before(:each) do
    @paginas = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]
    otras = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]
    @ids = @paginas.map(&:id)
    Navegacion.establecer(@ids.reverse)
  end

  it 'guardar en orden' do
    Navegacion.where(:pagina_id => @ids.last, :orden => 1).first.should be_true
    Navegacion.where(:pagina_id => @ids[0], :orden => @ids.length).first.should be_true
  end

  it 'borrar lo que había al grabar' do
    Navegacion.establecer(@ids)
    Navegacion.where(:pagina_id => @ids[0], :orden => 1).first.should be_true
    Navegacion.where(:pagina_id => @ids.last, :orden => 1).first.should be_false
  end

  it 'poder recuperar las páginas' do
    Navegacion.paginas.should == @paginas.reverse
  end

  it 'poder recuperar las IDs de páginas en orden' do
    Navegacion.pagina_ids.should == @ids.reverse
  end
end
