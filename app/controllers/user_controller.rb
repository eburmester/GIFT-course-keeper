class UserController < ApplicationController
 
    get "/signup" do 
       erb :signup 
    end

    post "/signup" do
        user_info = { 
            :name => params["name"],
            :email => params["email"],
            :password => params["password"] 
        }


        new_user = User.create(user_info)
        session[:user_id] = new_user.id

        redirect to "/courses/courses"
    end

    get "/login" do 
        redirect to '/courses/courses' if is_logged_in?
        erb :login 
    end

    post '/login' do
        user_info = {
            :email => params["email"],
            :password => params["password"]
        }


        user = User.find_by(:email => user_info[:email])

        if user && user.authenticate(user_info[:password])
            session[:user_id] = user.id
            redirect to '/courses/courses'
        else 
            redirect to '/login'
        end
    end

    get '/logout' do
        if is_logged_in?
            session.clear
            redirect to '/'
        else
            redirect to '/'
        end
    end
end
