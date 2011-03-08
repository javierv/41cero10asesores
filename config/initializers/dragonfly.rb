require 'dragonfly/rails/images'

if Rails.env.test?
  dragonfly = Dragonfly[:images]
  dragonfly.configure do |dragonfly_config|
    dragonfly_config.datastore.root_path = Rails.root.join("spec", "images")
  end
end
