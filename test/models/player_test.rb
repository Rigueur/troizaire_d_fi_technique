require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should not save player without name" do
    player = Player.new
    assert_not player.save, "Saved the player without a name"
  end

  test "should not save player without a valid role" do
    player = Player.new(name: "Test", role: "Test")
    assert_not player.save, "Saved the player without a valid role"
  end
end
