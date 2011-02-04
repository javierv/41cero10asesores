# encoding: utf-8

require 'spec_helper'

describe Navegacion do
  it { should validate_presence_of(:pagina_id) }
  it { should allow_mass_assignment_of(:pagina_id) }
  it { should validate_presence_of(:orden) }
  it { should allow_mass_assignment_of(:orden) }

  it { should belong_to(:pagina) }

  let(:paginas) { [Factory(:pagina), Factory(:pagina), Factory(:pagina)] }
  let(:ids) { paginas.map(&:id) }

  before(:each) do
    no_navegables = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]
    Navegacion.establecer(ids.reverse)
  end

  it 'guarda en orden' do
    Navegacion.where(:pagina_id => ids.last, :orden => 1).first.should be_true
    Navegacion.where(:pagina_id => ids[0], :orden => ids.length).first.should be_true
  end

  it 'borra lo que había al grabar' do
    Navegacion.establecer(ids)
    Navegacion.where(:pagina_id => ids[0], :orden => 1).first.should be_true
    Navegacion.where(:pagina_id => ids.last, :orden => 1).first.should be_false
  end

  it { Navegacion.paginas.should == paginas.reverse }
  it { Navegacion.pagina_ids.should == ids.reverse }
end
