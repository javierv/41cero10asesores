# encoding: utf-8

class BuscadorCell < ApplicationCell
  def display(term)
    render locals: { term: term }
  end
end
