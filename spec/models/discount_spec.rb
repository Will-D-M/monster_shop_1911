require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :min_quantity }

  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end
