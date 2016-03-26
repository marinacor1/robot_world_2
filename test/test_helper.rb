require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'

Capybara.app = RobotManagerApp #sets the app that will be tested with capybara

ENV['RACK_ENV'] ||= 'test'
#if run shotgun defaults in developer mode, else when runs in test sets it equal to test environment

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'

module TestHelpers
  def teardown
    robot_manager.delete_all
    super
  end

  def robot_manager #will overwrite what was database before. Manage data.
    database = Sequel.sqlite('db/robot_manager_test.sqlite')
    @robot_manager ||= RobotManager.new(database)
  end

  def create_robots(num = 2)
    num.times do |i|
    robot_manager.create_robot({:name       => "Name #{i + 1}",
                          :city      => "City #{i + 1}",
                          :state     => "State #{i + 1}",
                          :avatar     => "45 #{i + 1}",
                          :birthdate  => "08-30-195#{i + 1}",
                          :date_hired => "09-07-190#{i + 1}",
                          :department => "warping#{i + 1}"})
    end
  end
end
