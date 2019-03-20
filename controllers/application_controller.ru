class ApplicationController < ActiveRecord::Base
	
		Configure do 
			Set :public_folder, ‘public’
			Set :views, ‘app/views’
			Enable :sessions
				Set :session_secret, “GIFTcoursecollection”
		end
		
		get '/' do
			if is_logged_in?
			  redirect to '/courses'
			end
			erb :index
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
