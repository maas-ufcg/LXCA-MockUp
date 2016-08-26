require "rails_helper"

RSpec.describe FanMuxesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fan_muxes").to route_to("fan_muxes#index")
    end

    it "routes to #show" do
      expect(:get => "/fan_muxes/1").to route_to("fan_muxes#show", :id => "1")
    end

  end
end
