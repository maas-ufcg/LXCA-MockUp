require 'rails_helper'
require 'json'

RSpec.describe "Canisters", type: :request do
  describe "GET /canisters" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        @canisters = (0...5).map do |canister|
          create :canister
        end

        get canisters_path
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
    end

    context "With includeAttributes parameters" do
      before :each do
        @canisters = (0...5).map do |canister|
          create :canister
        end
        @includeAttributes = %i(
          backedBy
          dataHandle
        )

        get canisters_path, {includeAttributes: @includeAttributes.join(",")}
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
          absent = CanistersHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute).to eq(false)
          end
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @canisters = (0...5).map do |canister|
          create :canister
        end
        @excludeAttributes = %i(
          backedBy
          dataHandle
        )

        get canisters_path, {excludeAttributes: @excludeAttributes.join(",")}
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
            expect(object.has_key? attribute).to eq(false)
          end
        end
      end

      it "All items in response should have all unspecified attributes" do
        JSON.parse(response.body).each do |object|
          absent = CanistersHelper::required_fields - @excludeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end
    end
  end

  describe "GET /canisters/:uuid" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        canister = create :canister

        get canister_path(canister)
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


    end

    context "With includeAttributes parameters" do
      before :each do
        canister = create :canister

        @includeAttributes = %i(
          backedBy
          dataHandle
        )

        get canister_path(canister), {includeAttributes: @includeAttributes.join(",")}
        @fetched_canister = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_canister).to be_a(Hash)
      end

      it "All items in response should've all the specified attributes" do
        @includeAttributes.each do |attribute|
          expect(@fetched_canister.has_key? attribute.to_s).to eq(true)
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        absent = CanistersHelper::required_fields - @includeAttributes
        absent.each do |attribute|
          expect(@fetched_canister.has_key? attribute.to_s).to eq(false)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        canister = create :canister
        @excludeAttributes = %i(
          backedBy
          dataHandle
        )

        get canister_path(canister), {excludeAttributes: @excludeAttributes.join(",")}
        @fetched_canister = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_canister).to be_a(Hash)
      end

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_canister.has_key? attribute.to_s).to eq(false)
        end
      end

      it "All items in response should have all unspecified attributes" do
        absent = CanistersHelper::required_fields - @excludeAttributes
        absent.each do |attribute|
          expect(@fetched_canister.has_key? attribute.to_s).to eq(true)
        end
      end
    end
  end
end
