require 'rails_helper'

RSpec.describe "Canisters", type: :request do
  describe "GET /canisters" do
    it "works! (now write some real specs)" do
      get canisters_path
      expect(response).to have_http_status(200)
    end
  end
end
