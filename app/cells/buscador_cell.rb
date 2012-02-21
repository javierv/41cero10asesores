# encoding: utf-8

class BuscadorCell < ApplicationCell
  def display(term)
    expose(:term) { term }
    render
  end
end
