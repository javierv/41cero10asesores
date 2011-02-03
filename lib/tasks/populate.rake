namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    class Range
      def random
        to_a.sample
      end
    end


    [Pagina, Caja, Sidebar, Navegacion].each(&:delete_all)

    40.times do
      caja = Caja.new
      caja.titulo = Faker::Lorem.words((1..3).random).join(' ').titleize
      caja.cuerpo = Faker::Lorem.paragraphs((1..3).random).join("\n\n")
      caja.save(false)
    end

    caja_ids = Caja.all.map(&:id)

    75.times do
      pagina = Pagina.new
      pagina.titulo = Faker::Lorem.words((1..4).random).join(' ').titleize
      pagina.cuerpo = Faker::Lorem.paragraphs((4..10).random).join("\n\n")
      pagina.save(false)

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
      pagina = Pagina.new(:titulo => titulo)
      pagina.cuerpo = Faker::Lorem.paragraphs((4..10).random).join("\n\n")
      pagina.save(false)

      navegacion = Navegacion.new(:pagina_id => pagina.id, :orden => index + 1)
      navegacion.save(false)
    end
  end
end
