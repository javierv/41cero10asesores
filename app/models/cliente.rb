# encoding: utf-8

class Cliente < ApplicationModel
  attr_accessible :nombre, :email

  validates :nombre, presence: true
  validates :email,  presence: true, email: true

  display_name :nombre

  versioned dependent: :tracking, initial_version: true

  def mailto
    "#{nombre} <#{email}>"
  end
end
