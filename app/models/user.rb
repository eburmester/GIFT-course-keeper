class User < ActiveRecord::Base
    has_many :courses
    has_many :shared_courses, through: :user_courses, source: "course"
    has_secure_password
end
