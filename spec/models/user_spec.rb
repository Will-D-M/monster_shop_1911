require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password_digest}
  end

  describe "methods" do
    it "checks to see if user email is unique and not in the database" do
      email1 = "zboy@hotmail.com"
      user1 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg")
      email2 = "finn@yahoo.com"

      expect(user1.duplicate_email?(email1)).to eq(true)
      expect(user1.duplicate_email?(email2)).to eq(false)
    end
  end
end
