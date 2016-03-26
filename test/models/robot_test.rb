require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_assigns_attributes_correctly
    robot = Robot.new({:name       => "Sobuku",
                      :city       => "Dallas",
                      :state      => "Texas",
                      :avatar     => "45",
                      :birthdate  => "08-30-1956",
                      :date_hired => "09-07-12",
                      :department => "warping"})

    assert_equal "Sobuku", robot.name
    assert_equal "Dallas", robot.city
    refute robot.id == 2
  end

end
