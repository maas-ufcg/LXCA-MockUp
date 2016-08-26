require 'rails_helper'

RSpec.describe SwitchesController, type: :controller do

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


  end

  describe "GET #show" do
    context "fething existing switches" do
      before :each do
        @switches = (0..4).map{|n| create :valid_switch}
      end

      it "all switches should be fetched individually" do

        @switches.each do |switch|
          get :show, {id: switch.id}
          expect(assigns  :switch).to be_valid(Switch)
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
        it "updates the requested switch(#{key} values)" do
          @new_attributes = build :"switches_valid_put_request_#{key}"

          put :update, id: @switch._id, switch: {_id: @switch._id, properties: @new_attributes}

          expect(response).to have_http_status(:no_content)

          switch_updated_properties = Switch.find(@switch._id).properties.deep_symbolize_keys

          @new_attributes.keys.each do |key|
            expect(switch_updated_properties[key]).to eq(@new_attributes[key])
          end

          expect(switch_updated_properties.size).to_not eq(@new_attributes.size)
        end


      end

    end

    context "with invalid params" do
      it "assigns the switch as @switch" do
        switch = Switch.create! valid_attributes
        put :update, params: {id: switch.to_param, switch: invalid_attributes}, session: valid_session
        expect(assigns(:switch)).to eq(switch)
      end

      it "re-renders the 'edit' template" do
        switch = Switch.create! valid_attributes
        put :update, params: {id: switch.to_param, switch: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end



end
