require_relative  “./config/environment”
	
require ‘.config/enviornment’
	
if ActiveRecord::Migrator.needs_migration?
		raise ‘Migrations are pending. Run ‘rake db:migrate to resolve the issue.’
end 

	use Rake::MethodOverride
	run ApplicationController
