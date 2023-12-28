require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "should not save project without name" do
    project = Project.new
    assert_not project.save, "Saved the project without a name"
  end
end
