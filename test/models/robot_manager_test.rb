require_relative '../test_helper'

class RobotManagerTest < Minitest::Test
  include TestHelpers
  def test_robot_manager_creates_a_robot
    robot_manager.create({ :id       =>1,
                          :name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})
    robot = robot_manager.find(1)
    robot_2 = robot_manager.all
    assert_equal "Sobuku", robot.name
    assert_equal "08-30-1956", robot.birthdate
    assert_equal 1, robot.id
    refute robot.id == 2
  end

  def test_it_returns__empty_array_for_initial_all
    skip
    all = robot_manager.all
    assert_equal [], all
  end

  def test_it_returns__all_info_for_all
    skip
    robot_manager.create({:title => 'eat', :description => 'i love food'})
    robot_manager.create({:title => 'swim', :description => '30 minute laps'})
    robot_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    robot_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    all = robot_manager.all

    assert_equal Robot, all.first.class
    assert_equal 'eat', all.first.title
    assert_equal 'need milk', all.last.description
    # assert_equal 4, all.count
  end

  def test_find_will_create_new_robot_if_id_provided
    skip
    robot_manager.create({:title => 'eat', :description => 'i love food'})
    robot_manager.create({:title => 'swim', :description => '30 minute laps'})
    robot_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    robot_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    correct_robot = robot_manager.find(3)
    assert_equal 'yoga', correct_robot.title
    assert_equal 'yoga sculpt at 6pm', correct_robot.description
    refute_equal 'eat', correct_robot.title
  end

  def test_find_will_delete_based_on_id
    skip
    #assert with initial setup
    robot_manager.create({:title => 'eat', :description => 'i love food'})
    robot_manager.create({:title => 'swim', :description => '30 minute laps'})
    robot_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    robot_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    robot_manager.delete(1)
    new_all = robot_manager.all
    assert_equal 'swim', new_all.first.title
    refute_equal 'eat', new_all.first.title
    #add an any? assertion
  end

  def test_update_works
    skip
    robot_manager.create({:title => 'eat', :description => 'i love food'})
    robot = ({:title => 'cooking', :description => 'making healthy meals'})
    robot_manager.update(1, robot)
    assert_equal 'cooking', robot_manager.all.first.title
  end

end
