require 'rails_helper'

RSpec.describe "Nodes", type: :request do
  describe "GET /nodes" do
    it "works! (now write some real specs)" do
      get nodes_path
      expect(response).to have_http_status(200)
    end
  end
end
