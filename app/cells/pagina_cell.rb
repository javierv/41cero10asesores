class PaginaCell < ApplicationCell
  def texto(pagina)
    expose(:pagina) { pagina }
    render
  end
end
