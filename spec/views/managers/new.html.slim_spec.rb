require 'rails_helper'

RSpec.describe "managers/new", type: :view do
  before(:each) do
    assign(:manager, Manager.new)
  end

  it "renders new manager form" do
    render

    assert_select "form[action=?][method=?]", managers_path, "post" do

      assert_select "input[name=?]", "manager[name]"

      assert_select "input[name=?]", "manager[password]"

      assert_select "input[name=?]", "manager[password_confirmation]"
    end
  end
end
