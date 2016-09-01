require 'rails_helper'

RSpec.describe ChassisController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  describe "GET #index" do
    it "for 5 valid chassis" do
      before :each do
        @chassis = (0..4).map { |e| create :chassi }
        get :index
      end

      it "must store all five chassis assigned to @chassis" do
        expect(assigns(:chassis).count).to eq(5)
      end

      it "all must be valid" do
        assigns(:chassis).each do |chassi|
          expect(chassi).to be_valid(Chassi)
        end
      end

      it "musto to respond HTTP 200 (OK)" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  ###################################### DONE ABOVE ################

  describe "GET #show" do
    context "fetching existing chassis" do
      before :each do
        @chassis = (0..4).map { |e| create :chassi }
      end

      it "all chassis should be fetched individually" do
        @chassis.each do |chassi|
          get :show, {id: chassi.id}
          expect(assigns :chassis).to be_valid(Chassis)
        end
      end

      context "fetching unexisting chassi" do
        before :each do
          @random_id = SecureRandom.hex.upcase
          get :show, {id: @random_id}
        end

        it "returns HTTP 404(Not found) status code" do
          expect(response).to have_http_status(:not_found)
        end

        it "expects to assign nil @chassi in action" do
          expect(assigns :chassi).to be_nil
        end
      end
    end
  end

    ################################# DONE ABOVE ###########################

  describe "PUT #update" do
    context "with valid params" do

      before :each do
        @chassi = create :chassi
        @new_attributes = build :chassi_valid_put_request_properties
      end

      it "update the requested chassi(properties values)" do
        put :update, id: @chassi._id, chassi: {_id: chassi._id, properties: @new_attributes}
        expect(response).to have_http_status(:no_content)
        chassi_updated_properties = Chassi.find(@chassi._id).properties.deep_symbolize_keys

        @new_attributes.keys.each do |key|
          expect(chassi_updated_properties[key]).to_not eq(@new_attributes[key])
        end

        expect(chassi_updated_properties.size).to_not eq(@new_attributes.size)

      end

      it "updates the requested chassi(properties values) missing any param inside of proprerties" do
        @new_attributes.delete(ChassisHelper::fields_put_params_properties.sample)
        put :update, id: @chassi._id, chassi: {_id: @chassi._id, properties: @new_attributes}

        expect(response).to have_http_status(:no_content)
        chassi_updated_properties = Chassi.find(@chassi._id).properties.deep_symbolize_keys

        @new_attributes.keys.each do |key|
          expect(chassi_updated_properties[key]).to_not eq(@new_attributes[key])
        end

        expect(chassi_updated_properties.size).to_not eq(@new_attributes.size)

      end

      ChassisHelper::fields_put_params_properties.each do |key|
        it "updates the requested switch (#{key} values)" do
          @requested_attributes = build :"chassi_valid_put_request_#{key}"

          put :update, id: @chassi._id, chassi: {_id: @chassi._id, properties: @requested_attributes}

          expect(response).to have_http_status(:no_content)

          chassi_updated_properties = Chassi.find(@chassi._id).properties.deep_symbolize_keys

          @requested_attributes.keys.each do |key|
            expect(chassi_updated_properties[key]).to eq(@requested_attributes[key])
          end

          expect(chassi_updated_properties.size).to_not eq(@requested_attributes.size)
        end

      end

    end

    context "with invalid params" do

      before :each do
        @chassi_request = build :chassi_valid_put_request_properties
        @chassi_valid = create :chassi
      end

      it "assigns the switch as @switch" do
        put :update, id: @chassi_valid._id, switch:{id:@chassi_valid._id}
        expect(response).to have_http_status(:unprocessable_entity)
      end


    end
  end


end
