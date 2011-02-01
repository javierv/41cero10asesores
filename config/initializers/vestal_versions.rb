VestalVersions.configure do |config|
  # Place any global options here. For example, in order to specify your own version model to use
  # throughout the application, simply specify:
  #
  # config.class_name = "MyCustomVersion"
  #
  # Any options passed to the "versioned" method in the model itself will override this global
  # configuration.
end

module VestalVersions
  class Version < ActiveRecord::Base
    def reify(version_number = nil)
      version_number ||= number
      restored = versioned.class.find(versioned.id)
      restored.revert_to(version_number)
      restored
    end

    def current?
      number == versioned.version
    end

    def next
      versioned.versions.order("number DESC").where("number > ?", number).first
    end

    def previous
      versioned.versions.order("number DESC").where("number < ?", number).first
    end

    def current
      versioned.versions.order("number DESC").first
    end
  end
end
