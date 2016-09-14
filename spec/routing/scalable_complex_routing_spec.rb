require "rails_helper"

RSpec.describe ScalableComplexesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/scalable_complexes").to route_to("scalable_complexes#index")
    end

    it "routes to #show" do
      expect(:get => "/scalable_complexes/1").to route_to("scalable_complexes#show", :id => "1")
    end

  end
end
