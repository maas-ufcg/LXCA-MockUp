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

  end





  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested switch" do
        switch = Switch.create! valid_attributes
        put :update, params: {id: switch.to_param, switch: new_attributes}, session: valid_session
        switch.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested switch as @switch" do
        switch = Switch.create! valid_attributes
        put :update, params: {id: switch.to_param, switch: valid_attributes}, session: valid_session
        expect(assigns(:switch)).to eq(switch)
      end

      it "redirects to the switch" do
        switch = Switch.create! valid_attributes
        put :update, params: {id: switch.to_param, switch: valid_attributes}, session: valid_session
        expect(response).to redirect_to(switch)
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
