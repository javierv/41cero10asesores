class PaginaCell < ApplicationCell
  cache(:texto, if: proc { |cell, pagina| !pagina.changed? }) do |cell, pagina|
    pagina
  end

  def texto(pagina)
    expose(:pagina) { pagina }
    render
  end
end
