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
      it "devuelve una portada nueva" do
        Portada.portada.id.should be_nil
      end

      it "devuelve una página nueva" do
        Portada.pagina.id.should be_nil
      end
    end

    context "asignando portada" do
      let(:primera) { Factory :pagina }
      let(:portada) { Factory :portada }

      before(:each) do
        portada.pagina = primera
        portada.save
      end

      specify { primera.should be_portada }

      context "con portadas asignadas" do
        let(:posterior) { Factory :pagina }

        before(:each) do
          portada.pagina = posterior
          portada.save
        end

        specify do
          primera.should_not be_portada
          posterior.should be_portada
        end
      end
    end
  end
end
