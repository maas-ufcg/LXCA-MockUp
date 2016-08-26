require 'rails_helper'
require 'json'

RSpec.describe "FanMuxes", type: :request do
  describe "GET /fanMuxes" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        @fan_muxes = (0...5).map do |fan_mux|
          create :fan_mux
        end

        get fan_mux_path
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

      it "All items in the array should be of type FanMux" do
        JSON.parse(response.body).each do |object|
          expect(object["type"]).to eq("FanMux")
        end
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        @fan_muxes = (0...5).map do |fan_mux|
          create :fan_mux
        end
        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_mux_path, {includeAttributes: @includeAttributes.join(",")}
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

      it "All items in response should've all the specified attributes" do
        JSON.parse(response.body).each do |object|
          @includeAttributes.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        JSON.parse(response.body).each do |object|
          absent = FanMuxesHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(false)
          end
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @fan_muxes = (0...5).map do |fan_mux|
          create :fan_mux
        end
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_mux_path, {excludeAttributes: @excludeAttributes.join(",")}
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

      it "All items in response shouldn't have any of the specified attributes" do
        JSON.parse(response.body).each do |object|
          @excludeAttributes.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(false)
          end
        end
      end

      it "All items in response should have all unspecified attributes" do
        JSON.parse(response.body).each do |object|
          absent = FanMuxesHelper::required_fields - @excludeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end
    end
  end

  describe "GET /fanMuxes/:uuid" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        fan_mux = create :fan_mux

        get fan_mux_path(fan_mux)
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

      it "Should have type: \"FanMux\" in properties" do
        expect(JSON.parse(response.body)["type"]).to eq("FanMux")
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        fan_mux = create :fan_mux

        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_mux_path(fan_mux), {includeAttributes: @includeAttributes.join(",")}
        @fetched_fan_mux = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_fan_mux).to be_a(Hash)
      end

      it "All items in response should've all the specified attributes" do
        @includeAttributes.each do |attribute|
          expect(@fetched_fan_mux.has_key? attribute.to_s).to eq(true)
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        absent = FanMuxesHelper::required_fields - @includeAttributes
        absent.each do |attribute|
          expect(@fetched_fan_mux.has_key? attribute.to_s).to eq(false)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        fan_mux = create :fan_mux
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_mux_path(fan_mux), {excludeAttributes: @excludeAttributes.join(",")}
        @fetched_fan_mux = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_fan_mux).to be_a(Hash)
      end

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_fan_mux.has_key? attribute.to_s).to eq(false)
        end
      end

      it "All items in response should have all unspecified attributes" do
        absent = FanMuxesHelper::required_fields - @excludeAttributes
        absent.each do |attribute|
          expect(@fetched_fan_mux.has_key? attribute.to_s).to eq(true)
        end
      end
    end
  end
end
