require_relative '../test_helper'

class UserDeletesRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_robot
    visit '/'
    create_robots(1)

    visit '/robots'
      within(".buttons") do #index.erb
        assert page.has_content?("robot title 1")
      end

      click_button("Eliminar")
      assert_equal "/robots", current_path

      refute page.has_content?("robot title 1") #index.erb
  end
end
