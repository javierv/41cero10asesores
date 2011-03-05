# encoding: utf-8

require 'spec_helper'

describe Cliente do
  it { should validate_presence_of(:nombre) }
  it { should allow_mass_assignment_of(:nombre) }

  it { should validate_presence_of(:email) }
  it { should allow_mass_assignment_of(:email) }
  it { should validate_format_of(:email).with("elretirao@elretirao.net") }
  it { should validate_format_of(:email).not_with("ddd").with_message(/válido/) }
end
