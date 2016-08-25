require 'rails_helper'

RSpec.describe "FanMuxes", type: :request do
  describe "GET /fan_muxes" do
    it "works! (now write some real specs)" do
      get fan_muxes_path
      expect(response).to have_http_status(200)
    end
  end
end
