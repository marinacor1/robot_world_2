class RobotManagerApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_manager.all
    erb :index
  end

  get '/robots/dashboard' do
    @robots = robot_manager.all
    erb :dashboard_page
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_manager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_manager.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_manager.delete(id.to_i)
    redirect "/robots"
  end

  def robot_manager
    if ENV["RACK_ENV"]  == "test"
      database = Sequel.sqlite('db/robot_manager_test.sqlite')
    else
      database = Sequel.sqlite('db/robot_manager_devlopment.sqlite')
    end
    @robot_manager ||= RobotManager.new(database) #robots are created here
  end
end
