require "rails_helper"

RSpec.describe CanistersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/canisters").to route_to("canisters#index")
    end

    it "routes to #show" do
      expect(:get => "/canisters/1").to route_to("canisters#show", :id => "1")
    end
  end
end
