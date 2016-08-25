require 'rails_helper'
require 'securerandom'

RSpec.describe FansController, type: :controller do


  describe "GET #index" do
    context "for six existing valid fans" do
      before :each do
        @fans = (0..5).map {|n| create :valid_fan}
        get :index
      end

      it "must assign an Array to @fans" do
        expect(assigns :fans).to be_a(Mongoid::Criteria)
      end

      it "must store all six fans assigned to @fans" do
        expect(assigns(:fans).count).to eq(6)
      end

      it "all fans in @fans must be valid" do
        assigns(:fans).each do |fan|
          expect(fan).to be_valid(Fan)
        end
      end

      it "must render have HTTP Status 200 (OK)" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    context "Fetching existing fans" do
      before :each do
        @fans = (0..5).map {|n| create :valid_fan}
      end

      it "All fans can be fetched individually" do
        @fans.each do |fan| 
          get :show, {id: fan._id}
          expect(response).to have_http_status(:success)
        end
      end

      it "All fans are valid" do
        @fans.each do |fan| 
          get :show, {id: fan._id}
          expect(assigns :fan).to be_valid(Fan)
        end
      end
    end

    context "Fetching unexisting fans" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "Returns HTTP Status Code 404 (Not Found)" do
        expect(response).to have_http_status(:not_found)
      end

      it "Expects to assign nil to @fan in action" do
        expect(assigns :fan).to be_nil
      end
    end
  end

end
