Require “bundler” 

	Bundler.require
	Require_all ‘app’
	ActiveRecord::Base.establish_connection(
		:adapter => “sqlite3”,
		:database => “db/development.sqlite3”
	)
