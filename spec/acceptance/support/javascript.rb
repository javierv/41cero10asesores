RSpec.configure do |config|
  Capybara.register_driver :selenium do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
  end

  config.before(:each) do
    Capybara.current_driver = :selenium if example.metadata[:js]
  end

  config.after(:each) do
    Capybara.use_default_driver if example.metadata[:js]
  end
end
