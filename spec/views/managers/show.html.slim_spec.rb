require 'rails_helper'

RSpec.describe "managers/show", type: :view do
  before(:each) do
    @manager = assign(:manager, Manager.create!(
      :name => "Name",
      :password_digest => "Password Digest"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
