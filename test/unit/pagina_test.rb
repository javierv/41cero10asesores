require 'test_helper'

class PaginaTest < ActiveSupport::TestCase
  should validate_presence_of(:titulo)
  should allow_mass_assignment_of(:titulo)
  should validate_presence_of(:cuerpo)
  should allow_mass_assignment_of(:cuerpo)

  should have_many(:cajas).through(:sidebars)
end