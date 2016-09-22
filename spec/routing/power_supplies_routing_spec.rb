require "rails_helper"

RSpec.describe PowerSuppliesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/power_supplies").to route_to("power_supplies#index")
    end

    it "routes to #show" do
      expect(:get => "/power_supplies/1").to route_to("power_supplies#show", :id => "1")
    end

  end
end
