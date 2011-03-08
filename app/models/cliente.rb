# encoding: utf-8

class Cliente < ActiveRecord::Base
  attr_accessible :nombre, :email

  validates :nombre, presence: true
  validates :email,  presence: true, email: true

  display_name :nombre

  def mailto
    "#{nombre} <#{email}>"
  end
end
