# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :pagina do |f|
  f.titulo "MyString"
  f.cuerpo "MyText"
  f.borrador false
  f.published_id nil
end
