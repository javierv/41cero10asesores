# encoding: utf-8

namespace :xapit do
  desc "Index all xapit models."
  task :reindex => :environment do
    Xapit.remove_database
    Xapit.index_all do |member_class|
      puts "Indexing #{member_class.name}"
    end
  end
end
