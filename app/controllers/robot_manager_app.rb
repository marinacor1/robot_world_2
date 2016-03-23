require 'models/robot_manager'

class RobotManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__) #sets root of project
  set :method_override, true  # this allows us to use _method in the form

  get '/' do #this is the controller's single route
    erb :dashboard #will look for an erb file called dashboard
  end

  get '/robots' do #adding a route #READ for all the robots
    @robots = robot_manager.all
    erb :index
  end

  get '/robots/new' do #CREATE ?? It could be read because it's a get
    erb :new
  end

  post '/robots' do #using post bc its data to be processed (Get is for data from a specific source) #Create
    robot_manager.create(params[:robot])
    redirect '/robots' #once robot is created
  end

  get '/robots/:id' do |id| #will change address to match robot #update
    @robot = robot_manager.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id| #update
    @robot = robot_manager.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id| #update
    robot_manager.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    puts "this is the id: #{id}!!!!"
    robot_manager.delete(id.to_i)
    redirect "/robots"
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager') #YAML is the database. File is white space sensitive.
    @robot_manager ||= RobotManager.new(database) #robots are created here
  end
end
