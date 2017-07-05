require 'rails_helper'

RSpec.describe "tokens/edit", type: :view do
  before(:each) do
    @token = assign(:token, Token.create!(
      :_id => "MyString",
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit token form" do
    render

    assert_select "form[action=?][method=?]", token_path(@token), "post" do

      assert_select "input[name=?]", "token[name]"

      assert_select "input[name=?]", "token[email]"
    end
  end
end
