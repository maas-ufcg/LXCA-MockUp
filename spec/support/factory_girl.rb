require 'factory_girl_rails'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  to_create { |instance| instance.save(raise_on_failure: false) }
end
