db_number = if Rails.env.test?
              "2"
            elsif Rails.env.production?
              "0"
            else
              "1"
            end
TRANSLATION_STORE = Translation.new db: db_number
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)
