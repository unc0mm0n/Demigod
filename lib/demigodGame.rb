require_relative 'demigodGame/version'
require_relative 'demigodGame/Demigod'
require_relative 'demigodGame/World'

module DemigodGame
  @demigod
  def self.new
    puts UiHandler::NEW_GAME
    until (size = gets.chomp).match(/^\d+$/) && size.to_i >= 3
      puts "Invalid world size"
    end

    @demigod = Demigod.new(World.new(size.to_i))
  end

  def self.run
    while true
      @demigod.turn
    end
  end

end

DemigodGame.new
DemigodGame.run
