require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  it "status" do
    @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zzzzboy@hotmail.com", password: "sfgdfg", role: 0)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    order = @user.orders.create(name: 'Will', address: '123 st', city: 'Denver', state: 'CO', zip: '80204', status: 0)
    expect(order.status).to eq("pending")
  end

  describe 'instance methods' do
    before :each do
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)

      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 'fulfilled' )
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: 'fulfilled')
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it "total_items" do
      expect(@order_1.total_items).to eq(5)
    end

    it "fulfilled?" do
      expect(@order_1.fulfilled?).to eq(true)
    end

    it "packaged" do
      @order_1.packaged
      expect(@order_1.status).to eq("packaged")
    end

    it "ship" do
      @order_1.status = "packaged"
      @order_1.ship
      expect(@order_1.status).to eq("shipped")
    end

    it 'items_count' do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user2 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy22@hotmail.com", password: "test", role: 1)
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy23@hotmail.com", password: "sfgdfg", role: 0)
      tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order_1.item_orders.create!(item: chain, price: chain.price, quantity: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      expect(order_1.items_count(bike_shop.id)).to eq(3)
    end

    it 'items_value' do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user2 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy22@hotmail.com", password: "test", role: 1)
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy23@hotmail.com", password: "sfgdfg", role: 0)
      tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order_1.item_orders.create!(item: chain, price: chain.price, quantity: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      expect(order_1.items_value(bike_shop.id)).to eq(120)
    end

    it 'merchant_order_items' do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user2 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy22@hotmail.com", password: "test", role: 1)
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy23@hotmail.com", password: "sfgdfg", role: 0)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      huffy = @meg.items.create(name: "Huffy Bike", description: "Great for tailwhips!", price: 250, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order_1.item_orders.create!(item: chain, price: chain.price, quantity: 3)
      order_1.item_orders.create!(item: huffy, price: huffy.price, quantity: 1)

      expect(order_1.merchant_order_items(bike_shop.id).length).to eq(2)
    end
  end
end
