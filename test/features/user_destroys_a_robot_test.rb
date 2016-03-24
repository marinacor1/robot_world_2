require_relative '../test_helper'

class UserDeletesRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_task
    visit '/'
    create_tasks(1)

    visit '/tasks'
      within(".buttons") do #index.erb
        assert page.has_content?("task title 1")
      end

      click_button("Eliminar")
      assert_equal "/tasks", current_path

      refute page.has_content?("task title 1") #index.erb
  end
end
