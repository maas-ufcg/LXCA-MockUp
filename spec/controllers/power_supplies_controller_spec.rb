require 'rails_helper'
require 'securerandom'

RSpec.describe PowerSuppliesController, type: :controller do

  describe "GET #index" do

    context "for six existing valid power supply" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
          get :index
        end

        it "must assign an Array to @power_supplies" do
          expect(@power_supplies).to be_a(Array)
        end

        it "must store all six power_supplies assigned to @power_supplies" do
          expect(@power_supplies.count).to eq(6)
        end

        it "all power_supplies in @power_supplies must be valid" do
          @power_supplies.each do |power_supply|
            expect(power_supply).to be_valid(PowerSupply)
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end

      context "With includeAttributes parameters" do
        before :each do
          @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle)
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
          get :index, {includeAttributes: @includeAttributes.join(",")}
        end

        it "must assign an array to @power_supplies" do
          expect(@power_supplies).to be_a(Array)
        end

        it "must store all six power_supplies assigned to @power_supplies" do
          expect(@power_supplies.count).to eq(6)
        end

        it "All power_supplies have the attributes included" do
          assigns(:power_supplies).each do |power_supply|
            @includeAttributes.each do |attribute|
              expect(power_supply.properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All power_supplies doesn't have all other attributes" do
          assigns(:power_supplies).each do |power_supply|
            absent = PowerSuppliesHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              expect(power_supply.properties.has_key? attribute).to eq(false)
            end
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end

      context "With excludeAttributes parameters" do
        before :each do
          @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
          )
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
          get :index, {excludeAttributes: @excludeAttributes.join(",")}
        end

        it "must assign an Array to @power_supplies" do
          expect(@power_supplies).to be_a(Array)
        end

        it "must store all six power_supplies assigned to @power_supplies" do
          expect(@power_supplies.count).to eq(6)
        end

        it "All power_supplies doesn't have the attributes excluded" do
          assigns(:power_supplies).each do |power_supply|
            @excludeAttributes.each do |attribute|
              expect(power_supply.properties.has_key? attribute).to eq(false)
            end
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end


  describe "GET #show" do
    context "Fetching existing power_supplies" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
        end

        it "All power_supplies can be fetched individually" do
          @power_supplies.each do |power_supply|
            get :show, {id: power_supply._id}
            expect(response).to have_http_status(:success)
          end
        end

        it "All power_supplies are valid" do
          @power_supplies.each do |power_supply|
            get :show, {id: power_supply._id}
            expect(power_supply).to be_valid(PowerSupply)
          end
        end
      end

      context "With excludeAttributes parameters" do
        before :each do
          @excludeAttributes = %i(
          description
          hardwareRevision
          dataHandle
          )
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
        end

        it "All power_supplies can be fetched individually" do
          @power_supplies.each do |power_supply|
            get :show, {
              id: power_supply._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All power_supplies doesn't have the attributes excluded" do
          @power_supplies.each do |power_supply|
            get :show, {
              id: power_supply._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            @excludeAttributes.each do |attribute|
              power_supply_properties = assigns(:power_supply).properties
              expect(power_supply_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end

      context "With includeAttributes parameters" do
        before :each do
          @includeAttributes = %i(
          description
          hardwareRevision
          dataHandle
          )
          @power_supplies = (0..5).map {|n| create :valid_power_supply}
        end

        it "All power_suppliehod `valid?' s can be fetched individually" do
          @power_supplies.each do |power_supply|
            get :show, {
              id: power_supply._id,
              includeAttributes: @includeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All power_supplies have the attributes included" do
          @power_supplies.each do |power_supply|
            get :show, {
              id: power_supply._id,
              includeAttributes: @includeAttributes.join(",")
            }
            @includeAttributes.each do |attribute|
              power_supply_properties = power_supply.properties
              expect(power_supply_properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All power_supplies doesn't have other attributes" do
          @power_supplies.each do |power_supply|
            get :show, {
              id: power_supply._id,
              includeAttributes: @includeAttributes.join(",")
            }
            absent = PowerSuppliesHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              power_supply_properties = assigns(:power_supply).properties
              expect(power_supply_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end
    end

    context "Fetching unexisting power_supplies" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "Returns HTTP Status Code 404 (Not Found)" do
        expect(response).to have_http_status(:not_found)
      end

      it "Expects to assign nil to @fan in action" do
        expect(@power_supply).to be_nil
      end
    end
  end

end
