require 'rails_helper'

RSpec.describe "managers/index", type: :view do
  before(:each) do
    assign(:managers, [
      Manager.create!(
        :name => "MyString",
        :password => "MyString",
        :password_confirmation => "MyString"
      ),
      Manager.create!(
        :name => "MyString2",
        :password => "MyString",
        :password_confirmation => "MyString"
      )
    ])
  end

  it "renders a list of managers" do
    render
    assert_select "tr>td", :text => "MyString".to_s
    assert_select "tr>td", :text => "MyString2".to_s
  end
end
