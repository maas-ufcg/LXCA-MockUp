require 'rails_helper'
require 'securerandom'

RSpec.describe CanistersController, type: :controller do


  describe "GET #index" do
    context "for six existing valid canisters" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @canisters = (0..5).map {|n| create :valid_canister}
          get :index
        end

        it "must assign an Array to @canisters" do
          expect(assigns :canisters).to be_a(Array)
        end

        it "must store all six canisters assigned to @canisters" do
          expect(assigns(:canisters).count).to eq(6)
        end

        it "all canisters in @canisters must be valid" do
          assigns(:canisters).each do |canister|
            expect(canister).to be_valid(Canister)
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
            dataHandle
          )
          @canisters = (0..5).map {|n| create :valid_canister}
          get :index, {includeAttributes: @includeAttributes.join(",")}
        end

        it "must assign an Array to @canisters" do
          expect(assigns :canisters).to be_a(Array)
        end

        it "must store all six canisters assigned to @canisters" do
          expect(assigns(:canisters).count).to eq(6)
        end

        it "All canisters have the attributes included" do
          assigns(:canisters).each do |canister|
            @includeAttributes.each do |attribute|
              expect(canister.properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All canisters doesn't have all other attributes" do
          assigns(:canisters).each do |canister|
            absent = CanistersHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              expect(canister.properties.has_key? attribute).to eq(false)
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
          @canisters = (0..5).map {|n| create :valid_canister}
          get :index, {excludeAttributes: @excludeAttributes.join(",")}
        end

        it "must assign an Array to @canisters" do
          expect(assigns :canisters).to be_a(Array)
        end

        it "must store all six canisters assigned to @canisters" do
          expect(assigns(:canisters).count).to eq(6)
        end

        it "All canisters doesn't have the attributes excluded" do
          assigns(:canisters).each do |canister|
            @excludeAttributes.each do |attribute|
              expect(canister.properties.has_key? attribute).to eq(false)
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
    context "Fetching existing canisters" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @canisters = (0..5).map {|n| create :valid_canister}
        end

        it "All canisters can be fetched individually" do
          @canisters.each do |canister|
            get :show, {id: canister._id}
            expect(response).to have_http_status(:success)
          end
        end

        it "All canisters are valid" do
          @canisters.each do |canister|
            get :show, {id: canister._id}
            expect(assigns :canister).to be_valid(Canister)
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
          @canisters = (0..5).map {|n| create :valid_canister}
        end

        it "All canisters can be fetched individually" do
          @canisters.each do |canister|
            get :show, {
              id: canister._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All canisters doesn't have the attributes excluded" do
          @canisters.each do |canister|
            get :show, {
              id: canister._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            @excludeAttributes.each do |attribute|
              canister_properties = assigns(:canister).properties
              expect(canister_properties.has_key? attribute).to eq(false)
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
          @canisters = (0..5).map {|n| create :valid_canister}
        end

        it "All canisters can be fetched individually" do
          @canisters.each do |canister|
            get :show, {
              id: canister._id,
              includeAttributes: @includeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All canisters have the attributes included" do
          @canisters.each do |canister|
            get :show, {
              id: canister._id,
              includeAttributes: @includeAttributes.join(",")
            }
            @includeAttributes.each do |attribute|
              canister_properties = assigns(:canister).properties
              expect(canister_properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All canisters doesn't have other attributes" do
          @canisters.each do |canister|
            get :show, {
              id: canister._id,
              includeAttributes: @includeAttributes.join(",")
            }
            absent = CanistersHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              canister_properties = assigns(:canister).properties
              expect(canister_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end
    end

    context "Fetching unexisting canister" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "Returns HTTP Status Code 404 (Not Found)" do
        expect(response).to have_http_status(:not_found)
      end

      it "Expects to assign nil to @canister in action" do
        expect(assigns :canister).to be_nil
      end
    end
  end

end
