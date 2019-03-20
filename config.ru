require ‘./config/enviornment’
	
if ActiveRecord::Migrator.needs_migration?
		raise "Migrations are pending. Run ‘rake db:migrate' to resolve the issue."
end 

	use Rake::MethodOverride
	use CourseController
	use UserController
	run ApplicationController
