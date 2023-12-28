require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should not save task without name, a description and a project" do
    task = Task.new
    assert_not task.save, "Saved the task without a name, a description and a project"
  end

  test "should be able to assign the task to a user" do
    user = User.create(name: "Test")
    project = Project.create(name: "Test", description: "Test")
    task = Task.new(name: "Test", description: "Test", project_id: project.id, user_id: user.id)
    assert task.save, "Could not assign the task to a user"
  end

  test "should not be able to assign the task to a non-existent user" do
    project = Project.create(name: "Test", description: "Test")
    task = Task.new(name: "Test", description: "Test", user_id: 0, project_id: project.id)
    assert_raises(ActiveRecord::InvalidForeignKey) do
      task.save!
    end
  end

  test "should not be able to assign the task to a user with an invalid id" do
    project = Project.create(name: "Test", description: "Test")
    task = Task.new(name: "Test", description: "Test", user_id: "Test", project_id: project.id)
    assert_raises(ActiveRecord::InvalidForeignKey) do
      task.save!
    end
  end

  test "should be able to set a valid status for each task" do
    project = Project.create(name: "Test", description: "Test")
    task = Task.new(name: "Test", description: "Test", project_id: project.id, status: "in progress")
    assert task.save, "Could not set a status for the task"
  end

  test "should not be able to set an invalid status for each task" do
    project = Project.create(name: "Test", description: "Test")
    task = Task.new(name: "Test", description: "Test", project_id: project.id, status: "Test")
    assert_not task.save, "Set an invalid status for the task"
  end
end
