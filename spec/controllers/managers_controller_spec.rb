require 'rails_helper'

RSpec.describe ManagersController, type: :controller do
  let(:user) { 'octo' }
  let(:password) { 'jesuisupersecret' }
  before do
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end

  let(:valid_attributes) {
    {
     name: 'test' ,
     password: 'password',
     password_confirmation: 'password'
    }
  }

  let(:invalid_attributes) {
    {
     name: 'test' ,
     password: 'password',
     password_confirmation: 'invalid'
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ManagersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      manager = Manager.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      manager = Manager.create! valid_attributes
      get :show, params: {id: manager.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      manager = Manager.create! valid_attributes
      get :edit, params: {id: manager.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Manager" do
        expect {
          post :create, params: {manager: valid_attributes}, session: valid_session
        }.to change(Manager, :count).by(1)
      end

      it "redirects to the created manager" do
        post :create, params: {manager: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Manager.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {manager: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'new_test',
          password: 'new_password',
          password_confirmation: 'new_password'
        }
      }

      it "updates the requested manager name" do
        manager = Manager.create! valid_attributes
        put :update, params: {id: manager.to_param, manager: new_attributes}, session: valid_session
        manager.reload
        expect(manager.name).to eq('new_test')
      end

      it "updates the requested manager password" do
        manager = Manager.create! valid_attributes
        put :update, params: {id: manager.to_param, manager: new_attributes}, session: valid_session
        manager.reload
        expect(manager.authenticate('new_password')).to be_instance_of(Manager)
      end

      it "redirects to the manager" do
        manager = Manager.create! valid_attributes
        put :update, params: {id: manager.to_param, manager: valid_attributes}, session: valid_session
        expect(response).to redirect_to(manager)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        manager = Manager.create! valid_attributes
        put :update, params: {id: manager.to_param, manager: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested manager" do
      manager = Manager.create! valid_attributes
      expect {
        delete :destroy, params: {id: manager.to_param}, session: valid_session
      }.to change(Manager, :count).by(-1)
    end

    it "redirects to the managers list" do
      manager = Manager.create! valid_attributes
      delete :destroy, params: {id: manager.to_param}, session: valid_session
      expect(response).to redirect_to(managers_url)
    end
  end

end
