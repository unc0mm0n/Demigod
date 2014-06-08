# This file will handle the Demigod class, which is the heart of the game
# = as it's the player controlled class
#
# Turn order:
#-  First resources are calculater for the turn and printed on the screen
#-  The player then needs to answer in event, not all of them are interactive
#-  The player can either choose a tile to build on or skip by returning an empty line
#-  If the player chose a tile he now needs to input his action for the tile
# =============================================================================

require_relative 'UiHandler'
require_relative 'GameData'
require_relative 'World'

class Demigod
  attr_reader :resources
  @world

  # Starts a new game - each demigod has one world to rule
  # accepts different starting resources as a parameter
  def initialize (world, resources = GameData::STARTING_RESOURCES)
    @world = world
    @resources = resources
  end

  # Handles a turn, main function of the game
  def turn

    # calculates new amount of resources using the production function
    # world.production accepts a resources hash and returns a newly
    # calculated resource hash based on production
    @resources = @world.production(@resources)
    p @resources

    #do_event # ========= TODO ========= #

    # part 2 of every turn
    UiHandler.print_world(@world)
    UiHandler.print_turn_message

    # Asks the user for a tile to do his action on
    decision = UiHandler.get_decision()

    until (@world.valid?(decision) || decision == '')
      UiHandler.print_error(UiHandler::NO_TILE)
      UiHandler.print_turn_message
      decision = UiHandler.get_decision()
    end

    unless decision == ''
      tile = @world.get_tile decision # returns the tile at decision

      # checks for legality of move on tiles using tile.accepts? and tile.check_cost
      until tile.accepts?(decision)
        break if decision == ''
        UiHandler.print_tile_options(tile)
        decision = UiHandler.get_decision()
        if (!tile.accepts?(decision))
          UiHandler.print_error(UiHandler::INVALID)
        elsif (!tile.check_cost(decision, @resources))
          decision = nil
          UiHandler.print_error(UiHandler::RESOURCES)
        end
      end

      if decision != ''
        price = GameData.get_price(decision)
        @resources = reduce(price)
        @world.advance(tile, decision)
      end
    end

    # Clears the screen
    UiHandler.clear_messages()
  end

private

  # calls and handles a new event         # === TODO === #
  def do_event
=begin

     event = Events.new(@resources[:luck])
    # starts an event
    event.start
    decision = gets.chomp

    until event.accepts? decision # Requires valid input
      UiHandler.print_error(event.valid_range)
      decision = gets.chomp
    end

    # event.dispatch accepts player decision and affects the world
    # returning new number of resources
    @resources = event.dispatch(decision)

=end
  end

  # Reduces resources
  def reduce(amount)
    amount.each do |name, value|
      @resources[name] -= value
    end
    @resources
  end

end

