require 'rails_helper'

RSpec.describe "tokens/show", type: :view do
  before(:each) do
    @token = assign(:token, Token.create!(
      :_id => "Id",
      :name => "Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Id/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
  end
end
