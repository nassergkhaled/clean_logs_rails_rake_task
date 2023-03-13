# require_relative 'sweeper'
# require 'yaml'
# desc "Clean logs from all tables in sweepers directory"
# task :clean => :environment do |task|
#   # sweepers = YAML.load_file(File.join(Rails.root, 'config', 'sweepers.yml'))['sweepers']
#
#   sweepers.each { |sweeper| require_dependency File.join(Rails.root, 'lib', 'sweepers', "#{sweeper}.rb") }
#   Sweeper.clean_all_tables # Clean logs from all tables in sweepers directory
# end

require_relative '../../config/application'
require_relative '../../lib/tasks/sweeper'
desc "Clean logs from all tables in sweepers directory"
task :clean => :environment do |task|
  # sweepers = Dir.glob(File.join(Rails.root, 'lib', 'sweepers', '*_sweeper.rb')).map do |file|
  #   File.basename(file, '.rb').gsub('_sweeper', '')
  # end
  #
  # sweepers.each do |sweeper|
  #   require_dependency File.join(Rails.root, 'lib', 'sweepers', "#{sweeper}_sweeper.rb")
  # end

  Sweeper.clean_all_tables
end
