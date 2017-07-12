require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let(:user) { 'octo' }
  let(:password) { 'jesuisupersecret' }
  before do
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end

  let(:valid_attributes) do
    {
      _id: SecureRandom.hex,
      name: 'test',
      email: 'test@test.test'
    }
  end

  let(:invalid_attributes) do
    {
      _id: valid_attributes[:_id],
      name: nil,
      email: 'test@test.test'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      token = Token.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      token = Token.create! valid_attributes
      get :show, params: {id: token.to_param}, session: valid_session
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
      token = Token.create! valid_attributes
      get :edit, params: {id: token.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Token" do
        expect {
          post :create, params: {token: valid_attributes}, session: valid_session
        }.to change(Token, :count).by(1)
      end

      it "redirects to the created token" do
        post :create, params: {token: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Token.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        token = Token.create! valid_attributes
        post :create, params: {token: invalid_attributes}, session: valid_session

        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          _id: valid_attributes[:_id],
          name: 'new_test',
          email: 'test@test.test'
        }
      }

      it "updates the requested token" do
        token = Token.create! valid_attributes
        put :update, params: {id: token.to_param, token: new_attributes}, session: valid_session
        token.reload
        expect(token.name).to eq(new_attributes[:name])
      end

      it "redirects to the token" do
        token = Token.create! valid_attributes
        put :update, params: {id: token.to_param, token: valid_attributes}, session: valid_session
        expect(response).to redirect_to(token)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        token = Token.create! valid_attributes
        put :update, params: {id: token.to_param, token: invalid_attributes}, session: valid_session

        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested token" do
      token = Token.create! valid_attributes
      expect {
        delete :destroy, params: {id: token.to_param}, session: valid_session
      }.to change(Token, :count).by(-1)
    end

    it "redirects to the tokens list" do
      token = Token.create! valid_attributes
      delete :destroy, params: {id: token.to_param}, session: valid_session
      expect(response).to redirect_to(tokens_url)
    end
  end

end
