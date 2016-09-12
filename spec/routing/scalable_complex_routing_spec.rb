require "rails_helper"

RSpec.describe ScalableComplexController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/scalable_complex").to route_to("scalable_complex#index")
    end

    it "routes to #show" do
      expect(:get => "/scalable_complex/1").to route_to("scalable_complex#show", :id => "1")
    end

  end
end
