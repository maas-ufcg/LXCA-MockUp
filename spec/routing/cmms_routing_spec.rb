require "rails_helper"

RSpec.describe CmmsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cmms").to route_to("cmms#index")
    end

    it "routes to #new" do
      expect(:get => "/cmms/new").to route_to("cmms#new")
    end

    it "routes to #show" do
      expect(:get => "/cmms/1").to route_to("cmms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cmms/1/edit").to route_to("cmms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cmms").to route_to("cmms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cmms/1").to route_to("cmms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cmms/1").to route_to("cmms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cmms/1").to route_to("cmms#destroy", :id => "1")
    end

  end
end
