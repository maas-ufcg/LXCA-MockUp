require "rails_helper"

RSpec.describe ChassisController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chassis").to route_to("chassis#index")
    end

    it "routes to #show" do
      expect(:get => "/chassis/1").to route_to("chassis#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chassis/1").to route_to("chassis#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chassis/1").to route_to("chassis#update", :id => "1")
    end

  end
end
