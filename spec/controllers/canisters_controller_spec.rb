require 'rails_helper'
require 'pp'

RSpec.describe CanistersController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  describe "GET #index" do
    context "for 5 valid canisters" do
      before :each do
        @canisters = (0..4).map { |e| create :canister }
        get :index
      end

      it "must store all five canisters assigned to @canisters" do
        expect(assigns(:canisters).count).to eq(5)
      end

      it "all must be valid" do
        assigns(:canisters).each do |canister|
          expect(canister).to be_valid(Canister)
        end
      end

      it "must respond HTTP 200 (OK)" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  ###################################### DONE ABOVE ################

  describe "GET #show" do
    context "fetching existing canisters" do
      before :each do
        @canisters = (0..4).map { |e| create :canister }
      end

      it "all canisters should be fetched individually" do
        @canisters.each do |canister|
          get :show, {id: canister._id}

          canisters_response = (assigns :canisters)

          canisters_response.each do |canister|
            expect(canister).to be_valid(Canister)
          end
        end
      end

      context "fetching unexisting canister" do
        before :each do
          @random_id = SecureRandom.hex.upcase
          get :show, {id: @random_id}
        end

        it "returns HTTP 404(Not found) status code" do
          expect(response).to have_http_status(:not_found)
        end

        it "expects to assign nil @canister in action" do
          expect(assigns :canister).to be_nil
        end
      end
    end
  end






end
