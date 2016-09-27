require 'rails_helper'

RSpec.describe SwitchesController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  describe "GET #index" do
    context "for 5 existing valid switches" do
      before :each do
        @switches = (0..4).map{|n| create :valid_switch}
        get :index
      end

      it "must store all five switches assigned to @switches" do
        expect(assigns(:switches).count).to eq(5)
      end

      it "all must be valid" do
        assigns(:switches).each do |switch|
          expect(switch).to be_valid(Switch)

        end
      end

      it "must to respond HTTP 200(OK)" do
        expect(response).to have_http_status(:success)
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        @includeAttributes = %i(
        accessState)

        @switches = (0..5).map {|n| create :valid_switch}
        get :index, {includeAttributes:  @includeAttributes.join(",")}
      end

      it "must assign an array to @switches" do
        expect(@switches).to be_a(Array)
      end
      it "must store all six switches assigned to @switches" do
      expect(@switches.count).to eq(6)
    end

    it "All switches have the attributes included" do
      assigns(:switches).each do |switch|
        @includeAttributes.each do |attribute|
          expect(switch.properties.has_key? attribute).to eq(true)
        end
      end
    end
  end
end

  describe "GET #show" do
    context "fetching existing switches" do
      before :each do
        @switches = (0..4).map{|n| create :valid_switch}
      end

      it "all switches should be fetched individually" do

        @switches.each do |switch|
          get :show, {id: switch._id}
          expect(switch).to be_valid(Switch)
        end

      end

    end

    context "fetching unexisting switches" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "returns HTTP 404(Not found) status code" do
        expect(response).to have_http_status(:not_found)
      end

      it "expects to assign nil @switch in action" do
        expect(assigns :switch).to be_nil
      end

    end

  end


  describe "PUT #update" do
    context "with valid params" do
      # let(:new_attributes) {
      #   skip("Add a hash of attributes valid for your model")
      # }
      before :each do
        @switch = create :valid_switch

        @new_attributes = build :switches_valid_put_request_settings
      end

      it "updates the requested switch(settings values)" do

        put :update, id: @switch._id, switch: {_id: @switch._id, properties: @new_attributes}

        expect(response).to have_http_status(:no_content)
        switch_updated_properties = Switch.find(@switch._id).properties.deep_symbolize_keys

        @new_attributes.keys.each do |key|
          expect(switch_updated_properties[key]).to eq(@new_attributes[key])
        end

        expect(switch_updated_properties.size).to_not eq(@new_attributes.size)

      end

      it "updates the requested switch(settings values) missing any param inside of properties" do
        @new_attributes.delete(%i(hostname ipv4Address location ipv6Address).sample)

        put :update, id: @switch._id, switch: {_id: @switch._id, properties: @new_attributes}

        expect(response).to have_http_status(:no_content)
        switch_updated_properties = Switch.find(@switch._id).properties.deep_symbolize_keys

        @new_attributes.keys.each do |key|
          expect(switch_updated_properties[key]).to eq(@new_attributes[key])
        end

        expect(switch_updated_properties.size).to_not eq(@new_attributes.size)

      end



      SwitchesHelper::fields_put_params.each do |key|
        it "updates the requested switch (#{key} values)" do
          @requested_attributes = build :"switches_valid_put_request_#{key}"

          put :update, id: @switch._id, switch: {_id: @switch._id, properties: @requested_attributes}

          expect(response).to have_http_status(:no_content)

          switch_updated_properties = Switch.find(@switch._id).properties.deep_symbolize_keys

          @requested_attributes.keys.each do |key|
            expect(switch_updated_properties[key]).to eq(@requested_attributes[key])
          end

          expect(switch_updated_properties.size).to_not eq(@requested_attributes.size)
        end


      end

    end

    context "with invalid params" do

      before :each do
        @switch_request = build :switches_valid_put_request_settings
        @switch_valid = create :valid_switch
      end

      it "assigns the switch as @switch" do
        put :update, id: @switch_valid._id, switch:{id:@switch_valid._id}
        expect(response).to have_http_status(:unprocessable_entity)
      end


    end
  end

end
