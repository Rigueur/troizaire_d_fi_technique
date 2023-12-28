require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "should not save team without name" do
    team = Team.new
    assert_not team.save, "Saved the team without a name"
  end

  test "should not save team without a city" do
    team = Team.new(name: "Test")
    assert_not team.save, "Saved the team without a city"
  end
end
