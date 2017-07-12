require 'rails_helper'

RSpec.describe "managers/edit", type: :view do
  before(:each) do
    @manager = assign(:manager, Manager.create!(
      :name => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ))
  end

  it "renders the edit manager form" do
    render

    assert_select "form[action=?][method=?]", manager_path(@manager), "post" do

      assert_select "input[name=?]", "manager[name]"

      assert_select "input[name=?]", "manager[password]"

      assert_select "input[name=?]", "manager[password_confirmation]"
    end
  end
end
