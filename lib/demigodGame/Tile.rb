# Includes the base Tile class and all subsequent Tile types
# Handles the work with tiles, checks which values are valid for current tile
#
# Subclasses are: Sea, Mountain, Plain and Forest
# ================================================================
require_relative 'GameData'
class Tile

  attr_reader :raisable, :buildable, :built_on, :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @raisable = []
    @buildable = []
    @type = '.'
  end

  # The base tile class is abstract and therfore accepts no value
  # Should probably be overriden in subclasses
  def accepts?(order, resources)
    false
  end

  def print_options

    if @raisable != [] # raising options
      print "You can raise with:"
      @raisable.each do |name|
        print " #{name.to_s} | "
      end
      puts
    end

    if @buildable != [] # building options
      print "You can build with:"
      @buildable.each do |name|
        print " #{name.to_s} | "
      end
      puts
    end

    puts UiHandler::RAISE_WARNING if @built_on
    puts UiHandler::BACK


    print UiHandler::PROMPT
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
  def accepts?(order, resources)
    return false if !order.match( /\A\w\Z/ ) # vaild command

    (@raisable + @buildable).each do |check| # checks which order was given
      if (check.to_s == order)
        cost = GameData.get_price(check)
        puts "This costs #{cost}"
        if !check_cost(cost, resources)
          puts "Not enough resources!"
          return false
        end
        return true
      end
    end
    false
  end

private

  def check_cost(cost, resources)

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
    @raisable = [:p]
    @type = '-'
  end
end

# Ridge class, can't be raised, can build mine, chapel and dragon shrine
class Ridge < Tile

  def initialize(x, y)
    super(x, y)
    @buildable = [:m, :c, :d]
    @type = 'R'
  end
end

# Plains class, can be raised to ridge or forest, can build house, chapel and sheeps
class Plains < Tile

  def initialize(x, y)
    super(x, y)
    @raisable = [:r, :f]
    @buildable = [:h, :c, :s]
    @type = 'P'
  end
end

# Forst class, can be raised to ridge, can build woodcutter, chapel, house
class Forest < Tile

  def initialize(x, y)
    super(x, y)
    @buildable = [:w, :c, :h]
    @raisable = [:r]
    @type = 'F'
  end
end