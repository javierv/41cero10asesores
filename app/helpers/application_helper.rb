module ApplicationHelper
  def edit_pagina_title(pagina)
    if pagina.borrador?
      "Editando borrador de #{pagina}"
    else
      "Editando la página #{pagina}"
    end
  end
end
