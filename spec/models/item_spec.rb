require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "qboy@hotmail.com", password: "sfgdfg", role: 0)

      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @handle = @bike_shop.items.create(name: "Handle", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @wheel = @bike_shop.items.create(name: "Wheel", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @seat = @bike_shop.items.create(name: "Seat", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @frame = @bike_shop.items.create(name: "Frame", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @bell = @bike_shop.items.create(name: "Bell", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @x = @bike_shop.items.create(name: "x", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @y = @bike_shop.items.create(name: "y", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @z = @bike_shop.items.create(name: "z", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @a = @bike_shop.items.create(name: "a", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @b = @bike_shop.items.create(name: "b", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

    it "returns item with most orders" do
      order_1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_1.item_orders.create(item: @chain, price: @chain.price, quantity: 5)

      order_2 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_2.item_orders.create(item: @frame, price: @frame.price, quantity: 4)

      order_3 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_3.item_orders.create(item: @wheel, price: @wheel.price, quantity: 3)

      order_4 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_4.item_orders.create(item: @seat, price: @seat.price, quantity: 2)

      order_5 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_5.item_orders.create(item: @handle, price: @handle.price, quantity: 1)

      order_10 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_10.item_orders.create(item: @x, price: @x.price, quantity: 10)

      order_9 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_9.item_orders.create(item: @y, price: @y.price, quantity: 9)

      order_8 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_8.item_orders.create(item: @z, price: @z.price, quantity: 8)

      order_7 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_7.item_orders.create(item: @a, price: @a.price, quantity: 7)

      order_6 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_6.item_orders.create(item: @b, price: @b.price, quantity: 6)

      expected = [@x, @y, @z, @a, @b]
      expect(Item.most_ordered_items).to eq(expected)

      expected_2 = [@handle, @seat, @wheel, @frame, @chain]
      expect(Item.least_ordered_items).to eq(expected_2)
    end

    it "decrease_inventory" do
      @item_order_1 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)
      @chain.decrease_inventory(@item_order_1.quantity)
      expect(@chain.inventory).to eq(3)
    end

    it "increase_inventory" do
      @item_order_1 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)
      @chain.increase_inventory(@item_order_1.quantity)
      expect(@chain.inventory).to eq(7)
    end

    it "change_status" do
      @chain.active_false
      expect(@chain.active?).to eq(false)
      @chain.active_true
      expect(@chain.active?).to eq(true)
    end

    it 'no_order?' do
      order_1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order_1.item_orders.create(item: @chain, price: @chain.price, quantity: 5)
      expect(@chain.no_order?).to eq(false)
      expect(@bell.no_order?).to eq(true)
    end
  end
end
