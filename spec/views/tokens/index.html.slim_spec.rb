require 'rails_helper'

RSpec.describe "tokens/index", type: :view do
  before(:each) do
    assign(:tokens, [
      Token.create!(
        :_id => "Id",
        :name => "Name",
        :email => "Email"
      ),
      Token.create!(
        :_id => "Id2",
        :name => "Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of tokens" do
    render
    assert_select "tr>td", :text => /Id/, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
