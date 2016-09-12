require 'rails_helper'

RSpec.describe "Cmms", type: :request do
  describe "GET /cmms" do
    it "works! (now write some real specs)" do
      get cmms_path
      expect(response).to have_http_status(200)
    end
  end
end
