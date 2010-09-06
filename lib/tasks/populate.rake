namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [Pagina, Caja, Sidebar].each(&:delete_all)

    40.times do
      caja = Caja.new
      caja.titulo = Forgery::LoremIpsum.words(1..3).titleize
      caja.cuerpo = Forgery::LoremIpsum.paragraphs(1..4)
      caja.save(false)
    end

    caja_ids = Caja.all.map(&:id)

    20.times do
      pagina = Pagina.new
      pagina.titulo = Forgery::LoremIpsum.words(1..4).titleize
      pagina.cuerpo = Forgery::LoremIpsum.paragraphs(3..7)
      pagina.save(false)

      posibles_ids = caja_ids.clone
      orden = 1

      (1..4).random.times do
        sidebar = Sidebar.new
        sidebar.pagina_id = pagina.id
        sidebar.orden = orden
        sidebar.caja_id = posibles_ids.delete(posibles_ids.sample)
        sidebar.save
        orden += 1
      end
    end
  end
end