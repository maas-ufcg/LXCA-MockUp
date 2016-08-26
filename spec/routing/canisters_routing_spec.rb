require "rails_helper"

RSpec.describe CanistersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/canisters").to route_to("canisters#index")
    end

    it "routes to #new" do
      expect(:get => "/canisters/new").to route_to("canisters#new")
    end

    it "routes to #show" do
      expect(:get => "/canisters/1").to route_to("canisters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/canisters/1/edit").to route_to("canisters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/canisters").to route_to("canisters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/canisters/1").to route_to("canisters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/canisters/1").to route_to("canisters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/canisters/1").to route_to("canisters#destroy", :id => "1")
    end

  end
end
