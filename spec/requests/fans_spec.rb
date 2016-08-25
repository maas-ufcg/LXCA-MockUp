require 'rails_helper'
require 'json'

RSpec.describe "Fans", type: :request do
  describe "GET /fans" do
    before :each do
      @fans = (0...5).map do |fan|
        create :fan
      end

      get fans_path
    end

    it "HTTP response code is 200 (OK)" do
      expect(response).to have_http_status(:ok)
    end

    it "Response content-type must be json" do
      expect(response.content_type).to eq("application/json")
    end

    it "The body should contain an array of objects" do
      expect(JSON.parse(response.body)).to be_a(Array)
    end

    it "The body array should contain five items" do
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it "All items in the array should be a json object" do
      JSON.parse(response.body).each do |object|
        expect(object).to be_a(Hash)
      end
    end

    it "All items in the array should be of type Fan" do
      JSON.parse(response.body).each do |object|
        expect(object["type"]).to eq("Fan")
      end
    end
  end
end
