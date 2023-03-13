require_relative '../../config/application'
require_relative '../../lib/tasks/sweeper'

desc "Clean logs from all tables in sweepers directory"
# Set the task to depend on the "environment" task
task :clean => :environment do |task|
  # Call the clean_all_tables class method of the Sweeper class
  Sweeper.clean_all_tables
end
