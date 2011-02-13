XapianDb::DocumentBlueprint.setup(Pagina) do |blueprint|
  blueprint.attribute :titulo, weight: 10
  blueprint.attribute :cuerpo, weight: 4
  blueprint.index :titulo_cajas, weight: 3
  blueprint.index :cuerpo_cajas, weight: 1
end
