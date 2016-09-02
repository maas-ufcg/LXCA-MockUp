require 'rails_helper'

RSpec.describe "Chassis", type: :request do
  describe "GET /chassis" do
    it "works! (now write some real specs)" do
      get chassis_path
      expect(response).to have_http_status(200)
    end
  end
end
