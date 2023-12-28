require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(name: 'Test Project', description: 'Test Project Description')
    @task = @project.tasks.create!(name: 'Test Task', description: 'Test Task Description')
    @user = User.create!(name: 'Test User')
  end

  test "should create task" do
    assert_difference('Task.count') do
      post project_tasks_url(@project), params: { task: { name: 'New Task', description: 'New Task Description' } }
    end

    assert_redirected_to project_url(@project)
    assert_equal 'Task created !', flash[:notice]
  end

  test "should assign user to task" do
    patch assign_user_project_task_url(@project, @task), params: { user_id: @user.id }
    assert_redirected_to project_url(@project)
    assert_equal 'User assigned !', flash[:notice]
    assert_equal @user.id, @task.reload.user_id
  end

  test "should set task status" do
    patch set_status_project_task_url(@project, @task), params: { status: 'done' }
    assert_redirected_to project_url(@project)
    assert_equal 'Status updated !', flash[:notice]
    assert_equal 'done', @task.reload.status
  end
end
