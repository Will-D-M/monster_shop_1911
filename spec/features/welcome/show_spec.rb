require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'should greet the visitor' do
    visit "/"
    expect(page).to have_content("Welcome to Monster Shop where you can buy knickknacks, paddywacks, and maybe a bone for Fido.")
  end
end
