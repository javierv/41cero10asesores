# encoding: utf-8

namespace :redis do
  desc "Imports YAML translations to redis."
  task :import_yaml => :environment do
    translations = YAML.load(File.read(Rails.root.join("config", "locales", "public.es.yml")))
    translations["es"]["public"].each do |key, value|
      unless TRANSLATION_STORE["es.public.#{key}"]
        TRANSLATION_STORE.store_public_translations({key => value})
      end
    end
  end
end
