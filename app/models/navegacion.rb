class Navegacion < ActiveRecord::Base
  attr_accessible :pagina_id, :orden
  validates :pagina_id, :presence => true
  validates :orden, :presence => true
  belongs_to :pagina
  display_name :pagina

  def self.establecer(ids)
    delete_all

    ids.each_with_index.map do |id, orden|
      create(:pagina_id => id, :orden => orden + 1)
    end
  end
end