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
	
			# is_empty?(user_info, 'signup')
	
			# if User.find_by(:email => user_info[:email])
			#   flash[:account_taken] = "The email you provided is already in our system. Please enter a new email or log in to continue."
			#   redirect to '/signup'
			# end
				
			new_user = User.create(user_info)
			session[:user_id] = new_user.id
	
			redirect to "/courses/new"
		end

		get "/courses/new" do 
			erb :"courses/new" 
		end 

		get "/courses/courses" do 
			@courses = Course.all.sort_by{|c| c.course_name}
			erb :"courses/courses"
		end

		post "/courses/courses" do 
			course_info = { :course_name => params["course_name"]}

			course = Course.create(course_info)
		
			redirect to "/courses/courses"
		end

		get '/courses/:id/edit' do
			@user = current_user
			@course = Course.find(params["id"])
		
			erb :"courses/edit_course"
		end

		patch '/courses/:id' do
			@course = Course.find(params[:id])
	
			details = {
				:course_name => params["course_name"]
			}
	
			is_empty?(details, "courses/#{params[:id]}/edit")
	
			cour = Course.update_course(details)
	
			flash[:success] = "Successfully updated your experience!"
			redirect to "courses/#{cour.id}"
		end

		delete '/courses/:id/delete' do
			@user = current_user
			@course = Course.find(params[:id])
			if @user.id != @course.user_id
				flash[:edit_user]
				redirect to '/courses/#{@course.id}'
			else
				@course.destroy
				flash[:deleted] = "Your course has been deleted"
				redirect to '/courses'
			end
		end

		get '/courses/:id' do
			@user = current_user
			@course = Course.find(params["id"])
			erb :"courses/show"
		end
			 
		get "/login" do 
			erb :login 
		end

		post '/login' do
			user_info = {
				:email => params["email"],
				:password => params["password"]
			}
	
			is_empty?(user_info, 'login')
	
			user = User.find_by(:email => user_info[:email])
	
			if user && user.authenticate(user_info[:password])
				session[:user_id] = user.id
				redirect to '/courses/courses'
			else
				if user
					flash[:password] = "Your password is incorrect"
					redirect to '/login'
				else
					flash[:no_account] = "There is no account associated with that email address. Please enter a different email or sign up for an account."
					redirect to '/login'
				end
			end
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
