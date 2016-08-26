require 'rails_helper'
require 'json'

RSpec.describe "PowerSupplies", type: :request do
  describe "GET /power_supplies" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        @power_supplies = (0...5).map do |power_supply|
          create :power_supply
        end

        get power_supplies_path
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
          expect(object["type"]).to eq("PowerSupply")
        end
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        @power_supplies = (0...5).map do |power_supply|
          create :power_supply
        end
        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get power_supplies_path, {includeAttributes: @includeAttributes.join(",")}
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
          absent = PowerSuppliesHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(false)
          end
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @power_supplies = (0...5).map do |power_supply|
          create :power_supply
        end
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get power_supplies_path, {excludeAttributes: @excludeAttributes.join(",")}
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
          absent = PowerSuppliesHelper::required_fields - @excludeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end
    end
  end

  describe "GET /power_supplies/:uuid" do
    context "Without excludeAttributes or includeAttributes parameters" do
      before :each do
        power_supply = create :power_supply

        get power_supply_path(power_supply)
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

      it "Should have type: \"PowerSupply\" in properties" do
        expect(JSON.parse(response.body)["type"]).to eq("PowerSupply")
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        power_supply = create :power_supply

        @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get power_supply_path(power_supply), {includeAttributes: @includeAttributes.join(",")}
        @fetched_power_supply = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_power_supply).to be_a(Hash)
      end

      it "All items in response should've all the specified attributes" do
        @includeAttributes.each do |attribute|
          expect(@fetched_power_supply.has_key? attribute.to_s).to eq(true)
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        absent = PowerSuppliesHelper::required_fields - @includeAttributes
        absent.each do |attribute|
          expect(@fetched_power_supply.has_key? attribute.to_s).to eq(false)
        end
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        power_supply = create :power_supply
        @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
        )

        get power_supply_path(power_supply), {excludeAttributes: @excludeAttributes.join(",")}
        @fetched_power_supply = JSON.parse(response.body)
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(@fetched_power_supply).to be_a(Hash)
      end

      it "All items in response shouldn't have any of the specified attributes" do
        @excludeAttributes.each do |attribute|
          expect(@fetched_power_supply.has_key? attribute.to_s).to eq(false)
        end
      end

      it "All items in response should have all unspecified attributes" do
        absent = PowerSuppliesHelper::required_fields - @excludeAttributes
        absent.each do |attribute|
          expect(@fetched_power_supply.has_key? attribute.to_s).to eq(true)
        end
      end
    end
  end
end
