class Course < ActiveRecord::Base
    belongs_to :users
    has_many :users, through: :user_courses 

    def self.update_course(details)
        @details = details
        
        @course.update(
          :name => @details[:name]
        )
    
        @course.save
        @course
      end
end
