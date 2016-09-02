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

      it "All items in the array should be one of the Node types" do
        valid_types = ["ITE", "Rack-Tower Server", "Lenovo ThinkServer", "SCU"]
        JSON.parse(response.body).each do |object|
          expect(valid_types.include? (object["type"])).to be_truthy
        end
      end
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
        @fetched_node = JSON.parse(response.body)
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

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_node.has_key? attribute.to_s).to eq(false)
        end
      end
    end
  end


  describe "GET /nodes/:uuid" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        node = create :node

        get node_path(node)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(JSON.parse(response.body)).to be_a(Hash)
      end

      it "Should have one of the \"Node\" types in properties" do
        valid_types = ["ITE", "Rack-Tower Server", "Lenovo ThinkServer", "SCU"]
        expect(valid_types.include? (JSON.parse(response.body)["type"])).to be_truthy
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        node = create :node

        @includeAttributes = %i(
          description
          dataHandle
        )

        get node_path(node), {includeAttributes: @includeAttributes.join(",")}
        @fetched_node = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_node).to be_a(Hash)
      end

      it "All items in response should've all the specified attributes" do
        @includeAttributes.each do |attribute|
          expect(@fetched_node.has_key? attribute.to_s).to eq(true)
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        absent = NodesHelper::required_fields - @includeAttributes
        absent.each do |attribute|
          expect(@fetched_node.has_key? attribute.to_s).to eq(false)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        node = create :node
        @excludeAttributes = %i(
          description
          dataHandle
        )

        get node_path(node), {excludeAttributes: @excludeAttributes.join(",")}
        @fetched_node = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_node).to be_a(Hash)
      end

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_node.has_key? attribute.to_s).to eq(false)
        end
      end

      it "All items in response should have all unspecified attributes" do
        absent = NodesHelper::required_fields - @excludeAttributes
        absent.each do |attribute|
          expect(@fetched_node.has_key? attribute.to_s).to eq(true)
        end
      end
    end
  end
end
