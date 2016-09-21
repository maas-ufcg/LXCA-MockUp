
require 'factory_girl_rails'
# require_relative '../spec/support/factory_girl'
# require_relative '../spec/spec_helper'
# require_relative '../spec/rails_helper'
# require_relative '../spec/helpers/nodes_helper_spec'
# require_relative '../spec/factories/nodes'


# require_relative '../spec/rails_helper'

  10.downto(1) do
     FactoryGirl.create(:node)
  end
