# encoding: utf-8

class ClienteDecorator < ApplicationDecorator
  decorates :cliente

private
  def acciones
    [:edit, :destroy]
  end
end
