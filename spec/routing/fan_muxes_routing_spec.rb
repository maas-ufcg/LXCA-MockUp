require "rails_helper"

RSpec.describe FanMuxesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fanMuxes").to route_to("fanMuxes#index")
    end

    it "routes to #show" do
      expect(:get => "/fanMuxes/1").to route_to("fanMuxes#show", :id => "1")
    end

  end
end
