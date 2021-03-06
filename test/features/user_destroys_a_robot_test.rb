require_relative '../test_helper'

class UserDestroysARobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_robot
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
      within(".mess") do #index.erb
        assert page.has_content?("Mrs.Smith")
      end

      click_button("Eliminar")
      assert_equal "/robots", current_path

      refute page.has_content?("Mrs.Smith") #index.erb
  end
end
