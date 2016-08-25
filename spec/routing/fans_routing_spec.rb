require "rails_helper"

RSpec.describe FansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fans").to route_to("fans#index")
    end

    it "routes to #show" do
      expect(:get => "/fans/1").to route_to("fans#show", :id => "1")
    end

  end
end
