class UserController < Sinatra::Base 
    
    get "/login" do 
        erb :login 
    end

    get "/signup" do 
        erb :signup 
    end

    post '/signup' do
        user_info = { :name => params["name"],
                      :email => params["email"],
                      :password => params["password"] }
    
        is_empty?(user_info, 'signup')
    
        # if User.find_by(:email => user_info[:email])
        #   flash[:account_taken] = "The email you provided is already in our system. Please enter a new email or log in to continue."
        #   redirect to '/signup'
        # end
    
        new_user = User.create(user_info)
        session[:user_id] = new_user.id
    
        redirect to '/users/show'
      end
end
