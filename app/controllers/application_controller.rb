class ApplicationController < Sinatra::Base
	
		configure do	
			set :public_folder, 'public'
			set :views, 'app/views'
			enable :sessions
				set :session_secret, "GIFTcoursecollection"
		end
		
		get "/" do
			erb :homepage
		end


		helpers do
			def is_logged_in?
			  !!session[:user_id]
			end
		
			def current_user
			  User.find(session[:user_id])
			end
		
			def is_empty?(user_hash, route)
			  user_hash.each do |att, val|
				if val.empty?
				  flash[:empty] = "Please complete all fields."
				  redirect to "/#{route}"
				end
			  end
			end
		  end

    end 
