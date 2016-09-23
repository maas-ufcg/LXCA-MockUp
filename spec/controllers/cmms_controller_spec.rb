require 'rails_helper'
require 'pp'

RSpec.describe CmmsController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  describe "GET #index" do
    context "for 5 valid cmms" do
      before :each do
        @cmms = (0..4).map { |e| create :cmm }
        get :index
      end

      it "must store all five cmms assigned to @cmms" do
        expect(assigns(:cmms).count).to eq(5)
      end

      it "all must be valid" do
        assigns(:cmms).each do |cmm|
          expect(cmm).to be_valid(Cmm)
        end
      end

      it "must respond HTTP 200 (OK)" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  ###################################### DONE ABOVE ################

  describe "GET #show" do
    context "fetching existing cmms" do
      before :each do
        @cmms = (0..4).map { |e| create :cmm }
      end

      it "all cmms should be fetched individually" do
        @cmms.each do |cmm|
          get :show, {id: cmm._id}

          cmms_response = (assigns :cmms)

          cmms_response.each do |cmm|
            expect(cmm).to be_valid(Cmm)
          end
        end
      end

      context "fetching unexisting cmm" do
        before :each do
          @random_id = SecureRandom.hex.upcase
          get :show, {id: @random_id}
        end

        it "returns HTTP 404(Not found) status code" do
          expect(response).to have_http_status(:not_found)
        end

        it "expects to assign nil @cmm in action" do
          expect(assigns :cmm).to be_nil
        end
      end
    end
  end

    ################################# DONE ABOVE ###########################

  describe "PUT #update" do
    context "with valid params" do

      before :each do
        @cmm = create :cmm
        @new_attributes = build :cmm_valid_put_request_properties
      end

      it "update the requested cmm(properties values)" do

        put :update, id: @cmm._id, cmm: {_id: @cmm._id, properties: @new_attributes}
        expect(response).to have_http_status(:no_content)

        cmm_updated_properties = Cmm.find(@cmm._id).properties.deep_symbolize_keys

        @new_attributes.keys.each do |key|
          expect(cmm_updated_properties[key]).to eq(@new_attributes[key])
        end



      end

      CmmsHelper::field_put_params.each do |key|
        it "updates the requested cmm (#{key} values)" do
          @requested_attributes = build :"cmm_valid_put_request_#{key}"


          put :update, id: @cmm._id, cmm: {_id: @cmm._id, properties: @requested_attributes}

          expect(response).to have_http_status(:no_content)

          cmm_updated_properties = Cmm.find(@cmm._id).properties.deep_symbolize_keys


          @requested_attributes.keys.each do |key|
            if not cmm_updated_properties[key].is_a? Hash
              expect(cmm_updated_properties[key]).to eq(@requested_attributes[key])
            end
          end

          expect(cmm_updated_properties.size).to_not eq(@requested_attributes.size)
        end

      end

    end

    context "with invalid params" do

      before :each do
        @cmm_request = build :cmm_invalid_put_request_properties
        @cmm_valid = create :cmm
      end

      it "assigns the cmm as @cmm" do
        put :update, id: @cmm_valid._id, cmm:{id:@cmm_valid._id, properties:@cmm_request}
        expect(response).to have_http_status(:unprocessable_entity)
      end


    end
  end


end
