require 'spec_helper'

describe Cliente do
  it { should validate_presence_of(:nombre) }
  it { should allow_mass_assignment_of(:nombre) }

  it { should validate_presence_of(:email) }
  it { should allow_mass_assignment_of(:email) }
end
