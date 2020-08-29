require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
		def is_logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

  get '/' do
    erb :index
  end

  get '/tweets' do 
    erb :'tweets/tweets'
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post "/signup" do
    # Create a new ActiveRecord object using params submitted by Sinatra
    user = User.new(:username => params[:username], :email => params[:email], password => params[:password])

    # user.save returns either true or false if the above user is filled out or not
    # We can use this literally as a condition instead of just erroring out
    if user.save
      redirect "/tweets"
    else
      redirect "/index"
    end
  end

end
