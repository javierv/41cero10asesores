# encoding: utf-8

require "spec_helper"

def ruta(action, params = {})
  ruta = action.split('#')
  { controller: ruta[0], action: ruta[1] }.merge params
end

def ruta_pagina(params = {})
  ruta "paginas#show", params
end

describe "rutas" do
  describe "versiones" do
    it "para la ref_id en la ruta para comparar versiones" do
      { get: "/versions/1/compare/2"}.
        should route_to ruta("versions#compare", id: "1", ref_id: "2")
    end
  end

  describe "rutas con un slug" do
    it "busca una página dado un slug" do
      { get: "/quienes" }.should route_to ruta_pagina(id: "quienes")
    end

    it "no busca rutas con mayúsculas" do
      { get: "/COSA" }.should_not be_routable
    end

    it "acepta guiones en la ruta" do
      { get: "/acerca-de" }.should route_to ruta_pagina(id: "acerca-de")
    end

    it "acepta un interrogante normal como parámetros extra" do
      { get: "/quienes?" }.should route_to ruta_pagina(id: "quienes")
    end

    it "no acepta el resto de interrogantes ni explicacioens" do
      { get: "/quienes!" }.should_not be_routable
      { get: "/¡quienes" }.should_not be_routable
      { get: "/¿quienes" }.should_not be_routable
    end
  end

  it "ruta al índice"

  describe "rutas varias" do
    it { { get: "/autocomplete" }.should route_to ruta("ajax_form#autocomplete") }
    it { { get: "/ayuda-textile" }.should route_to ruta("static#ayuda_textile") }
  end

end
