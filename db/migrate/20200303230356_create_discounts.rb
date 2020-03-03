class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :total_items
      t.integer :percent
      t.timestamps
    end
  end
end
