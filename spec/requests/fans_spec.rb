require 'rails_helper'
require 'json'

RSpec.describe "Fans", type: :request do
  describe "GET /fans" do
    context "Without excludeAttributes or includeAttributes parameters" do
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

    context "With includeAttributes parameters" do
      before :each do
        @fans = (0...5).map do |fan|
          create :fan
        end
        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fans_path, {includeAttributes: @includeAttributes.join(",")}
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
          absent = FansHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(false)
          end
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @fans = (0...5).map do |fan|
          create :fan
        end
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fans_path, {excludeAttributes: @excludeAttributes.join(",")}
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
          absent = FansHelper::required_fields - @excludeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end
    end
  end

  describe "GET /fans/:uuid" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        fan = create :fan

        get fan_path(fan)
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

      it "Should have type: \"Fan\" in properties" do
        expect(JSON.parse(response.body)["type"]).to eq("Fan")
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        fan = create :fan

        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_path(fan), {includeAttributes: @includeAttributes.join(",")}
        @fetched_fan = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_fan).to be_a(Hash)
      end

      it "All items in response should've all the specified attributes" do
        @includeAttributes.each do |attribute|
          expect(@fetched_fan.has_key? attribute.to_s).to eq(true)
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        absent = FansHelper::required_fields - @includeAttributes
        absent.each do |attribute|
          expect(@fetched_fan.has_key? attribute.to_s).to eq(false)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        fan = create :fan
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get fan_path(fan), {excludeAttributes: @excludeAttributes.join(",")}
        @fetched_fan = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_fan).to be_a(Hash)
      end

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_fan.has_key? attribute.to_s).to eq(false)
        end
      end

      it "All items in response should have all unspecified attributes" do
        absent = FansHelper::required_fields - @excludeAttributes
        absent.each do |attribute|
          expect(@fetched_fan.has_key? attribute.to_s).to eq(true)
        end
      end
    end
  end
end
