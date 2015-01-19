# encoding: utf-8

FactoryGirl.define do
  factory :portada do
    pagina_id 1
  end

  factory :boletin do
    archivo_uid "example.pdf"
    archivo_name "example.pdf"
    titulo      "Boletín Calesur 5 de marzo"
  end

  factory :caja do
    titulo "Mi caja"
    cuerpo "Cuerpo de caja"
  end

  factory :cliente do
    nombre "Fulano"
    email "fulano@elretirao.net"
  end

  factory :foto do
    imagen_uid "blank.png"
  end

  factory :navegacion do
    pagina_id 1
    orden 1
  end
  
  factory :pagina do
    titulo "Mi página"
    cuerpo "El texto de mi página"
    borrador false
    published_id nil
  end

  factory :sidebar do
    pagina_id 1
    caja_id 1
    orden 1
  end

  factory :usuario do
    email "fulano@elretirao.net"
    password "password"
  end
end
