require 'rails_helper'

RSpec.describe "tokens/new", type: :view do
  before(:each) do
    assign(:token, Token.new(
      :_id => "MyString",
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new token form" do
    render

    assert_select "form[action=?][method=?]", tokens_path, "post" do

      assert_select "input[name=?]", "token[name]"

      assert_select "input[name=?]", "token[email]"
    end
  end
end
