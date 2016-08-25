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
    it "assigns the requested switch as @switch" do
      switch = Switch.create! valid_attributes
      get :show, params: {id: switch.to_param}, session: valid_session
      expect(assigns(:switch)).to eq(switch)
    end
  end

  describe "GET #new" do
    it "assigns a new switch as @switch" do
      get :new, params: {}, session: valid_session
      expect(assigns(:switch)).to be_a_new(Switch)
    end
  end

  describe "GET #edit" do
    it "assigns the requested switch as @switch" do
      switch = Switch.create! valid_attributes
      get :edit, params: {id: switch.to_param}, session: valid_session
      expect(assigns(:switch)).to eq(switch)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Switch" do
        expect {
          post :create, params: {switch: valid_attributes}, session: valid_session
        }.to change(Switch, :count).by(1)
      end

      it "assigns a newly created switch as @switch" do
        post :create, params: {switch: valid_attributes}, session: valid_session
        expect(assigns(:switch)).to be_a(Switch)
        expect(assigns(:switch)).to be_persisted
      end

      it "redirects to the created switch" do
        post :create, params: {switch: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Switch.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved switch as @switch" do
        post :create, params: {switch: invalid_attributes}, session: valid_session
        expect(assigns(:switch)).to be_a_new(Switch)
      end

      it "re-renders the 'new' template" do
        post :create, params: {switch: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
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

  describe "DELETE #destroy" do
    it "destroys the requested switch" do
      switch = Switch.create! valid_attributes
      expect {
        delete :destroy, params: {id: switch.to_param}, session: valid_session
      }.to change(Switch, :count).by(-1)
    end

    it "redirects to the switches list" do
      switch = Switch.create! valid_attributes
      delete :destroy, params: {id: switch.to_param}, session: valid_session
      expect(response).to redirect_to(switches_url)
    end
  end

end
