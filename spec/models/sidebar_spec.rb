# encoding: utf-8

require 'spec_helper'

describe Sidebar do
  it { should validate_presence_of(:pagina_id) }
  it { should allow_mass_assignment_of(:pagina_id) }
  it { should validate_presence_of(:caja_id) }
  it { should allow_mass_assignment_of(:caja_id) }
  it { should allow_mass_assignment_of(:orden) }
end
