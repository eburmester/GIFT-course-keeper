class ApplicationController < Sinatra::Base
	
		configure do	
			set :public_folder, 'public'
			set :views, 'app/views'
			enable :sessions
				set :session_secret, "GIFTcoursecollection"
		end

		get "/" do
			if is_logged_in?
				redirect to '/courses/courses'
			end
			erb :homepage
		end

		helpers do
			def is_logged_in?
			  !!session[:user_id]
			end
		
			def current_user
			  User.find(session[:user_id])
			end
		

		end
		
		error ActiveRecord::RecordNotFound do
			redirect '/'
		end
		
  end 
