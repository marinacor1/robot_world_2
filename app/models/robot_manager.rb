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
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id}
    end
  end

  def all
    database.from(:robots).map do |data|
      Robot.new(data)
    end
  end

  # def raw_robot(id)
  #   x = raw_robots.find do |robot|
  #     robot["id"] == id
  #   end
  # end

  def find(id)
    num = id - 1
    correct_robot = all[num]
  end

  def delete_all #access database so use database.transaction
    database.from(:robots).delete
  end
end
