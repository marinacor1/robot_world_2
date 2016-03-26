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
    database.transaction do
      target = database['robots'].find { |data| data["id"] == id}
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["avatar"] = robot[:avatar]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def delete(id)
   all.reject! do |robot|
      all.index(robot) == id-1
    end
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
