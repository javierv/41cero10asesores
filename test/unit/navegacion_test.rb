# encoding: utf-8

require 'test_helper'

class NavegacionTest < ActiveSupport::TestCase
  should validate_presence_of(:pagina_id)
  should allow_mass_assignment_of(:pagina_id)
  should validate_presence_of(:orden)
  should allow_mass_assignment_of(:orden)

  should belong_to(:pagina)

  setup do
    paginas = [Factory(:pagina), Factory(:pagina), Factory(:pagina)]
    @ids = paginas.map(&:id)
    Navegacion.establecer(@ids.reverse)
  end

  should 'guardar en orden' do
    assert Navegacion.where(:pagina_id => @ids.last, :orden => 1).first
    assert Navegacion.where(:pagina_id => @ids[0], :orden => @ids.length).first
  end

  should 'borrar lo que había al grabar' do
    Navegacion.establecer(@ids)
    assert Navegacion.where(:pagina_id => @ids[0], :orden => 1).first
    assert !Navegacion.where(:pagina_id => @ids.last, :orden => 1).first
  end
end