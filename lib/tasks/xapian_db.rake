# encoding: utf-8

namespace :xapian_db do
  desc "Index all xapit models."
  task :reindex => :environment do
    Pagina.rebuild_xapian_index
  end
end
