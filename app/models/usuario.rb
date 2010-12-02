class Usuario < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :timeoutable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  display_name :email
end
