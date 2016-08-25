require 'rails_helper'
require 'securerandom'

RSpec.describe FanMuxesController, type: :controller do

  describe "GET #index" do
    context "for six existing valid fan_muxes" do
      before :each do
        @fan_muxes = (0..5).map {|n| create :valid_fan_mux}
        get :index
      end

      it "must assign an Array to @fans_muxes" do
        expect(assigns :fan_muxes).to be_a(Mongoid::Criteria)
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
  end

  describe "GET #show" do
    context "Fetching existing fan_muxes" do
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
        @fans.each do |fan_mux|
          get :show, {id: fan_mux._id}
          expect(assigns :fan_mux).to be_valid(FanMux)
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
