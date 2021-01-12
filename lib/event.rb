class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.include?(item)
    end
  end

  def total_inventory
    all_items = @food_trucks.map do |food_truck|
      food_truck.inventory.keys
    end.flatten.uniq

    total_items_hash = {}
    all_items.each do |item, value|
      total_items_hash[item] = {}
    end

    inventory = total_items_hash.reduce({}) do |total_inventory, (item, sub_hash)|
      total_inventory[item] = {quantity: 0, food_trucks: []}
      food_trucks_that_sell(item).each do |food_truck|
        total_inventory[item][:quantity] += food_truck.check_stock(item)
        total_inventory[item][:food_trucks] << food_trucks_that_sell(item)
        total_inventory[item][:food_trucks] = total_inventory[item][:food_trucks].flatten.uniq
      end
      total_inventory
    end
  end

  def overstocked_items
    
  end
end
