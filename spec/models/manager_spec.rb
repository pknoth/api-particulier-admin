require 'rails_helper'

RSpec.describe Manager, type: :model do
  let(:valid_attributes) {
    {
     name: 'test' ,
     password: 'password',
     password_confirmation: 'password'
    }
  }

  let(:manager) { Manager.create!(valid_attributes) }

  it 'can be created with valid attributes' do
    expect(manager.persisted?).to be_truthy
  end

  it 'has a secure password' do
    expect(manager.password).not_to eq(manager.password_digest)
  end
end
