require_relative '../test_helper'

class RobotManagerTest < Minitest::Test
  include TestHelpers
  def test_robot_manager_creates_a_robot
    robot_manager.create({ :name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})

    robot = robot_manager.all.last
    robot_2 = robot_manager.all.first
    assert_equal "Sobuku", robot.name
    assert_equal "08-30-1956", robot.birthdate
  end

  def test_it_returns__empty_array_for_initial_all
    all = robot_manager.all
    assert_equal [], all
  end

  def test_it_returns__all_info_for_all
    robot_manager.create({ :name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})

    robot_manager.create({ :name       => "Zaza",
                          :city      => "Rome",
                          :state     => "Texas",
                          :avatar     => "234",
                          :birthdate  => "04-30-1956",
                          :date_hired => "12-07-12",
                          :department => "aa"})

    robot_manager.create({ :name       => "Egrega",
                          :city      => "Eaton",
                          :state     => "Illinois",
                          :avatar     => "23423",
                          :birthdate  => "08-31-1956",
                          :date_hired => "3-12-12",
                          :department => "wasfrping"})
    all = robot_manager.all

    assert_equal Robot, all.first.class
    assert_equal 'Sobuku', all.first.name
    assert_equal 'wasfrping', all.last.department
    assert_equal 3, all.count
  end

  def test_find_robot_if_id_provided
    robot_manager.create({ :name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})

    robot_manager.create({ :name       => "Zaza",
                          :city      => "Rome",
                          :state     => "Texas",
                          :avatar     => "234",
                          :birthdate  => "04-30-1956",
                          :date_hired => "12-07-12",
                          :department => "aa"})

    robot_manager.create({ :name       => "Egrega",
                          :city      => "Eaton",
                          :state     => "Illinois",
                          :avatar     => "23423",
                          :birthdate  => "08-31-1956",
                          :date_hired => "3-12-12",
                          :department => "wasfrping"})

    correct_robot = robot_manager.find(3)
    assert_equal 'Egrega', correct_robot.name
    assert_equal 'Illinois', correct_robot.state
    refute_equal 'mom', correct_robot.state
  end

  def test_find_will_delete_based_on_id
    robot_manager.create({:name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})

    robot_manager.create({:name       => "Zaza",
                          :city      => "Rome",
                          :state     => "Texas",
                          :avatar     => "234",
                          :birthdate  => "04-30-1956",
                          :date_hired => "12-07-12",
                          :department => "aa"})

    robot_manager.create({ :name       => "Egrega",
                          :city      => "Eaton",
                          :state     => "Illinois",
                          :avatar     => "23423",
                          :birthdate  => "08-31-1956",
                          :date_hired => "3-12-12",
                          :department => "wasfrping"})

    assert_equal 3, robot_manager.all.count

    robot_id = robot_manager.all.first.id
    robot_manager.delete(robot_id)

    assert_equal 'Zaza', robot_manager.all.first.name
    assert_equal 'Rome', robot_manager.all.first.city
    assert_equal 2, robot_manager.all.count
  end

  def test_update_works
    robot_manager.create({:name       => "Sobuku",
                          :city      => "Dallas",
                          :state     => "Texas",
                          :avatar     => "45",
                          :birthdate  => "08-30-1956",
                          :date_hired => "09-07-12",
                          :department => "warping"})

    robot_manager.create({:name       => "Zaza",
                          :city      => "Rome",
                          :state     => "Texas",
                          :avatar     => "234",
                          :birthdate  => "04-30-1956",
                          :date_hired => "12-07-12",
                          :department => "aa"})    

    updated_robot = ({:name       => "Sarah",
                          :city      => "New York",
                          :state     => "New York",
                          :avatar     => "234",
                          :birthdate  => "04-30-1956",
                          :date_hired => "12-07-12",
                          :department => "aa"})

    robot_id = robot_manager.all.first.id
    robot_manager.update(robot_id, updated_robot)

    assert_equal 'Sarah', robot_manager.all.first.name
    assert_equal 'New York', robot_manager.all.first.city
  end

end
