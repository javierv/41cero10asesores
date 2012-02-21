class PaginaCell < ApplicationCell
  cache(:texto) do |cell, pagina|
    pagina
  end

  def texto(pagina)
    expose(:pagina) { pagina }
    render
  end
end
