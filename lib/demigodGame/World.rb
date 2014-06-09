# This file will handle the World class, which holds the world map and all relevant functions
# =============================================================================
require_relative 'Tile'
require_relative 'UiHandler'
require_relative 'GameData'

class World
  BUILDABLE = {:wood_cutter => 'w', :sheep => 's', :mines => 'm', :chapel => 'c', :house => 'h', :dragon => 'd'}
  DECISIONS = {:build => {:w => 'wood_cutter', :s => 'sheep', :m => 'mines', :c => 'chapel', :h => 'house', :d => 'dragon'},
               :raise => {:r => 'ridge', :f => 'forest', :p => 'plains'}}
  DECISIONS.default = nil

  attr_reader :tiles, :buildings, :size

  def initialize(size = 5)
    @buildings = {:wood_cutter => 0, :sheep => 0, :mines => 0, :chapel => 0, :house => 0, :dragon => 0}
    @size = size

    generate_tiles(size)
  end

  # returns a specific tile from an str with a space
  def get_tile(str)
    str.strip!
    str = str.split(" ")
    x = str[0].to_i - 1
    y = str[1].to_i - 1
    @tiles[x][y]
  end

  # Advances the world map based on given 1-letter instruction
  # Assumes all given decisions were checked by tile.accept
  def advance(tile, order)
    if order.match(/\A[rfp]\Z/) # for raise of Ridge, Forest or Plain
      raise_tile(tile.x, tile.y, DECISIONS[:raise][order.to_sym])

    elsif order.match(/\A[wsmchd]\Z/) # for build of any building
      build_on_tile(tile, DECISIONS[:build][order.to_sym])
    else
      UiHandler.print_error()
    end
  end

  # Adds to resources by number of buildings. Also checks the only lose condition in the game
  def production(resources)
    resources[:wood] += @buildings[:wood_cutter]
    resources[:food] += @buildings[:sheep] -resources[:population]
    resources[:iron] += @buildings[:mines]
    resources[:favor] += @buildings[:chapel] * (resources[:population] / 10 + 1)
    resources[:favor] = (resources[:favor] * 0.9).to_i

    if resources[:population] < resources[:food]
      resources[:population] += @buildings[:house]
    else
      puts UiHandler::NOT_ENOUGH_FOOD
      resources[:population] -= resources[:population] - resources[:food]
    end
    UiHandler.print_status(resources, @buildings)

    resources.each do |name, value| # lose condition
      if value < 0
        system "clear" or system "cls"
        UiHandler.print_lost_message
        exit
      end
    end
    resources
  end

  def valid? (str)
    str.strip!
    return false if !str.match(/\A\d+\s\d+\Z/)
    true
  end

private

  # generates a starting grid based on size
  def generate_tiles(size)

    @tiles = []     # starts from fresh

    size.times do |x|
      @tiles << []     # Creates a multi dimensional array
      size.times do |y|
        tiles[x] << Sea.new(x, y)     # Adds the sea
      end
    end

    middle = size / 2

    # raises an initial cross of plains
    (-1..1).step(1) do |i|
      raise_tile(middle + i, middle, :plains)
      raise_tile(middle, middle + i, :plains)
    end

    # puts initial buildings
      build_on_tile(@tiles[middle][middle], :house)
      random1, random2 = (rand(0..1) * 2 - 1), (rand(0..1) * 2 - 1)
      build_on_tile(@tiles[middle + random1][middle], :chapel)
      build_on_tile(@tiles[middle][middle + random2], :sheep)

    # initial forest
      raise_tile(middle - random1, middle - random2, :forest)
  end

  # creates a new tile, placing it in given location
  # does not check for compatibility
  def raise_tile(x, y, tile_type)
    case tile_type.to_sym
    when :ridge
      new_tile = Ridge.new(x, y)
    when :plains
      new_tile = Plains.new(x, y)
    when :sea
      new_tile = Sea.new(x, y)
    when :forest
      new_tile = Forest.new(x, y)
    end
    @tiles[x][y] = new_tile
  end

  # builds given building on given location, and updates building count
  # does not check tile compatability
  # does check for empty tile
  def build_on_tile(tile , building)
    if !tile.built_on

      tile.build(BUILDABLE[building.to_sym])
      @buildings[building.to_sym] += 1
      if building.to_sym == :dragon
        UiHandler.print_win_message
        exit
      end
    else # This shouldn't happen normally
      puts "This shouldn't have happened (Buidling already in square)"
    end

  end

  # debugging purpose print world function
  def temp_print_world
    puts "======================================="
    @tiles.each do |row|
      row.each do |tile|
        print "#{tile.to_s}\t"
      end
      puts
    end
    puts "======================================="
  end
end

