# GameData module Holds all important and CONSTANT game GameData
# Includes methods to return specific prices
# ==============================================================

module GameData
  STARTING_RESOURCES = {:wood => 2,
                        :food => 2,
                        :population => 1,
                        :iron => 0,
                        :favor => 20,
                        :luck => 0
                        }

  RAISE_PLAINS_PRICE = {:favor => 5}
  RAISE_FOREST_PRICE = {:favor => 5}
  RAISE_RIDGE_PRICE = {:favor => 10}

=begin
  RAISE_PRICES = {:p => RAISE_PLAINS_PRICE,
                  :f => RAISE_FOREST_PRICE,
                  :r => RAISE_RIDGE_PRICE
                  }
  RAISE_PRICES.default = nil
=end

  BUILD_WOODCUTTER_PRICE = {:food => 3}
  BUILD_SHEEP_PRICE = {:food => 0} # Sheeps are free, yay!
  BUILD_DRAGONSHRINE_PRICE = {:food => 10, :iron => 10, :wood => 10, :favor => 100}
  BUILD_MINE_PRICE = {:wood => 5}
  BUILD_CHAPEL_PRICE = {:wood => 2, :food => 3}
  BUILD_HOUSE_PRICE = {:wood => 2}

=begin
  BUILD_PRICES = {:w => BUILD_WOODCUTTER_PRICE,
                  :s => BUILD_SHEEP_PRICE,
                  :d => BUILD_DRAGONSHRINE_PRICE,
                  :m => BUILD_MINE_PRICE,
                  :c => BUILD_CHAPEL_PRICE,
                  :h => BUILD_HOUSE_PRICE
                  }
  BUILD_PRICES.default = nil
=end

  PRICES = {:w => BUILD_WOODCUTTER_PRICE,
            :s => BUILD_SHEEP_PRICE,
            :d => BUILD_DRAGONSHRINE_PRICE,
            :m => BUILD_MINE_PRICE,
            :c => BUILD_CHAPEL_PRICE,
            :h => BUILD_HOUSE_PRICE,
            :p => RAISE_PLAINS_PRICE,
            :f => RAISE_FOREST_PRICE,
            :r => RAISE_RIDGE_PRICE
          }

  def self.get_price(sym)
    return PRICES[sym.to_sym]
  end

end
