require "rails_helper"

RSpec.describe FansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fans").to route_to("fans#index")
    end

    it "routes to #new" do
      expect(:get => "/fans/new").to route_to("fans#new")
    end

    it "routes to #show" do
      expect(:get => "/fans/1").to route_to("fans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fans/1/edit").to route_to("fans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fans").to route_to("fans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fans/1").to route_to("fans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fans/1").to route_to("fans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fans/1").to route_to("fans#destroy", :id => "1")
    end

  end
end
