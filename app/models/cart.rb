class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

  def add_quantity id
    @contents[id] += 1
  end

  def subtract_quantity id
    @contents[id] -= 1
  end

  def limit_reached? id
    @contents[id] == Item.find(id.to_s).inventory
  end

  def quantity_zero?(id)
    @contents[id] == 0
  end
end
