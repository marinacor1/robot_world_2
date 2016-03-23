require 'yaml/store' #allows us to store data in specific file
require_relative 'robot'

class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database #gives instance of YAML::Store in db/robot_manager file
  end

  def create(robot) #transaction method is from YAML file
    database.transaction do #creating a robot if it does not exist than create what's on teh right else do whats on the left
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {"id" => database['total'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department]}
    end
  end

  def update(id, robot)
    database.transaction do
      target = database['robots'].find { |data| data["id"] == id}
      target["name"] = robot[:name] #you need string to access YAML, symbol is allowed for params though
      target["department"] = robot[:department]
    end
  end

  def delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id} #deleting if have the same id
    end
  end

  def raw_robots #goes into YAML file and retrieves everything under database['robots']
    database.transaction do #database is the YAML file
      database['robots'] || []
    end
  end

  def all
    raw_robots.map do |data|
      Robot.new(data)
    end
  end

  def raw_robot(id)
    raw_robots.find do |robot|
      robot["id"] == id
    end
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

end
