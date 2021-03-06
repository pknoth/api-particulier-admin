require 'rails_helper'

RSpec.describe "Tokens", type: :request do
  let(:user) { 'octo' }
  let(:password) { 'jesuisupersecret' }
  let(:auth_basic) do
    ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end

  describe "GET /tokens" do
    it "works! (now write some real specs)" do
      get tokens_path, env: { 'HTTP_AUTHORIZATION' => auth_basic }
      expect(response).to have_http_status(200)
    end
  end
end
