require 'yaml/store'

class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    robots = database.from(:robots)
    robots.insert(robot)
  end

  def update(id, robot)
    database.from(:robots).where(:id => id).update(robot)
  end

  def delete(id)
    #database is all info . from robots looks for robots table
    database.from(:robots).where(:id => id).delete
  end

  def all
    database.from(:robots).map do |data|
      Robot.new(data)
    end
  end

  def find(id)
    correct_robot = all[id - 1]
  end

  def delete_all
    database.from(:robots).delete
  end
end
