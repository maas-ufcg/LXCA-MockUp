require 'rails_helper'
require 'json'

RSpec.describe "Nodes", type: :request do
  describe "GET /nodes" do

    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        @fans = (0...5).map do |fan|
          create :node
        end

        get nodes_path
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

      it "All items in the array should be a hash object" do
        JSON.parse(response.body).each do |object|
          expect(object).to be_a(Hash)
        end
      end

      #TODO check tests of type return
      # it "All items in the array should be of type Node" do
      #   JSON.parse(response.body).each do |object|
      #     expect(object["type"]).to eq("Node")
      #   end
      # end
    end

    context "With includeAttributes parameters" do
      before :each do
        @fans = (0...5).map do |node|
          create :node
        end
        @includeAttributes = %i(
          description
          dataHandle
        )

        get nodes_path, {includeAttributes: @includeAttributes.join(",")}
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

      it "All items in the array should be a hash object" do
        JSON.parse(response.body).each do |object|
          expect(object).to be_a(Hash)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @nodes = (0...5).map do |node|
          create :node
        end
        @excludeAttributes = %i(

        )
        get nodes_path, {excludeAttributes: @excludeAttributes.join(",")}
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

      it "All items in the array should be a hash object" do
        JSON.parse(response.body).each do |object|
          expect(object).to be_a(Hash)
        end
      end
    end
  end
end
