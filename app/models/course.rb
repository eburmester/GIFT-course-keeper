class Course < ActiveRecord::Base
    belongs_to :user
    has_many :users, through: :user_courses 

    def self.create_new_course(course_info, session_uid)
        @course_info = course_info
        @user = User.find(session_uid)
    
    
        @course = Course.new(
          :course_name => @course_info[:course_name],
          :user_id => @course_info[:user_id]
        )
    
        @course.user = @user
    
        @course.save
        @course
      end


    def self.update_course(details,course)
        @details = details
        @course = course
        @course.update(
          :course_name => @details[:course_name]
        )
    
        @course.save
        @course
      end
end
