require 'rails_helper'

describe 'As a admin on the users index' do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @user_1 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 2)
    @user_2 = User.create!(name: "Meghan", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "soccerluver69@hotmail.com", password: "test", role: 0)
    @user_3 = User.create!(name: "Matt", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "littlekid@hotmail.com", password: "test", role: 0)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
    @huffy = @meg.items.create(name: "Huffy", description: "Perfect for X-ups and Tail Whips!", price: 200, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 15)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  it "I see a list of all users " do
    visit '/'
    click_on 'See All Users'

    expect(current_path).to eq('/admin/users')

    click_link(@user_1.name)

    expect(current_path).to eq("/admin/users/#{@user_1.id}")
  end


end
