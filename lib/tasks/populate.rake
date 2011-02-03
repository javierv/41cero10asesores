namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    class Range
      def random
        to_a.sample
      end
    end


    [Pagina, Caja, Sidebar, Navegacion, Usuario].each(&:delete_all)

    ['pruebas', 'davidz', 'javier', 'administrador', 'rafael'].each do |nombre|
      Usuario.create(:email => "#{nombre}@calesur.es", :password => nombre)
    end

    40.times do
      caja = Caja.new
      caja.titulo = Faker::Lorem.words((1..3).random).join(' ').titleize
      caja.cuerpo = Faker::Lorem.paragraphs((1..3).random).join("\n\n")
      caja.save(false)
    end

    caja_ids = Caja.all.map(&:id)

    75.times do
      pagina = Pagina.new

      (1..7).random.times do
        pagina.titulo = Faker::Lorem.words((1..4).random).join(' ').titleize
        pagina.cuerpo = Faker::Lorem.paragraphs((4..10).random).join("\n\n")
        pagina.updated_by = Usuario.all.rand
        pagina.save(false)
      end
      posibles_ids = caja_ids.clone
      orden = 1

      (1..3).random.times do
        sidebar = Sidebar.new
        sidebar.pagina_id = pagina.id
        sidebar.orden = orden
        sidebar.caja_id = posibles_ids.delete(posibles_ids.sample)
        sidebar.save
        orden += 1
      end
    end

    ['Nuestros valores', 'Ámbitos de actuación', 'Participamos', 'Ubicación', 'Contacto'].each_with_index do |titulo, index|
      pagina = Pagina.new

      (1..7).random.times do
        pagina.titulo = Faker::Lorem.words((1..4).random).join(' ').titleize
        pagina.cuerpo = Faker::Lorem.paragraphs((4..10).random).join("\n\n")
        pagina.updated_by = Usuario.all.rand
        pagina.save(false)
      end

      pagina.titulo = titulo
      pagina.save(false)
      navegacion = Navegacion.new(:pagina_id => pagina.id, :orden => index + 1)
      navegacion.save(false)
    end
  end
end
