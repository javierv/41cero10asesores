# encoding: utf-8

require 'spec_helper'

define_match :be_portada do |actual|
  Portada.pagina == actual
end

describe Portada do
  it { should validate_presence_of(:pagina_id) }
  it { should allow_mass_assignment_of(:pagina_id) }
  it { should belong_to :pagina }

  describe "portada" do
    context "sin portadas asignadas" do
      let(:portada_primera) { Factory :pagina }
      before(:each) { Portada.asigna(portada_primera) }

      specify { portada_primera.should be_portada }

      context "con portadas asignadas" do
        let(:portada_posterior) { Factory :pagina }
        before(:each) do
          Portada.asigna(portada_posterior)
        end

        specify do
          portada_primera.should_not be_portada
          portada_posterior.should be_portada
        end
      end
    end
  end
end
