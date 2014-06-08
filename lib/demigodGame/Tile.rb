# Includes the base Tile class and all subsequent Tile types
# Handles the work with tiles, checks which values are valid for current tile
#
# Subclasses are: Sea, Mountain, Plain and Forest
# ================================================================
require_relative 'GameData'
class Tile

  attr_reader :options, :built_on, :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @type = '.'
  end

  def to_s
    "#{@type}#{@built_on}"
  end

  # Adds building to tile, doesn't check if valid building
  def build(building)
    @built_on = building
    @buildable = []
  end

  # Checks if an order is valid
  def accepts?(order)
    return false if !order || !order.match( /\A\w\Z/) # vaild command

    @options.each do |check| # checks which order was given
      return true if (check.to_s == order)
    end
    false
  end

  def check_cost(order, resources)
    cost = GameData.get_price(order)
    puts cost
    # checks each resource for the correct amount
    cost.each do |resource, amount|
      return false if amount > resources[resource]
    end
    return true
  end
end

# Sea class, can raise plains, can't be built on
class Sea < Tile

  def initialize(x, y)
    super(x, y)
    @options = [:p]
    @type = '-'
  end
end

# Ridge class, can't be raised, can build mine, chapel and dragon shrine
class Ridge < Tile

  def initialize(x, y)
    super(x, y)
    @options = [:m, :c, :d]
    @type = 'R'
  end
end

# Plains class, can be raised to ridge or forest, can build house, chapel and sheeps
class Plains < Tile

  def initialize(x, y)
    super(x, y)
    @options = [:r, :f, :h, :c, :s]
    @type = 'P'
  end
end

# Forst class, can be raised to ridge, can build woodcutter, chapel, house
class Forest < Tile

  def initialize(x, y)
    super(x, y)
    @options = [:w, :c, :h, :r]
    @type = 'F'
  end
end