require 'test/unit'
require_relative '../lib/demigodGame/demigod'
require_relative '../lib/demigodGame/world'

class MyUnitTests < Test::Unit::TestCase

  def setup
    puts "setup!"
  end

  def teardown
    puts "teardown!"
  end

  def test_basic
    dummygod = Demigod.new(World.new)
  end

end