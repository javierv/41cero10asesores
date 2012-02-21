# encoding: utf-8

class AdminCell < ApplicationCell
  cache :menu, :usuario_signed_in?

  def menu
    if usuario_signed_in?
      render
    else
      render text: ""
    end
  end
end
