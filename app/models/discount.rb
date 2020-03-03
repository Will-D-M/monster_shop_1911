class Discount < ApplicationRecord
  validates_presence_of :name,
                        :total_items,
                        :percent
  belongs_to :merchant
end
