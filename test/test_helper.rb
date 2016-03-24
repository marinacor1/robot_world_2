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
    super #minitest after every test will tear down doesn't overwrite functionality
  end

  def robot_manager #will overwrite what was database before. Manage data.
    database = YAML::Store.new('db/robot_manager_test')
    @robot_manager ||= RobotManager.new(database)
  end

  # def create_robots(num = 2)
  #   num.times do |i|
  #     robot_manager.create({:title => "robot title #{i + 1}", :description => "robot description #{i + 2}" })
  #   end
  # end
end
