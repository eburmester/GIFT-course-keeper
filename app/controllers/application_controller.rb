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

		get "/signup" do 
			erb :signup 
		end

		post "/signup" do
			user_info = { :name => params["name"],
										:email => params["email"],
										:password => params["password"] }
	
			#is_empty?(user_info, 'signup')
	
			# if User.find_by(:email => user_info[:email])
			#   flash[:account_taken] = "The email you provided is already in our system. Please enter a new email or log in to continue."
			#   redirect to '/signup'
			# end
				binding.pry
			new_user = User.create(user_info)
			session[:user_id] = new_user.id
	
			redirect to '/users/show'
		end
			 
		get "/login" do 
			erb :login 
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
