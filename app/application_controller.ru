class ApplicationController < ActiveRecord::Base
	
		Configure do 
			Set :public_folder, ‘public’
			Set :views, ‘app/views’
			Enable :sessions
				Set :session_secret, “GIFTcoursecollection”
        end

    end 
