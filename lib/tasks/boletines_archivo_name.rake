# encoding: utf-8

namespace :db do
  desc  "Graba la columna archivo_name de los boletines"
  task :inicia_boletines_archivo_name => :environment do
    Boletin.all.each do |boletin|
      boletin.archivo.path # Requerido para que se cargue boletin.archivo.meta
      boletin.update_attribute :archivo_name, boletin.archivo.meta[:name]
    end
  end
end
