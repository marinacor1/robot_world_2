class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    puts "this is the data: #{data}!!"
    @id         = data["id"]
    @name       = data["name"]
    @city       = data["city"]
    @state      = data["state"]
    @avatar     = data["avatar"]
    @birthdate  = data["birthdate"]
    @date_hired = data["date_hired"]
    @department = data["department"]
  end

  def average_robot_age
end

  def robots_hired_per_year
  end

  def deparment_number
  end

  def city_number
  end

  def state
  end
end
