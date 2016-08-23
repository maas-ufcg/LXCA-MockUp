require "rails_helper"

RSpec.describe PowerSuppliesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/power_supplies").to route_to("power_supplies#index")
    end

    it "routes to #new" do
      expect(:get => "/power_supplies/new").to route_to("power_supplies#new")
    end

    it "routes to #show" do
      expect(:get => "/power_supplies/1").to route_to("power_supplies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/power_supplies/1/edit").to route_to("power_supplies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/power_supplies").to route_to("power_supplies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/power_supplies/1").to route_to("power_supplies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/power_supplies/1").to route_to("power_supplies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/power_supplies/1").to route_to("power_supplies#destroy", :id => "1")
    end

  end
end
