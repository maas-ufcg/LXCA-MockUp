require "rails_helper"

RSpec.describe SwitchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/switches").to route_to("switches#index")
    end

    it "routes to #show" do
      expect(:get => "/switches/1").to route_to("switches#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/switches/1").to route_to("switches#update", :id => "1")
    end

  end
end
