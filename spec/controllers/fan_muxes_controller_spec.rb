require 'rails_helper'
require 'securerandom'

RSpec.describe FanMuxesController, type: :controller do

  describe "GET #index" do
    context "for six existing valid fan_muxes" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
          get :index
        end

        it "must assign an Array to @fans_muxes" do
          expect(assigns :fan_muxes).to be_a(Array)
        end

        it "must store all six fan_muxes assigned to @fan_muxes" do
          expect(assigns(:fan_muxes).count).to eq(6)
        end

        it "all fan_muxes in @fan_muxes must be valid" do
          assigns(:fan_muxes).each do |fan_mux|
            expect(fan_mux).to be_valid(FanMux)
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
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
          get :index, {includeAttributes: @includeAttributes.join(",")}
        end

        it "must assign an Array to @fan_muxes" do
          expect(assigns :fan_muxes).to be_a(Array)
        end

        it "must store all six fans assigned to @fan_muxes" do
          expect(assigns(:fan_muxes).count).to eq(6)
        end

        it "All fan_muxes have the attributes included" do
          assigns(:fan_muxes).each do |fan_mux| 
            @includeAttributes.each do |attribute|
              expect(fan_mux.properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All fan_muxes doesn't have all other attributes" do
          assigns(:fan_muxes).each do |fan_mux| 
            absent = FanMuxesHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              expect(fan_mux.properties.has_key? attribute).to eq(false)
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
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
          get :index, {excludeAttributes: @excludeAttributes.join(",")}
        end

        it "must assign an Array to @fan_muxes" do
          expect(assigns :fan_muxes).to be_a(Array)
        end

        it "must store all six fan_muxes assigned to @fan_muxes" do
          expect(assigns(:fan_muxes).count).to eq(6)
        end

        it "All fan_muxes doesn't have the attributes excluded" do
          assigns(:fan_muxes).each do |fan_mux| 
            @excludeAttributes.each do |attribute|
              expect(fan_mux.properties.has_key? attribute).to eq(false)
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
    context "Fetching existing fan_muxes" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
        end

        it "All fan_muxes can be fetched individually" do
          @fan_muxes.each do |fan_mux|
            get :show, {id: fan_mux._id}
            expect(response).to have_http_status(:success)
          end
        end

        it "All fan_muxes are valid" do
          @fan_muxes.each do |fan_mux|
            get :show, {id: fan_mux._id}
            expect(assigns :fan_mux).to be_valid(FanMux)
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
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
        end

        it "All fan_muxes can be fetched individually" do
          @fan_muxes.each do |fan_mux| 
            get :show, {
              id: fan_mux._id, 
              excludeAttributes: @excludeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All fan_muxes doesn't have the attributes excluded" do
          @fan_muxes.each do |fan_mux| 
            get :show, {
              id: fan_mux._id, 
              excludeAttributes: @excludeAttributes.join(",")
            }
            @excludeAttributes.each do |attribute|
              fan_mux_properties = assigns(:fan_mux).properties
              expect(fan_mux_properties.has_key? attribute).to eq(false)
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
          @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
        end

        it "All fan_muxes can be fetched individually" do
          @fan_muxes.each do |fan_mux| 
            get :show, {
              id: fan_mux._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All fan_muxes have the attributes included" do
          @fan_muxes.each do |fan_mux| 
            get :show, {
              id: fan_mux._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            @includeAttributes.each do |attribute|
              fan_mux_properties = assigns(:fan_mux).properties
              expect(fan_mux_properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All fan_muxes doesn't have other attributes" do
          @fan_muxes.each do |fan_mux| 
            get :show, {
              id: fan_mux._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            absent = FanMuxesHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              fan_mux_properties = assigns(:fan_mux).properties
              expect(fan_mux_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end
    end

    context "Fetching unexisting fan_muxes" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "Returns HTTP Status Code 404 (Not Found)" do
        expect(response).to have_http_status(:not_found)
      end

      it "Expects to assign nil to @fan_mux in action" do
        expect(assigns :fan_mux).to be_nil
      end
    end
  end

end
