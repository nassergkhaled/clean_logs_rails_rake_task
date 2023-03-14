require_relative '../../config/application'
require_relative '../../lib/tasks/sweeper'

desc "Clean logs from all tables in sweepers directory"
task :clean => :environment do |task|
  Sweeper.clean_all_tables
end
