class PaginaCell < ApplicationCell
  cache(:texto, if: proc { |cell, pagina| !pagina.changed? }) do |cell, pagina|
    pagina
  end

  def texto(pagina)
    render locals: {pagina: pagina}
  end
end
