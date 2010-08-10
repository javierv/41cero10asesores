require 'test_helper'

class SidebarTest < ActiveSupport::TestCase
  should validate_presence_of(:pagina_id)
  should allow_mass_assignment_of(:pagina_id)
  should validate_presence_of(:caja_id)
  should allow_mass_assignment_of(:caja_id)
  should validate_presence_of(:orden)
  should allow_mass_assignment_of(:orden)
end