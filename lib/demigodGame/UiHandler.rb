# Module to handle most of the output to the screen
# =================================================

module UiHandler

  NEW_GAME = "Welcome to Demigod! What size would you want your world to be?"
  PROMPT = '>'
  NO_TILE = "There is no such tile"
  NOT_ENOUGH_FOOD = "Your people lack food! Some have died of starvation!"
  RAISE_WARNING = "Warning: Raising the ground here will destroy the existing building!"
  BACK = "Press enter on an empty line to go back"
  INVALID = "That's an invalid move!"
  LOST = "You ran out of resources, I guess you lose..."
  WIN = "The dragon shrine is built and so the dragons grant you all the powers of immortality"
  AVAILABLE = "Available moves are: "

          # output #

  def self.print_world(world)
    puts
    print ' -'
    (world.size).times { |i| print "-#{i+1}--"}
    puts

    row_number = 1
    world.tiles.each do |row|
      print "#{row_number}"
      row.each do |tile|
        print "| #{tile.to_s}"
        print " " if tile.to_s.length == 1
      end
      puts '|'
      row_number += 1
    end

    print ' -'
    (world.size).times { |i| print "----"}

    puts ''
  end

  def self.print_status(resources, buildings)
    print_hash resources
    print_hash buildings
    puts
  end

  def self.print_hash(hash)
    hash. each do |name, amount|
      print "#{name}: #{amount} | " if name != :luck
    end
    puts
  end

  def self.print_turn_message
    puts "Choose a tile to work on. Enter 2 numbers with a space in between i.e. \"1 1\""
    print PROMPT
  end

  def self.print_error(error_str)
    puts "Oops! #{error_str}"
    puts
  end

  def self.print_tile_options(options = {})
    options.each |key, value| do
      print (AVAILABLE)
      puts ("#{key} - #{value}")
    end
    print PROMPT
  end

          # input #

  def self.get_decision()
    gets.chomp()
  end
end