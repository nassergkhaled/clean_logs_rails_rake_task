
# require_relative 'sweeper_base'
# # require 'pry-byebug'
# class Sweeper
#   def self.clean_all_tables
#   ActiveRecord::Base.establish_connection
#   sweepers = YAML.load_file(File.join(Rails.root, 'config', 'sweepers.yml'))['sweepers']
#
#   sweepers.each do |sweeper|
#       sweeper_class_name = "Sweepers::#{sweeper.classify}"
#     sweeper_class = sweeper_class_name.safe_constantize
#
#     if sweeper_class.nil?
#       puts "Unable to find class #{sweeper_class_name}"
#     else
#       puts "Cleaning logs for #{sweeper_class_name}"
#       sweeper_class.new.call
#     end
#   end
# end
#
# end


# class Sweeper
#   def self.clean_all_tables
#     ActiveRecord::Base.establish_connection
#
#     sweepers = ObjectSpace.each_object(Class).select do |klass|
#       klass < SweeperBase
#     end
#
#     sweepers.each do |sweeper_class|
#       sweeper_class_name = sweeper_class.name
#
#       puts "Cleaning logs for #{sweeper_class_name}"
#       sweeper_class.new(30.days.ago).call
#     end
#   end
# end
#
# class SweeperBase < ActiveRecord::Base
#   self.abstract_class = true
#
#   attr_reader :keep_duration
#
#   def initialize(keep_duration)
#     @keep_duration = keep_duration
#   end
# end





# require_relative 'sweeper_base'
require_relative '../../lib/sweepers/task_sweep'


# require 'pry-byebug'

class Sweeper
  SWEEPERS_DIR = File.join(Rails.root, 'lib', 'sweepers')
  SWEEPERS = Dir.glob("#{SWEEPERS_DIR}/*_sweep.rb").map do |file_path|
    File.basename(file_path, '.rb').camelize
  end.freeze

  def self.clean_all_tables
    ActiveRecord::Base.establish_connection
    if SWEEPERS.empty?
      puts "No sweep files found in #{SWEEPERS_DIR}"
    else
      SWEEPERS.each do |sweeper_name|
        sweeper_class_name = "Sweepers::#{sweeper_name}"
        sweeper_class = Object.const_get(sweeper_class_name) rescue nil
        binding.pry

        if sweeper_class.nil?
          puts "Unable to find class #{sweeper_class_name}"
        else
          puts "Cleaning logs for #{sweeper_class_name}"
          sweeper_class.new(10.days.ago).call
        end
      end
    end
  end
end
