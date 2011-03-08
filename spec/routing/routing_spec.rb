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

    it "acepta guiones en la ruta" do
      { get: "/acerca-de" }.should route_to ruta_pagina(id: "acerca-de")
    end

    it "acepta un interrogante normal como parámetros extra" do
      { get: "/quienes?" }.should route_to ruta_pagina(id: "quienes")
    end

    it "se basa en el título de la página como ID" do
      pagina = Factory :pagina, titulo: "nosotros"
      { get: pagina_path(pagina) }.should route_to ruta_pagina(id: "nosotros")
    end

    it "genera la URL a partir de la página" do
      pagina = Factory :pagina, titulo: "nosotros"
      pagina_path(pagina).should == "/nosotros"
    end

    it "permite números" do
      { get: "noticias-2007" }.should route_to ruta_pagina(id: "noticias-2007")
    end
  end

  describe "rutas de otras acciones de páginas" do
    it { { get: "/search" }.should route_to ruta("paginas#search") }
    it { { get: "/new" }.should route_to ruta("paginas#new") }
    it { { post: "/"}.should route_to ruta("paginas#create")}
  end

  it "ruta a la portada"

  describe "rutas varias" do
    it { { get: "/autocomplete" }.should route_to ruta("ajax_form#autocomplete") }
    it { { get: "/ayuda-textile" }.should route_to ruta("static#ayuda_textile") }
  end

  describe "clientes" do
    it { { get: "/clientes" }.should route_to ruta("clientes#index") }
    it { { get: "/clientes/new" }.should route_to ruta("clientes#new") }
    it { { get: "/clientes/1" }.should route_to ruta("clientes#show", id: "1") }
    it { { get: "/clientes/1/edit" }.should route_to ruta("clientes#edit", id: "1") }
    it { { post: "/clientes" }.should route_to ruta("clientes#create") }
    it { { put: "/clientes/1" }.should route_to ruta("clientes#update", id: "1") }
    it { { delete: "/clientes/1" }.should route_to ruta("clientes#destroy", id: "1") }
  end
end
