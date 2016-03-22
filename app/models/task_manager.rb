require 'yaml/store' #allows us to store data in specific file
require_relative 'task'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database #gives instance of YAML::Store in db/task_manager file
  end

  def create(task) #transaction method is from YAML file 
    database.transaction do #creating a task if it does not exist than create what's on teh right else do whats on the left
      database['tasks'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['tasks'] << {"id" => database['total'], "title" => task[:title], "description" => task[:description]}
    end
  end

  def raw_tasks #goes into YAML file and retrieves everything under database['tasks']
    database.transaction do #database is the YAML file
      database['tasks'] || []
    end
  end

  def all  #read
    raw_tasks.map do |data|
      Task.new(data)
    end
  end

  def raw_task(id) #read
    raw_tasks.find do |task|
      task["id"] == id
    end
  end

  def find(id)
    Task.new(raw_task(id))
  end
end
