require_relative '../test_helper'

class UserEditsaRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_edit_a_robot
    visit '/'

      click_link("Nuevo Robot")

      assert_equal "/robots/new", current_path
      fill_in 'robot[name]', with: "Mrs.Smith" #new.erb
      fill_in 'robot[city]', with: "Albuquerque" #new.erb
      fill_in 'robot[state]', with: "New Mexico" #new.erb
      fill_in 'robot[avatar]', with: "9798" #new.erb
      fill_in 'robot[birthdate]', with: "05-06-1987" #new.erb
      fill_in 'robot[date_hired]', with: "04-03-1997" #new.erb
      fill_in 'robot[department]', with: "Weirdo" #new.erb
      click_button("Submit")

    visit '/robots'

      click_link("Editar")
      assert current_path.include?("edit")
    #  assert_equal "robots/1/edit", current_path

      fill_in 'robot[name]', with: "Mrs. Jackson" #edit.erb
      fill_in 'robot[city]', with: "Boston" #edit.erb
      fill_in 'robot[state]', with: "Massachusetts" #edit.erb
      fill_in 'robot[avatar]', with: "9272" #edit.erb
      fill_in 'robot[birthdate]', with: "05-16-1087" #edit.erb
      fill_in 'robot[date_hired]', with: "03-13-1927" #edit.erb
      fill_in 'robot[department]', with: "Jello" #edit.erb
      click_button("Submit")

    assert current_path.include?("robots") #edit.erb ??

    within(".edits") do
      assert page.has_content?("Mrs. Jackson") #index.erb
    end
  end
end
