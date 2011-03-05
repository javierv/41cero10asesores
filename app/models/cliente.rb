class Cliente < ActiveRecord::Base
  attr_accessible :nombre, :email
  validates :nombre, :presence => true
  validates :email,  :presence => true
  display_name :nombre
end
