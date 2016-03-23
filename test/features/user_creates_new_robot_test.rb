require_relative '../test_helper'

class UserCanCreateNewTaskTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_new_task
    visit '/'
      click_link("New Task")
      assert_equal "/tasks/new", current_path
      fill_in 'task[title]', with: "Learn Capybara" #new.erb
      fill_in 'task[description]', with: "Its super helpful" #new.erb
      click_button("Submit")

    assert_equal "/tasks", current_path

    within(".buttons") do
      assert page.has_content?("Learn Capybara") #index.erb
    end
  end
end
