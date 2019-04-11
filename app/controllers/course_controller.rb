class CourseController < ApplicationController
    
    before '/courses/*' do
        if !is_logged_in?
            redirect to '/login'
        end
    end

    get "/courses/new" do 
        @user = current_user
        
        erb :"courses/new" 
    end 

    post "/courses/new" do 
        course_info = { :course_name => params["course_name"], :user_id => session[:user_id] }

        @course = Course.create_new_course(course_info, session[:user_id])
    
        redirect to "/courses/courses"
    end

    get "/courses/courses" do 
        @user = current_user
        @courses = Course.all
        erb :"courses/courses"
    end

    post "/courses/courses" do 
        @user = current_user 
        @courses = Course.all.sort_by{|c| c.course_name}
    end

    get '/courses/:id/edit' do
        @user = current_user
        @course = @user.courses.find(params["id"])
    
        erb :"courses/edit_course"
    end

    patch '/courses/:id' do
        @user = current_user
        course = @user.courses.find(params["id"])

        details = {
            :course_name => params[:course_name],
            :user_id => session[:user_id]
        }

        cour = course.update(details)

        redirect to "/courses/courses"
    end

    delete '/courses/:id/delete' do
        @user = current_user
        @course = @user.courses.find(params[:id])

        @course.destroy
    
        redirect to '/courses/courses'
    end

    get '/courses/:id' do
        @user = current_user
        @course = @user.courses.find(params["id"])
        erb :"courses/show"
    end

end
